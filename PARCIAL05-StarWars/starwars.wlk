class Planeta {
    const habitantes = []

    method poderTotal() = habitantes.sum {habitante => habitante.poder()}

    method poseeOrden() = self.poderHabitantesMasPoderosos() > self.poderTotal() * 0.5

    method poderHabitantesMasPoderosos() =      //bloque bool de 2
            habitantes.sortBy({ unHabitante, otroHabitante => 
			unHabitante.poder() > otroHabitante.poder() }).take(3)
}

class Habitante {
    var property valentia
    var property inteligencia

    method poder() = self.valentia() + self.inteligencia()
}

class Soldado inherits Habitante {
    const equipamiento = []

    override method poder() = super() + self.potenciaEquipamiento()

    method potenciaEquipamiento() = (self.equipamientoUtil()).sum {item => item.potencia()}

    method equipamientoUtil() = equipamiento.filter {item => item.esUtil()}

    method sumarEquipamiento(unItem) {
        equipamiento.add(unItem)
    }

    method desprenderseDeEquipamiento(unItem) {
        equipamiento.remove(unItem)
    }

    method usarItem(unItem) {
        unItem.usar()
    }

    method reparar(item) {
        item.reparar()
    }
}

class Item {
    var potencia
    var desgaste

    method potencia() = potencia
    method esUtil() = potencia > 10 && !self.estaDesgastado()
    method estaDesgastado() = desgaste

    method reparar() {
        desgaste = false
    }

    method usar() {
        desgaste = true
    }

}

class Maestro inherits Habitante {
    const property midiclorianos
    const sableDeLuz
    const equipamiento = []

	var ladoFuerza

    override method poder() = super() + (1/1000) * self.midiclorianos() + ladoFuerza.potenciaSable(sableDeLuz)

    method pasarSuceso(suceso, maestro) {
        ladoFuerza.formaDeSuceder(suceso, maestro)
    }

    method convertirseLado(unLadoFuerza) {
        ladoFuerza = unLadoFuerza
        self.reparacionPorCambioDeLado()
    }

    method reparacionPorCambioDeLado() {
        equipamiento.map {item => item.reparar()}
    }
}

class Fuerza {
    var tiempoEnFuerza = 0

    method tiempoEnFuerza() = tiempoEnFuerza

    method potenciaSable(sableDeLuz)

    method pasarTiempo() {
        tiempoEnFuerza += 1
    }

    method formaDeSuceder(suceso, maestro)
}

class Jedi inherits Fuerza {
    var pazInterior = 100

    override method potenciaSable(sableDeLuz) =  self.tiempoEnFuerza() + sableDeLuz.energiaSable()

    override method formaDeSuceder(suceso, maestro) {
        self.pasarTiempo()
        self.modificarPazInterior(suceso.cargaEmocional())
        self.evaluarPazInterior(maestro)
    }

    method modificarPazInterior(cargaEmocional) {
        pazInterior += cargaEmocional
    }

    method evaluarPazInterior(maestro) {
        if (pazInterior <= 0) {
            maestro.convertirseLado(ladoOscuro)
        } else {
            return
        }
    }


}

class Sith inherits Fuerza {
    var odio = 100

    override method potenciaSable(sableDeLuz) =  self.tiempoEnFuerza() + sableDeLuz.energiaSable() * 2

    override method formaDeSuceder(suceso, maestro) {
        self.pasarTiempo()
        self.modificarOdio(suceso.cargaEmocional(), maestro)
    }

    method modificarOdio(cargaEmocional, maestro) {
        if (cargaEmocional < odio) {
        odio += odio * 0.1
        } else if (cargaEmocional >= odio) {
            maestro.convertirseLado(ladoDelBien)
        }
    }
}

class Sable inherits Item {
    const energia
    const maestroPoseedor

    method energiaSable() = energia


}

class Suceso {
    const property cargaEmocional
}

const ladoDelBien = new Jedi()
const ladoOscuro = new Sith()