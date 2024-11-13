import personalidadOpinion.*


class Invitado {
    var disfraz
    var edad
    var personalidad
    const opinionSobreDisfraz

    method disfraz() = disfraz
    method edad() = edad

    method esSexy() = personalidad.condicionSexy(self)

    method estaConforme() = disfraz.puntuacion() > 10 and opinionSobreDisfraz.condicion(disfraz)

    method cambiarDisfraz(nuevoDisfraz) {disfraz = nuevoDisfraz}

    method tieneDisfraz() = disfraz != null
}
