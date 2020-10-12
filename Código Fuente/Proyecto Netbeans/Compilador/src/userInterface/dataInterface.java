package userInterface;


/**
 *
 * @author María del Mar Cardona
 */
public interface dataInterface {
    
    public void setCurrentProjectPath(String dir);
    
    public void setCurrentProjectName(String name);
    
    public String getNombreProyecto();
    
    public void setScriptActual(String file);
    
    public String getScriptActual();
    
    public String[] getProjectScripts();
    
    public String getScriptNombre();
    
    public String getProjectPath();
    
    public String getContenidoScript(String name);
    
}
