package compilador;

import java.io.Reader;
import java.io.BufferedReader;
import java.io.FileReader;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.Symbol;
import java_cup.runtime.SymbolFactory;
import data.Data;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import userInterface.CreateProject;

/**
 *
 * @author María del Mar Cardona
 */
public class Compilador implements userInterface.compiladorInterface {

    /**
     * Datos del programa.
     */
    private Data data;
    /**
     * Código fuente del programa.
     */
    private File sourceCode;

    /**
     * Constructor.
     * @param data: datos
     */
    public Compilador(Data data) {
        this.data = data;
        this.sourceCode = generarSourceCode();
    }

    /**
     * Iniciar proceso de compilación.
     * @return string con detalles de la compilación.
     */
    @Override
    public String iniciarCompilacion() {
        Reader input;
        try {
            input = new FileReader(sourceCode);
            SymbolFactory sf = new ComplexSymbolFactory();
            Scanner scanner = new Scanner(input, data);
            Parser parser = new Parser(scanner, data.getNombreProyecto(), data.getProjectPath(), data.getNombreVectorEnt());
            Symbol result = parser.parse();
            
            return (String) (result.value);

        } catch (Exception e) {
            String msg = "Error de compilación: "
                    + "\n" + e.getMessage();
            System.err.println(msg);
            PrintStream ps = null;
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
            LocalDateTime now = LocalDateTime.now();
            String fileName = data.getProjectPath() + "/errors/" + data.getNombreProyecto() + "" + dtf.format(now);
            File errorsDir = new File(data.getProjectPath() + "/errors");
            if (!errorsDir.exists()) {
                errorsDir.mkdir();
            }
            try {
                ps = new PrintStream(fileName);
                System.setErr(ps);
                System.err.println("error: " + e);
            } catch (FileNotFoundException ex) {
                Logger.getLogger(Compilador.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                ps.close();
            }
            return msg + "\n File error: " + fileName;
        }
    }

    /**
     * Generar código fuente.
     * Generar un único archivo que unifica todos los scripts del proyecto.
     * @return fichero con el código fuente.
     */
    private File generarSourceCode() {

        String root = data.getProjectPath();
        String code = obtenerCódigo();

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
     * Scripts del proyecto.
     * Leer todos los scripts del proyecto.
     * @return string con el código.
     */
    private String obtenerCódigo() {
        String files[] = data.getProjectScripts();
        String root = data.getProjectPath();
        String code = "";
        try {
            FileReader fr = new FileReader(root + "/scripts/" + data.getMainScript());
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
        for (String file : files) {
            if (!file.equals(data.getMainScript())) {
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
        }
        return code;
    }

    /**
     * End of file.
     */
    private static final int END_OF_FILE = -1;
}
