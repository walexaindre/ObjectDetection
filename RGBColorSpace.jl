struct xyY
    x::Float64
    y::Float64
    Y::Float64
end

struct XYZ 
    X::Float64
    Y::Float64
    Z::Float64
end

function toXYZ(color::xyY)
    if color.y != 0
        return XYZ(color.x * color.Y / color.y, color.Y, (1 - color.x - color.y) * color.Y / color.y)
    else
        return XYZ(0.0, 0.0, 0.0)
    end
end

struct RGBColorSpace
    name::String
    gamma::Float64
    reference_white::String
    red::xyY
    green::xyY
    blue::xyY
end

function LinearRGBtoXYZ(space::RGBColorSpace)
    r = space.red
    g = space.green
    b = space.blue

    function transform(color::xyY)
        color.x / color.y,1.0,(1 - color.x - color.y) / color.y   
    end

    Xr,Yr,Zr = transform(r)
    Xg,Yg,Zg = transform(g)
    Xb,Yb,Zb = transform(b)

    XM = [Xr Xg Xb;
        Yr Yg Yb;
        Zr Zg Zb]

    ref_white = Illuminant[space.reference_white]

    Sr,Sg,Sb = XM \ [ref_white.X, ref_white.Y, ref_white.Z]
    [Xr*Sr Xg*Sg Xb*Sb;
        Yr*Sr Yg*Sg Yb*Sb;
        Zr*Sr Zg*Sg Zb*Sb]
end

function XYZtoLinearRGB(space::RGBColorSpace)
    M = LinearRGBtoXYZ(space)
    inv(M)
end

RGBWorkingSpace = Dict("AdobeRGB" => RGBColorSpace("AdobeRGB", 2.2, "D65",
    xyY(0.6400,0.3300,0.297361),
    xyY(0.2100,0.7100,0.627355),
    xyY(0.1500,0.0600,0.075285)),
    "AppleRGB" => RGBColorSpace("AppleRGB", 1.8, "D65",
    xyY(0.6250,0.3400,0.244634),
    xyY(0.2800,0.5950,0.672034),
    xyY(0.1550,0.0700,0.083332)))



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