# MeLiApp

App que utiliza la API de Mercado Libre para buscar productos por nombre, 
muestra los resultados en una tabla, y permite acceder al detalle de cada item.
Si bien quedan muchas cosas por mejorar, por falta de tiempo se decidio entregar este proyecto en este estado, para lugo con el tiempo ir corrigiendo errores y agregando funcionalidades.

### ScreenShots
<img width="200" alt="Screen Shot 2020-01-13 at 00 35 01" src="https://user-images.githubusercontent.com/30415736/72232096-c33e5080-359d-11ea-80cd-26eb5b181f16.png">            <img width="200" alt="Screen Shot 2020-01-13 at 00 35 20" src="https://user-images.githubusercontent.com/30415736/72232100-c76a6e00-359d-11ea-8bef-af5769242da7.png">           <img width="200" alt="Screen Shot 2020-01-13 at 00 35 35" src="https://user-images.githubusercontent.com/30415736/72232104-cafdf500-359d-11ea-8960-7632be1b388a.png">


## Estructura

Opte por utilizar `Model View ViewModel` para mantener las vistas y los modelos desacoplados. 
Por falta de tiempo no pude finalizar muchos aspectos de la app, pero esta estructura me permite continuar  con el desarrollo de la misma de una forma ordenada y practica.

## Flujo

La app se conforma de tres pantallas con las que el usuario puede interactuar.

### Pantalla de busqueda

Se compone de una interfaz totalmente intuitiva, que consta de un campo de busqueda con auto foco, un boton que realiza la consulta del producto buscado y el logo de Mercado Libre.
Cuenta ademas con una alerta que notifica al usuario si no se ha ingresado ningun valor en el campo de busqueda.

### Pantalla de resultado

Al igual que la pantalla de busqueda la app de Mercado Libre en iOS, esta compuesta por una table view con celdas reutilizables para optimizar el uso de memoria, la cual muestra los resultados provenientes del servidor.

### Pantalla de detalle del producto

Opte por utilizar una collection view, configurada de forma horizontal, para mostrar un arreglo de fotos provenientes del servidor.
Configure varios labels para mostrar informacion simple, como el titulo del producto y el precio, entre otros datos.
Por ultimo utilice un text field para mostrar el detalle del producto que obtengo del servidor como texto plano.

## API request

El proceso de consulta a la API se dividio en diferentes pasos

### Consulta al servidor

Implemente un NetworkManager que realiza una consulta generica, el cual es utilizado por tres metodos que le pasan una url y un tipo de modelo especifico para realizar la serializacion del JSON que proveniente del servidor.

### Serializacion del JSON

Se crearon diferentes modelos para mapear la respuesta de la API a un objeto que pueda ser utilizado por el view model.
Si bien el modelo creado es mucho mas grande que los objetos utilizados, me permite en un futuro poder implementar nuevas funcionalidades 

## Librerias

### SDWebImages

Opte por utilizar esta libreria para descargar las imagenes provenientes de la API ya que la descarga es bajo demanda y funciona de forma asincronica. 
Otra de las ventajas de esta libreria es que cuenta con una cache que permita almacenar las imagenes descargadas, reduciendo el uso de la red.

Link al repo de [SDWebImages](https://github.com/%/SDWebImage).

## Permisos 
Para hacer uso del framework antes mencionado es necesario agregar dentro de las opciones del `info.plist` el diccionario `App Transport Security Settings` con la key `Allow arbitrary loads` y su valor en `YES`.

## Testing

Implemente el testeo algunos metodos de DetailViewModel mediante Unit Testing. Para realizar esto fue necesario que a los metodos encargados de realizar la consulta a la API se les pudiera inyectar una dependencia. 
Para esto se creo un protocolo que extienden tanto las clases que utiliza la app para realizar la consulta, como asi tambien una clase que mockea las respuestas de la API.

