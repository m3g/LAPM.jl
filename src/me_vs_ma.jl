
export gyr_radius

function gyr_radius(p)
    ca = select(p, at -> name(at) == "CA")
    cm = center_of_mass(ca)
    gr = 0.0
    for at in ca
        gr += sum(abs2, position(at) - cm)
    end
    return sqrt(gr / length(ca)) 
end