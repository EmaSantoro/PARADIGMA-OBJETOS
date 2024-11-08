//Personajes
class Personaje {
  var copas = 0

  method ganarCopas(cantidad) {
    copas += cantidad
  }

  method cantidadDeCopas() = copas

  method destreza()
  method poseeEstrategia()
  //method participarDeUnaMision(mision)
}

class Arqueros inherits Personaje {
  const agilidad
  const rango

  override method destreza() = agilidad * rango

  override method poseeEstrategia() = rango >= 100
}

class Guerreras inherits Personaje {
  const tieneEstrategia
  const fuerza

  override method poseeEstrategia() = tieneEstrategia

  override method destreza() = 1.5 * fuerza
}

class Ballesteros inherits Arqueros {
  override method destreza() = super() * 2
}

//Misiones
class Mision {
  var formaDePremiar = normal

  method realizar(){
    self.validarRealizacion()
    self.repartirCopas()
  }

  method validarRealizacion() {
    if(!self.puedeRealizar()) {
      throw new Exception(message = "Misión no puede comenzar")
    }
  }

  method puedeSuperar()
  method puedeRealizar()
  method repartirCopas()

  method cantCopas() = formaDePremiar.cantCopasFinal(self)
  method sumarOrestar() = if(self.puedeSuperar()) 1 else -1

  method formaDePremiar(unaForma) { formaDePremiar = unaForma }
}

class MisionIndividual inherits Mision {
  var personaje
  var dificultad

  method copasEnJuego() = dificultad * 2

  override method puedeSuperar() = (personaje.poseeEstrategia()) or self.poseeSuficienteDestreza()

  method poseeSuficienteDestreza() = personaje.destreza() > dificultad

  method personaje(unPersonaje) { personaje = unPersonaje }

  override method puedeRealizar() = (personaje.cantidadDeCopas() >= 10) 

  override method repartirCopas() = personaje.ganarCopas(self.cantCopas() * self.sumarOrestar())
}

class MisionGrupal inherits Mision {
  var personajes = []

  method copasEnJuego() = 50 / self.cantidadDeParticipantes()

  override method puedeSuperar() = self.poseenMitadEstrategica() or self.poseenDestreza(400)

  method poseenMitadEstrategica() = (personajes.size() / 2) > personajes.count({personaje => personaje.poseeEstrategia()})

  method poseenDestreza(nivel) = (personajes.all({personaje => personaje.destreza() > nivel}))

  override method puedeRealizar() = (personajes.cantidadDeCopas() >= 60) 

  method cantidadDeCopas() = personajes.sum({personaje => personaje.cantidadDeCopas()})

  override method repartirCopas() = personajes.forEach({personaje => personaje.ganarCopas(self.cantCopas() * self.sumarOrestar())})

  method cantidadDeParticipantes() = personajes.size()
}

//misiones Boost y las misiones Bonus
object bonus {
	method cantCopasFinal(mision) = mision.copasEnJuego() + mision.cantidadDeParticipantes()
}

class Boost {
	var property multiplicador 
	method cantCopasFinal(mision) = mision.copasEnJuego() * multiplicador
}

object normal {
	method cantCopasFinal(mision) = mision.copasEnJuego()
}