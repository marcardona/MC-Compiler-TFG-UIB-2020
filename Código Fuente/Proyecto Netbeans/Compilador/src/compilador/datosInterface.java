package compilador;

import java.io.File;

/**
 *
 * @author María del Mar Cardona
 */
public interface datosInterface {
    
    public String getProjectPath();
    
    public String[] getProjectScripts();
    
    public String getMainScript();
    
    public File generarSourceCode();
    
    public String getCodigo();
}
