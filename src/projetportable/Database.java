 /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package projetportable;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Fabien
 */
public class Database {

	private static Connection connection;

	public static Connection getConnection() throws MonException {
		try {
			if (connection instanceof Connection) {
				return connection;
			} else {
				Class.forName("org.sqlite.JDBC");
				connection = DriverManager.getConnection("jdbc:sqlite:BddSonVideo.db");
				return connection;
			}
		} catch (SQLException e) {
			throw new MonException(e.getMessage());
		} catch (ClassNotFoundException ex) {
			throw new MonException(ex.getMessage());
		}
	}

	public static ResultSet read(String request) throws MonException {
		try {
			Statement requete = Database.getConnection().createStatement();
			ResultSet result = requete.executeQuery(request);
			return result;
		} catch (Exception e) {
			throw new MonException(e.getMessage());
		}
	}
}
