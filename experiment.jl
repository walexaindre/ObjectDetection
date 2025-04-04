using LinearAlgebra
using Images
using Statistics
include("ChromaticAdaptation.jl")
include("Illuminant.jl")
include("RGBColorSpace.jl")
include("Companding.jl")
include("Oklab.jl")


im = load("flowers.jpg")
im2 = load("chari.jpg")
im3 = load("charigib.png")
L,a,b = LinearRGBtoOkLab(im[1,1].r|>Float64,im[1,1].g|>Float64,im[1,1].b|>Float64)

function pixel(p)
    r = p.r |>Float64
    g = p.g |>Float64
    b = p.b |>Float64 

    r = RGBtoLinearRGBgamma(r,2.2)
    g = RGBtoLinearRGBgamma(g,2.2)
    b = RGBtoLinearRGBgamma(b,2.2)

    L,a,b = LinearRGBtoOkLab(r,g,b)
    L
end

S = pixel.(im)
S1 = pixel.(im2)
S2 = pixel.(im3)
function MedianFilter(S,len)
    #New array with padding
    New = zeros(Float64, size(S,1)+2*len, size(S,2)+2*len)
    New[len+1:size(S,1)+len,len+1:size(S,2)+len] = S
    # Full
    for i in len+1:size(New,1)-len
        for j in len+1:size(New,2)-len
            S[i-len,j-len] = median(New[i-len:i+len,j-len:j+len])
        end
    end
end

MedianFilter(S,2)
MedianFilter(S1,2)
MedianFilter(S2,2)



function image(v)
    RGB(v, v, v)
end








Sm = image.(S)
S1m = image.(S1)
S2m = image.(S2)


Si = image.(S)