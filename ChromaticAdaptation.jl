const Bradford = [0.8951000  0.2664000 -0.1614000;
-0.7502000  1.7135000  0.0367000;
 0.0389000 -0.0685000  1.0296000]

const BradfordInverse = [0.9869929 -0.1470543  0.1599627;
0.4323053  0.5183603  0.0492912;
-0.0085287  0.0400428  0.9684867]

const VonKries = [0.4002400  0.7076000 -0.0808100;
-0.2263000  1.1653200  0.0457000;
 0.0000000  0.0000000  0.9182200]

const VonKriesInverse = [1.8599364 -1.1293816  0.2198974;
0.3611914  0.6388125 -0.0000064;
0.0000000  0.0000000  1.0890636]

function ChromaticAdaptation(from,to,MA,MAinv)
    ρs,γs,βs = MA * [from.X, from.Y, from.Z]
    ρd,γd,βd = MA * [to.X, to.Y, to.Z]
    
    diagonal = [ρd/ρs, γd/γs, βd/βs]

    MAinv*diagm(diagonal)*MA
end

function ChromaticAdaptationBradford(from, to)
    ChromaticAdaptation(from, to, Bradford, BradfordInverse)
end

function ChromaticAdaptationVonKries(from, to)
    ChromaticAdaptation(from, to, VonKries, VonKriesInverse)
end
