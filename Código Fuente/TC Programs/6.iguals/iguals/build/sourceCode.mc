programa iguals (ent) 
copia: vector
copiar(ent, copia)
escriure(accepta,1)
mentre llegir(ent)  /= # fer
	si llegir(ent) /= llegir(copia) llavors
		escriure(accepta,0)
	si_no
		dreta(ent)
		dreta(copia)
	fsi
fmentre
si llegir(ent) /= llegir(copia) llavors
	escriure(accepta,0)
si_no
	esquerra(ent)
	esquerra(copia)
	mentre llegir(ent) /= # fer
		esquerra(ent)
		esquerra(copia)
	fmentre
fsi
fi

programa copiar (ent, copia) 
mentre llegir(ent) /= # fer
	escriure(copia, llegir(ent))
	dreta(ent)
	dreta(copia)
fmentre
esquerra(ent)
esquerra(copia)
mentre llegir(ent) /= # fer
	esquerra(ent)
	esquerra(copia)
fmentre
dreta(ent)
dreta(copia)
fi

