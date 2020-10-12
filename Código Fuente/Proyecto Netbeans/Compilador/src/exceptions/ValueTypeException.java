package exceptions;

/**
 *
 * @author MarCardona
 */
public class ValueTypeException extends Exception {

    /**
     * Creates a new instance of <code>ValueTypeException</code> without detail
     * message.
     */
    public ValueTypeException() {
    }

    /**
     * Constructs an instance of <code>ValueTypeException</code> with the
     * specified detail message.
     *
     * @param msg the detail message.
     */
    public ValueTypeException(String msg) {
        super(msg);
    }
}
