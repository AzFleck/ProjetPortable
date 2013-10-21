/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package projetportable;

/**
 *
 * @author Quentin
 */
public class Dommage {
	public String nomObjet;
	public String minDom;
	public String maxDom;
	public String eleDom;
	public String typeDom;

	public Dommage(String nomObjet, String minDom, String maxDom, String eleDom, String typeDom) {
		this.nomObjet = nomObjet;
		this.minDom = minDom;
		this.maxDom = maxDom;
		this.eleDom = eleDom;
		this.typeDom = typeDom;
	}
}
