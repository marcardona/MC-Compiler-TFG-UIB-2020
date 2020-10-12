package data;

import exceptions.FileException;
import java.awt.List;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import userInterface.CreateProject;

/**
 *
 * @author MarCardona
 */
public class Data implements userInterface.dataInterface, compilador.datosInterface {
    
    /**
     * Directorio completo del proyecto.
     */
    private String directorioProyecto;
    /**
     * Script actualmente en edición.
     */
    private String scriptActual;
    /**
     * Nombre del proyecto.
     */
    private String nombreProyecto;
    /**
     * Nombre del vector de entrada.
     */
    private String nombreVectorEnt;
    /**
     * Fin de fichero.
     */
    private static final int END_OF_FILE = -1;
    
    /**
     * Asignar directorio del proyecto.
     * @param dir 
     */
    @Override
    public void setCurrentProjectPath(String dir) {
        directorioProyecto = dir;
    }
    
    /**
     * Asignar nombre del proyecto.
     * @param nombre 
     */
    @Override
    public void setCurrentProjectName(String nombre) {
        nombreProyecto = nombre;
    }
    
    /**
     * Obtener el nombre del proyecto.
     * @return nombre.
     */
    @Override
    public String getNombreProyecto() {
        return nombreProyecto;
    }
    
    /**
     * Asignar el script actual en edición.
     * @param file: fichero que se edita.
     */
    @Override
    public void setScriptActual(String file) {
        scriptActual = file;
    }

    /**
     * Obtener contenido del script.
     * Leer el fichero del script.
     * @return string: contenido del script.
     */
    @Override
    public String getScriptActual() {
        String script = "";
        try {
            FileReader fr = new FileReader(directorioProyecto+"/"+scriptActual);
            BufferedReader br = new BufferedReader(fr);
            int c = br.read();
            while (c != END_OF_FILE) {
                script += ""+ (char) c;
                c = br.read();
            }
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex);
        }
        return script;
    }

    /**
     * Obtener todos los scripts ".tc" del proyecto.
     * @return ficheros con extensión .tc
     */
    @Override
    public String[] getProjectScripts() {
        // open directory
        File f = new File(directorioProyecto+"/scripts");
        String allFiles[] = f.list();
        // count .tc scripts
        int nScripts = 0;
        for (String file: allFiles) {
            if (file.substring(file.length()-3, file.length()).equals(".tc")) {
                nScripts++;
            }
        }
        // get the .tc scripts
        int i = 0;
        String[] scripts = new String[nScripts];
        for (String file: allFiles) {
            if (file.substring(file.length()-3, file.length()).equals(".tc")) {
                scripts[i] = file; i++;
            }
        }
        return scripts;
    }
    
    /**
     * Obtener el contenido de texto de un script.
     * @param path: directorio completo del script
     * @return contenido de texto
     * @throws File Exception
     */
    @Override
    public String getContenidoScript(String path) {
        AccesoFichero af = new AccesoFichero();
        String s = "";
        try {
            s = af.readFile(path);
        } catch (IOException ex) {
            try {
                throw new FileException("Error: File Exception 1.\n"
                        +"Error getting the content of "+path+".");
            } catch (FileException ex1) {
                Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex1);
            }
        }
        return s;
    }
    
    /**
     * Obtener el nombre del script actual en edición.
     * @return nombre.
     */
    @Override
    public String getScriptNombre() {
        return scriptActual;
    }

    /**
     * Obtener directorio del proyecto.
     * @return 
     */
    @Override
    public String getProjectPath() {
        return directorioProyecto;
    }

    /**
     * Obtener el nombre del programa principal (main).
     * @return nombre del script.
     */
    @Override
    public String getMainScript() {
        return nombreProyecto+".tc";
    }
    
    /**
     * Generar código fuente.
     * Este método genera el fichero que contiene todo el código fuente del
     * proyecto. Este archivo contiene todos los scripts del proyecto..
     * @return fichero del código fuente.
     */
    @Override
    public File generarSourceCode() {

        String root = directorioProyecto;
        String code = getCodigo();
        
        // make build dir
        File buildDir = new File(root + "/" + "build");
        if (!buildDir.exists()) {
            buildDir.mkdir();
        }
        File codePath = new File(buildDir.getAbsolutePath() + "/" + "sourceCode.mc");
        try {
            if (codePath.exists()) {
                codePath.delete();
            }
            codePath.createNewFile();
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(codePath))) {
                writer.write(code);
            }
        } catch (IOException ex) {
            Logger.getLogger(CreateProject.class.getName()).log(Level.SEVERE, null, ex);
        }

        return codePath;
    }

    /**
     * Obtener código fuente.
     * Método que une en un único string todos los scripts del proyecto.
     * @return string con el código
     */
    public String getCodigo() {
        String files[] = getProjectScripts();
        String root = directorioProyecto;
        String code = "";
        for (String file : files) {
            try {
                FileReader fr = new FileReader(root + "/scripts/" + file);
                BufferedReader br = new BufferedReader(fr);
                int c = br.read();
                while (c != END_OF_FILE) {
                    code += "" + (char) c;
                    c = br.read();
                }
                code += "\n\n";
            } catch (FileNotFoundException ex) {
                Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return code;
    }

    /**
     * Obtener nombre del vector de entrada.
     * @return nombre
     */
    public String getNombreVectorEnt() {
        return nombreVectorEnt;
    }

    /**
     * Asignar nombre al vector de entrada.
     * @param nombreVectorEnt 
     */
    public void setNombreVectorEnt(String nombreVectorEnt) {
        this.nombreVectorEnt = nombreVectorEnt;
    }
    
}
