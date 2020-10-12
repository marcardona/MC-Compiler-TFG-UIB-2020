package compilador;

import exceptions.ComparisionException;
import exceptions.SymbolTableException;
import java.util.ArrayList;

/**
 *
 * @author María del Mar Cardona
 */
public class C3D {

    /**
     * Lista del código de 3 direcciones.
     */
    private ArrayList<Cuadruplo> listCode;
    /**
     * Espacios en blanco reservados.
     */
    private int blankSpaces = 0;
    /**
     *  Nombre del vector de entrada.
     */
    private String entVector = "";

    /**
     * Constructor.
     */
    public C3D() {
        listCode = new ArrayList();
    }

    /**
     * Generar cuádruplo. 
     * Se genera un cuádruplo y se añade al final de la lista del código intermedio.
     * @param instruction: instrucción del cuádruplo
     * @param param1: parámetro 1 del cuádruplo
     * @param param2: parámetro 2 del cuádruplo
     * @param result: resultado del cuádruplo
     */
    public void generarCuadruplo(Instruccion instruction, Operador param1, Operador param2, Operador result) {
        Cuadruplo quadruple = new Cuadruplo(instruction, param1, param2, result);
        listCode.add(quadruple);
    }

    /**
     * Generar cuádruplo.Se genera un cuádruplo y se añade al final de la lista del código intermedio.
     * @param instruction: instrucción del cuádruplo
     * @param param1: parámetro 1 del cuádruplo
     * @param param2: parámetro 2 del cuádruplo
     * @param result: resultado del cuádruplo
     * @param index: índice de inserción del cuádruplo
     */
    public void generarCuadruplo(Instruccion instruction, Operador param1, Operador param2, Operador result, int index) {
        Cuadruplo quadruple = new Cuadruplo(instruction, param1, param2, result);
        blankSpaces--;
        listCode.set(index, quadruple);
    }

    /**
     * Primera instrucción del código de 3 direcciones.
     * Para marcar un cuádruplo como primera llamada del programa.
     */
    public void primeraLlamada() {
        Cuadruplo quadruple = listCode.remove(listCode.size() - 1);
        listCode.add(0, quadruple);                                 //Lo añadimos el primero
    }

    /**
     * Convertir a String el código de 3 direcciones.
     * @return 3@ code string
     */
    @Override
    public String toString() {
        String text = "";
        for (int i = 0; i < listCode.size(); i++) {
            text += listCode.get(i).toString() + "\n";
        }
        return text;
    }

    /**
     * Generar código.
     * Genera el código ensamblador del programa a partir del c3@ optimizado.
     * @param tables: variables, procedures and tag tables
     * @param dir: path of the project
     * @param name: name of the main program
     * @param entVector: name of the ent vector
     * @return true if the assemby code has been generated correctly.
     */
    public boolean generarCodigoEnsamblador(Tablas tables, String dir, String name, String entVector) {
        boolean result;
        setEntVector(entVector);
        Optimizador opt = new Optimizador(listCode);
        Ensamblador assemblyCode = new Ensamblador(opt.optimize(), dir.replace('\\', '/'), name, tables, this.entVector);
        result = assemblyCode.generarCodigoEnsamblador();
        return result;
    }


    /**
     * Insertar cuádruplo vacío.
     * Inserta un cuádruplo vacío en el código de 3 direcciones.
     * @return índice del cuádruplo.
     */
    public int addBlankSpace() {
        listCode.add(new Cuadruplo());
        blankSpaces++;
        return listCode.size() - 1;
    }


    /**
     * Rellenar espacios en blanco.
     * Cuando se llama a un subprograma antes de que haya sido declarado se deja
     * espacio hasta conocerlo. Cuando se conocen todos se rellenan los espacios
     * en blanco.
     * @param functions: lista de funciones llamadas antes de haber sido declaradas.
     * @param ts: tabla de símbolos.
     * @param tables: tablas de datos.
     * @throws exceptions.ComparisionException
     * @throws exceptions.SymbolTableException
     */
    public void fillBlankSpaces(ArrayList<ParserFunc> functions, TablaDeSimbolos ts, Tablas tables) throws ComparisionException, SymbolTableException {
        for (ParserFunc func : functions) {
            //Codigo parametros
            int indice = func.getIndex();
            d dfunc = ts.consult(func.getNombre());
            if (dfunc == null) {
                throw new SymbolTableException("Error: Symbol Table Exception 16.\n"
                                    + "El subprograma '" + func.getNombre() + "' no ha sido declarado.");
            }
            for (int i = 0; i < func.getParams().size(); i++) {
                // asociar los parametros con los vectores
                Parametro p = ts.findParam(i, dfunc.getR());
                if (p != null) {
                    Vector vector = tables.findVector(func.getParams().get(i), func.getProcedureCall());
                    if (vector == null) {
                        if (!ts.linkParam(p, func.getParams().get(i), func.getNombre())) {
                            throw new SymbolTableException("Error: Symbol Table Exception 17.\n"
                                    + "El vector '" + func.getParams().get(i) + "' del subprograma '"+func.getNombre()+"' no se ha encontrado.");
                        }
                    }
                    //vector.setParam(p);
                } else if (!ts.linkParam(p, func.getParams().get(i), func.getNombre())) {
                    throw new SymbolTableException("Error: Symbol Table Exception 17.\n"
                            + "El vector '" + func.getParams().get(i) + "' del subprograma '"+func.getNombre()+"' no se ha encontrado.");
                }
            }

            // llamada a la funcion
            generarCuadruplo(Instruccion.call_, null, null, new Operador(dfunc.getR() + "", TipoOperador.ref_proc), indice);
        }
    }

    /**
     * Comprobar blank spaces.
     * @return true si no hay espacios en blanco en el código de 3 direcciones.
     */
    public boolean checkBlankSpaces() {
        return blankSpaces == 0;
    }

    /**
     * Asignar vector de entrada.
     * @param entVector: nombre del vector de entrada
     */
    public void setEntVector(String entVector) {
        this.entVector = entVector;
    }

    /**
     * Get vector de entrada.
     * @return nombre del vector de entrada.
     */
    public String getEntVector() {
        return this.entVector;
    }
}
