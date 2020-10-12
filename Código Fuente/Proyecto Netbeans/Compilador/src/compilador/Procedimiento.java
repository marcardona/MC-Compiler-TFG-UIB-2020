package compilador;

/**
 *
 * @author María del Mar Cardona
 */
class Procedimiento {
    
    /**
     * Nombre del procedimiento.
     */
    private String np;               
    /**
     * Profundidad.
     */
    private int profundidad;              
    /**
     * Nombre de la etiqueta en ensamblador.
     */
    private String initTag;          
    /**
     * Número de parámetros.
     */
    private int nParams;             
    /**
     * Ocupación de las variables locales.
     */
    private int ocupLocalVars;     
    /**
     * Ocupación de los argumentos temprales.
     */
    private int ocupTempArgs;        
    /**
     * Ocupación total.
     */
    private int ocupacion;                 

    /**
     * Constructor.
     * @param np: nombre del procedimiento
     * @param profundidad: profundidad del procedimiento
     * @param initTag: initial tag
     * @param nParams: número de parámetros
     * @param ocupLocalVars: ocupacion de las variables locales
     * @param ocupacion: total ocupacion
     */
    public Procedimiento (String np, int profundidad, String initTag, int nParams, int ocupLocalVars, int ocupacion) {
        this.np = np;
        this.profundidad = profundidad;
        this.initTag = initTag;
        this.nParams = nParams;
        this.ocupLocalVars = ocupLocalVars;
        this.ocupTempArgs = 0;
        this.ocupacion = ocupacion;
    }

    /**
     * Convertir procedimiento a String.
     * @return string
     */
    @Override
    public String toString() {
        return  "nombre: " + np + 
                ", profundidat: " + profundidad + 
                ", Etiqueta_Inicial: " + initTag + 
                ", numParametros: " + nParams + 
                ", Ocup_var_locals: " + ocupLocalVars + 
                ", Ocupacion: " + ocupacion + "\n";
    }

    /**
     * Obtener nombre del procedimiento.
     * @return nombre
     */
    public String getNp() {
        return np;
    }

    /**
     * Asignar el nombre del procedimiento.
     * @param np: name
     */
    public void setNp(String np) {
        this.np = np;
    }

    /**
     * Obtener la profundidad del procedimiento.
     * @return profundidad
     */
    public int getProfundidad() {
        return profundidad;
    }

    /**
     * Asignar la profundidad del procedimiento.
     * @param profundidad 
     */
    public void setProfundidad(int profundidad) {
        this.profundidad = profundidad;
    }

    /**
     * Obtener la etiqueta inicial del procedimiento.
     * @return init tag
     */
    public String getInitTag() {
        return initTag;
    }

    /**
     * Asignar la etiqueta inicial del procedimiento.
     * @param initTag
     */
    public void setInitTag(String initTag) {
        this.initTag = initTag;
    }

    /**
     * Obtener el número de parámetros del procedimiento.
     * @return número de parámetros
     */
    public int getnParams() {
        return nParams;
    }

    /**
     * Asignar el número de parámetros del procedimiento.
     * @param nParams 
     */
    public void setnParams(int nParams) {
        this.nParams = nParams;
    }

    /**
     * Obtener la ocupacion de la variables locales.
     * @return ocupacion de las variables locales
     */
    public int getOcupLocalVars() {
        return ocupLocalVars;
    }

    /**
     * Asignar la ocupación de las variables locales.
     * @param ocupLocalVars 
     */
    public void setOcupLocalVars(int ocupLocalVars) {
        this.ocupLocalVars = ocupLocalVars;
    }

    /**
     * Obtener la ocupación de los argumentos temporales.
     * @return ocupacion de los argumentos temporales
     */
    public int getOcupTempArgs() {
        return ocupTempArgs;
    }

    /**
     * Asignar la ocupación de los argumentos temporales.
     * @param ocupTempArgs 
     */
    public void setOcupTempArgs(int ocupTempArgs) {
        this.ocupTempArgs = ocupTempArgs;
    }

    /**
     * Obtener la ocupación total del procedimiento.
     * @return ocupacion.
     */
    public int getOcupacion() {
        return ocupacion;
    }

    /**
     * Asignar la ocupación total del procedimiento.
     * @param ocupacion 
     */
    public void setOcupacion(int ocupacion) {
        this.ocupacion = ocupacion;
    }
}
