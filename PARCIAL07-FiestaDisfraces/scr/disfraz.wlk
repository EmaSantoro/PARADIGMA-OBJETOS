
//DISFRACES
class UnDisfraz{
  const caracteristicas = #{}
  const property nombre
  const property diasConfeccion
  var duenio


  method duenio() = duenio

  method compradoATiempo() = diasConfeccion <= 2 

  //puntaje disfraz
  method puntuacion() = caracteristicas.sum {caracteristica => caracteristica.puntos(self, duenio)}
}

//CARACTERISTICAS DISFRAZ
class gracioso {
  var gracia
  method puntos(disfraz) = gracia * self.multiplicadorPorEdad(disfraz)

  method multiplicadorPorEdad(disfraz) = if(disfraz.duenio().edad() > 50) 3 else 1
}

object tobaras {
  method puntos(disfraz) = if (disfraz.compradoATiempo()) 5 else 3
}

class Caretas {
  const caretaPersonaje
  method puntos(disfraz) = caretaPersonaje.valorPuntaje()
}

object sexy {
  method puntos(disfraz) = if(disfraz.duenio().esSexy()) 15 else 2
}

class caretaPersonaje {
  const property valorPuntaje
}