#=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   Project      : MAGEMin_C
#   License      : GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#   Developers   : Nicolas Riel, Boris Kaus
#   Contributors : Dominguez, H., Assunção J., Green E., Berlie N., and Rummel L.
#   Organization : Institute of Geosciences, Johannes-Gutenberg University, Mainz
#   Contact      : nriel[at]uni-mainz.de
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ =#
# Function to calculate the Li partitioning coefficient in biotite, after C. Beard., 2025

function bi_Li_CB_model(    y :: Float64,
                            f :: Float64,
                            T :: Float64 )

    bi_xSiT     = 0.5-f/2.0 - y/2.0
    bi_SiT      = (2.0 * bi_xSiT)+2.0 # need cations, not fraction
    ln_D_Li     = (-22.359) + (5.592*bi_SiT) + (10000*0.67*1/(T+273.15))
    KD_Li       = exp(ln_D_Li)

    return KD_Li 
end

# For the following bi_Li_IL_model and cd_Li_IL_model, the T is in Celsius
function bi_Li_IL_model(   T :: Float64 )
    return -0.0076*(T)+6.5775 
end

function cd_Li_IL_model(   T :: Float64 )
    return -0.0021*(T)+1.933
end