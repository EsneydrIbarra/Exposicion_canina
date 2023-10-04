package servlets;
//librerias importadas
import com.umariana.exposicionCanina.Perro;
import com.umariana.exposicionCanina.Persistencia;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
/**
 *
 * @author esney
 */
@MultipartConfig
@WebServlet(name = "svEditarPerro", urlPatterns = {"/svEditarPerro"})
public class svEditarPerro extends HttpServlet {
    ArrayList<Perro> misPerros = new ArrayList<>();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");          
    }
    /**
     * 
     * @throws ServletException 
     */
    public void init() throws ServletException{        
    }
    private Perro buscarPerroPorNombre (String nombre){
        for ( Perro perro : misPerros){
            if (perro.getNombre().equals(nombre)){
                return perro;
            }
        }
        return null;
    }
     /**
      * 
      * @param request
      * @param response
      * @throws ServletException
      * @throws IOException 
      */
 @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
    }
     /**
      * en este metodo dopost se hara la accion que permite editar la informacion del perrito.
      * @param request
      * @param response
      * @throws ServletException
      * @throws IOException 
      */
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        //metodos para guardar las sesiones que almacenaran los datos del perrito y la ruta de la ejecucion
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        //creacion del array para guardar los datos de los perritos
        ArrayList<Perro> misPerros = new ArrayList<>();
        //se intenta cargar la lista de perros desde un archivo
        try 
        {
            Persistencia.lectura(misPerros, context);
           //si se produce un error al leer el archivo, se captura la excepción y se registra un mensaje de error
        }    
        catch (ClassNotFoundException ex)
        {
            Logger.getLogger(svCaninos.class.getName()).log(Level.SEVERE, null, ex);
        }
        processRequest(request, response);
    
        // Verifica si la solicitud es una edicion (comprobar si se ha enviado el campo "nombreEditar")
    String nombreEditar = request.getParameter("nombreEditar");
    String uploadPath = context.getRealPath("/foto");
    if (nombreEditar != null && !nombreEditar.isEmpty()) {
        // Implementa la lógica para editar el perro con el nombre proporcionado

        // Busca el perrito por el nombre original (nombreEditar)
        Perro perroAEditar = buscarPerroPorNombre(nombreEditar);

        if (perroAEditar != null) {
            // Se obtienen los nuevos valores del formulario de edicion
            String nuevoNombre = request.getParameter("nuevoNombre");
            String nuevaRaza = request.getParameter("nuevaRaza");
            String nuevoPuntos = request.getParameter("nuevosPuntos");
            String nuevaEdad = request.getParameter("nuevaEdad");
            Part nuevaFotoPart = request.getPart("fotoEditar");
            // Actualiza los datos del perrito
            perroAEditar.setNombre(nuevoNombre);
            perroAEditar.setRaza(nuevaRaza);
            perroAEditar.setPuntos(Integer.parseInt(nuevoPuntos));
            perroAEditar.setEdad(Integer.parseInt(nuevaEdad));
            // Maneja la actualización de la foto si se proporciona una nueva
            if (nuevaFotoPart != null && nuevaFotoPart.getSize() > 0) {
                // Guarda la nueva foto y actualiza el nombre de la foto del perrito
                String nuevoNombreArchivo = nuevoNombre +
                        nuevaFotoPart.getSubmittedFileName().substring(
                                nuevaFotoPart.getSubmittedFileName().lastIndexOf('.')
                        );
                String nuevoFilePath = uploadPath + File.separator + nuevoNombreArchivo;
                // Guarda la imagen en el servidor
                try (InputStream fileContent = nuevaFotoPart.getInputStream();
                     FileOutputStream outputStream = new FileOutputStream(nuevoFilePath)) {
                    int read;
                    byte[] buffer = new byte[1024];
                    while ((read = fileContent.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, read);
                    }
                }

                // Actualiza el nombre de la foto en el perro
                perroAEditar.setFoto(nuevoNombreArchivo);
            }

            // Actualiza la lista de perros y guarda en el contexto
            Persistencia.escritura(misPerros, context);

            // Redirige de nuevo a la página deseada (en este caso, index.jsp)
            response.sendRedirect("index.jsp");
            return; // Importante: salir del método doPost para evitar procesamiento adicional
        }
    }
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}