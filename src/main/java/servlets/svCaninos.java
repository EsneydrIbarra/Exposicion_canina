package servlets;

import com.umariana.exposicionCanina.Perro;
import com.umariana.exposicionCanina.Persistencia;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;

/**
 * 
 *
 * @author esney
 */

// Este servlet permite añadir nuevos perros a una lista.

@MultipartConfig
@WebServlet(name = "svCaninos", urlPatterns = {"/svCaninos"})
public class svCaninos extends HttpServlet {
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {                
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        String uploadPath = context.getRealPath("/foto");        

        try 
        {
            Persistencia.lectura(misPerros, context);
        } 
        catch (ClassNotFoundException ex) 
        {
            Logger.getLogger(svCaninos.class.getName()).log(Level.SEVERE, null, ex);
        }     
        
                        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
String nombrePerroABuscar = request.getParameter("buscar");
        
Perro perroABuscar = buscarPerroPorNombre(nombrePerroABuscar);  
        
    if (nombrePerroABuscar != null && !nombrePerroABuscar.isEmpty()) {
        // Implementa la lógica para buscar el perro en tu lista de perros
        Perro perroEncontrado = buscarPerroPorNombre(nombrePerroABuscar);
    if (perroEncontrado != null)                                    
        {
            // Genera la respuesta HTML con los detalles del perro
            String perroHtml = 
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Nombre</strong><br>" + "<h5 style='color: #555555; text-align: center;'</h5>"+ perroABuscar.getNombre() + "</h4>" +
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Raza</strong><br>" + "<h5 style='color: #555555; text-align: center;'</h5>" + perroABuscar.getRaza() +"</h4>" +
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Puntos</strong><br>" +"<h5 style='color: #555555; text-align: center;'</h5>" + perroABuscar.getPuntos() + "</h4>" +
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Meses de edad</strong><br>" + "<h5 style='color: #555555; text-align: center;'</h5>" + perroABuscar.getEdad() + "</h4>" +
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Foto del perrito</strong><br><br>" +
                   "<img src='" + request.getContextPath() + "/foto/" + perroABuscar.getFoto() + "' alt='" + perroABuscar.getNombre() + "' height='70%' width='75%' style='border: 2px solid #226638; border-radius:10px;'/></p>";

            response.setContentType("text/html");
            response.getWriter().write(perroHtml);
        } else {
            // Maneja el caso en el que no se encuentra el perro
            response.setContentType("text/plain");
            response.getWriter().write( "No hay perritos registrados con este nombre.");
        }
    }

//////////////////////////////////////// 
        
                
        //metodo para eliminar el perrito con el icono o boton trasher
        String eliminarNombre = request.getParameter("eliminar");
        // Encuentra el perro a eliminar en la lista
        if (eliminarNombre != null) {
        // Encuentra el perro a eliminar en la lista
        Perro perroAEliminar = buscarPerroPorNombre(eliminarNombre);
        if (perroAEliminar != null) {
            // Elimina el perro de la lista
            misPerros.remove(perroAEliminar);
            
            // Elimina también el archivo de la foto del perro
            String nombreArchivoFoto = perroAEliminar.getFoto();
            File archivoFoto = new File(uploadPath, nombreArchivoFoto);
            archivoFoto.delete();            
            // Guarda la lista actualizada
            Persistencia.escritura(misPerros, context);
        }
    }
        processRequest(request, response);
        
        String nombre = request.getParameter("nombre");
        //System.out.println(nombre);
        // Implementa la lógica para buscar el perro en tu lista de perros
        Perro perro = buscarPerroPorNombre(nombre); 
        
        if (perro != null)                                    
        {
            // Genera la respuesta HTML con los detalles del perro
            String perroHtml = 
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Nombre</strong><br>" + "<h5 style='color: #555555; text-align: center;'</h5>"+ perro.getNombre() + "</h4>" +
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Raza</strong><br>" + "<h5 style='color: #555555; text-align: center;'</h5>" + perro.getRaza() +"</h4>" +
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Puntos</strong><br>" +"<h5 style='color: #555555; text-align: center;'</h5>" + perro.getPuntos() + "</h4>" +
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Meses de edad</strong><br>" + "<h5 style='color: #555555; text-align: center;'</h5>" + perro.getEdad() + "</h4>" +
                   "<h4 style='color: #1c1c1c; text-align: center;'><strong>Foto del perrito</strong><br><br>" +
                   "<img src='" + request.getContextPath() + "/foto/" + perro.getFoto() + "' alt='" + perro.getNombre() + "' height='70%' width='75%' style='border: 2px solid #226638; border-radius:10px;'/></p>";

            response.setContentType("text/html");
            response.getWriter().write(perroHtml);
        } else {
            // Maneja el caso en el que no se encuentra el perro
            response.setContentType("text/plain");
            response.getWriter().write("No hay perritos registrados con este nombre.");
        }        
 
        //cerrar doGet
    }
    
// Inicio del método doPost()
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
        
        //aqui se recibiran los datos ingresados en el formulario
        String nombre = request.getParameter("nombre");
               // Verificar si el perro con el mismo nombre ya existe
               boolean perroExistente = misPerros.stream().anyMatch(p -> p.getNombre().equals(nombre)); 

if (perroExistente) {
   // mostrar una alerta al usuario en ventana modal.
   //cuando detectas que el nombre de un perro ya existe en la lista, se establece un atributo "nombreDuplicado" que se forma en la clase header
response.setContentType("text/html");
request.setAttribute("nombreDuplicado", true);
request.getRequestDispatcher("index.jsp").forward(request, response);
} else {
    // Resto del código para agregar el perro
    String raza = request.getParameter("raza");
    // Obtener la parte del archivo o sea la foto
    Part filePart = request.getPart("foto");
    String puntos = request.getParameter("puntos");
    String edad = request.getParameter("edad");
    // Método realizado para guardar la imagen y almacenarla, directorio
    String uploadPath = context.getRealPath("/foto");
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    String filePath = uploadPath + File.separator + fileName;
    String nuevoNombreArchivo = nombre + fileName.substring(fileName.lastIndexOf('.'));
    String nuevoFilePath = uploadPath + File.separator + nuevoNombreArchivo;
    
    // Lee el archivo de imagen desde la solicitud y lo escribe en el servidor, guardando el archivo en el sistema de archivos
    try (InputStream fileContent = filePart.getInputStream();
        FileOutputStream outputStream = new FileOutputStream(nuevoFilePath)) {
        int read;
        byte[] buffer = new byte[1024];
        while ((read = fileContent.read(buffer)) != -1) {
            outputStream.write(buffer, 0, read);
        }
    }
    
    // Crea el objeto Perro con el nuevo nombre del archivo
    Perro perro = new Perro(nombre, raza, nuevoNombreArchivo, Integer.parseInt(puntos), Integer.parseInt(edad));
    misPerros.add(perro);

    // Persistencia y redireccionamiento
    Persistencia.escritura(misPerros, context);
    session.setAttribute("misPerros", misPerros);
    // Redireccionar a la página deseada
    response.sendRedirect("index.jsp");
}        // Fin del método doPost()        
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo()
    {
        return "Short description";
    }
        // </editor-fold>
}
