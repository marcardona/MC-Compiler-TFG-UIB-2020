package compilador;

import java.util.ArrayList;

/**
 *
 * @author María del Mar Cardona
 */
public class ParserFunc {
    
    /**
     * Nombre del procedimiento.
     */
    private String nombre;     // nombre del procedimiento
    /**
     * Índice c3@.
     */
    private final int index;      
    /**
     * Lista de nombres de parámetros.
     */
    private final ArrayList<String> params;
    /**
     * Id de procedimiento. Procedimiento en el que se hace la llamada.
     */
    private final int pcall;
    
    
    /**
     * Constructor.
     * Definir los parámetros de una llamada.
     * @param nombre: nombre of the procedure that is going to be called
     * @param index: index of the call param 
     * @param params: params names 
     * @param pcall: procedure id where the call is generated 
     */
    public ParserFunc(String nombre, int index, ArrayList<String> params, int pcall){
        this.nombre = nombre;
        this.index = index;
        this.params = params;
        this.pcall = pcall;
    }

    /**
     * Obtener nombre del procedimiento.
     * @return 
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Asignar nombre del procedimiento.
     * @param nombre: nombre del procedimiento. 
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Obtener índice del C3@.
     * @return index.
     */
    public int getIndex() {
        return index;
    }
    
    /**
     * Obtener lista de parámetros del procedimiento.
     * @return nombres de los parámetros.
     */
    public ArrayList<String> getParams() {
        return params;
    }
    
    /**
     * Obtener el id del procedimiento de la llamada.
     * @return id del procedimiento.
     */
    public int getProcedureCall () {
        return pcall;
    }
    
}