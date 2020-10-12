package compilador;

import java.util.ArrayList;

/**
 *
 * @author María del Mar Cardona
 */
public class Optimizador {

    /**
     * Código original de 3 direcciones sin optimizar.
     */
    private final ArrayList<Cuadruplo> listCode;
    /**
     * C3@ optimizado.
     */
    private ArrayList<Cuadruplo> optCode;

    /**
     * Constructor.
     *
     * @param listCode: C3@ sin optimizar.
     */
    public Optimizador(ArrayList<Cuadruplo> listCode) {
        this.listCode = listCode;
        this.optCode = new ArrayList<Cuadruplo>();
    }

    /**
     * Optimizar código intermedio. 
     * Aplica las "optimizaciones de mirilla" al código intermedio.
     *
     * @return c3@ optimizado.
     */
    public ArrayList<Cuadruplo> optimize() {
        optimizacionesDeMirilla();
        return optCode;
    }

    /**
     * Optimizaciones de mirilla. 
     * Crea el código óptimo a partir del código sin optimizar. Realiza las
     * optimizaciones:
     * 1. Eliminación de código inaccesible.
     * 2. Inversión de condiciones.
     * 3. Asignaciones encadenadas.
     */
    private void optimizacionesDeMirilla() {
        boolean ifnot = false;
        int last_if = -5;
        int last_goto = -5;
        int last_assig = -5;
        int index = 0;
        Cuadruplo c3a;
        for (int i = 0; i < listCode.size(); i++) {
            c3a = listCode.get(i);
            //optimitzacions de mireta
            switch (c3a.getInstruccion()) {
                case goto_:
                    // caso 1
                    // - goto TAG
                    // - skip TAG
                    if ((i+1 < listCode.size()) && (listCode.get(i+1).getInstruccion()==Instruccion.skip_)) {
                        if (c3a.getResult().getData().equals(listCode.get(i+1).getResult().getData())){
                            i++;
                            c3a = listCode.get(i);
                        }
                    } else {
                        // caso 2
                        // eliminar codi inaccessible
                        last_goto = i;
                        i = eliminaCodigoInaccesible(i);
                        break;
                    }
                case assig_:
                    if (i+1 < listCode.size()) {
                        Cuadruplo next = listCode.get(i+1);
                        switch (next.getInstruccion()) {
                            case assig_:
                                // assig v/s  ___ sim1
                                // assig sim1 ___ sim2
                                if ((c3a.getResult().getData().equals(next.getParam1().getData())) && (c3a.getResult().getTipo()==next.getParam1().getTipo())) {
                                    c3a = new Cuadruplo(Instruccion.assig_, c3a.getParam1(), null, next.getResult());
                                    i++;
                                }
                                break;
                            case escriure_:
                                // assig val  ___ simb
                                // escri simb ___ vect
                                if (c3a.getResult().getData().equals(next.getParam1().getData())) {
                                    c3a = new Cuadruplo(Instruccion.escriure_, c3a.getParam1(), null, next.getResult());
                                    i++;
                                }
                                break;
                            case empila_:
                                // assig val  ___ simb
                                // empil simb ___ ___
                                if (c3a.getResult().getData().equals(next.getParam1().getData())) {
                                    c3a = new Cuadruplo(Instruccion.empila_, c3a.getParam1(), null, next.getResult());
                                    i++;
                                }
                                break;
                        }
                    }
                    break;
            }
            optCode.add(c3a);
        }
    }

    /**
     * Obtiene el índice de línea de código inaccesible.
     * @param i linea de código del goto
     * @return linea de código previa a la siguiente etiqueta
     */
    private int eliminaCodigoInaccesible(int i) {
        Cuadruplo c3a = listCode.get(i);
        if (c3a.getInstruccion() != Instruccion.goto_) {
            return i;
        }
        i++;
        while (i < listCode.size()) {
            c3a = listCode.get(i);
            if (c3a.getInstruccion() == Instruccion.skip_) {
                break;
            }
            i++;
        }
        return i - 1; // i es una etiqueta, el bucle principal no se la puede saltar!
    }

    /**
     * Código intermedio optimizado a string.
     * @return string.
     */
    @Override
    public String toString() {
        String s = "";
        for (int i = 0; i < optCode.size(); i++) {
            s += "" + optCode.get(i) + "\n";
        }
        return s;
    }
}
