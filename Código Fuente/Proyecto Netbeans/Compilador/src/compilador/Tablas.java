package compilador;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author María del Mar Cardona
 */
class Tablas implements Serializable {

    /**
     * Tabla de variables.
     * (Variables Table)
     */
    private ArrayList<Variable> VT; 
    /**
     * Tabla de procedimientos.
     * (Procedures Table)
     */
    private ArrayList<Procedimiento> PT;
    /**
     * Tabla de etiquetas.
     * (Tags Table)
     */
    private ArrayList<Etiqueta> TT;

    /**
     * Lista de vectores.
     */
    private ArrayList<Vector> V;

    /**
     * Último procedimiento.
     * Id del último procedimiento creado.
     */
    private int lp;

    /**
     * Existencia de pila.
     * Booleano que indica si ya existe una pila en el programa.
     */
    private boolean stack;

    /**
     * Constructor.
     */
    public Tablas() {
        VT = new ArrayList();
        PT = new ArrayList();
        TT = new ArrayList();
        V = new ArrayList();
        lp = -1;
        stack = false;
    }

    /**
     * Obtener id del último procedimiento.
     * @return id.
     */
    public int getLp() {
        return lp;
    }

    /**
     * Asignar id del último procedimiento.
     * @return id.
     */
    public void setLp(int lp) {
        this.lp = lp;
    }

    /**
     * Insertar vector en la tabla de vectores.
     * @param vnombre: nombre del vector
     * @param pid: id del procedimiento
     * @param pnombre: nombre del procedimiento
     * @return id del vector si se insertó correctamente.
     */
    public int addVector(String vnombre, int pid, String pnombre) {
        for (Vector v : V) {
            if (vnombre.equals(v.getVectorName()) && pid == v.getIdProcedimiento()) {
                return -1;
            }
        }
        int vid = V.size();
        Vector vector = new Vector(vid, vnombre, pid, pnombre);
        V.add(vector);
        return vid;
    }

    /**
     * Buscar vector.
     * Busca el vector en la tabla de vectores. El vector puede haber sido 
     * declarado en un procedimiento o como parámetro.
     * @param vnombre: nombre del vector.
     * @param pid: procedimiento donde el vector ha sido declarado.
     * @return el vector si lo ha encontrado.
     */
    public Vector findVector(String vnombre, int pid) {
        for (Vector vector : V) {
            if (vector.getVectorName().equals(vnombre) && vector.getIdProcedimiento() == pid) {
                return vector;
            } else {
                String pname = PT.get(pid).getNp();
                if (vector.findInParams(vnombre, pname)) {
                    return vector;
                }
            }
        }
        return null;
    }
    
    /**
     * Insertar variable en la tabla de variables.
     * @param nombre: nombre de la variable
     * @param pid: procedimiento donde se encuentra la variable
     * @param ocupacion: ocupacion de la variable
     * @param argTipo: tipo de argumento (0 si var, 1 si argumento)
     * @param tipo: tipo de la variable
     * @return índice de la variable en la tabla de variables.
     */
    public int addVariable(String nombre, int pid, int ocupacion, int argTipo, tsb tipo) {
        Variable v = new Variable(nombre, pid, ocupacion, argTipo, tipo);
        VT.add(v);
        return VT.size() - 1;
    }

    /**
     * Obtener el índice de una variable en la VT.
     * @param nombre: nombre de la variable
     * @return índice de la variable, -1 si no se ha podido encontrar
     */
    public int getVariable(String nombre) {
        int id = -1;
        //name = "#" + name;
        boolean found = false;
        for (int i = 0; i < VT.size() && !found; i++) {
            if (VT.get(i).getNombreVar().equals(nombre)) {
                found = true;
                id = i;
            }
        }
        return id;
    }

    /**
     * Obtener la variable dado su índice en la VT.
     * @param id: índice de la variable en la VT.
     * @return variable dato
     */
    public Variable getVariable(int id) {
        return VT.get(id);
    }

    /**
     * Obtener el tamaño de la VT.
     * @return int con la longitud de VT.
     */
    public int getVariablesTableSize() {
        return VT.size();
    }

    /**
     * Obtener el vector dado su índice en la tabla de vectores
     * @param id: índice del vector en la tabla de vectores
     * @return vector dato
     */
    public Vector getVector(int id) {
        return V.get(id);
    }

    /**
     * Obtener tamaño de la tabla de vectores.
     * @return int con la longitud de la tabla V.
     */
    public int getVectorsTableSize() {
        return V.size();
    }

    /**
     * Actualizar variable. Cuando una asignación ocurre (instrucción escriure),
     * la variable tiene que actualizar su tamaño.
     * @param id: índice de la variable
     * @param size: nuevo tamaño de la variable
     */
    public void updateVariable(int id, int size) {
        VT.get(id).setOcupacion(size);
    }

    /**
     * Insertar procedimiento en la PT.
     * @param nombre: nombre del procedimiento
     * @param profundidad: profundidad del procedimiento
     * @param nParams: número de parámetros del procedimiento
     * @param ocupacion: tamaño del procedimiento
     * @return índice del procedimiento creado
     */
    public int addProcedure(String nombre, int profundidad, int nParams, int ocupacion) {
        String tag = "P_" + nombre;
        //name = "#" + name;
        Procedimiento p = new Procedimiento(nombre, profundidad, tag, nParams, 0, ocupacion);
        PT.add(p);
        return PT.size() - 1;
    }

    /**
     * Obtener procedimiento.
     * Obtener el índice del procedimiento en la PT dado su nombre.
     * @param nombre
     * @return índice del procedimiento
     */
    public int getProcedure(String nombre) {
        int id = -1;
        //name = "#" + name;
        boolean found = false;
        for (int i = 0; i < PT.size() && !found; i++) {
            if (PT.get(i).getNp().equals(nombre)) {
                found = true;
                id = i;
            }
        }
        return id;
    }

    /**
     * Actualizar ocupación del procedimiento.
     * @param id: índice del procedimiento.
     * @param ocupation: nueva ocupación del procedimiento
     */
    public void updateProcedureOcupation(int id, int ocupation) {
        PT.get(id).setOcupacion(ocupation);
    }

    /**
     * Actualizar el número de parámetros del procedimiento.
     * @param id: índice del procedimiento.
     * @param nParams: nuevo número de parámetros del procedimiento.
     */
    public void updateProcedureParams(int id, int nParams) {
        PT.get(id).setnParams(nParams);
    }

    /**
     * Obtener procedimiento. 
     * Obtener los datos de un procedimiento dado su índice en la PT.
     * @param id: índice del procedimiento
     * @return datos del procedimiento.
     */
    public Procedimiento getProcedure(int id) {
        return PT.get(id);
    }

    /**
     * Índice del procedimiento actual.
     * @return índice
     */
    public int actualProcedure() {
        return PT.size() - 1;
    }

    /**
     * Cálculo del desplazamiento de la ocupación.
     * Calcula la ocupación de las variables locales, la ocupación de los 
     * argumentos temporales y del desplazamiento.
     */
    public void calculosDesplazamientoOcupacion() {
        for (int i = 0; i < VT.size(); i++) {
            int p = VT.get(i).getProcId();
            int ocup = VT.get(i).getOcupacion();
            if (VT.get(i).getDesplazamiento() != -1) {
                PT.get(p).setOcupLocalVars(PT.get(p).getOcupLocalVars() - ocup);
                VT.get(i).setDesplazamiento(PT.get(p).getOcupLocalVars());
            } else { //Argumento
                PT.get(p).setOcupTempArgs(PT.get(p).getOcupTempArgs() + ocup);
                VT.get(i).setDesplazamiento(PT.get(p).getOcupTempArgs());
            }
        }
        //Añadimos la ocupacion temporal de los argumentos
        for (int i = 0; i < PT.size(); i++) {
            PT.get(i).setOcupLocalVars(PT.get(i).getOcupTempArgs() - PT.get(i).getOcupLocalVars());
        }
    }

    /**
     * Crear etiqueta.
     * @param pid: id del procedimiento
     * @param cond: condicion
     * @return nombre de la etiqueta
     */
    public String createTag(int pid, String cond) {
        String name;
        if (TT.isEmpty()) {
            name = "t_0_et_" + pid + "_" + cond;
        } else {
            String tagName = TT.get(TT.size() - 1).getNombre();
            int f = TT.get(TT.size() - 1).getProcedimiento();
            if (pid == f) {
                f = Integer.parseInt(tagName.split("_")[1]) + 1;
                name = "t_" + f + "_et_" + pid + "_" + cond;
            } else {
                name = "t_0_et_" + pid + "_" + cond;
            }
        }
        TT.add(new Etiqueta(name, pid));

        return name;
    }

    /**
     * Insertar etiqueta.
     * @param t: etiqueta
     */
    public void addTag(Etiqueta t) {
        TT.add(new Etiqueta(t.getNombre(), t.getProcedimiento()));
    }
    
    /**
     * Eiquetas de las ramas del ramifica.
     * Devuelve las etiquetas para ensamblador de un ramifica.
     * @param nramifica: número de ramifica del programa.
     * @return nombres de las etiquetas.
     */
    public ArrayList<String> ramasDeRamifica(String nramifica) {
        ArrayList<String> ramas = new ArrayList<>();
        for (Etiqueta etq: TT) {
            if (etq.getNombre().startsWith("t_ramifica_"+nramifica+"_")) {
                ramas.add(etq.getNombre());
            }
        }
        ramas.add("t_end_ramifica_"+nramifica);
        return ramas;
    }

    /**
     * Convertir tablas a String.
     * @return string representation of the tables.
     */
    @Override
    public String toString() {
        String s = variablesTableToString();
        s += proceduresTableToString();
        s += tagsTableToString();
        return s;
    }

    /**
     * Convertir tabla de variables a String.
     * @return string representation of the variables table.
     */
    public String variablesTableToString() {
        String s = "VARIABLES TABLE --------------------------" + "\n";
        for (int i = 0; i < VT.size(); i++) {
            s += "ID: " + i + " " + VT.get(i).toString();
        }
        return s;
    }

    /**
     * Convertir tabla de procedimientos a String.
     * @return string representation of the procedures table.
     */
    public String proceduresTableToString() {
        String s = "PROCEDURES TABLE ---------------------" + "\n";
        for (int j = 0; j < PT.size(); j++) {
            s += "ID: " + j + " " + PT.get(j).toString();
        }
        return s;
    }

    /**
     * Convertir tabla de etiquetas a String.
     * @return string representation of the tags table.
     */
    public String tagsTableToString() {
        String s = "TAGS TABLE --------------------------" + "\n";
        for (int k = 0; k < TT.size(); k++) {
            s += "ID: " + k + " " + TT.get(k).toString();
        }
        return s;
    }

    /**
     * Convertir tabla de vectores a String.
     * @return string representation of the vectors table.
     */
    public String vectorsTableToString() {
        String s = "VECTORS TABLE --------------------------" + "\n";
        for (int k = 0; k < V.size(); k++) {
            s += "ID: " + k + " " + V.get(k).toString();
        }
        return s;
    }

    /**
     * Obtener los símbolos del procedimiento.
     * @param id: id del procedimiento.
     * @return lisa de simbols.
     */
    public ArrayList<String> getSimbolsFromProcedure(int id) {
        ArrayList<String> simbols = new ArrayList<>();
        for (int i = 0; i < VT.size(); i++) {
            if ((VT.get(i).getTipo() == tsb.ts_simbol) && (VT.get(i).getProcId() == id)) {
                simbols.add(VT.get(i).getNombreVar());
            }
        }
        return simbols;
    }

    /**
     * Obtener nombres de los vectores.
     * @return lista de nombres de vectores.
     */
    public ArrayList<String> getVectors() {
        ArrayList<String> vectors = new ArrayList<>();
        for (int i = 0; i < V.size(); i++) {
            vectors.add(V.get(i).getVectorName());
        }
        return vectors;
    }

    /**
     * Preguntar si existe pila.
     * @return true si hay.
     */
    public boolean isStack() {
        return stack;
    }

    /**
     * Indicar si existe pila.
     * @param stack: true si hay pila.
     */
    public void setStack(boolean stack) {
        this.stack = stack;
    }

    /**
     * Obtener nombre de la pila.
     * @return nombre de la pila
     */
    public String getStack() {
        String stackname = "";
        for (Variable v : VT) {
            if (v.getTipo() == tsb.ts_tipus_pila) {
                return stackname;
            }
        }
        return stackname;
    }
}
