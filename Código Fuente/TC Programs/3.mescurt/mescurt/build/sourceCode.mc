programa mescurt (ent) 
si llegir(ent)=1 llavors
	dreta(ent)
	mentre llegir(ent)=1 fer
		dreta(ent)
	fmentre
	si llegir(ent)=# llavors
		esquerra(ent)
	fsi
	si llegir(ent)=1 llavors
		escriure(ent,#)
		esquerra(ent)
	fsi
	mentre llegir(ent)=1 fer
		esquerra(ent)
	fmentre
	si llegir(ent)=# llavors
		dreta(ent)
		escriure(accepta,1)
	fsi
fsi
fi

