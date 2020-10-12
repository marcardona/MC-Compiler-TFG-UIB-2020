package data;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author María del Mar Cardona
 */
public class AccesoFichero {

    public AccesoFichero() {

    }

    /**
     * Leer fichero.Leer el fichero y almacenar su contenido en un String.
     * @param path: directorui
     * @return contenido del fichero
     * @throws java.io.IOException
     */
    public String readFile(String path) throws IOException {
        String s = "";
        // crear el fichero si no existe
        File f = new File(path);
        if (!f.exists()) {
            f.createNewFile();
        }
        try {
            FileReader fr = new FileReader(path);
            int c = fr.read();
            while (c != -1) {
                s += "" + (char) c;
                c = fr.read();
            }
        } catch (FileNotFoundException ex) {
            Logger.getLogger(AccesoFichero.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(AccesoFichero.class.getName()).log(Level.SEVERE, null, ex);
        }
        return s;
    }

    /**
     * Escribir fichero.
     * @param file: fichero
     * @param content: contenido del fichero
     */
    public void writeFile(File file, String content) {

        BufferedWriter writer = null;
        try {
            writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF8"));
            writer.write(content);
            writer.close();
        } catch (IOException ex) {
            Logger.getLogger(AccesoFichero.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                writer.close();
            } catch (IOException ex) {
                Logger.getLogger(AccesoFichero.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * Duplicar fichero.
     * Duplica el fichero con un nuevo nombre.
     * @param filepath: directoriuo del fichero.
     * @param newName: nuevo nombre
     */
    public void duplicateFile(String filepath, String newName) {
        File source = new File(filepath);
        File dest = new File(source.getParent()+"/"+newName);
        InputStream is = null;
        OutputStream os = null;
        try {
            is = new FileInputStream(source);
            os = new FileOutputStream(dest);
            byte[] buffer = new byte[1024];
            int length;
            while ((length = is.read(buffer)) > 0) {
                os.write(buffer, 0, length);
            }
            is.close();
            os.close();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(AccesoFichero.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(AccesoFichero.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
