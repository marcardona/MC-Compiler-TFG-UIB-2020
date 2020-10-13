programa zeroperun (ent) 
mentre llegir(ent)=1 fer
	dreta(ent)
fmentre
mentre llegir(ent)=# fer
	dreta(ent)
fmentre
si llegir(ent)=0 llavors
	escriure(ent,1)
	dreta(ent)
fsi
mentre llegir(ent) = 1 fer
	dreta(ent)
fmentre
si llegir(ent)=# llavors
	esquerra(ent)
fsi
mentre llegir(ent)=1 fer
	esquerra(ent)
fmentre
si llegir(ent)=# llavors
	dreta(ent)
	escriure(accepta,1)
fsi
fi

