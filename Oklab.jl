#XYZ to lms

function XYZtoOkLab(color::XYZ)
    #XYZ to lms
    M1 = [0.8189330101 0.3618667424 -0.1288597137;
    0.0329845436 0.9293118715 0.0361456387;
    0.0482003018 0.2643662691 0.6338517070]
    
    LMS = M1 * [color.X; color.Y; color.Z]
    #Power law companding
    LMS = cbrt.(LMS)

    #l'm's' to Lab
    M2 = [0.2104542553 0.7936177850 -0.0040720468;
    1.9779984951 -2.4285922050 0.4505937099;
    0.0259040371 0.7827717662 -0.8086757660]

    M2 * LMS
end

function LinearRGBtoOkLab(r,g,b)
    X,Y,Z = AdobeLinearRGBtoXYZ * [r; g; b]
    XYZtoOkLab(XYZ(X,Y,Z))
end
