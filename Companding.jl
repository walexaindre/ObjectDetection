function LinearRGBtoRGBgamma(v,γ)
    v^(1/γ)
end

function RGBtoLinearRGBgamma(V,γ)
    V^γ
end

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


function LinearRGBtoRGBLstar(v)
    const ϵ = 216/24389
    const k100 = 24389/2700

    if v > ϵ
        return 1.16 * cbrt(v) - 0.16
    else
        return k100 * v
    end   
end

function RGBtoLinearRGB(V)
    const ϵ = 2/25
    const kinv = 27/24389
    const kinv100 = kinv * 100
    if V > ϵ
        return (25*V+4)^3/24389
    else
        return V * kinv100
    end 
end