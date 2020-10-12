package exceptions;

/**
 *
 * @author MarCardona
 */
public class IntermediateCodeException extends Exception {

    /**
     * Creates a new instance of <code>IntermediateCodeException</code> without
     * detail message.
     */
    public IntermediateCodeException() {
    }

    /**
     * Constructs an instance of <code>IntermediateCodeException</code> with the
     * specified detail message.
     *
     * @param msg the detail message.
     */
    public IntermediateCodeException(String msg) {
        super(msg);
    }
}
