import disfraz.*
import invitados.*

//PERSONALIDADES
object alegre {
    method condicionSexy(invitado) = false
}

object taciturnas {
    method condicionSexy(invitado) = invitado.edad() < 30
}

object cambiante {
    method condicionSexy(invitado) = (self.personalidadAleatoria()).condicionSexy(invitado)

    method personalidadAleatoria() = [alegre, taciturnas].anyOne()
}

//OPINIONES
object caprichoso {
    method condicion(disfraz) = disfraz.nombre() % 2 == 0
}

object pretencioso {
    method condicion(disfraz) = disfraz.diasConfeccion() < 30
}

class Numerologos {
    var valorPretendico
    method condicion(disfraz) = disfraz.puntuacion() > 10 and disfraz.puntuacion() == valorPretendico
}