export plot_hbonds_urea_ratios

const HBONDS_UREA = DF.DataFrame(
    residue = ["A", "D", "E", "G", "H", "I", "K", "L", "N", "P", "Q", "R", "S", "T", "V"],
    residue_name = [
        "Alanine", "Aspartic Acid", "Glutamic Acid", "Glycine", "Histidine",
        "Isoleucine", "Lysine", "Leucine", "Asparagine", "Proline",
        "Glutamine", "Arginine", "Serine", "Threonine", "Valine",
    ],
    backbone_1_hbonds = [0.075, 0.070, 0.070, 0.070, 0.025, 0.065, 0.065, 0.075, 0.060, 0.070, 0.070, 0.075, 0.070, 0.060, 0.085],
    backbone_1_ratio_to_gly = [1.07, 1.00, 1.00, 1.00, 0.36, 0.93, 0.93, 1.07, 0.86, 1.00, 1.00, 1.07, 1.00, 0.86, 1.21],
    backbone_2_hbonds = [0.17, 0.15, 0.16, 0.16, 0.04, 0.11, 0.14, 0.14, 0.13, 0.14, 0.14, 0.15, 0.16, 0.12, 0.17],
    backbone_2_ratio_to_gly = [1.06, 0.94, 1.00, 1.00, 0.25, 0.69, 0.88, 0.88, 0.81, 0.88, 0.88, 0.94, 1.00, 0.75, 1.06],
)

"""
    plot_hbonds_urea_ratios(; data=HBONDS_UREA)

Create a grouped bar plot of the two Glycine-normalized H-bond ratio columns
(`backbone_1_ratio_to_gly` and `backbone_2_ratio_to_gly`) for each residue type.
"""
function plot_hbonds_urea_ratios(; data=HBONDS_UREA)
    labels = data.residue
    y = hcat(data.backbone_1_ratio_to_gly, data.backbone_2_ratio_to_gly)

    plt = groupedbar(
        labels,
        y;
        bar_position=:dodge,
        label=["1M" "2.5M"],
        xlabel="Residue Type",
        ylabel="H-bond Ratio (relative to Glycine)",
        #title="Backbone H-bond Ratios in Urea",
        lw=0,
        size=(950, 420),
        legend=:bottomright,
        framestyle=:box,
        fontfamily="Computer Modern",
        ylims=(-0.1, 1.3),
        margin=0.5Plots.Measures.cm,
    )

    hline!(plt, [1.0]; color=:black, ls=:dash, lw=1.5, label="Glycine baseline")
    return plt
end
