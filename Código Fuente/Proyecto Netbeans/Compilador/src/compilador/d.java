package compilador;


/**
 *
 * @author María del Mar Cardona
 */
public class d {
    
    /**
     * dtipo.
     */
    private dtipo dtipo;
    /**
     * Tipo subyacente basico.
     */
    private tsb tsb;
    /**
     * Tamaño.
     */
    private int size;
    /**
     * Límite inferior.
     */
    private int infLimit;
    /**
     * Límite superior..
     */
    private int supLimit;
    /**
     * Nombre.
     */
    private String idb;
    /**
     * Hijos.
     */
    private int hijos;
    /**
     * Padre.
     * 0 si no tiene padre.
     */
    private int padre;
    /**
     * Referencia.
     */
    private int r;                          
    
    /**
     * Constructor vacío.
     */
    public d() {
        hijos = 0;
        padre = 0;
        r = -1;
    }
    
    /**
     * Constructor.
     * @param dtipo
     * @param tsb 
     * @param size 
     * @param infLimit 
     * @param supLimit 
     */
    public d(dtipo dtipo, tsb tsb, int size, int infLimit, int supLimit){
        hijos = 0;
        padre = 0;
        r = -1;
        this.dtipo = dtipo;
        this.tsb = tsb;
        this.size = size;
        this.infLimit = infLimit;
        this.supLimit = supLimit;
    }
    
    /**
     * Constructor.
     * @param dtipo
     * @param tsb 
     */
    public d(dtipo dtipo, tsb tsb){
        hijos = 0;
        padre = 0;
        r = -1;
        this.dtipo = dtipo;
        this.tsb = tsb;
    }
    
    
    // Getters and setters

    /**
     * Obtener dtipo
     * @return dtipo
     */
    public dtipo getDtipo() {
        return dtipo;
    }

    /**
     * Asignar dtipo
     * @param dtipo 
     */
    public void setDtipo(dtipo dtipo) {
        this.dtipo = dtipo;
    }

    /**
     * Obtener tipo subyacente básico
     * @return tsb
     */
    public tsb getTsb() {
        return tsb;
    }

    /**
     * Asignar tipo subyacente básico.
     * @param tsb 
     */
    public void setTsb(tsb tsb) {
        this.tsb = tsb;
    }

    /**
     * Obtener tamaño.
     * @return tamaño
     */
    public int getSize() {
        return size;
    }

    /**
     * Asignar tamaño.
     * @param size 
     */
    public void setSize(int size) {
        this.size = size;
    }

    /**
     * Obtener límite inferior.
     * @return límite inferior.
     */
    public int getInfLimit() {
        return infLimit;
    }

    /**
     * Asignar límite inferior.
     * @param infLimit 
     */
    public void setInfLimit(int infLimit) {
        this.infLimit = infLimit;
    }

    /**
     * Obtener límite superior.
     * @return límite superior.
     */
    public int getSupLimit() {
        return supLimit;
    }

    /**
     * Asignar límite superior
     * @param supLimit 
     */
    public void setSupLimit(int supLimit) {
        this.supLimit = supLimit;
    }

    /**
     * Obtener idb.
     * @return 
     */
    public String getIdb() {
        return idb;
    }

    /**
     * Asignar idb.
     * @param idb 
     */
    public void setIdb(String idb) {
        this.idb = idb;
    }

    /**
     * Obtener número de hijos.
     * @return número de hijos.
     */
    public int getSons() {
        return hijos;
    }

    /**
     * Asignar hijos.
     * @param son 
     */
    public void setSons(int son) {
        this.hijos = son;
    }

    /**
     * Obtener padre.
     * @return referencia padre.
     */
    public int getPadre() {
        return padre;
    }

    /**
     * Asignar referencia de padre.
     * @param padre
     */
    public void setPadre(int padre) {
        this.padre = padre;
    }

    /**
     * Obtener referencia.
     * @return referencia
     */
    public int getR() {
        return r;
    }
    
    /**
     * Asignar referencia.
     * @param r 
     */
    public void setR(int r) {
        this.r = r;
    }

    
    
}
