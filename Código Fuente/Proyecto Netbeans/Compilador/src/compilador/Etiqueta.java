package compilador;

/**
 *
 * @author María del Mar Cardona
 */
class Etiqueta {
    
    private String nombre;
    private int procedimiento;

    public Etiqueta (String nombre, int procedimiento) {
        this.nombre = nombre;
        this.procedimiento = procedimiento;
    }

    @Override
    public String toString() {
        return "nombre: " + nombre + ", funcion: " + procedimiento +"\n";
    }

    /**
     * Obtener nombre de la etiqueta.
     * @return nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Establecer el nombre de la etiqueta.
     * @param nombre 
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Obtener el id del procedimiento.
     * @return identificador numérico del procedimiento
     */
    public int getProcedimiento() {
        return procedimiento;
    }

    
    /**
     * Establece el procedimiento.
     * @param identificador numérico del procedimiento 
     */
    public void setProcedimiento(int procedimiento) {
        this.procedimiento = procedimiento;
    }
}
