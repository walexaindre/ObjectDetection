struct RGBColorSpace
    name::String
    gamma::Float64
    reference_white::String
    red::NamedTuple{(:x,:y,)}
    blue = ()
    green = ()
end