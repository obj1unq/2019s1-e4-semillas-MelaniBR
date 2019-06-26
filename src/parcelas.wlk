import semillas.*
class Parcela {
	const ancho
	const largo 
	const plantas = []
	const tipo
	const property solQueRecibe
	method superficie() = ancho * largo
	method maximoDePlantas() = if (ancho > largo )
								self.dividirSuperficie(5) 
									else 
								self.dividirSuperficie(3) + largo 	
	method dividirSuperficie(numero)= self.superficie() / numero 
	method complicaciones() = plantas.any{planta => planta.horasAlSolTolerables() < solQueRecibe}
	method plantar(planta) { self.seSuperoMaximo()
							 self.superoToleranciaAlSol(planta)
							 plantas.add(planta)
		
	}
	method cantDePlantas() = plantas.size()
	method seSuperoMaximo(){ if (self.cantDePlantas() == self.maximoDePlantas())
								self.error("Se supero el maximo de Plantas posibles en parcela")
	}
	method superoToleranciaAlSol(planta) {
										if (planta.horasAlSolTolerables() <= (solQueRecibe - 2))
												self.error("Supero su cant de hora al sol")
	}		
	method sinSuperar()= plantas.all{planta => planta.altura() < 1.5}
	method seAsociaBien(planta)=tipo.requisito(planta,self)
	method cantPlantasAsociadasBien() = plantas.count{planta => self.seAsociaBien(planta)}
	method porcentajeDeAsociadas() = (self.cantPlantasAsociadasBien() * 100) / self.cantDePlantas() 
}



object parcelasEcologicas {
	method requisito(planta, parcela) = not parcela.complicaciones() and planta.esIdeal(parcela)
}
object parcelasIndustriales{
	method requisito(planta,parcela) = self.minimoDePlantas(parcela) and planta.esFuerte()
	method minimoDePlantas(parcela) = parcela.cantDePlantas() <= 2  
}
object inta {
	var property  parcelas = []
	method sumaTotalPlantas() = parcelas.sum{parcela => parcela.cantDePlantas()}
	method cantDeParcelas()= parcelas.size()
	method promedioDePlantasPorParcela() = self.sumaTotalPlantas() / self.cantDeParcelas()
	method  masAutosustentable() = self.parcelasConMasDe4().max{parcela => parcela.porcentajeDeAsociadas()}
	method parcelasConMasDe4()= parcelas.filter{parcela => self.cantDePlantasMayores(parcela)}
	method cantDePlantasMayores(parcela) = parcela.cantDePlantas() > 4  
	method agregar(parcela) {parcelas.add(parcela)}
}

//La asociación de plantas es una práctica ancestral que busca maximizar los beneficios de las plantas al plantarlas 
//en conjunto con otras que de alguna manera potencian sus beneficios. Para modelar esto, debemos previamente
// diferenciar las parcelas en dos tipos: las ecológicas y las industriales.
//
//Para saber si una planta se asocia bien dentro de una parcela, hay que tener en cuenta:
//
//para las parcelas ecológicas: que la parcela no tenga complicaciones y se a ideal para la planta;
//para las parcelas industriales: que haya como máximo 2 plantas y que la planta en cuestión sea fuerte.