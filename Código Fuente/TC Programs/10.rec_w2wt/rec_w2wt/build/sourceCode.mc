programa rec_w2wt (ent) 
pila: tipus_pila
escriure(accepta,1)
mentre llegir(ent)/=2 i llegir(ent)/=# fer
    empilar(pila,llegir(ent))
    dreta(ent)
fmentre
si llegir(ent)=2 llavors
    dreta(ent)
si_no
    escriure(accepta,0)
fsi
mentre no buida(pila) i cim(pila)=llegir(ent)  fer
    desempilar(pila)
    dreta(ent)
fmentre
si no buida(pila) o llegir(ent)/=# llavors
    escriure(accepta,0)
fsi
fi

