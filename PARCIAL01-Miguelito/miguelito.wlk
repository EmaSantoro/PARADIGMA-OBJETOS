class Plato {
  method peso()
  method aptoCeliaco()
  method valoracion()

  method esEspecial() = self.peso() > 250

	method precio() = self.valoracion() * 300 + self.montoExtraPorCeliaquia()

	method montoExtraPorCeliaquia() = if(self.aptoCeliaco()) 1200 else 0
}

class Provoleta inherits Plato {
  const tieneEmpanado

  override method esEspecial() = super() && tieneEmpanado
  override method aptoCeliaco() = !tieneEmpanado
  override method valoracion() = if (self.esEspecial()) 120 else 80
}

class HamburguesasDeCarne inherits Plato {
  const pesoMedallon
	const pan

	override method peso() = self.pesoCarne() + pan.peso()
  method pesoCarne() = pesoMedallon

  override method aptoCeliaco() = pan.aptoCeliacos()
  override method valoracion() = self.peso() / 10
}

class Pan{
	var property peso
	var property aptoCeliacos = false
}

const panIndustrial = new Pan(peso = 60)
const panCasero = new Pan(peso = 100)
const panMaiz = new Pan(peso = 30, aptoCeliacos = true)

class HamburguesaDoble inherits HamburguesasDeCarne{
  override method pesoCarne() = pesoMedallon * 2
  override method esEspecial() = self.peso() > 500
}

class CorteCarne inherits Plato{
  var peso
	var estaAPunto
	
	override method peso() = peso
	override method esEspecial() = super() && estaAPunto
	override method aptoCeliaco() = true
	override method valoracion() = 100
}

class Parrillada inherits Plato{
  var componentes = []

  override method peso() = componentes.sum({componente => componente.peso()})
  override method esEspecial() = super() && componentes.size() >= 3
  override method aptoCeliaco() = componentes.all({componente => componente.aptoCeliaco()})
  override method valoracion() = componentes.max({componente => componente.valoracion()}).valoracion()
}

//PARRILLA

object parrillaMiguelito {
  const platos = []
  var ingresos = 0
  const comensales = []

  method platosAccesiblesCon(dinero) = platos.filter {plato => plato.precio() <= dinero}

  method vender(plato, comensal) {
    ingresos += plato.precio()
    comensales.add(comensal)
  }

  method hacerPromocion(dineroADar){
		comensales.forEach({comensal => comensal.recibirDinero(dineroADar)})
	}

method agregarPlatoAlMenu(plato){
		platos.add(plato)
	}

}

//COMENSAL Y PREFERENCIAS DEL MISMO

class Comensal {
  var dinero
  var preferencia

  method dinero() = dinero


  method darseUnGusto() {
    if(self.platosQuePuedeComprar().isEmpty()){
			throw new DomainException(message="No hay platos que puedan ser comprados") //Si no hay ningún plato que pueda comprar, advertir adecuadamente y con precisión
		}
    self.comprarPlato(self.platoMasValorado())
  }

  method platosQuePuedeComprar() = parrillaMiguelito.platosAccesiblesCon(dinero).filter({plato => preferencia.leGusta(plato)}) //EN LA PARRILLA FILTRO LOS PLATOS ACCESIBLES CON DINERO Y ACA LOS DE SU PREFERENCIA

  method platoMasValorado() = self.platosQuePuedeComprar().max({plato => plato.valoracion()})

  method comprarPlato(plato) {
    dinero -= plato.precio()
    parrillaMiguelito.vender(plato, self)
  }

  method recibirDinero(cantidad) {
    dinero += cantidad
  }

  method cambiarHabitos(nuevaPreferencia) {
    preferencia = nuevaPreferencia
  }

  method problemasCeliacos() {
    self.cambiarHabitos(celiacos)
  }

  method puedeComerTodo() = preferencia.puedeComerTodo()

  method degustaPlatoParaInstagram() = preferencia.paladarFino()  //Inventar algo que provoque que alguien se haga paladar fino.
}

object celiacos {
  method leGusta(plato) = plato.aptoCeliaco()
  method puedeComerTodo() = false
}

object paladarFino {
  method leGusta(plato) = plato.valoracion() > 100 || plato.esEspecial()
  method puedeComerTodo() = true
}

object todoTerreno {
  method leGusta(plato) = true
  method puedeComerTodo() = true
}

object gobierno {
  const ciudadanos = []

	method tomarDecisionEconomica() {
		self.ciudadanosAptosAlCambio().cambiarHabito(todoTerreno)
	}

	method ciudadanosAptosAlCambio() = ciudadanos.filter({ciudadano => ciudadano.puedeComerTodo()})
}
