package domain

import java.time.LocalDate
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.FetchType
import javax.persistence.OneToOne

@Entity
@Accessors
@Observable
class Entrada {

	@Id @GeneratedValue
	Long id
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="pelicula", referencedColumnName="id")
	Pelicula pelicula
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="funcion", referencedColumnName="id")
	Funcion funcion

	def precioEntrada() {
		pelicula.precioBase + funcion.valorPorDiaFuncion
	}

	def LocalDate fechaFuncion() {
		return funcion.getFecha
	}

}
