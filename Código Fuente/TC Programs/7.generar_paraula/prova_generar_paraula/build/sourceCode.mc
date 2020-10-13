programa prova_generar_paraula (ent) 
    generar_paraula(ent)
fi

programa generar_paraula (par) 
continui: vector
escriure(continui,1)
mentre llegir(continui) = 1 fer
    ramificar
        escriure(continui,0)
    amb
        escriure(par,0)
        dreta(par)
    amb
        escriure(par,1)
        dreta(par)
    framificar
fmentre
fi

