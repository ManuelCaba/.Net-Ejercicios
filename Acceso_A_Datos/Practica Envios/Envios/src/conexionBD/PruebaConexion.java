package conexionBD;

import java.sql.SQLException;

public class PruebaConexion {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		try {
			System.out.println(MiConexion.getConexion().isClosed());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
