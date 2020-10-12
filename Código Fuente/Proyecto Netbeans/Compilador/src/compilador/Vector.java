package compilador;
/**
 *
 * @author María del Mar Cardona
 */
public class Vector {
    
    /**
     * Id del vector.
     */
    private int idVector;
    /**
     * Nombre del vector.
     */
    private String nombreVector;
    /**
     * Id del procedimiento.
     * Donde se declara el vector.
     */
    private final int idProcedimiento;
    /**
     * Nombre del procedimiento.
     */
    private String nombreProcedimiento;
    /**
     * Primer item de la lista enlazada de parámetros.
     */
    private Parametro param;
    
    /**
     * Constructor.
     * @param nombreVector: nombre del vector
     * @param idProcedimiento: id del procedimiento
     * @param nombreProcedimiento: nombre del procedimiento
     */
    public Vector (String nombreVector, int idProcedimiento, String nombreProcedimiento) {
        this.nombreVector = nombreVector;
        this.idProcedimiento = idProcedimiento;
        this.nombreProcedimiento = nombreProcedimiento;
        this.param = null;
    }
    
    /**
     * Constructor.
     * @param idVector: id del vector
     * @param nombreVector: nombre del vector
     * @param idProcedimiento: id del procedimiento
     * @param nombreProcedimiento: nombre del procedimiento
     */
    public Vector (int idVector, String nombreVector, int idProcedimiento, String nombreProcedimiento) {
        this.idVector = idVector;
        this.nombreVector = nombreVector;
        this.idProcedimiento = idProcedimiento;
        this.nombreProcedimiento = nombreProcedimiento;
        this.param = null;
    }

    /**
     * Encontrar parámetro.
     * Buscar un vector como parámetro.
     * @param vnombre: nombre del vector como parámetro
     * @param pnombre: nombre del procedimiento
     * @return true si lo ha encontrado
     */
    public boolean findInParams (String vnombre, String pnombre) {
        Parametro p = this.param;
        Parametro np = new Parametro(vnombre, pnombre);
        while (p != null) {
            if (p.equals(np)) return true;
            p = p.getNext();
        }
        return false;
    }
    

    /**
     * Obtener nombre del vector.
     * @return nombre
     */
    public String getVectorName() {
        return nombreVector;
    }

    /**
     * Obtener id del procedimiento.
     * @return id
     */
    public int getIdProcedimiento() {
        return idProcedimiento;
    }

    /**
     * Obtener nombre del procedimeinto.
     * @return nombre del procedimiento.
     */
    public String getProcedureName() {
        return nombreProcedimiento;
    }

    /**
     * Obtener parámetro.
     * @return primer item de la lista enlazada de parámetros.
     */
    public Parametro getParam() {
        return param;
    }

    /**
     * Insertar parámetro.
     * Añade el parámetro al final de la lista de parámetros
     * @param param: parámetro a añdir.
     */
    public void setParam(Parametro param) {
        if (this.param == null) {
            this.param = param;
        } else {
            Parametro p = this.param;
            while (p.getNext() != null) {
                p = p.getNext();
            }
            p.setNext(param);
        }
        
    }
    
    /**
     * Obtener id del vector
     * @return vector id.
     */
    public int getIdVector() {
        return idVector;
    }
    
    /**
     * Asignar id al vector.
     * @param idVector 
     */
    public void setIdVector(int idVector) {
        this.idVector = idVector;
    }
}
