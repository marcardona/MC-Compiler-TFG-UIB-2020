programa recP (ent) 
pila: tipus_pila
escriure(accepta,1)
empilar(pila,P)
mentre no buida(pila) i llegir(accepta)=1 fer
    si cim(pila)=P llavors
        desempilar(pila)
        si llegir(ent)=p llavors
            empilar_par(pila, Bf)
            dreta(ent)
        si_no
            escriure(accepta,0)
        fsi
    si_no
        si cim(pila)=B llavors
            desempilar(pila)
            si llegir(ent) en {i, s, m} llavors
                empilar_par(pila,IB)
            si_no
                si llegir(ent) no en {f, g, h} llavors
                    escriure(accepta,0)
                fsi
            fsi
        si_no
            si cim(pila) = I llavors
                desempilar(pila)
                si llegir(ent) = i llavors
                    dreta(ent)
                si_no
                    si llegir(ent)=s llavors
                        empilar_par(pila,Bg)
                        dreta(ent)
                    si_no
                        si llegir(ent)=m llavors
                            empilar_par(pila,Bh)
                            dreta(ent)
                        si_no
                            escriure(accepta,0)
                        fsi
                    fsi
                fsi
            si_no 
                si cim(pila) en {f, g, h} llavors
                    si cim(pila)=llegir(ent) llavors
                        desempilar(pila)
                        dreta(ent)
                    si_no
                        escriure(accepta,0)
                    fsi
                fsi
            fsi
        fsi
    fsi
fmentre
si llegir(ent)/=# llavors
    escriure(accepta,0)
fsi
fi

