package compilador;

/**
 *
 * @author María del Mar Cardona
 */
class Operador {
    
    /**
     * Dato.
     */
    private String data;
    /**
     * Operator tipo.
     */
    private TipoOperador tipo;

    /**
     * Constructor de Operador.
     * @param dato
     * @param tipo 
     */
    public Operador(String dato, TipoOperador tipo) {
        this.data = dato;
        this.tipo = tipo;
    }
    
    /**
     * Equals. 
     * @param o: operador
     * @return cierto si son iguales
     */
    public boolean equals(Operador o){
        return data.equals(o.data) && tipo == o.tipo;
    }
    
    /**
     * Obtener dato.
     * @return string
     */
    public String getData() {
        return data;
    }
    
    /**
     * Operator tipo getter.
     * @return string
     */
    public TipoOperador getTipo() {
        return tipo;
    }
}
