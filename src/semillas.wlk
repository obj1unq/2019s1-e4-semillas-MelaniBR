
class Plantas{
	const anioDeObtencion 
	const property altura 
	method horasAlSolTolerables()
	method esFuerte()= self.horasAlSolTolerables()> 10
	method daSemillas() = self.esFuerte()	
	 
}
//Comenzaremos modelando a cada una de las plantas que hay en la huerta, de las cuales podemos configurar los siguientes aspectos:
//
//el año de obtención de la semilla. Es decir, en qué año la semilla que le dio origen se sacó de su planta "madre";
//la altura que tiene, medida en metros.
//Además, queremos poder preguntarle:
//
//cuántas horas de sol tolera;
//si es fuerte o no;
//si da nuevas semillas o no;
//cuánto espacio ocupa una vez plantada, medido en metros cuadrados.
//De todos ellos, el año de obtención y la altura se configuran para cada planta; el resto se calcula en función de la especia y 
//de características generales.
//
//Se dice que una planta es fuerte si tolera más de 10 horas de sol al día, esto es igual para todas las plantas. E
//l cálculo de las horas de sol que tolera depende exclusivamente de cada especie (ver más abajo).
//
//Otro aspecto que nos interesa es saber si da nuevas semillas, para lo cual se tiene que cumplir que la planta sea fuerte o 
//bien una condición alternativa, que define cada especie. En cuanto al espacio que ocupa, depende pura y 
//exclusivamente de características de la especie.
//
//Contemplaremos las especies que se detallan a continuación.
class Quinoa inherits Plantas {
	const property horasAlSolTolerables
	
	method espacioQueOcupa() = 0.5
	method anteriorA2005() = anioDeObtencion < 2005
	override method daSemillas()= super() or self.anteriorA2005()
	method esIdeal(parcela) = parcela.sinSuperar()
}

class Soja inherits Plantas{
	override method horasAlSolTolerables()= if (altura < 0.5)
													6
									else if (altura >= 0.5 and altura <= 1)
												 	7 
													else {9} 
	
	
	method esPosteriorA2007() = anioDeObtencion > 2007												 				
	method puedeDarSemillas()= self.esPosteriorA2007() and altura > 1 
	method espacioQueOcupa() = altura / 2
	override method daSemillas()= super() or self.puedeDarSemillas()											
	method esIdeal(parcela) = self.horasAlSolTolerables() == parcela.solQueRecibe()
}

class Menta inherits Plantas {
	override method  horasAlSolTolerables() = 6
	method espacioQueOcupa() = altura* 3
	method esMayor()= altura > 0.4
	override method daSemillas()= super() or self.esMayor()
	method esIdeal(parcela)= parcela.superficie()> 6 
}

class SojaTransgenica inherits Soja{
	override method daSemillas() = false
	override method esIdeal(parcela) = parcela.maximoDePlantas() == 1
}
class Hierbabuena inherits Menta{
	override method espacioQueOcupa() = super() * 2
}










