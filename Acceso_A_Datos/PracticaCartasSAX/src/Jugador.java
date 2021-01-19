package src;

public class Jugador {
	
	//Atributos de la clase
	String nombre;
	double cantidadJugada;
	
	//Constructores
	public Jugador()
	{
		nombre = "";
		cantidadJugada = 0;
	}
	
	public Jugador(String nombre)
	{
		this.nombre = nombre;
		cantidadJugada = 0;
	}
	
	public Jugador(String nombre, double cantidadJugada)
	{
		this.nombre = nombre;
		this.cantidadJugada = cantidadJugada;
	}
	
	public Jugador(Jugador jugador)
	{
		this.nombre = jugador.nombre;
		this.cantidadJugada = jugador.cantidadJugada;
	}

	//Propiedades
	
	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public double getCantidadJugada() {
		return cantidadJugada;
	}

	public void setCantidadJugada(double cantidadJugada) {
		this.cantidadJugada = cantidadJugada;
	}
	
	

}
