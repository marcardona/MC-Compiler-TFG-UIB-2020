package userInterface;

import compilador.Compilador;
import data.AccesoFichero;
import data.Data;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.FontMetrics;
import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFileChooser;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTextPane;
import javax.swing.filechooser.FileFilter;
import javax.swing.text.SimpleAttributeSet;
import javax.swing.text.StyleConstants;
import javax.swing.text.TabSet;
import javax.swing.text.TabStop;

/**
 * @author María del Mar Cardona
 */
public class UserInterface extends javax.swing.JFrame {

    /**
     * Datos del proyecto.
     */
    private Data data;

    /**
     * Crear UserInterface. Crea un nuevo form de la interfaz de usuario.
     *
     * @param data
     */
    public UserInterface(Data data) {
        this.data = data;
        initComponents();
        initUserInterface();
        this.setTitle("MC Compiler");
    }

    /**
     * Iniciar componentes de la interfaz.
     */
    private void initUserInterface() {
        projectNameLabel.setText(data.getNombreProyecto());
        loadTabPanes();
        addMenuBar();
    }

    /**
     * Mostrar interfaz.
     */
    public void showUI() {
        this.pack();
        this.setVisible(true);
        this.setResizable(false);
        this.setPreferredSize(new Dimension(900, 666));
        this.setSize(900, 666);
        this.setLocationRelativeTo(null);
    }

    /**
     * Añadir shortcuts. Este método simula los mnemónicos de la barra del menú.
     */
    private void setShortCuts(Component c) {
        // is like the mnemonic for save
        c.setFocusTraversalKeysEnabled(false);
        c.addKeyListener(new KeyListener() {

            @Override
            public void keyPressed(KeyEvent e) {

                switch (e.getKeyCode()) {
                    case KeyEvent.VK_F1:
                        newScriptAction();
                        break;
                    case KeyEvent.VK_F2:
                        newProjectAction();
                        break;
                    case KeyEvent.VK_F3:
                        openProjectAction();
                        break;
                    case KeyEvent.VK_F4:
                        saveAction();
                        break;
                    case KeyEvent.VK_F5:
                        openScriptAction();
                        break;
                    case KeyEvent.VK_F6:
                        closeScriptAction();
                        break;
                    case KeyEvent.VK_F7: 
                        try {
                        editEntryVector();
                    } catch (IOException ex) {
                        Logger.getLogger(UserInterface.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    break;
                    case KeyEvent.VK_F8:
                        runProject();
                        break;
                    case KeyEvent.VK_F9:
                        cleanProject();
                        break;
                }
            }

            @Override
            public void keyReleased(KeyEvent e) {
            }

            @Override
            public void keyTyped(KeyEvent e) {
                JTextPane c = (JTextPane) (((((JScrollPane) tabbedPane.getComponentAt(tabbedPane.getSelectedIndex())).getViewport()))).getView();
                int cursor;
                switch (e.getKeyChar()) {
                    case KeyEvent.VK_TAB:
                        cursor = c.getCaretPosition() - 1;
                        c.setText(c.getText().replaceAll("\t", "    "));
                        c.setCaretPosition(cursor + 4);
                        break;
                    case KeyEvent.VK_ENTER:
                        cursor = c.getCaretPosition() - 2;
                        if (cursor >= 0) {
                            int indent = getIndent(c.getText(), cursor);
                            c.setText(c.getText().substring(0, cursor + 2) + " ".repeat(indent) + c.getText().substring(cursor + 2));
                            c.setCaretPosition(cursor + 2 + indent);
                        }
                        break;
                    /*case 8:
                        cursor = c.getCaretPosition() - 1;
                        while (cursor >= 0 && c.getText().charAt(cursor) == ' ') {
                            cursor--;
                        }
                        if (c.getText().charAt(cursor) == '\n') {
                            int newCaretPosition = c.getCaretPosition() - 3;
                            c.setText(c.getText().substring(0, c.getCaretPosition() - 3) + c.getText().substring(c.getCaretPosition()));
                            c.setCaretPosition(newCaretPosition);
                        }
                        break;*/
                }
            }
        });
    }

    private int getIndent(String text, int cursor) {
        for (; cursor >= 0; cursor--) {
            if (text.charAt(cursor) == '\n') {
                cursor++;
                return countTabs(text, cursor);
            }
        }
        return 0;
    }

    private int countTabs(String text, int cursor) {
        int tabs = 0;
        for (int i = cursor; text.charAt(i) == ' '; i++) {
            tabs++;
        }
        return tabs;
    }

    /**
     * Barra de menú.
     */
    private void addMenuBar() {
        // menu bar
        JMenuBar menuBar = new JMenuBar();

        // menus
        JMenu mccompiler = new JMenu("MC Compiler");
        JMenu file = new JMenu("Archivo");
        JMenu run = new JMenu("Ejecutar");
        JMenu edit = new JMenu("Editar");
        menuBar.add(mccompiler);
        menuBar.add(file);
        menuBar.add(edit);
        menuBar.add(run);

        // file items
        JMenuItem newScript;
        JMenuItem newProject;
        JMenuItem openProject;
        JMenuItem save;
        JMenuItem openScript;
        JMenuItem closeScript;
        newScript = new JMenuItem("Nuevo Script          F1");
        newProject = new JMenuItem("Nuevo Proyecto     F2");
        openProject = new JMenuItem("Abrir Proyecto       F3");
        save = new JMenuItem("Guardar                 F4");
        openScript = new JMenuItem("Abrir Script           F5");
        closeScript = new JMenuItem("Cerrar Script         F6");

        file.add(newScript);
        file.add(newProject);
        file.addSeparator();
        file.add(openProject);
        file.addSeparator();
        file.add(save);
        file.addSeparator();
        file.add(openScript);
        file.add(closeScript);

        newScript.addActionListener((ActionEvent e) -> {
            newScriptAction();
        });

        newProject.addActionListener((ActionEvent e) -> {
            newProjectAction();
        });

        openProject.addActionListener((ActionEvent e) -> {
            openProjectAction();
        });

        save.addActionListener((ActionEvent e) -> {
            saveAction();
        });

        openScript.addActionListener((ActionEvent e) -> {
            openScriptAction();
        });

        closeScript.addActionListener((ActionEvent e) -> {
            closeScriptAction();
        });

        // edit items
        JMenuItem entryVector = new JMenuItem("Vector de Entrada   F7");
        edit.add(entryVector);
        entryVector.addActionListener((ActionEvent e) -> {
            try {
                editEntryVector();
            } catch (IOException ex) {
                Logger.getLogger(UserInterface.class.getName()).log(Level.SEVERE, null, ex);
            }
        });

        // run items
        JMenuItem runProject = new JMenuItem("Ejecutar Proyecto     F8");
        JMenuItem cleanProject = new JMenuItem("Limpiar Proyecto      F9");
        run.add(runProject);
        run.addSeparator();
        run.add(cleanProject);

        runProject.addActionListener((ActionEvent e) -> {
            runProject();
        });
        cleanProject.addActionListener((ActionEvent e) -> {
            cleanProject();
        });

        this.setJMenuBar(menuBar);
    }

    /**
     * Acción abrir proyecto.
     */
    private void openProjectAction() {
        this.setVisible(false);
        this.dispose();
        StarterPage starterPage = new StarterPage(data);
        starterPage.startUI();
    }

    /**
     * Guardar el contenido del editor de texto.
     */
    private void saveAction() {
        statusLabel.setText("Saved");
        refreshComponent(statusLabel);

        for (int i = 0; i < tabbedPane.getTabCount(); i++) {
            String scriptName = tabbedPane.getTitleAt(i);
            Component comp = tabbedPane.getComponentAt(i);
            JScrollPane tp = (JScrollPane) comp;
            JTextPane c = (JTextPane) (((((JScrollPane) tabbedPane.getComponentAt(i)).getViewport()))).getView();
            String content = c.getText();

            File script = new File(data.getProjectPath() + "/scripts/" + scriptName);
            AccesoFichero af = new AccesoFichero();
            af.writeFile(script, content);
        }

    }

    /**
     * Acción crear nuevo script. Abre la ventana para crear un nuevo script.
     */
    private void newScriptAction() {
        String msg = "¿Quieres guardar los cambios antes de continuar?";
        String title = "Cambios no guardados";
        if (!statusLabel.getText().equals("Guardado")) {
            int answer = JOptionPane.showConfirmDialog(null, msg, title, JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.INFORMATION_MESSAGE);
            switch (answer) {
                case JOptionPane.CANCEL_OPTION:
                    break;
                case JOptionPane.YES_OPTION:
                    saveAction();
                case JOptionPane.NO_OPTION:
                    this.dispose();
                    NewScript ns = new NewScript(data);
                    ns.start();
                    break;
            }
        } else {
            this.dispose();
            NewScript ns = new NewScript(data);
            ns.start();
        }
    }

    /**
     * Acción crear nuevo proyecto.
     */
    private void newProjectAction() {
        String msg = "¿Quieres guardar los cambios antes de continuar?";
        String title = "Cambios no guardados";
        if (!statusLabel.getText().equals("Guardado")) {
            int answer = JOptionPane.showConfirmDialog(null, msg, title, JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.INFORMATION_MESSAGE);
            switch (answer) {
                case JOptionPane.CANCEL_OPTION:
                    break;
                case JOptionPane.YES_OPTION:
                    saveAction();
                case JOptionPane.NO_OPTION:
                    this.dispose();
                    CreateProject cp = new CreateProject();
                    cp.start();
                    break;
            }
        } else {
            this.dispose();
            CreateProject cp = new CreateProject();
            cp.start();
        }

    }

    /**
     * Acción cerrar script.
     */
    private void closeScriptAction() {
        String msg = "¿Quieres guardar los cambios antes de continuar?";
        String title = "Cambios no guardados";
        if (!statusLabel.getText().equals("Guardado")) {
            int answer = JOptionPane.showConfirmDialog(null, msg, title, JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.INFORMATION_MESSAGE);
            switch (answer) {
                case JOptionPane.CANCEL_OPTION:
                    break;
                case JOptionPane.YES_OPTION:
                    saveAction();
                case JOptionPane.NO_OPTION:
                    tabbedPane.remove(tabbedPane.getSelectedIndex());
                    break;
            }
        } else {
            tabbedPane.remove(tabbedPane.getSelectedIndex());
        }
    }

    /**
     * Acción abrir script.
     */
    private void openScriptAction() {
        String msg = "¿Quieres guardar los cambios antes de continuar?";
        String title = "Cambios no guardados";
        if (!statusLabel.getText().equals("Guardado")) {
            int answer = JOptionPane.showConfirmDialog(null, msg, title, JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.INFORMATION_MESSAGE);
            switch (answer) {
                case JOptionPane.CANCEL_OPTION:
                    break;
                case JOptionPane.YES_OPTION:
                    saveAction();
                case JOptionPane.NO_OPTION:
                    openScript();
                    break;
            }
        } else {
            openScript();
        }

    }

    /**
     * Apertura de un script a seleccionar por el usuario.
     */
    private void openScript() {
        JFileChooser jfc = new JFileChooser(data.getProjectPath() + "/scripts/");
        int returnValue = jfc.showOpenDialog(null);
        if (returnValue == JFileChooser.APPROVE_OPTION) {
            File selectedFile = jfc.getSelectedFile();
            String text = data.getContenidoScript(selectedFile.getAbsolutePath());
            if (tabbedPaneExists(selectedFile.getName())) {
                JOptionPane.showMessageDialog(null, "Este script ya está abierto", "Error abriendo script", JOptionPane.DEFAULT_OPTION);
            } else if (!selectedFile.getParent().equals(data.getProjectPath() + "/scripts")) {
                JOptionPane.showMessageDialog(null, "Este script no pertenece al proyecto", "Error abriendo script", JOptionPane.DEFAULT_OPTION);
            } else {
                JTextPane tp = new JTextPane();
                tp.setText(text);
                JScrollPane jsp = new JScrollPane(tp);
                TextLineNumber tln = new TextLineNumber(tp);
                jsp.setRowHeaderView(tln);
                tabbedPane.addTab(selectedFile.getName(), jsp);
            }
        }
    }

    /**
     * Buscar una pestaña del panel.
     *
     * @param title: nombre de la pestaña.
     * @return true si existe.
     */
    private boolean tabbedPaneExists(String title) {
        for (int i = 0; i < tabbedPane.getTabCount(); i++) {
            if (tabbedPane.getTitleAt(i).equals(title)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Acción editar vector de entrada.
     *
     * @throws IOException
     */
    private void editEntryVector() throws IOException {
        String msg = "¿Quieres guardar los cambios antes de continuar?";
        String title = "Cambios no guardados";
        if (!statusLabel.getText().equals("Guardado")) {
            int answer = JOptionPane.showConfirmDialog(null, msg, title, JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.INFORMATION_MESSAGE);
            switch (answer) {
                case JOptionPane.CANCEL_OPTION:
                    break;
                case JOptionPane.YES_OPTION:
                    saveAction();
                case JOptionPane.NO_OPTION:
                    this.setEnabled(false);
                    VectorEditor ve = new VectorEditor(data, this);
                    ve.start();
                    break;
            }
        } else {
            this.setEnabled(false);
            VectorEditor ve = new VectorEditor(data, this);
            ve.start();
        }
    }

    /**
     * Ejecutar proyecto. Lanzar el proceso de compilación.
     */
    private void runProject() {
        saveAction();
        Compilador c = new Compilador(data);
        String output = c.iniciarCompilacion();
        showOutput(output);
    }

    /**
     * Limpiar el proyecto. Eliminar los archivos generados en el proceso de
     * compilación.
     */
    private void cleanProject() {
        saveAction();
        // borrar la carpeta assembly y su contenido si existe
        emptyDirectory(data.getProjectPath() + "/assembly");
        // borrar la carpeta errors y su contenido si existe
        emptyDirectory(data.getProjectPath() + "/errors");
        // borrar la carpeta errors y su contenido si existe
        emptyDirectory(data.getProjectPath() + "/build");
        File f = new File(data.getProjectPath() + "/output");
        if (f.exists()) {
            f.delete();
        }
        // volver a crear la carpeta build
        File files = new File(data.getProjectPath() + "/build");
        files.mkdir();
        // volver a crear la carpeta files
        files = new File(data.getProjectPath() + "/build/files");
        files.mkdir();
        // crear el vector de entrada
        File entFile = new File(files.getPath() + "/" + data.getNombreVectorEnt());
        char[] content = new char[1024];
        Arrays.fill(content, '#');
        String vectorContent = new String(content);
        AccesoFichero af = new AccesoFichero();
        af.writeFile(entFile, vectorContent);
        showOutput("Proyecto Limpio");
    }

    /**
     * Vaciar directorio.
     *
     * @param path: directorio.
     */
    private void emptyDirectory(String path) {
        File directory = new File(path);
        if (directory.exists()) {
            File files[] = directory.listFiles();
            for (File f : files) {
                if (f.isDirectory()) {
                    emptyDirectory(f.getAbsolutePath());
                } else {
                    f.delete();
                }
            }
        }
        directory.delete();
    }

    /**
     * Mostrar la salida de la compilación. Si se ha compilado el proyecto y
     * existe una ventana que contenga un resultado anterior, se actualiza. Si
     * la pestaña no existe, se crea.
     *
     * @param output
     */
    private void showOutput(String output) {

        JTextPane jtp = new JTextPane();
        jtp.setText(output);
        jtp.setEditable(false);
        JScrollPane tp = new JScrollPane(jtp);

        String tabName = tabbedPane.getTitleAt(tabbedPane.getTabCount() - 1);
        if (!tabName.equals("resultado")) {
            tabbedPane.addTab("resultado", tp);
        } else {
            tabbedPane.setComponentAt(tabbedPane.getTabCount() - 1, tp);
        }
        tabbedPane.setSelectedIndex(tabbedPane.getTabCount() - 1);
        refreshComponent(tabbedPane);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jMenuBar1 = new javax.swing.JMenuBar();
        jMenu1 = new javax.swing.JMenu();
        jMenu2 = new javax.swing.JMenu();
        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        projectNameLabel = new javax.swing.JLabel();
        statusLabel = new javax.swing.JLabel();
        tabbedPane = new javax.swing.JTabbedPane();
        jScrollPane2 = new javax.swing.JScrollPane();
        scriptTextPane = new javax.swing.JTextPane();

        jMenu1.setText("File");
        jMenuBar1.add(jMenu1);

        jMenu2.setText("Edit");
        jMenuBar1.add(jMenu2);

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setSize(new java.awt.Dimension(829, 525));

        jPanel4.setBackground(new java.awt.Color(250, 250, 250));

        projectNameLabel.setText("Project Name");

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGap(401, 401, 401)
                .addComponent(projectNameLabel)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addComponent(projectNameLabel)
                .addGap(0, 0, Short.MAX_VALUE))
        );

        statusLabel.setFont(new java.awt.Font("Lucida Grande", 1, 14)); // NOI18N
        statusLabel.setText("Guardado");

        jScrollPane2.setViewportView(scriptTextPane);

        tabbedPane.addTab("tab1", jScrollPane2);

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jPanel4, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel2Layout.createSequentialGroup()
                        .addComponent(tabbedPane, javax.swing.GroupLayout.PREFERRED_SIZE, 887, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(statusLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 181, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addComponent(jPanel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(tabbedPane, javax.swing.GroupLayout.PREFERRED_SIZE, 561, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(statusLabel)
                .addContainerGap(21, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 7, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * Indicar si el script en edición esta actualmente con los cambios
     * guardados o no.
     *
     * @param c: text pane que coniene el script en edición.
     */
    private void addKeyListener(Component c) {
        JTextPane tp = (JTextPane) c;
        tp.addKeyListener(new KeyListener() {
            @Override
            public void keyTyped(KeyEvent e) {
                if (statusLabel.getText().equals("Guardado")) {
                    statusLabel.setText("No Guardado");
                }
            }

            @Override
            public void keyPressed(KeyEvent e) {
                //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
            }

            @Override
            public void keyReleased(KeyEvent e) {
                //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
            }

        });
    }

    /**
     * Refrescar la interfaz.
     *
     * @param c
     */
    private void refreshComponent(Component c) {
        c.setVisible(false);
        c.setVisible(true);
    }

    /**
     * Cargar todos los scripts en las pestañas.
     */
    private void loadTabPanes() {
        tabbedPane.removeAll();
        // scripts
        for (String script : data.getProjectScripts()) {
            String text = data.getContenidoScript(data.getProjectPath() + "/scripts/" + script);
            JTextPane tp = new JTextPane();
            tp.setText(text);
            addKeyListener(tp);
            setShortCuts(tp);
            JScrollPane jsp = new JScrollPane(tp);
            TextLineNumber tln = new TextLineNumber(tp);
            jsp.setRowHeaderView(tln);
            tabbedPane.addTab(script, jsp);
        }
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenu jMenu2;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JLabel projectNameLabel;
    private javax.swing.JTextPane scriptTextPane;
    private javax.swing.JLabel statusLabel;
    private javax.swing.JTabbedPane tabbedPane;
    // End of variables declaration//GEN-END:variables

    private int lines = 0;          // number of lines of the current script

}
