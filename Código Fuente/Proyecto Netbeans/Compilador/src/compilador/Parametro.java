package compilador;


/**
 *
 * @author María del Mar Cardona
 */
public class Parametro {
 
    /**
     * Nombre del vector como parámetro.
     */
    private String nombreVector;
    /**
     * Nombre del procedimiento en el que el vector llega como parámetro.
     */
    private String nombreProcedimiento;
    /**
     * Siguiente parámetro de la lista.
     */
    private Parametro next;
    
    /**
     * Constructor de parámetro.
     * @param nombreVector: nombre del vector como parámetro.
     * @param nombreProcedimiento: nombre del procedimiento donde el vector llega 
     * como parámetro.
     */
    public Parametro(String nombreVector, String nombreProcedimiento) {
        this.nombreVector = nombreVector;
        this.nombreProcedimiento = nombreProcedimiento;
        this.next = null;
    }
    
    /**
     * Obtener nombre del vector.
     * @return string.
     */
    public String getNombreVector (){
        return nombreVector;
    }
    
    /**
     * Obtener nombre del procedimiento.
     * @return string.
     */
    public String getNombreProcedimiento (){
        return nombreProcedimiento;
    }
    
    /**
     * Obtener siguiente parámetro.
     * @return parameter.
     */
    public Parametro getNext() {
        return next;
    }
    
    /**
     * Asignar siguiente parámetro.
     * @param next 
     */
    public void setNext (Parametro next) {
        this.next = next;
    }
    
    /**
     * Comparar parámetros..
     * Compara si dos parámetros son iguales.
     * @param p: parámetro con el que se compara el objeto.
     * @return true si son iguales.
     */
    public boolean equals (Parametro p) {
        return this.nombreVector.equals(p.nombreVector) && this.nombreProcedimiento.equals(p.nombreProcedimiento);
    }
    
    /**
     * Asignar nombre al vector.
     * @param nombreVector: nombre del vector.
     */
    public void setNombreVector(String nombreVector) {
        this.nombreVector = nombreVector;
    }
    
    /**
     * Asignar nombre al procedimiento.
     * @param nombreProcedimiento: nombre del procedimiento.
     */
    public void setNombreProcedimiento(String nombreProcedimiento) {
        this.nombreProcedimiento = nombreProcedimiento;
    }
}
