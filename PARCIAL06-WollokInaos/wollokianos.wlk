//MENSAJES
class Mensaje {
    const remitente
    const peso
    const property contenido

    method peso() = transferencia.valorFijo() + self.pesoContenido() * red.factor()

    method pesoContenido() = contenido.peso()

    method remitente() = remitente
}

object transferencia {
    method valorFijo() = 5
}
object red {
    method factor() = 2
}

//TIPO DE CONTENIDO DE MENSAJES
class Texto {
    const contenido

    method peso() = contenido.size()
}

class Audio {
    const duracion

    method peso() = duracion * 1.2
}

class Imagen {
    const ancho
    const alto
    const tipoCompresion

    method peso() = tipoCompresion.pesoComprimido(self.cantidadPixels()) * 2   //2 porque cada pixel pesa 2KB

    method cantidadPixels() = ancho * alto
}

class Gif inherits Imagen {
    const cuadros
    override method peso() = super() * cuadros
}

class Contacto {
    const property contactoEnviado

    method peso() = 3
}

//COMPRESIONES TIPO
object compresionOriginal {
    method pesoComprimido(cantidadPixels) = cantidadPixels 
}

class CompresionVariable {
    const factor

    method pesoComprimido(cantidadPixels) = cantidadPixels * (factor/100)
}

object compresionMaxima {
    method pesoComprimido(cantidadPixels) = 10000.min(cantidadPixels)
}


////////////////////////////////////////////////////////////////////////
//CHATS

class Chat {
    const participantes = []
    const property mensajes = [] 

    method puedeEnviarMensaje(mensaje) = participantes.contains(mensaje.emisor()) 
        and participantes.all {participante => participante.poseenEspacioParaRecibir(mensaje)}

    method espacioQueOcupa() = mensajes.sum {mensaje => mensaje.peso()}

    method enviarMensaje(mensaje) {
        self.validarEnvio(mensaje)
        mensajes.add(mensaje)
        self.notificarParticipantes(mensaje)
    }

    method validarEnvio(mensaje){
		if (not self.puedeEnviarMensaje(mensaje)) {
			self.error("No se puede enviar el mensaje")
		}
	}

    method notificarParticipantes(mensaje) {
        participantes.forEach({usuario => usuario.recibirNotificacion(new Notificacion(chat = self))})
    }

    method contiene(texto) = mensajes.any {mensaje => mensaje.contenido().contains(texto)}
        or participantes.any {participante => participante.nombre().contains(texto)}
        or mensajes.any {mensaje => mensaje.contenido().contactoEnviado().contains(texto)}

    method mensajeMasPesado() = mensajes.max({mensaje => mensaje.peso()})
}

class ChatPremium inherits Chat{
    var tipoChat

    override method puedeEnviarMensaje(mensaje) = super(mensaje) and tipoChat.puedeEnviarMensaje(mensaje, mensajes)

    method modificarTipoChat(nuevoTipo) { tipoChat = nuevoTipo }

    method agregarParticipante(participante) { 
        participantes.add(participante) and participante.agregarChat(self)
    }

    method eliminarParticipante(participante) { 
        participantes.remove(participante) and participante.eliminarChat(self)
    }

}

class Difusion {
    const creador
    method puedeEnviarMensaje(mensaje, mensajesChat) = mensaje.remitente() == creador
}

class Restringido {
    const limiteMensajes
    method puedeEnviarMensaje(mensaje, mensajesChat) = mensajesChat.size() < limiteMensajes
}

class Ahorro {
    const pesoMaximo
    method puedeEnviarMensaje(mensaje, mensajesChat) = mensaje.peso() < pesoMaximo
}


//USUARIO
class Usuario{
    var memoria
    const property nombre
    const chats = []
    const notificaciones = []

    method poseenEspacioParaRecibir(mensaje) = memoria >= mensaje.peso()
    
    //Modificar pertenecia a chats
    method agregarChat(chat) { chats.add(chat) }
    method eliminarChat(chat) { chats.remove(chat) }

    //busqueda de chats
    method buscar(texto) = chats.filter{chat => chat.contiene(texto)}

    //mensaje mas pesado
    method mensajesMasPesado() = chats.map {chat => chat.mensajeMasPesado()}


    //notificaciones
    method recibirNotificacion(notificacion) { notificaciones.add(notificacion) }


}

class Notificacion {
	const property chat
	var property leida = false
	
	method leer() { leida = true }
}