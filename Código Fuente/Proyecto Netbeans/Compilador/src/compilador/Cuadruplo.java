package compilador;

/**
 *
 * @author María del Mar Cardona
 */
public class Cuadruplo {
    
    /**
     * Instrucción.
     */
    private Instruccion instruccion;
    /**
     * Párametro 1.
     */
    private Operador param1;
    /**
     * Parámetro 2.
     */
    private Operador param2;
    /**
     * Resultado.
     */
    private Operador result;
    
    /**
     * Quadruple constructor.
     * @param instruction
     * @param param1
     * @param param2
     * @param result 
     */
    public Cuadruplo(Instruccion instruction, Operador param1, Operador param2, Operador result) {
        this.instruccion = instruction;
        this.param1 = param1;
        this.param2 = param2;
        this.result = result;
    }
    
    /**
     * Empty constructor.
     */
    public Cuadruplo() {
        
    }
    
    /**
     * Quadruplo a string.
     * @return string del cuádruplo.
     */
    @Override
    public String toString() {
        String s = instruccion.name() + " ";
        
        if(param1 != null)
            s += param1.getData() + " ";
        else
            s += "- ";
        if(param2 != null)
            s += param2.getData() + " ";
        else
            s += "- ";
        if(result != null)
            s += result.getData() + " ";
        else
            s += "- ";
        
        return s;
    }
    
    /**
     * Intrucción del cuádruplo.
     * @return instruccion
     */
    public Instruccion getInstruccion() {
        return instruccion;
    }
    
    /**
     * Parámetro 1 del cuádruplo.
     * @return param 1
     */
    public Operador getParam1() {
        return param1;
    }
    
    /**
     * Parámetro 2 del cuádruplo.
     * @return param 2
     */
    public Operador getParam2() {
        return param2;
    }
    
    /**
     * Operador resultado del cuádruplo.
     * @return result
     */
    public Operador getResult() {
        return result;
    }
    
    /**
     * Asignar la instrucción del cuádruplo.
     * @param instruccion 
     */
    public void setInstruccion(Instruccion instruccion) {
        this.instruccion = instruccion;
    }
    
    /**
     * Asignar el parámetro 1 del cuádruplo.
     * @param param1 
     */
    public void setParam1(Operador param1) {
        this.param1 = param1;
    }
    
    /**
     * Asignar el parámetro 2 del cuádruplo.
     * @param param2 
     */
    public void setParam2(Operador param2) {
        this.param2 = param2;
    }
    
    /**
     * Asignar el operador resultado del cuádruplo.
     * @param result 
     */
    public void setResult(Operador result) {
        this.result = result;
    }
}
