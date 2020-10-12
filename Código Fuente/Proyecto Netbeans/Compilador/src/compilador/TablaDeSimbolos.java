package compilador;

import exceptions.ComparisionException;
import exceptions.StackException;
import java.io.FileNotFoundException;
import java.util.ArrayList;

/**
 *
 * @author María del Mar Cardona
 */
public class TablaDeSimbolos {

    /**
     * Ámbito actual.
     */
    private int n;
    /**
     * Tabla de índices.
     */
    private ArrayList ta;
    /**
     * Tabla de expansión.
     */
    private ArrayList te;
    /**
     * Tabla de descripción.
     */
    private ArrayList td;
    /**
     * Lista de parámetros
     */
    private ArrayList params;

    public TablaDeSimbolos() {
        n = 0;
        ta = new ArrayList();
        te = new ArrayList();
        td = new ArrayList();
        params = new ArrayList();
        ta.add(n, 0);
    }

    /**
     * Obtener el tipo del identificador.
     *
     * @param id
     * @return tipo del id. Null si no existe.
     */
    public d consult(String id) {
        for (int i = 0; i < td.size(); i++) {
            if (((Tipus) td.get(i)).getId().equals(id)) {
                return ((Tipus) td.get(i)).getD();
            }
        }
        return null;
    }

    /**
     * Buscar un parámetro. Busca el parámetro en la lista de parámetros no
     * asignados de un procedimiento con el índice y el id.
     *
     * @param index: número de parámetro del procedimiento
     * @param pid: id del procedimiento
     * @return el parámetro. Null si no existe.
     */
    public Parametro findParam(int index, int pid) {
        int i = 0;
        String pname = "";
        for (int j = 0; j < params.size(); j++) {
            Parametro p = (Parametro) params.get(j);
            if (!p.getNombreProcedimiento().equals(pname)) {
                pname = p.getNombreProcedimiento();
                i = 0;
            }
            if (p.getNombreProcedimiento().equals(pname) && i == index) {
                return (Parametro) params.get(j);
            } else {
                i++;
            }
        }
        return null;
    }

    /**
     * Enlazar parámetro. Intenta enlazar el parámetro indicado con un vector
     * que tenga las características indicadas.
     *
     * @param param: parámetro a enlazar.
     * @param vname: nombre del vector
     * @param pname: nombre del procedimiento
     * @return true si el enlace ha sido posible
     */
    public boolean linkParam(Parametro param, String vname, String pname) {
        for (int i = 0; i < params.size(); i++) {
            Parametro p = (Parametro) params.get(i);
            if (vname.equals(p.getNombreVector()) && pname.equals(p.getNombreProcedimiento())) {
                p.setNext(param);
                return true;
            }
        }
        return false;
    }

    /**
     * Entrada a un nuevo bloque de visibilidad.
     */
    public void entrarBloque() {
        n++;
        ta.add(n, ta.get(n - 1));
    }

    /**
     * Preguntar si existe alguna función en la TS.
     *
     * @return true si existe.
     */
    public boolean functionExists() {
        boolean existe = false;
        for (int i = 0; i < td.size() && !existe; i++) {
            if (((Tipus) td.get(i)).getD().getDtipo() == dtipo.dfunc) {
                existe = true;
            }
        }
        return existe;
    }

    /**
     * Añadir identificador a la TS.
     *
     * @param id: identificador
     * @param d: tipo
     * @return id, null if error
     * @throws ComparisionException
     * @throws FileNotFoundException
     */
    public String add(String id, d d) throws ComparisionException, FileNotFoundException {
        //miramos primero si existe en la tabla actual
        boolean exists = false;
        Tipus t = new Tipus();
        t.setD(d);
        t.setId(id);
        t.setNd(n);
        for (int i = 0; i < td.size(); i++) {
            if (((Tipus) td.get(i)).getId().equals(id)) {
                //Primeramente si existe, miramos si es de difente ambito
                if (((Tipus) td.get(i)).getD().getDtipo() == dtipo.dfunc) {
                    throw new ComparisionException(id + " already exists as identifier in a subprogram.");
                }
                if (((Tipus) td.get(i)).getD().getDtipo() == dtipo.darg) {
                    throw new ComparisionException(id + " already exists as argument of the actual subprogram.");
                }
                if (((Tipus) td.get(i)).getNd() == n) {
                    throw new ComparisionException(id + " already has been declared in this subprogram.");
                }
                exists = true;
                //Si no existe en ese ambito, lo añadimos a la tabla de expansion (te)
                ta.set(n, ((int) ta.get(n)) + 1);
                te.add((int) ta.get(n), (Tipus) td.get(i));
                //Añadimos el nuevo id en la posicion del anterior
                td.set(i, t);
                break; //Paramos la busqueda
            }
        }
        if (!exists) {
            td.add(t); //Añadimos el id al final la lista
        }
        return null;
    }

    /**
     * Actualiza el tipo del id seleccionado.
     *
     * @param id: identificador
     * @param d: tipo
     * @throws ComparisionException
     */
    public void update(String id, d d) throws ComparisionException {
        boolean actualizat = false;
        for (int i = 0; i < td.size(); i++) {
            if (((Tipus) td.get(i)).getId().equals(id)) {
                ((Tipus) td.get(i)).setD(d);
                actualizat = true;
                break;
            }
        }
        //Si no se ha actualizado error
        if (!actualizat) {
            throw new ComparisionException(id + " has not been declared.");
        }
    }

    /**
     * Insertar parámetro en la lista.
     *
     * @param nombre: nombre del parámetro
     * @param pnombre: nombre del procedimiento.
     */
    public void addParam(String nombre, String pnombre) {
        Parametro param = new Parametro(nombre, pnombre);
        params.add(param);
    }

    /**
     * Salir del bloque de visibilidad actual.
     *
     * @throws ComparisionException
     */
    public void salirBloque() throws ComparisionException {
        if (n == 0) {
            throw new ComparisionException("Error while exiting the ambit, actual ambit:  " + n);
        }
        int end = (int) ta.get(n);
        n--; //Salimos del nivel
        int begin = (int) ta.get(n) + 1; //Para pasar al siguiente
        //Colocamos los identificadores en la tabla de descripcion
        while (begin <= end) {
            Tipus t = (Tipus) te.get(begin); //Cogido de te
            for (int i = 0; i < td.size(); i++) {
                if (((Tipus) td.get(i)).getId().equals(t.getId())) {
                    td.set(i, t);
                    break;
                }
            }
            begin++;
        }
        //Borramos los identificadores que estan en un nivel superior al actual
        ArrayList ids = new ArrayList();
        for (int i = 0; i < td.size(); i++) {
            if (((Tipus) td.get(i)).getNd() > n) {
                ids.add(((Tipus) td.get(i)));
            }
        }
        //Eliminamos los guardados
        for (int i = 0; i < ids.size(); i++) {
            td.remove(((Tipus) ids.get(i)));
        }
        //Eliminamos los nombres de los parametros de las funciones
        if (n == 0) { //Solo borraremos si estamos en nivel 0
            for (int i = 0; i < td.size(); i++) {
                if (((Tipus) td.get(i)).getD().getDtipo() == dtipo.dfunc) {
                    //Borramos los nombres
                    int node = i;
                    while (((Tipus) td.get(node)).getD().getSons() != 0) {
                        Tipus t = ((Tipus) td.get(node));
                        Tipus tipus = (Tipus) td.get(t.getD().getSons());
                        tipus.setId("");
                        node = ((Tipus) td.get(node)).getD().getSons();
                    }
                }
            }
        }
    }

    /**
     * Preguntar si existe un "tipus_pila" en la TS.
     *
     * @return true si existe.
     * @throws StackException
     */
    public boolean existePila() throws StackException {
        boolean found = false;
        for (int i = 0; i < td.size(); i++) {
            if (((Tipus) td.get(i)).getD().getTsb() == tsb.ts_tipus_pila) {
                if (found) {
                    return true;
                }
            }
        }
        return found;
    }

    /**
     * Convertir a String la TS.
     *
     * @return
     */
    @Override
    public String toString() {
        String s = "";
        for (int i = 0; i < td.size(); i++) {
            if (!((Tipus) td.get(i)).getId().equals("")) {
                s += (((Tipus) td.get(i)).getId()) + "\n";
            }
        }
        return s;
    }

    /**
     * Obtener ámbito actual de la TS.
     *
     * @return ámbito.
     */
    public int getN() {
        return this.n;
    }
}
