import invitados.*

class Fiesta {
  const lugarOcurrencia
  const invitados = #{}

  var fecha
  
  //saber si la fiesta es un bodrio
  method esUnBodrio() = invitados.all {invitado => !invitado.estaConforme()}

  //cual es el mejor disfraz
  method mejorDisfraz() = invitados.max {invitado => invitado.disfraz().puntuacion()}

  //intercambiar disfraces
  method intercambiarDisfraces(unInvitado, otroInvitado)  {
    invitados.contains(unInvitado) and invitados.contains(otroInvitado)
    and self.algunoEstaDisconforme(unInvitado, otroInvitado) 
    and self.elCambioLosDejaComformes(unInvitado, otroInvitado)
  }

  method algunoEstaDisconforme(unInvitado, otroInvitado) = !unInvitado.estaConforme() or !otroInvitado.estaConforme()

  method elCambioLosDejaComformes(unInvitado, otroInvitado) = 
    unInvitado.cambiarDisfraz(otroInvitado.disfraz()).estaConforme()
    and otroInvitado.cambiarDisfraz(unInvitado.disfraz()).estaConforme()
  

  //Agregar un invitado
  method agregarInvitado(invitado) = if (self.cumpleCondicionesAsistencia(invitado)) invitados.add(invitado)
  
  method cumpleCondicionesAsistencia(invitado) = invitado.tieneDisfraz() 
}

class FiestaInolvidable inherits Fiesta {
  override method cumpleCondicionesAsistencia(invitado) = invitado.esSexy() and invitado.estaConforme()
}