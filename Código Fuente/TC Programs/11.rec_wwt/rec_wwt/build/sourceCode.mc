programa rec_wwt (ent) 
pila: tipus_pila
continui: simbol
escriure(continui,1)
mentre llegir(continui)=1 fer
    ramificar
        si llegir(ent)/=# llavors
            empilar(pila, llegir(ent))
            dreta(ent)
        si_no
            escriure(continui,0)
        fsi
    amb
        escriure(continui,0)
    framificar
fmentre
mentre no buida(pila) i cim(pila)=llegir(ent) fer
    desempilar(pila)
    dreta(ent)
fmentre
si buida(pila) i llegir(ent)=# llavors
    escriure(accepta,1)
fsi
fi

