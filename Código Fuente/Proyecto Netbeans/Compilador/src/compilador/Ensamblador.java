package compilador;

import data.AccesoFichero;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author María del Mar Cardona
 */
public class Ensamblador {

    /**
     * Código de 3 direcciones del programa.
     */
    private final ArrayList<Cuadruplo> listCode;
    /**
     * Tablas de procedimientos, variables, vectores y etiquetas.
     */
    private final Tablas tablas;
    /**
     * Nombre del proyecto.
     */
    private final String nombre;
    /**
     * Directorio principal del proyecto.
     */
    private final String directorio;
    /**
     * Macros del código ensamblador.
     */
    private final Macros macros;
    /**
     * Nombre del vector de entrada.
     */
    private final String entVector;

    /**
     * Constructor.
     *
     * @param listCode: código de 3 direcciones del programa.
     * @param directory: directorio principal del proyecto.
     * @param name: nombre del proyecto.
     * @param tables: tablas de datos.
     * @param entVector: nombre del vector de entrada.
     */
    public Ensamblador(ArrayList<Cuadruplo> listCode, String directory, String name, Tablas tables, String entVector) {
        this.listCode = listCode;
        this.nombre = name;
        this.tablas = tables;
        this.directorio = directory;
        this.macros = new Macros();
        this.entVector = entVector;
        initComponents();
    }

    /**
     * Iniciar componentes. Prepara algunos de los directorios y ficheros para
     * generar el código ensamblador.
     */
    private void initComponents() {
        File dir = new File(directorio + "/assembly");
        if (!dir.exists()) {
            dir.mkdir();
        }
        macros.generateMacros(directorio + "/assembly");
        dir = new File(directorio + "/assembly/files");
        if (!dir.exists()) {
            dir.mkdir();
        }
        File source = new File(directorio + "/build/files/" + entVector);
        File dest = new File(directorio + "/assembly/files/" + entVector);
        if (dest.exists()) {
            dest.delete();
        }
        try {
            Files.copy(source.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException ex) {
            Logger.getLogger(Ensamblador.class.getName()).log(Level.SEVERE, null, ex);
        }
        dir = new File(directorio + "/assembly/resultados");
        if (!dir.exists()) {
            dir.mkdir();
        }
    }

    /**
     * Devolver tipo. Devuelve un valor entero dado un tsb.
     *
     * @param tipo
     * @return valor
     */
    private int devolverTipo(tsb tipo) {
        int valor = -1;
        switch (tipo) {
            case ts_boolean:
                valor = 0;
                break;
            case ts_simbol:
                valor = 1;
                break;
            case ts_vector:
                valor = 2;
                break;
            case ts_tipus_pila:
                valor = 3;
                break;
        }
        return valor;
    }

    /**
     * Cálculo del desplazamiento de la variable.
     *
     * @param param: variable
     * @return: desplazamiento
     */
    private int DESP(Variable param) {
        if (param.getDesplazamiento() > 0) { //ARG
            int tipo = devolverTipo(param.getTipo());
            if (tipo == 0) {
                return param.getDesplazamiento();
            } else {
                return param.getDesplazamiento() + 2;
            }
        } else { //var
            return param.getDesplazamiento();
        }
    }

    /**
     * Cabecera del código ensamblador.
     *
     * @return string con el código en ensamblador.
     */
    private String cabecera() {
        String ensamblador = ""
                + "*------------------------------------------------------------\n"
                + "* Title      : CODIGO ENSAMBLADOR DE " + nombre + " \n"
                + "* Date       : " + new Date().toString() + "\n"
                + "* Description: Codigo ensamblador\n"
                + "*------------------------------------------------------------\n\n";
        ensamblador += ""
                + "*************************************************************\n"
                + "*                             MACROS                         *\n"
                + "*************************************************************\n";
        ensamblador += ""
                + "    INCLUDE \"macros/macros.X68\"                                   \n"
                + "                                                              \n"
                + "                                                              \n"
                + "                                                              \n";
        ensamblador += ""
                + "*************************************************************\n"
                + "*                         MAIN PROGRAM                      *\n"
                + "*************************************************************\n\n"
                + "    ORG    $2000\n"
                + "START:                  ; first instruction of program\n\n";
        ensamblador += ""
                + "; cerrar todos los ficheros (aconsejado)                     \n"
                + "; close file                                            \n"
                + "    MOVE.L  #50,D0                                          \n"
                + "    TRAP    #15                                              \n";
        return ensamblador;
    }

    /**
     * Generar código ensamblador. Traducir cada una de las instrucciones del
     * código de 3 direcciones a código ensamblador. Generar el archivo x.69 con
     * el código ensamblador.
     *
     * @return true si todo ok.
     */
    public boolean generarCodigoEnsamblador() {
        String ensamblador = "";
        for (int i = 0; i < listCode.size(); i++) {
            switch (listCode.get(i).getInstruccion()) {
                case call_:
                    if (i == 0) { //Referida a la primera instruccion
                        String entname = tablas.getVector(0).getVectorName();
                        String entprocname = tablas.getVector(0).getProcedureName();
                        String enttag = entname + "" + entprocname;
                        ensamblador += ";   cargar el vector de entrada \n";
                        ensamblador += "    LOAD_ENT    ent, " + enttag + "\n";
                        if (tablas.isStack()) {
                            ensamblador += "    LEA     stack,A0\n";
                        }
                        // empezamos en 1 porque el vector 0 es el vector de entrada
                        for (int j = 1; j < this.tablas.getVectorsTableSize(); j++) {
                            String vectorname = tablas.getVector(j).getVectorName();
                            String vectorprocname = tablas.getVector(j).getProcedureName();
                            String vectortag = vectorname + "" + vectorprocname;
                            ensamblador += "    INIT_VECTOR " + vectortag + "\n";
                        }
                        ensamblador += ";   instruccion start del programa \n";
                        ensamblador += ";   c3d:        " + listCode.get(i).toString() + "\n";
                        ensamblador += "    JSR         " + tablas.getProcedure(Integer.parseInt(listCode.get(i).getResult().getData())).getInitTag().toUpperCase() + "\n\n";
                        ensamblador += "FINALLY:\n";
                        ensamblador += ";   imprimir valor de accepta \n"
                                + "    LEA         acceptastr,A1 \n"
                                + "    MOVE.W      #14,D0        \n"
                                + "    TRAP        #15           \n"
                                + "    CLR.L       D1            \n"
                                + "    LEA         accepta,A1    \n"
                                + "    MOVE.W      (A1),D1       \n"
                                + "    MOVE.W      #6,D0         \n"
                                + "    TRAP        #15           \n";
                        String vector, procname, vectortag;
                        for (int v = 0; v < tablas.getVectorsTableSize(); v++) {
                            // escribir vector en ensamblador
                            vector = tablas.getVector(v).getVectorName();
                            procname = tablas.getVector(v).getProcedureName();
                            vectortag = vector + "" + procname;
                            ensamblador += "    SAVE_VEC    r" + vectortag + ", " + vectortag + "\n";
                        }
                        ensamblador += "    SIMHALT             ; halt simulator\n";
                    } else { //Llamadas entre programas
                        ensamblador += ";   llamada a un subprograma \n";
                        ensamblador += ";   c3d:    " + listCode.get(i).toString() + "\n";
                        ensamblador += "    MOVE.L  A7, A5      ;Preparamos la pila para añadir nuevo prmbl\n";
                        ensamblador += "    MOVE.L  A6, A7      \n";
                        ensamblador += "    MOVE.L  A5, -(A7)  ;BP anterior\n";
                        Procedimiento proc = tablas.getProcedure(Integer.parseInt(listCode.get(i).getResult().getData()));
                        ensamblador += "    SUB.L #4, A7  ;Espacio para PC\n";
                        //Llamamos al metodo
                        int desp = Math.abs(proc.getOcupTempArgs()) + 4; //Nos ponemos en PC para que ponga la direccion
                        ensamblador += "    ADD.L #" + desp + ", A7  ;Regresamos para poner el pc en el salto\n";
                        ensamblador += "    JSR " + proc.getInitTag().toUpperCase() + "\n";
                        //Volvera aqui
                        ensamblador += "    ;volvemos de subrutina\n";
                        ensamblador += "    ADD.L #" + proc.getOcupacion() + ", A7 ;Botamos return\n"; //COMRPOBAR
                        ensamblador += "    MOVE.L (A7)+, A5 ;Cogemos BP\n";
                        ensamblador += "    MOVE.L A7, A6  ;Dejamos A6 en la cima\n";
                        ensamblador += "    MOVE.L A5, A7 ;Nos colocamos en el BP del metodo actual\n";
                    }
                    break;
                case procedure_:
                    ensamblador += "; c3d:  " + listCode.get(i).toString() + "\n";
                    ensamblador += "\n" + tablas.getProcedure(Integer.parseInt(listCode.get(i).getResult().getData())).getInitTag().toUpperCase() + ":\n";
                    break;
                case preamble_:
                    ensamblador += ";   c3d:    " + listCode.get(i).toString() + "\n";
                    Procedimiento proc = tablas.getProcedure(Integer.parseInt(listCode.get(i).getResult().getData()));
                    ensamblador += "\n";
                    ensamblador += "    SUB.L   #" + Math.abs(proc.getOcupTempArgs()) + ", A7\n";
                    ensamblador += "    SUB.L   #4, A7  ;BP\n";
                    ensamblador += "    MOVE.L  #0, (A7) ;Todo 0\n";
                    ensamblador += "    MOVE.L  A7, A6 ;SP==A7\n";
                    ensamblador += "    SUB.L   #" + Math.abs(proc.getOcupLocalVars()) + ", A6  \n";
                    break;
                case endProcedure_:
                    ensamblador += ";   c3d:    " + listCode.get(i).toString() + "\n";
                    Procedimiento proce = tablas.getProcedure(Integer.parseInt(listCode.get(i).getResult().getData()));
                    int desp = Math.abs(proce.getOcupLocalVars()) + 4; //BP + args
                    ensamblador += "    MOVE.L  A6,A7        \n";
                    ensamblador += "    ADD.L   #" + desp + ", A7  ;nos situamos en PC para volver\n";
                    ensamblador += "    RTS\n";
                    break;
                case assig_:
                    ensamblador += "; c3d: " + listCode.get(i).toString() + "\n";
                    switch (listCode.get(i).getParam1().getTipo()) {
                        case val_simbol:
                            if (listCode.get(i).getResult().getData().equals("accepta")) {
                                // asignar el valor a accepta
                                ensamblador += "    ASIGN_VALUE_ACCEPTA "
                                        + "#" + listCode.get(i).getParam1().getData() + ", accepta"
                                        + "\n";
                            } else {
                                // asignar el valor al simbolo
                                ensamblador += "    ASIGN_VALUE_SIMBOL "
                                        + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + ", "
                                        + "#" + listCode.get(i).getParam1().getData()
                                        + "\n";
                            }
                            break;
                        case ref_simbol:
                            if (listCode.get(i).getParam1().getData().equals("accepta")) {
                                // asignar valor de accepta a un simbolo
                                ensamblador += "    ASIGN_ACCEPTA_SIMBOL "
                                        + "accepta, "
                                        + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + " \n";
                            } else if (listCode.get(i).getResult().getData().equals("accepta")) {
                                // asignar el simbolo a accepta
                                ensamblador += "    ASIGN_SIMBOL_ACCEPTA "
                                        + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + ", "
                                        + "accepta \n";
                            } else {
                                // asignar un simbolo a otro simbolo
                                ensamblador += "    ASIGN_SIMBOL_SIMBOL "
                                        + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + ", "
                                        + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + "\n";
                            }
                    }
                    break;
                case escriure_:
                    String procname = tablas.getVector(Integer.parseInt(listCode.get(i).getResult().getData())).getProcedureName();
                    String vectortag = tablas.getVector(Integer.parseInt(listCode.get(i).getResult().getData())).getVectorName() + "" + procname;
                    String cursortag = vectortag + "cursor";
                    ensamblador += "; c3d: " + listCode.get(i).toString() + "\n";
                    switch (listCode.get(i).getParam1().getTipo()) {
                        case val_simbol:
                            ensamblador += "    ASIGN_VALUE_VECTOR "
                                    + "#" + listCode.get(i).getParam1().getData() + ","
                                    + vectortag + ","
                                    + cursortag + "\n";
                            break;

                        case ref_simbol:
                            ensamblador += "    ASIGN_SIMBOL_VECTOR "
                                    + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + ", "
                                    + vectortag + ","
                                    + cursortag + "\n";
                    }
                    // escribir un simbolo en un vector
                    break;
                case dreta_:
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    String pd = tablas.getVector(Integer.parseInt(listCode.get(i).getResult().getData())).getProcedureName();
                    String vd = tablas.getVector(Integer.parseInt(listCode.get(i).getResult().getData())).getVectorName() + "" + pd;
                    String cd = vd + "cursor";
                    ensamblador += "    DRETA " + cd + "\n";
                    break;
                case esquerra_:
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    String pe = tablas.getVector(Integer.parseInt(listCode.get(i).getResult().getData())).getProcedureName();
                    String ve = tablas.getVector(Integer.parseInt(listCode.get(i).getResult().getData())).getVectorName() + "" + pe;
                    String ce = ve + "cursor";
                    ensamblador += "    ESQUERRA " + ce + "\n";
                    ensamblador += "    IF.L    D0 <EQ> #-4 THEN.S \n"
                            + "        ASIGN_VALUE_ACCEPTA #'e', accepta\n"
                            + "        JMP FINALLY\n"
                            + "    ENDI\n";
                    break;
                case igual_:
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    COMP_IGUAL_SIMBOL "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + ", "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam2().getData()))) + ", "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + "   \n";
                    break;
                case diferent_:
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    COMP_DIF_SIMBOL "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + ", "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam2().getData()))) + ", "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + "   \n";
                    break;
                case llegir_:
                    String p = tablas.getVector(Integer.parseInt(listCode.get(i).getParam1().getData())).getProcedureName();
                    String v = tablas.getVector(Integer.parseInt(listCode.get(i).getParam1().getData())).getVectorName() + "" + p;
                    String c = v + "cursor";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    READ_VECTOR \t"
                            + v + ", "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + ", "
                            + c + "\n";
                    ensamblador += "    LEA.L   "+c+",A1\n";
                    ensamblador += "    MOVE.L  (A1),D0\n";
                    ensamblador += "    IF.L    D0 <LE> #-2 THEN.S \n"
                            + "        ASIGN_VALUE_ACCEPTA #'e', accepta\n"
                            + "        JMP FINALLY\n"
                            + "    ENDI\n";
                    break;
                case if_:
                    ensamblador += ";   condicional if \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    MOVE.W  " + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + "(A7),D0 \n";
                    ensamblador += "    CMP.W   #1, D0   \n";
                    ensamblador += "    BEQ " + listCode.get(i).getResult().getData().replace("#", "e") + "   \n";
                    break;
                case ifnot_:
                    ensamblador += ";   condicional if \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    MOVE.W  " + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + "(A7),D0 \n";
                    ensamblador += "    CMP.W   #0, D0   \n";
                    ensamblador += "    BEQ " + listCode.get(i).getResult().getData().replace("#", "e") + "   \n";
                    break;
                case goto_:
                    ensamblador += ";   saltar a la etiqueta \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    BRA " + listCode.get(i).getResult().getData().replace("#", "e") + "   \n";
                    break;
                case skip_:
                    ensamblador += ";   escribir etiqueta \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += listCode.get(i).getResult().getData().replace("#", "e") + ":\n";
                    break;
                case empila_:
                    ensamblador += ";   empilar simbolo \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    if (listCode.get(i).getParam1().getTipo() == TipoOperador.val_simbol) {
                        ensamblador += "    EMPILA_VALOR "
                            + "#" + listCode.get(i).getParam1().getData() + "\n";
                    } else {
                        ensamblador += "    EMPILA "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + "\n";
                    }
                    break;
                case desempila_:
                    ensamblador += ";   desempilar simbolo \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    LEA stack,A1\n"
                            + "    IF.L A0 <EQ> A1 THEN.S\n"
                            + "        ASIGN_VALUE_ACCEPTA #'e', accepta\n"
                            + "        JMP FINALLY\n"
                            + "    ENDI\n";
                    ensamblador += "    DESEMPILA \n";
                    break;
                case cim_:
                    ensamblador += ";   cima de la pila \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    CIM "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + "\n";
                    break;
                case buida_:
                    ensamblador += ";   buida pila \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    BUIDA stack, "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + "\n";
                    break;
                case nobuida_:
                    ensamblador += ";   no buida pila \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    NOBUIDA stack, "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + "\n";
                    break;
                case and_:
                    ensamblador += ";   instrucción and \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    AND_SIMBOL "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + ", "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam2().getData()))) + ", "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + "   \n";
                    break;
                case or_:
                    ensamblador += ";   instrucción or \n";
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    ensamblador += "    OR_SIMBOL "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam1().getData()))) + ", "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getParam2().getData()))) + ", "
                            + DESP(tablas.getVariable(Integer.parseInt(listCode.get(i).getResult().getData()))) + "   \n";
                    break;
                case ramifica_:
                    ensamblador += ";   c3d: " + listCode.get(i).toString() + "\n";
                    // cargar las etiquetas del ramifica en la pila
                    ArrayList<String> etqs = tablas.ramasDeRamifica(listCode.get(i).getResult().getData());
                    for (int e = etqs.size() - 1; e >= 0; e--) {
                        ensamblador += "    MOVE.L  #" + etqs.get(e) + ",-(A6)      \n";
                    }
                    ensamblador += "ask_" + listCode.get(i).getResult().getData() + ":  \n";
                    // preguntar por la rama que se desea ejecutar
                    int nramas = (tablas.ramasDeRamifica(listCode.get(i).getResult().getData()).size() - 1);
                    ensamblador += "    ASK_RAMIF   #" + listCode.get(i).getResult().getData() + ", #" + nramas + "\n";
                    // si introduce un numero incorrecto volver a solicitarlo
                    ensamblador += "    IF.B    D1 <GT> #" + nramas + " THEN.S\n"
                            + "        MOVE.L  #13,D0\n"
                            + "        MOVE.L  #novalido,A1\n"
                            + "        TRAP    #15\n"
                            + "        BRA     ask_" + listCode.get(i).getResult().getData() + "\n"
                            + "    ENDI\n";
                    ensamblador += "    MOVE.L     A6,A1\n"
                            + "    SUB.L      #1,D1\n"
                            + "    MULU.W     #4,D1\n"
                            + "    ADD.L      D1,A1\n"
                            + "    MOVE.L     (A1),A1\n"
                            + "    JMP        (A1)\n";
                    /*ensamblador += "    SET_RAMIF    ramificando,#1 \n";
                    ensamblador += "    SAVE_MEM    actual,registros  \n";*/
                    break;
                case framifica_:
                    ensamblador += "    ADD.L   #" + (tablas.ramasDeRamifica(listCode.get(i).getResult().getData()).size() * 4) + ",A6\n";
                    break;
                default:
                    break;
            }
        }

        //Fin
        ensamblador += "\n\n    ORG $4000                                   \n";
        ensamblador += "* Put variables and constants here                   \n";
        ensamblador += "memoria         ds.l    0                       \n";
        ensamblador += "accepta         dc.b    '00',0                  \n";
        ensamblador += "                ds.w     0                      \n";
        ensamblador += "acceptastr      dc.w    'VALOR DE ACCEPTA: ',0  \n";
        ensamblador += declararVectores();
        if (tablas.isStack()) {
            ensamblador += "space           ds.w    1024                    \n";
            ensamblador += "stack           ds.w    0                       \n";
        }
        ensamblador += "ent             dc.l    'files/" + entVector + "',0\n";
        ensamblador += "linea1          dc.b    'Ramificacion del programa: ',0\n";
        ensamblador += "linea2          dc.b    'Seleccionar la rama a ejecutar entre 1 y ',0\n";
        ensamblador += "dospuntos       dc.b    ': ',0\n";
        ensamblador += "separador       dc.b    '-----------------------------------------------',0\n";
        ensamblador += "novalido        dc.b    'El numero de rama no es valido. Por favor, introduce otro.',0\n";
        ensamblador += "    END    START        ; last line of source    \n";

        // Create the file
        String codigo = cabecera() + ensamblador;
        AccesoFichero af = new AccesoFichero();
        File f = new File(directorio + "/assembly/" + nombre + ".X68");
        af.writeFile(f, codigo);
        return true;
    }

    /**
     * Declarar vectores y cursores. Declarar en ensamblador el espacio para los
     * vectores y los cursores inicializados a 0.
     *
     * @return string con el código ensamblador
     */
    private String declararVectores() {
        String s = "", vector, procname, vectortag, cursortag;
        for (int i = 0; i < tablas.getVectorsTableSize(); i++) {
            // escribir vector en ensamblador
            vector = tablas.getVector(i).getVectorName();
            procname = tablas.getVector(i).getProcedureName();
            vectortag = vector + "" + procname;
            cursortag = vectortag + "cursor";
            s += "" + vectortag + "     ds.l        1024\n";
            s += "" + cursortag + "     dc.l        0   \n";
            s += "r" + vectortag + "     dc.l        'resultados/" + vector + "_" + procname + ".txt',0\n";
        }
        return s;
    }

    /**
     * Coger el nombre del proyecto.
     *
     * @return string.
     */
    public String getNombre() {
        return nombre;
    }
}
