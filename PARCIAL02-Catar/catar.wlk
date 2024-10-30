class Plato {
    const cocinero

    method cocinero() = cocinero
    method cantidadAzucar()
    method esBonito()

    method caloriasPlato() {
        return 3 * self.cantidadAzucar() + 100
    }

}

class Entrada inherits Plato {

    override method cantidadAzucar() = 0
    override method esBonito() = true
}

class Principal inherits Plato {
    const cantidadAzucar
    const esBonito

    override method esBonito() = esBonito
    override method cantidadAzucar() = cantidadAzucar

}

class Postre inherits Plato {
    var colores 

    method colores() = colores

    override method esBonito() = colores > 3

    override method cantidadAzucar() = 120
}

// COCINEROS Y CHEFS
class Cocinero {
    var especialidad
    
    
    method calificacionPlato(plato) = especialidad.catar(plato)

    method asignarEspecialidad(unaEspecialidad) {
        especialidad = unaEspecialidad
    }

    method cocinar(cocinero) = especialidad.cocinar(cocinero)

    method presentarseATorneo(torneo, cocinero){
        torneo.presentarPlato(self.cocinar(cocinero))
    }
}

class Chef {
    const calorias

    method caloriasDeseadas() = calorias

    method catar (unPlato) = if (self.cumpleExpectativas(unPlato)) 10 else self.calificacionSinExpectativas(unPlato)

    method calificacionSinExpectativas(unPlato) = 0

    method cumpleExpectativas(unPlato) = unPlato.esBonito() && self.apruebaCalorias(unPlato)

    method apruebaCalorias(unPlato) = unPlato.caloriasPlato() <= self.caloriasDeseadas()

    method cocinar(cocinero) = new Principal(cocinero = cocinero, cantidadAzucar = calorias, esBonito = true)
}

class Pastelero {
    const dulzor

    method dulzorDeseado() = if (dulzor >= 10) 10 else dulzor

    method catar(unPlato) =  5 * unPlato.cantidadAzucar() / self.dulzorDeseado()

    method cocinar(cocinero) = new Postre(cocinero = cocinero, colores = (self.dulzorDeseado()/50))
}

class SousChef inherits Chef {
    override method calificacionSinExpectativas(unPlato) = (unPlato.caloriasPlato() / 100).min(6)

    override method cocinar(cocinero) = new Entrada(cocinero = cocinero)
}

// TORNEOS
class Torneo {
    const platosParticipantes = []
    const catadores = []

    method presentarPlato(unPlato) {
        platosParticipantes.add(unPlato)
    }

    method definirGanador() {
        if (platosParticipantes.isEmpty()) {
            throw new Exception(message = "No hay platos para evaluar")
        } else {
            return platosParticipantes.max({plato => self.calificacionPlato(plato)}).cocinero()
        }
    }

    method calificacionPlato(unPlato) {
        return catadores.sum({catador => catador.catar(unPlato)})
    }
}