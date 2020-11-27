package conexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PruebaConexion {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		try {
			Connection conexion = MiConexion.getConexion();
			
			Statement statement = null;
			ResultSet rs = null;
			String query = null;
			
			try {
				
				if(conexion != null)
				{
					query = "SELECT E.* FROM Envios AS E\r\n"
							+ "LEFT JOIN Asignaciones AS A ON E.ID = A.IDEnvio WHERE A.IDAlmacen IS NULL\r\n"
							+ "";
					
					rs = statement.executeQuery(query);
					
					System.out.println("Posicion | IDEquipo | NombreEquipo | PartidosJugados | PartidosGanados | PartidosEmpatados | PartidosPerdidos"
							+ " | GolesFavor | GolesContra | DiferenciaGoles | Puntos\n");
					
					while(rs.next())
					{
						System.out.println(rs.getInt(1)+" | "+rs.getString(2)+" | "+rs.getString(3)+" | "+rs.getInt(4)+" | "+rs.getString(5)+" | "+
						+rs.getInt(6)+" | "+rs.getInt(7)+" | "+rs.getInt(8)+" | "+rs.getString(9)+" | "+rs.getInt(10)+" | "+rs.getString(11)); 
					}
						
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
