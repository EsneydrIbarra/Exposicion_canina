<%@page import="com.umariana.exposicionCanina1.Persistencia"%>
<%@page import="com.umariana.exposicionCanina1.Perro"%>
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
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/[email protected]/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.0.0-beta1/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0v8FqFjcJ6pajs/rfdfs3SO+kD4Ck5BdPtF+to8xM6B5z6W5" crossorigin="anonymous"></script>
                <!-- Barra de navegación con botones -->
                <div class="navbar-nav">
                    <div class="input-group">
                        <input type="text" class="form-control" id="nombrePerroABuscar" placeholder="Buscar nombre del perrito">
                        <button class="btn btn-outline-primary" id="btnBuscar" type="button" data-bs-toggle="modal" data-bs-target="#modalBusqueda">Buscar perrito</button>
                        <div class="btn-group" role="group" aria-label="Botones de búsqueda y ordenamiento">
                            <button class="btn btn-outline-primary" onclick="ordenarPorPuntos()">Ordenar por mayor Puntaje</button>
                            <button class="btn btn-outline-primary" id="btnOrdenarPorEdad" onclick="ordenarPorEdadDescendente()">Ordenar por mayor Edad</button>
                            <button class="btn btn-outline-primary" id="btnOrdenarPorNombre" onclick="ordenarPorNombre()">Ordenar por Nombre (A-Z)</button>
                            <button type="button" class="btn btn-outline-primary" id="btnMostrarMayorPuntaje">Mostrar Perro con Mayor Puntaje</button>
                            <button type="button" class="btn btn-outline-primary" id="btnMostrarMenorPuntaje">Mostrar Perro con Menor Puntaje</button>
                            <button type="button" class="btn btn-outline-primary" id="btnMostrarPerroMasViejo">Mostrar Perro Más Viejo</button>                        
                        </div>
                    </div>
                </div>
                <thead>
                    <tr class="text-center"> 
                           
                        <th>Nombre</th>                           
                            
                        <th>Raza</th>
                            
                        <th>Foto</th>
                            
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
                    <tr id="tr" class="text-center">                                   
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
                <!-- include para incluir un archivo dentro de otro, en este caso el footer qque tomara los scripts realizados en esa clase.  -->
                <%@include file= "templates/footer.jsp"%>