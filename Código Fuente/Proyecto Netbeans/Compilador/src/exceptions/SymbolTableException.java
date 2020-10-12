package exceptions;

/**
 *
 * @author MarCardona
 */
public class SymbolTableException extends Exception {

    /**
     * Creates a new instance of <code>SymbolTableException</code> without
     * detail message.
     */
    public SymbolTableException() {
    }

    /**
     * Constructs an instance of <code>SymbolTableException</code> with the
     * specified detail message.
     *
     * @param msg the detail message.
     */
    public SymbolTableException(String msg) {
        super(msg);
    }
}
