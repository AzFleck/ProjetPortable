/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package projetportable;

/**
 *
 * @author Quentin
 */
public class MonException extends Exception{
	private String message;

	@Override
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public MonException(String message) {
		this.message = message;
	}
}
