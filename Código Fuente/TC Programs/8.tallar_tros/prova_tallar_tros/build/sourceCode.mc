programa prova_tallar_tros (ent) 
resultat: vector
    tallar_tros(ent, resultat)
    escriure(accepta,1)
fi

programa tallar_tros (v1, v2) 
continui: vector
escriure(continui,1)
mentre llegir(continui)=1 fer
    si llegir(v1) = # llavors
        escriure(continui,0)
    si_no
        ramificar
            escriure(continui,0)
        amb
            escriure(v2, llegir(v1))
            escriure(v1,#)
            dreta(v1)
            dreta(v2)
        framificar
    fsi
fmentre
fi

