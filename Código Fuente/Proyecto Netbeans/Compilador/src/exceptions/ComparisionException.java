package exceptions;

/**
 *
 * @author MarCardona
 */
public class ComparisionException extends Exception {

    /**
     * Creates a new instance of <code>ComparisionException</code> without
     * detail message.
     */
    public ComparisionException() {
    }

    /**
     * Constructs an instance of <code>ComparisionException</code> with the
     * specified detail message.
     *
     * @param msg the detail message.
     */
    public ComparisionException(String msg) {
        super(msg);
    }
}
