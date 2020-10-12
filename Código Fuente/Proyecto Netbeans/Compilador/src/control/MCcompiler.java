package control;

import data.Data;
import userInterface.*;

/**
 *
 * @author María del Mar Cardona
 */
public class MCcompiler {
    
    /**
     * Datos.
     */
    private Data data;
    
    /**
     * Interfaz de usuario.
     */
    private final StarterPage starterPage;
    
    /**
     * Constructor.
     */
    public MCcompiler() {
        data = new Data();
        starterPage = new StarterPage(data);
        starterPage.startUI();
    }
    
    /**
     * Main.
     * @param Args 
     */
    public static void main(String Args[]) {
        new MCcompiler();
    }
}
