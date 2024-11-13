class UnaClase {
    //BLOQUES
    const elementos = []
    var property modificable


    method condicion () = elementos.all {elemento => elemento.condicion()}  //todos los elementos cumplen una condición

    method elementoConMayorAlgo() =      //bloque bool de 2 que toma los primeros 3 elementos ordenados por un criterio
            elementos.sortBy({ elemento, otroElemento => 
			elemento.tamanio() > otroElemento.tamanio() }).take(3)

    method tareaPendienteRealizable () = elementos.find {elemento => elemento.puedeRealizar()}  //elemento que puede realizar

    method conteoDeAlgo() = elementos.count {elemento => elemento.condicion()}  //cantidad de elementos que cumplen una condición


    method validacion(){
        if (self.condicion()) {
            throw new Exception(message = "Misión no puede comenzar")
        }
    }

    method modificarValor(valor) {
        modificable += valor    //suma
        modificable -= valor    //resta
    }

    method sumarOrestar() = if(self.puedeSuperar()) 1 else -1
    method puedeSuperar() 


    method unValorRandom() { 1.randomUpTo(3) < 1 }  //devuelve un valor random entre 1 y 3, 33% de probabilidad de que sea 1

}

//valores pretendidos en var
