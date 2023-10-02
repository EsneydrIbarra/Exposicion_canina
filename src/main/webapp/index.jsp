<%@page import="com.umariana.exposicionCanina.Perro"%>
<%@page import="com.umariana.exposicionCanina.Perro"%>
<%@page import="com.umariana.exposicionCanina.Persistencia"%>
<%@page import="java.util.ArrayList"%>

<!-- include para incluir un archivo dentro de otro, en este caso el header.  -->
<%@include file="templates/header.jsp"%>
<!-- Agregar banner para interfaz principal -->
<nav class="navbar navbar-light bg-light">
    <a class="img-fluid mx-auto navbar-brand">
        <img src="imagenes/banner.jpg" style="width: 100%; height: auto;" class="d-inline-block align-top" alt="banner">    
    </a>
</nav>

<!-- clase contenedora -->    
<!-- Clase container-fluid para que el contenedor se extienda a toda la pantalla -->
<div style="font-family: 'Archivo Black';" class="container-fluid">
 <!-- Clase max-width para establecer un ancho máximo para el contenedor -->
  <div class="row max-width">       
      <!-- clase division por 4 columnas -->
      <!-- Clase mx-auto para centrar el contenedor horizontalmente -->
      <div class="col-md-4 mx-auto">         
        <div class="card card-body"> 
                <!-- tarjeta de trabajo o formulario, enctype que permite enviar archivos medidos en bytes, img-->
                <form action ="svCaninos" method = "POST" enctype="multipart/form-data">
                    <h3 style="text-align: center">Agregar nuevo perrito</h3>                    
                    <!-- Label e input para el nombre-->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="nombre">Nombre</label>
                        <input type="text" name="nombre" class="form-control" placeholder="Ingrese el nombre" aria-label="Ingrese el nombre" aria-describedby="basic-addon1" id="nombre" required="ingresa name">                                         
                      </div>                                    
                      <!-- Label e input para la raza-->
                      <div class="input-group mb-3">
                          <label class="input-group-text" for="raza">Raza</label>
                          <input type="text" name="raza" class="form-control" placeholder="Ingrese la raza" aria-label="Ingrese la raza" aria-describedby="basic-addon1" id="raza" required>
                      </div>
                      <!--Label e input para la foto-->                     
                      <div  class="input-group mb-3">
                          <label class="input-group-text" for="foto">Foto</label>                          
                          <!-- tipo file para subir las imagenes de varios formatos de imagen, permite modificar boton y examinar en explorador -->
                          <input type="file" class="form-control" name="foto" id="foto" required data-content="" accept="image/jpeg, image/pjpeg, image/png, image/gif, image/svg+xml, image/bmp, image/tiff" required>                                                       
                      </div>                  
                      <!--Label e inputnput para los puntos-->                   
                      <div class="input-group mb-3">
                          <label class="input-group-text" for="puntos">Puntos</label>
                          <select class="form-select" name="puntos" aria-label="Default select example" required>
                              <option value="" disabled selected>Seleccione...</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                            </select>
                      </div>
                      <!-- Label e input para la edad-->
                      <div class="input-group mb-3">
                          <label class="input-group-text" for="edad">Edad</label>
                          <input type="text" name="edad" class="form-control" placeholder="Ingrese la edad" aria-label="la edad" aria-describedby="basic-addon1" id="edad" required>
                      </div>
                      <!-- boton de agregar el perrito --> 
                      <div class="text-center">
                          <button type="submit" class="btn btn-success mx-auto">Agregar perrito</button>
                      </div>
                        </form>               
                    </div>    
                </div> 
                <!-- Tabla de datos, agregamos diseño gris en table-light -->
                <div class="col-md-8">
                    <table style="font-family: 'Archivo Black';" class="table  table-bordered table-light">  
                        <!-- Agregando buscador de perritos -->                        
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" id="nombrePerroABuscar" placeholder="Buscar nombre del perrito">
                            <button class="btn btn-primary" id="btnBuscar" type="button" data-bs-toggle="modal" data-bs-target="#modalBusqueda">
                                Buscar perrito
                            </button> 
                            
                        </div>
                            <thead>
                            <tr class="text-center"> 
                                <th>Nombre</th>                           
                                <th>Raza</th>
                                <th>Foto (ubicación)</th>
                                <th>Puntos</th>
                                <th>Edad</th>
                                <th>Acciones</th>                                                  
                            </tr>                    
                        </thead>        
                        <tbody>                              
                            <!-- se toma el array creado en el POST para los datos de los perritos-->
                            <%
                                ArrayList<Perro> misPerros = new ArrayList<>();                    
                                ServletContext context = getServletContext();
                                //con el metodo de lectura de la clase persistencia se trae la informacion del archivo
                                Persistencia.lectura(misPerros, context);                            
                                // if usado para saber si no hay informacion en el archivo o algo no deseado paso
                                if (misPerros != null) 
                                {
                                //siclo for para hacer que la tabla se extienda las veces necesarias segun los datos del formulario
                                for (Perro perro : misPerros) 
                                {
                                %>
                                <tr class="text-center">
                                    <!-- las extensiones para la sub tabla con los datos registrados en el form -->
                                    <td><%= perro.getNombre() %></td>
                                    <td><%= perro.getRaza() %></td>
                                    <!--esta linea siguiente <td> sera comentarizada para no mostrar toda la ruta de la imagen, por lo que se la reemplazo por la siguiente linea que muestra solo nombre.formato-->
                                    <!-- agregamos el nombre de la iamgen con el nombre del perro, y se agrega el "/foto/" para que se note la ubicacion de la carpeta, es un complemento -->
                                    <!--<td><%= request.getContextPath() %>/foto/<%= perro.getNombre() + perro.getFoto().substring(perro.getFoto().lastIndexOf('.')) %>"</td>-->
                                    <!--Sin embargo tambien se agrego la imagen de esta manera para simplemente ver el nombre de la imagen reemplazada-->
                                    <td><%=perro.getFoto()  %></td>
                                    <td><%= perro.getPuntos() %></td>
                                    <td><%= perro.getEdad() %></td>
                                        <!-- se agrego de esta manera los iconos para poderlos ver sin espaciados y en el mismo bloque<td> -->
                                    <td>
                                        <a href="svCaninos" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal" data-nombre="<%=perro.getNombre()%>">
                                            <i class="fa fa-eye text-white"></i>
                                        </a>
                                        <!-- Actualiza el botón de edición en la tabla de perritos, para editar su informacion -->
                                        <a href="#editModal" class="btn btn-warning btn-sm" title="Editar"
                                            onclick="abrirFormularioEdicion('<%= perro.getNombre() %>', '<%= perro.getRaza() %>', '<%= perro.getPuntos() %>', '<%= perro.getEdad() %>')">
                                            <i class="fa fa-pencil-alt text-white"></i>
                                        </a>
                                              <!-- boton para eliminar el perrito modificado para usar jax -->
                                        <button class="btn btn-danger btn-sm" onclick="eliminarPerro('<%= perro.getNombre() %>')">
                                            <i class="fa fa-trash text-white"></i>
                                        </button>                                               
                                    </td>
                                </tr>
                                <!-- cierre de el ciclo for e if-->
                                <%                        
                                    }
                                }           
                                %>     
                        </tbody>
                    </table>                       
                </div>
            </div>          
        </div>    
                        <!-- boostrap -->
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>                       

                <!-- Modal para la búsqueda -->
<div style="font-family: 'Archivo Black';" class="modal fade" id="modalBusqueda" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">¿Este es el perrito que buscabas?</h4>
                <button type="button" class="btn-close btn-close-danger" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Elemento para mostrar el mensaje de alerta -->
                <div id="alertaBusquedaVacia" class="alert alert-danger" style="display: none;">
                    Ingresa un nombre de perrito para buscar.
                </div>

                <!-- Aquí puedes mostrar el resultado de la búsqueda -->
                <div id="perro-detailss" class="text-center">
                    <!-- Detalles del perro buscado -->
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-danger btn-success" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>


                      <!-- agregamos la ventana modal desde boostrap -->
                        <!-- Modal con clases de la ventana de boostrap, propiedad tabindex que en este caso manda hacia adelante la ventama-->
                        <!-- agregar data-bs... para que la ventana no se cierre al presionar por fuera -->
  <div style="font-family: 'Archivo Black';" class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" id="tablaResultados">
    <div class="modal-dialog modal-dialog-centered  modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Detalles del Perrito</h4>
            <button type="button" class="btn-close btn-close-danger" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="perro-details" class="text-center">
                    <!-- Detalles del perro -->
                </div>
            </div>
   <!-- cambio al estilo del boton cerrar -->
   <div class="modal-footer d-flex justify-content-center">
       <!-- aqui se agrega en este boton, data-bs... para que la ventana se cierre con ese unico boton -->
       <button type="button" class="btn btn-danger btn-success" data-bs-dismiss="modal" data-bs-dismiss="modal">Cerrar</button>
        </div>
        </div>
    </div>
</div>                 
                        <!--agregamos modal para la edicion de la informacion del perrito-->
<div style="text-align: center" style="font-family: 'Archivo Black';" class="modal fade" id="editModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Editar Perrito</h4>
                <button type="button" class="btn-close btn-close-danger" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="svCaninos" method="POST" enctype="multipart/form-data">
                    <!-- Campo de nombre oculto para editar -->
                    <input type="hidden" id="editDogNombre" name="nombreEditar">
                    <input type="hidden" id="editDogRaza" name="razaEditar">
                    <input type="hidden" id="fotoActual" name="fotoEditar">
                    <input type="hidden" id="editDogPuntos" name="puntosEditar">
                    <input type="hidden" id="editDogEdad" name="edadEditar">
                    <!-- Campo de nuevo nombre (editable) -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="nuevoNombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nuevoNombre" name="nombreEditar" required>
                    </div>                   
                    <!-- Campo de nueva raza (editable) -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="nuevaRaza" class="form-label">Raza</label>
                        <input type="text" class="form-control" id="nuevaRaza" name="razaEditar" required>
                    </div>

                    <!-- Campo de nueva foto (editable) -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="nuevaFoto" class="form-label">Nueva Foto</label>
                        <input type="file" class="form-control" id="nuevaFoto" name="fotoEditar" accept="image/jpeg, image/pjpeg, image/png, image/gif, image/svg+xml, image/bmp, image/tiff" required>
                    </div>                                        

                    <!-- Campo de nuevos puntos (editable) -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="nuevosPuntos" class="form-label">Puntos</label>
                        <select class="form-select" id="nuevosPuntos" name="puntosEditar" aria-label="Default select example" required>
                            <option value="" disabled selected>Seleccione...</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select>
                    </div>
                 
                    <!-- Campo de nueva edad (editable) -->
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="nuevaEdad" class="form-label">Edad</label>
                        <input type="text" class="form-control" id="nuevaEdad" name="edadEditar" required>
                    </div>
                    
                    <!-- Botón para guardar cambios -->
                    <div class="d-flex justify-content-center">
                        <button type="submit" class="btn btn-success mx-2">Guardar Cambios</button>
                        <!-- Cambio al estilo del botón Cerrar -->
                        <button type="button" class="btn btn-danger btn-success mx-2" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>                                               
                        <!-- este script es para la funcion de mostrar detalles del perrito-->
                        <script>
                            // funcion para mostrar los datos en la ventana modal
                                     $('#exampleModal').on('show.bs.modal', function (event) {
                                    // Botón que desencadenó el evento
                                   var button = $(event.relatedTarget); 
                                    // Obtén el nombre del perro
                                   var nombre = button.data('nombre'); 
                                   // Realiza una solicitud AJAX al servlet para obtener los detalles del perro por su nombre
                                    $.ajax({
                                    // Cambia 'id' por el nombre del parámetro que esperas en tu servlet
                                     url: 'svCaninos?nombre=' + nombre, 
                                    method: 'GET',
                                   success: function (data) {
                                    // Actualiza el contenido del modal con los detalles del perro
                                        $('#perro-details').html(data);
                                    },
                                    error: function () {
                                        // Maneja errores aquí si es necesario
                                             console.log('Error al cargar los detalles del perro.');
                                         }
                                     });
                                 });
                                          </script>
                                          <!-- esta funcion es para eliminar a un perrito, usado igual que el anterior, con un ajax-->                                          
                                          <script>
                                    function eliminarPerro(nombrePerro) {
                                        if (confirm("          ¿Estás seguro de que quieres eliminar a " + nombrePerro + "?" + "\n" +
                                                    "\n" +
                                                     "                          Esta acción no se puede cancelar.")) {
                                            // Envía una solicitud AJAX al servidor para eliminar el perro
                                            $.ajax({
                                                type: 'GET',
                                                url: 'svCaninos?eliminar=' + nombrePerro,
                                                success: function (data) {
                                                    
                                                    // Actualiza la tabla en la página sin recargarla
                                                    location.reload();
                                                },
                                                error: function () {
                                                    console.log('Error al eliminar el perro.');
                                                }
                                            });
                                        }
                                    }
                                </script>    
                                <script>
                            // Verifica si se debe mostrar el modal de nombre duplicado
                            <% if (request.getAttribute("nombreDuplicado") != null) { %>
                                $(document).ready(function() {
                                    $('#nombreDuplicadoModal').modal('show');
                                });
                            <% } %>
                        </script>
                        <!--script para buscar al perrito por su nombre-->
                        <script>
$(document).ready(function() {
    $('#btnBuscar').click(function() {
        var nombreABuscar = $('#nombrePerroABuscar').val().trim();
        var modalTitle = $('#modalBusqueda').find('.modal-title'); // Encuentra el elemento del título de la modal

        if (nombreABuscar === '') {
            // Mostrar la modal con título de error si el campo de búsqueda está vacío
            modalTitle.text('Error');
            $('#alertaBusquedaVacia').show();
            // Limpiar el contenido de la modal para eliminar la información del perro anteriormente buscado
            $('#perro-detailss').html('');
            return; // Salir de la función y evitar la búsqueda vacía
        } else {
            // Ocultar el mensaje de alerta si se ingresó un nombre válido
            $('#alertaBusquedaVacia').hide();
        }
        
        // Restaurar el título predeterminado de la modal
        modalTitle.text('¿Este es el perrito que buscabas?');
        
        // Realizar una solicitud AJAX al servidor para buscar el perro por nombre
        $.ajax({
            type: 'GET',
            //se uso "nombre" para recorrerlo y simplificar, no hay motivos de sancion por este hecho
            url: 'svCaninos?nombre=' + nombreABuscar,
            success: function(data) {
                // Verificar si se encontraron resultados antes de mostrar la modal
                if (data.trim() !== '') {
                    // Actualizar la tabla de resultados con los detalles del perro
                    $('#perro-detailss').html(data);
                } else {
                    // Mostrar un mensaje si no se encontraron resultados
                    alert('No se encontraron resultados para el nombre de perro ingresado.');
                    // Limpiar el contenido de la modal para eliminar la información del perro anteriormente buscado
                    $('#perro-detailss').html('');
                }
            },
            error: function() {
                // Manejar errores aquí si es necesario
                console.log('Error al buscar el perro.');
            }
        });
    });
});

                        </script>
          
                                          <!-- include para incluir un archivo dentro de otro, en este caso el footer.  -->
                                          <%@include file= "templates/footer.jsp"%>