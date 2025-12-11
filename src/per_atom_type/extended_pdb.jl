# --- Helper 2: Rotate a point around an axis ---
function rotate_point(
    point::AbstractVector{<:Real},
    axis_start::AbstractVector{<:Real},
    axis_end::AbstractVector{<:Real},
    angle_rad::Real
)
    # Define vector relative to pivot (axis_start)
    v = point - axis_start

    # Unit vector for rotation axis
    k = normalize(axis_end - axis_start)

    # Rodrigues' rotation formula
    v_rot = v * cos(angle_rad) + cross(k, v) * sin(angle_rad) + k * dot(k, v) * (1 - cos(angle_rad))

    return v_rot + axis_start
end

# Identify atoms to move:
# Everything in current residue "after" C (just the Oxygen O) + all subsequent residues.
# NOTE: Sidechains are attached to CA, so they do NOT rotate with Psi.

function get_atom(res_atoms, name_str)
    idx = findfirst(at -> name(at) == name_str, res_atoms)
    return isnothing(idx) ? nothing : res_atoms[idx]
end

function set_phi_psi!(ats, phi_target, psi_target)

    phi_target = phi_target * π / 180
    psi_target = psi_target * π / 180

    residues = collect(eachresidue(ats))
    for i in 2:length(residues)-1
        c_prev = get_atom(residues[i-1], "C")
        n_curr = get_atom(residues[i], "N")
        ca_curr = get_atom(residues[i], "CA")
        c_curr = get_atom(residues[i], "C")
        n_next = get_atom(residues[i+1], "N")
        o_curr = get_atom(residues[i], "O")
        if any(isnothing, (c_prev, n_curr, ca_curr, c_curr, n_next, o_curr))
            error("Missing atom.")
        end

        if !(resname(residues[i]) == "PRO")
            current_phi = dihedral(c_prev, n_curr, ca_curr, c_curr) * π / 180
            delta_phi = phi_target - current_phi

            # Who moves with PHI? 
            # 1. Sidechain atoms (Attached to CA)
            # 2. The Carbonyl group (C, O)
            # 3. All subsequent residues
            # (Technically, we rotate everything in current residue EXCEPT N, H, CA)
            # Move atoms in current residue
            for at in residues[i]
                if name(at) != "N" && name(at) != "H" && name(at) != "CA"
                    new_pos = rotate_point(coor(at), coor(n_curr), coor(ca_curr), delta_phi)
                    set_position!(at, new_pos)
                end
            end
            # Move all subsequent residues
            for j in i+1:length(residues)
                for at in residues[j]
                    new_pos = rotate_point(coor(at), coor(n_curr), coor(ca_curr), delta_phi)
                    set_position!(at, new_pos)
                end
            end
        end

        current_psi = dihedral(n_curr, ca_curr, c_curr, n_next) * π / 180
        delta_psi = psi_target - current_psi

        # Who moves with PSI?
        # 1. The Oxygen (O) (Attached to C)
        # 2. All subsequent residues
        # (Sidechain does NOT move, it is on CA)

        # Move Oxygen in current residue
        new_pos = rotate_point(coor(o_curr), coor(ca_curr), coor(c_curr), delta_psi)
        set_position!(o_curr, new_pos)

        # Move all subsequent residues
        for j in i+1:length(residues)
            for at in residues[j]
                new_pos = rotate_point(coor(at), coor(ca_curr), coor(c_curr), delta_psi)
                set_position!(at, new_pos)
            end
        end

    end
    return ats
end

function set_chi1_to_180!(atoms)
    
    # Target angle is 180 degrees (trans conformation)
    target_angle_rad = pi
    
    residues = collect(eachresidue(atoms))

    for res_atoms in residues
        res_name = resname(res_atoms)
        if res_name == "PRO"
            continue
        end
        
        # 1. Identify the 3 backbone atoms for the angle definition: N, CA, CB
        N  = get_atom(res_atoms, "N")
        CA = get_atom(res_atoms, "CA") # Axis Start
        CB = get_atom(res_atoms, "CB") # Axis End (Skip if CB is missing, e.g., GLY/ALA)
        
        if any(isnothing.((N, CA, CB))) continue end

        # 2. Find Atom D (the atom attached to CB) to define the dihedral
        # We need any atom X such that the torsion N-CA-CB-X is defined.
        # Check common names (CG, OG, SG, etc.)
        D = get_atom(res_atoms, "CG")
        if isnothing(D) D = get_atom(res_atoms, "OG") end
        if isnothing(D) D = get_atom(res_atoms, "SG") end
        
        # If no D atom is found (e.g., C-terminal residue with only CB), skip
        if isnothing(D) continue end
        
        # 3. Calculate rotation required
        current_chi1 = dihedral(N, CA, CB, D) * pi / 180
        delta_chi1 = target_angle_rad - current_chi1

        for at in res_atoms
            if !(isbackbone(at)) && !(name(at) == "CB")
                new_pos = rotate_point(coor(at), coor(CA), coor(CB), delta_chi1)
                set_position!(at, new_pos)
            end
        end
    end
    
    return atoms
end
