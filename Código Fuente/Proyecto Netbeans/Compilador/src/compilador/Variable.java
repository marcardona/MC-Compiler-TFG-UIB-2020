package compilador;

/**
 *
 * @author María del Mar Cardona
 */
class Variable {
    
    /**
     * Nombre.
     */
    private String nombreVar;           
    /**
     * Id de procedimiento.
     */
    private int procId;       
    /**
     * Ocupacion.
     */
    private int ocupacion;      
    /**
     * Desplazamiento.
     */
    private int desplazamiento;    
    /**
     * Tipo.
     */
    private tsb tipo;

    /**
     * Constructor.
     * @param nombreVar: nombre de la variable
     * @param procId: id del procedimiento donde se declara
     * @param ocupacion: ocupación de la variable
     * @param desplazamiento: desplazamiento de la variable
     * @param tipo: tipo de la variable
     */
    public Variable (String nombreVar, int procId, int ocupacion, int desplazamiento, tsb tipo) {
        this.nombreVar = nombreVar;
        this.procId = procId;
        this.ocupacion = ocupacion;
        this.desplazamiento = desplazamiento;
        this.tipo = tipo;
    }
    
    /**
     * Convertir variable a String.
     * @return 
     */
    @Override
    public String toString() {
        return "nombre: " + nombreVar + 
                ", funcion: " + procId + 
                ", ocupacion: " + ocupacion + 
                ", desplazamiento: " + desplazamiento +
                ", type: "+tipo.name()+"\n";
    }

    /**
     * Obtener el nombre de la variable.
     * @return nombre.
     */
    public String getNombreVar() {
        return nombreVar;
    }

    /**
     * Asignar el nombre a la variable.
     * @param nombreVar: nombre
     */
    public void setNombreVar(String nombreVar) {
        this.nombreVar = nombreVar;
    }

    /**
     * Obtener el id del procedimiento
     * @return int id
     */
    public int getProcId() {
        return procId;
    }

    /**
     * Asignar el id del procedimiento.
     * @param procId 
     */
    public void setProcId(int procId) {
        this.procId = procId;
    }

    /**
     * Obtener la ocupación de la variable.
     * @return ocupación
     */
    public int getOcupacion() {
        return ocupacion;
    }

    /**
     * Asignar la ocupación de la variable.
     * @param ocupacion 
     */
    public void setOcupacion(int ocupacion) {
        this.ocupacion = ocupacion;
    }

    /**
     * Obtenre el desplazamiento de la variable en la tabla.
     * @return desplazamiento
     */
    public int getDesplazamiento() {
        return desplazamiento;
    }

    /**
     * Asignar el desplazamiento de la variable en la tabla.
     * @param desplazamiento 
     */
    public void setDesplazamiento(int desplazamiento) {
        this.desplazamiento = desplazamiento;
    }

    /**
     * Obtener el tipo subyacente básico de la variable.
     * @return tipo
     */
    public tsb getTipo() {
        return tipo;
    }

    /**
     * Asignar el tipo subyacente básico a la variables.
     * @param tipo 
     */
    public void setTipo(tsb tipo) {
        this.tipo = tipo;
    }
}
