programa perdos (ent) 
mentre llegir(ent) /= # fer
	dreta(ent)
fmentre
esquerra(ent)
mentre llegir(ent)/=# fer
	si llegir(ent)=0 llavors
		dreta(ent)
		escriure(ent,0)
	si_no
		dreta(ent)
		escriure(ent,1)
	fsi
	esquerra(ent)
	esquerra(ent)
fmentre
dreta(ent)
escriure(ent,0)
escriure(accepta,1)
fi

