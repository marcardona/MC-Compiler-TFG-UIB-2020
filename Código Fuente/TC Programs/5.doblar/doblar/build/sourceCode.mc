programa doblar (ent) 
vec: vector
mentre llegir(ent)/=# fer
	escriure(vec, llegir(ent))
	dreta(ent)
	dreta(vec)
fmentre
esquerra(vec)
mentre llegir(vec) /=# fer
	esquerra(vec)
fmentre
dreta(vec)
mentre llegir(vec) /= # fer
	escriure(ent, llegir(vec))
	dreta(ent)
	dreta(vec)
fmentre
esquerra(ent)
mentre llegir(ent) /= # fer
	esquerra(ent)
fmentre
dreta(ent)
escriure(accepta,1)
fi

