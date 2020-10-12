package userInterface;

import data.Data;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author María del Mar Cardona
 */
public class NewScript extends javax.swing.JFrame {

    /**
     * Datos del proyecto.
     */
    private Data data;

    /**
     * Nuevo Script.
     * Crea un nuevo form para crear un nuevo script en el proyecto.
     * @param data: datos del proyecto.
     */
    public NewScript(Data data) {
        this.data = data;
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        scriptNameField = new javax.swing.JTextField();
        acceptButton = new javax.swing.JButton();
        cancelButton = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setLocation(new java.awt.Point(400, 250));
        setResizable(false);

        jLabel1.setFont(new java.awt.Font("Lucida Grande", 0, 18)); // NOI18N
        jLabel1.setText("Nuevo Script");

        jLabel2.setText("Nombre:");

        acceptButton.setText("Aceptar");
        acceptButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                acceptButtonActionPerformed(evt);
            }
        });

        cancelButton.setText("Cancelar");
        cancelButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cancelButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(75, 75, 75)
                .addComponent(cancelButton)
                .addGap(42, 42, 42)
                .addComponent(acceptButton)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(44, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(scriptNameField, javax.swing.GroupLayout.PREFERRED_SIZE, 247, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(21, 21, 21))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(118, 118, 118))))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(15, 15, 15)
                .addComponent(jLabel1)
                .addGap(27, 27, 27)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(scriptNameField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(acceptButton)
                    .addComponent(cancelButton))
                .addContainerGap(23, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void cancelButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cancelButtonActionPerformed
        data.setScriptActual(data.getNombreProyecto()+".tc");
        UserInterface ui = new UserInterface(data);
        ui.showUI();
        this.dispose();
    }//GEN-LAST:event_cancelButtonActionPerformed

    private void acceptButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_acceptButtonActionPerformed
        // check if field is empty
        if ("".equals(scriptNameField.getText())) {
            JOptionPane.showMessageDialog(this, "Please, fill the name field", "ERROR", JOptionPane.ERROR_MESSAGE);
        } else {
            // check if already exists
            File dir = new File(data.getProjectPath() + "/scripts/" + scriptNameField.getText()+".tc");
            if (dir.exists()) {
                JOptionPane.showMessageDialog(this, "This script already exists", "ERROR", JOptionPane.ERROR_MESSAGE);
            } else {
                try {
                    boolean r = dir.createNewFile();
                    if (!r) {
                        JOptionPane.showMessageDialog(this, "Error creating the project main script", "ERROR", JOptionPane.ERROR_MESSAGE);
                    }
                    String mainProgram = ""
                            + "programa " + scriptNameField.getText() + " (ent) \n"
                            + "\n"
                            + "fi";
                    BufferedWriter writer = new BufferedWriter(new FileWriter(dir));
                    writer.write(mainProgram);
                    writer.close();
                    data.setScriptActual(scriptNameField.getText()+".tc");
                    this.dispose();
                    UserInterface ui = new UserInterface(data);
                    ui.showUI();
                } catch (IOException ex) {
                    Logger.getLogger(CreateProject.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }//GEN-LAST:event_acceptButtonActionPerformed

    /**
     * Mostrar interfaz.
     */
    public void start() {
        this.setLocationRelativeTo(null);
        this.pack();
        this.setVisible(true);
    }
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton acceptButton;
    private javax.swing.JButton cancelButton;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JTextField scriptNameField;
    // End of variables declaration//GEN-END:variables
}
