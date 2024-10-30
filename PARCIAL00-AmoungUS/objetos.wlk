class Jugador {
    var estaVivo = true
    var puedeVotar = true
    var property nivelSospecha = 40
    var personalidad
    
    const mochila = []  //Es una constante, a pesar que agrego cosas, no cambia el objeto lista sino que su contenido


    //NIVEL DE SOSPECHA
    method esSospechoso () = nivelSospecha > 50

    method nivelSospecha() = nivelSospecha

    method aumentarSospecha (unValor) {
        nivelSospecha += unValor
    }

    method disminutirSospecha (unValor) {
        nivelSospecha -= unValor
    }


    //ITEMS MOCHILA 
    method agregarItem (unItem) {
        mochila.add(unItem)
    }

    method usarItem (unItem) {
        mochila.remove(unItem)
    }

    method tieneItem (unItem) = mochila.contains(unItem)

    method tieneItems () = !mochila.isEmpty()


    //ACCIONES
    method impugnarVoto () {
        puedeVotar = false
    }

    method llamarReunion () {
        nave.llamarReunionDeEmergencia()
    }

    method estaVivo() = estaVivo
}


class Tripulante inherits Jugador {
    const property tareas = []


    method completoSusTareas () {
        tareas.isEmpty()
    }

    method agregarTareas (unaTarea) {
        tareas.add(unaTarea)
    }

    method realizarTarea () {
        const tarea = self.tareaPendienteRealizable()
        tarea.realizarse(self)
        tareas.remove(tarea)
        nave.terminaronTarea()
    }

    method tareaPendienteRealizable () = tareas.find {tarea => tarea.puedeRealizar(self)}

    method voto () = if (puedeVotar) {
        personalidad.voto()
    }else {
        self.votarEnBlanco()
    }

    method votarEnBlanco() {
        puedeVotar = true
        return votoEnBlanco  // EL CASO PROHIBIDO
    }

    method expulsar() {
        estaVivo = false
        nave.expulsarTripulante()
    }

}

class Impostor inherits Jugador {
    method completoSusTareas () = true

    method realizarTarea () {
        //no hace nada
    }

    method realizarSabotaje (unSabotaje) {
        self.aumentarSospecha(5)
        unSabotaje.realizarse()
    }

    method voto () = nave.cualquierJugadorVivo()

    method expulsar () {
        estaVivo = false
        nave.expulsarImpostor()
    }
}

class Tarea{
    const itemsNecesarios

    method puedeRealizar (unJugador) = itemsNecesarios.all {item => unJugador.tiene(item)}

    method realizarse (unJugador) {
        self.usarItemsNecesarios(unJugador)
        self.afectarA(unJugador)
        nave.terminaronTarea()
    }

    method usarItemsNecesarios (unJugador) {
        itemsNecesarios.forEach {item => unJugador.usarItem(item)}
    }

    method afectarA (unJugador) 

    method tareasPendientesRealizables 
}

class ArreglarTablero inherits Tarea (itemsNecesarios = ["llaveInglesa"]) {   

    override method afectarA (unJugador){
        unJugador.aumentarSospecha(10)
    }
}

class SacarBasura inherits Tarea (itemsNecesarios = ["escoba", "bolsaBasura"]) {

    override method afectarA (unJugador) {
        unJugador.disminuirSospecha(4)
    }
}

class VentilarNave inherits Tarea {
    override method puedeRealizar (unJugador) = true

    override method realizarse (unJugador) {
        nave.aumentarOxigeno(5)
    }

}

object nave {
    var nivelOxigeno = 100
    var cantidadImpostores = 0
    var cantidadTripulantes = 0

    const jugadores = []
    

    method disminuirOxigeno (unValor) {
        nivelOxigeno -= unValor
        self.validarGanaronImpostores()
    }

    method aumentarOxigeno (unValor) {
        nivelOxigeno += unValor
    }

    method terminaronTarea () = 
    if (self.seCompetaronTodasLasTareas()) {
        throw new DomainException(message = "Ganaron los tripulantes")
    }
    
    method seCompetaronTodasLasTareas () = jugadores.all {jugador => jugador.completoSusTareas()}
    
    method sabotearOxigeno (unValor) {
        if (not self.alguienTieneTuboOxigeno()){
            self.disminuirOxigeno(unValor)
        }
    }

    method alguienTieneTuboOxigeno () = jugadores.any {jugador => jugador.tieneItem("tuboOxigeno")}

    method validarGanaronImpostores () {
        if (nivelOxigeno <= 0) {
            throw new DomainException(message = "Ganaron los impostores")
        }
    }

    method llamarReunionDeEmergencia () {
        const losVotos = self.jugadoresVivos().map{ jugador => jugador.voto()}
        const elMasVotado = losVotos.max {alguien => losVotos.occurrencesOf(alguien)}
        elMasVotado.expulsar()
    }

    method jugadoresVivos () = jugadores.filter { jugador => jugador.estaVivo() }

    method jugadorNoSospechoso () =  self.jugadoresVivos().findOrDefault({ jugador => !jugador.esSospechoso() }, votoEnBlanco)

    method jugadorMasSospechoso () =   self.jugadoresVivos().max { jugador => jugador.nivelSospecha() }

    method jugadorSinItems () = self.jugadoresVivos().findOrDefault({ jugador => !jugador.tieneItems() }, votoEnBlanco)

    method cualquierJugadorVivo() = self.jugadoresVivos().anyOne()

    method expulsarTripulante() {
        cantidadTripulantes -= 1
        self.validarGanaronImpostores()
    }

    method expulsarImpostor() {
        cantidadImpostores -= 1
        if (cantidadImpostores == 0) {
            throw new DomainException(message = "Ganaron los tripulantes")
        }
    }

}


object reducirOxigeno {
    method realizarse () {
        nave.sabotearOxigeno(10)   
    }
}

class ImpugnarJugador {
    const jugadorImpugnado 

    method realizarse () {
        jugadorImpugnado.impugnarVoto()
    }
}

object troll {
    method voto() = nave.jugadorNoSospechoso()
}

object detective {
    method voto() = nave.jugadorMasSospechoso()
}

object materialista {
    method voto() = nave.jugadorSinItems()
}

object votoEnBlanco {
    method expulsar() {
        // No hace nada
    }
}

//occurrencesOf, cuenta la cantidad de apariciones de un elemento en una colección.
//findOrDefault, devuelve un elemento (si encuentra uno que cumpla la condición) o un valor default en caso negativo.
