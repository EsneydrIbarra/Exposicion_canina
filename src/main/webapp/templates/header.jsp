
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>   
<head>
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Exposición Canina</title>
    <!--importacion del boostrap para estilos adaptados-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- importacion del link de font awesome para los iconos -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" rel="stylesheet">            
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- llamar a un archivo que se encuentra eb el proyecto pero esta externo -->
    <script src="scripts/script.js" type="text/javascript"></script>
    <!-- agregando las fuentes desde google fonts-->
    <style>
  @import url('https://fonts.googleapis.com/css2?family=Alice&family=Architects+Daughter&family=Bungee&family=Chakra+Petch:wght@300&family=Kaushan+Script&family=Khand:wght@500&family=Oswald:wght@200;400;700&family=Permanent+Marker&family=Sedgwick+Ave+Display&family=Ultra&display=swap');
</style>
<!-- Agrega este script JavaScript antes de </body> en index.jsp -->
<script>
   function abrirFormularioEdicion(nombrePerro, razaPerro, puntosPerro, edadPerro, fotoPerro) {
    // Rellena el formulario de edición con los datos actuales del perro
    document.getElementById("editDogNombre").value = nombrePerro;
    document.getElementById("nuevoNombre").value = nombrePerro;

    document.getElementById("editDogRaza").value = razaPerro;
    document.getElementById("nuevaRaza").value = razaPerro;

    // Para la foto, estableciendo la imagen actual del perrito
    var imgElement = document.getElementById("fotoActual");
    imgElement.src = "<%= request.getContextPath() %>/foto/" + fotoPerro;

    document.getElementById("editDogPuntos").value = puntosPerro;
    document.getElementById("nuevosPuntos").value = puntosPerro;

    document.getElementById("editDogEdad").value = edadPerro;
    document.getElementById("nuevaEdad").value = edadPerro;

    // Abre la ventana modal de edición
    $('#editModal').modal('show');
}
</script>
</head>
<body>
    <!--creacion de modal para mostrar ventana emergente si el nombre llegase a ser repetido-->
  <div style="font-family: 'Archivo Black';" id="nombreDuplicadoModal" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Nombre existente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                El nombre que ingresaste ya está en uso. Por favor, elige otro nombre.
            </div>
            <div class="modal-footer d-flex justify-content-center" >
                <a class="btn btn-danger btn-success" href="index.jsp" class="btn btn-secondary">Regresar</a>
            </div>
        </div>
    </div>
</div>


