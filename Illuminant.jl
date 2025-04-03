struct ReferenceWhite
    name::String
    X::Float64
    Y::Float64
    Z::Float64
end

Illuminant = Dict("D65" => ReferenceWhite("D65",0.95047,1.00000,1.08883),
    "D50" => ReferenceWhite("D50",0.96422,1.00000,0.82521),
    "D55" => ReferenceWhite("D55",0.95682,1.00000,0.92149),
    "D75" => ReferenceWhite("D75",0.94972,1.00000,1.22638))