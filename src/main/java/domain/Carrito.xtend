package domain

import java.math.BigDecimal
import java.time.LocalDateTime
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Carrito {
	List<Entrada> entradas

	new() {
		entradas = new ArrayList<Entrada>
	}

	def setearUsuariosEntradas(Usuario usuario) {
		entradas.forEach(entrada|entrada.setUsuario(usuario))
		entradas.forEach(entrada|print(entrada.usuario.username + "\n"))
	}

	def agregarAlCarrito(Entrada entrada) {
		entradas.add(entrada)
	}

	def eliminarDelCarrito(Entrada entrada) {
		entradas.remove(entrada)
	}

	def vaciarCarrito() {
		entradas.clear
	}

	def getTotal() {
		if (carritoEstaVacio)
			return new BigDecimal("0")
		else
			new BigDecimal(entradas.fold(0d, [acum, entrada|acum + entrada.getPrecioEntrada()]))
	}

	def Integer cantidadEntradas() {
		return entradas.size
	}

	def getCarritoEstaVacio() {
		entradas.isNullOrEmpty()
	}

	def setPreciosEntradas() {
		entradas.forEach(entrada|entrada.setPrecioEntrada())
	}

	def setHoraStringFuncion() {
		entradas.forEach(entrada|entrada.setHoraString())
	}

	def setFechaHora() {
		entradas.forEach(entrada|entrada.funcion.fechaHora = LocalDateTime.now())
		entradas.forEach(entrada|print(entrada.funcion.fechaHora.toString()))
	}

}
