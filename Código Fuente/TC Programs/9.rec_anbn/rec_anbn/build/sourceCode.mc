programa rec_anbn (ent)
pila: tipus_pila
mentre llegir(ent) = a fer
    empilar(pila,A)
    dreta(ent)
fmentre
mentre llegir(ent)=b i no buida(pila) fer
    desempilar(pila)
    dreta(ent)
fmentre
si buida(pila) i llegir(ent)=# llavors
    escriure(accepta,1)
fsi
fi

