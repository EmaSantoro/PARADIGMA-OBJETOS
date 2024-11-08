class Filosofo {

  var iluminacion
  var diasDeVida

  const actividades = []
  const argumentos = []
  const honorificos = #{}
  const nombre 


  method presentarse() {  // Un filósofo se presenta indicando su nombre, precedido de todos sus honoríficos, separados por coma
    return nombre + (honorificos.tipoHonorifico()).join(", ")
  }

  method estaEnLoCorrecto() = self.iluminacion() > 1000

  method modificarNivelIluminacion(nivel, sumarOrestar){
    iluminacion += nivel * sumarOrestar
  }

  method obtenerHonorifico(honorifico) {
    honorificos.add(honorifico)
  }

  method realizarActividad(actividad) {
    actividad.realizar()
  }

  method iluminacion() = iluminacion

  method envejecer(dias)  {
    diasDeVida += dias
  }

  method rejuvenecer(dias) {
    diasDeVida -= dias
  }

  method edad() = diasDeVida / 365

  method vivirUnDia() {
    self.envejecer(1)
    actividades.forEach{tarea => tarea.realizar(self)}
  }

  method agregarArgumento(argumento) {
    argumentos.add(argumento)
  }

  method tieneBuenosArgumentos() {
    return argumentos.count {argumento => argumento.esEnriquecedor()} >= argumentos.size() / 2
  }
}

//ACTIVIDADES

object tomarVino {
  method realizar(filosofo) {
    filosofo.modificarNivelIluminacion(10, -1)
    filosofo.obtenerHonorifico(elBorracho)
  }
}

class JuntarseEnAgora {
  var compania 

  method compania() = compania
  method realizar(filosofo) {
    filosofo.modificarNivelIluminacion(self.inspirarseConOtro(), 1)
  }

  method inspirarseConOtro() = compania.iluminacion() / 10
}

object admirarPaisaje {
  method realizar(filosofo){}
}

class MeditarBajoCascada {
  const metrosCascada  

  method realizar(filosofo) {
    filosofo.modificarNivelIluminacion(self.valorSegunCascada(), 1)
  }

  method valorSegunCascada() = metrosCascada * 10
}

class PracticarDeporte {
  const tipoDeporte
  
  method realizar(filosofo){
    tipoDeporte.jugar(filosofo)
  }
}

class Deporte {
  const parametroRejuvenecedor
  
  method jugar(filosofo) {
    filosofo.rejuvenecer(parametroRejuvenecedor)
  }
}

const futbol = new Deporte(parametroRejuvenecedor = 1)
const polo = new Deporte(parametroRejuvenecedor = 2)
const waterPolo = new Deporte(parametroRejuvenecedor = 4)

//HONORIFICOS
object elBorracho {
  method tipoHonorifico() = "el Borracho"
}

//DISCUSION
class Discusion {
  const partido1
  const partido2
  method esBuena() = partido1.esBuenDiscutidor() && partido2.esBuenDiscutidor()

}

class Partido {
  const filosofo
  
  method esBuenDiscutidor() = filosofo.tieneBuenosArgumentos() && filosofo.estaEnLoCorrecto()
}

class Argumento {
  const descripcion
  const tipoNaturaleza

  method esEnriquecedor() = tipoNaturaleza.esEnriquecedor()
}

object estoico {
  method esEnriquecedor() = true
}

object moralista {
  method esEnriquecedor() = Argumento.descripcion.split(" ").size() >= 10
}

object esceptica {
  method esEnriquecedor() = Argumento.descripcion.last() == "?"
}

object cinica {
  method esEnriquecedor() {
    1.randomUpTo(3) < 1
  } 
}

object combinada {
  var argumentos = []

  method argumentos() = argumentos
  method esEnriquecedor() = argumentos.all {naturaleza => naturaleza.esEnriquecedor()}
}


//filosofos contemporaneos
class Contemporaneo inherits Filosofo {

  override method presentarse() {
    return "hola"
  }

  override method iluminacion() {
    /*if (actividades.contains(admirarPaisaje)) {
      return super() * 5
    } else {
      return super()
    }*/
  }
}