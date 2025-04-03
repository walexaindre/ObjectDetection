include("ChromaticAdaptation.jl")
include("Illuminant.jl")


struct RGBColorSpace
    name::String
    gamma::Float64
    reference_white::String
end


mutable struct Color
    data::Vector{Float64}
    type::Int
end


using  LinearAlgebra

M = [0.4122214708 0.5363325363 0.0514459929;
    0.2119034982 0.6806995451 0.1073969566;
    0.0883024619 0.2812969002 0.6302613619]


#XYZ to lms
M1 = [0.8189330101 0.3618667424 -0.1288597137;
0.0329845436 0.9293118715 0.0361456387;
0.0482003018 0.2643662691 0.6338517070]m

#lms to l'm's'
function pr(x)
    cbrt(x)
end


#l'm's' to Lab
M2 = [0.2104542553 0.7936177850 -0.0040720468;
1.9779984951 -2.4285922050 0.4505937099;
0.0259040371 0.7827717662 -0.8086757660]


function sRGBtoLinearRGB(x::Float64)
    if x>0.04045
        return ((x+0.055)/1.055)^2.4
    else
        return x/12.92
    end
end

function LinearRGBtosRGB(x::Float64)

    if x>0.0031308
        return 1.055*x^(1/2.4)-0.055
    else
        return x*12.92
    end
end

AdobeLinearRGBtoXYZ = [0.5767309  0.1855540  0.1881852;
0.2973769  0.6273491  0.0752741;
0.0270343  0.0706872  0.9911085]

XYZtoAdobeLinearRGB = [2.0413690 -0.5649464 -0.3446944;
-0.9692660  1.8760108  0.0415560;
 0.0134474 -0.1183897  1.0154096]

AppleLinearRGBtoXYZ = [0.4497288  0.3162486  0.1844926;
0.2446525  0.6720283  0.0833192;
0.0251848  0.1411824  0.9224628]

XYZtoAppleLinearRGB = [2.9515373 -1.2894116 -0.4738445;
-1.0851093  1.9908566  0.0372026;
 0.0854934 -0.2694964  1.0912975]

BruceLinearRGBtoXYZ = [0.4674162  0.2944512  0.1886026;
0.2410115  0.6835475  0.0754410;
0.0219101  0.0736128  0.9933071]

XYZtoBruceLinearRGB = [2.7454669 -1.1358136 -0.4350269;
-0.9692660  1.8760108  0.0415560;
 0.0112723 -0.1139754  1.0132541]


function LinearRGBtoOkLab(LinearR,LinearG,LinearB)

    
end