/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package projetportable;

import java.awt.GridLayout;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import java.io.*;
import java.net.*;

/**
 *
 * @author Quentin
 */
public class ProjetPortable extends JFrame implements ActionListener {
	private JTextField[] carac;
	private JTextField nom;
	private JTextField image;
	private JTextField description;
	private JComboBox type;
	private JComboBox[] typecarac;
	private ArrayList<String> liste_carac;
	private ArrayList<String> liste_type;
	private JPanel all;
	private JButton valide;
	
	
	

	public ProjetPortable() throws HeadlessException {
		this.setTitle("Insertion d'item");
		this.setSize(400, 600);
		this.setLocationRelativeTo(null);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		all = new JPanel();
		all.setLayout(new GridLayout(25, 2));
		JLabel lbl_nom = new JLabel("nom : ");
		JLabel lbl_image = new JLabel("image : ");
		JLabel lbl_descr = new JLabel("descr : ");
		JLabel lbl_type = new JLabel("type : ");
		//initialisation
		carac = new JTextField[20];
		typecarac = new JComboBox[20];
		for(int i = 0; i<20;i++){
			carac[i] = new JTextField();
			typecarac[i] = new JComboBox();
		}
		valide = new JButton("Valider");
		valide.addActionListener(this);
		nom = new JTextField();
		image = new JTextField();
		description = new JTextField();
		type = new JComboBox();
		liste_carac = new ArrayList<String>();
		this.rempli_liste_carac();
		liste_type = new ArrayList<String>();
		this.rempli_liste_type();
		
		all.add(lbl_nom);
		all.add(nom);
		all.add(lbl_image);
		all.add(image);
		all.add(lbl_descr);
		all.add(description);
		all.add(lbl_type);
		all.add(type);
		this.rempli_combos();
		all.add(valide);
		this.add(all);
		this.setVisible(true);
	}
	public void rempli_liste_carac(){
		String req = "Select * from caracteristique order by idcaracteristique";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/projetappli", "root", "root");
			Statement st = con.createStatement();
			ResultSet result = st.executeQuery(req);
			while (result.next()) {
				liste_carac.add(result.getString(2));
			}
		} catch (Exception ex) {
			System.err.println(ex.getMessage());
		}
	}
	public void rempli_liste_type(){
		String req = "Select * from type order by idtype";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/projetappli", "root", "root");
			Statement st = con.createStatement();
			ResultSet result = st.executeQuery(req);
			while (result.next()) {
				liste_type.add(result.getString(2));
				type.addItem(result.getString(2));
			}
		} catch (Exception ex) {
			System.err.println("erreur dans la rÃ©cupÃ©ration des types d'item");
		}
	}
	public void rempli_combos(){
		for(int i = 0; i<20; i++){
			for(int j = 0; j<liste_carac.size(); j++){
				typecarac[i].addItem(liste_carac.get(j));
			}
			all.add(carac[i]);
			all.add(typecarac[i]);
		}
	}
	
	/**
	 * @param args the command line arguments
	 */
	public static void main(String[] args) {
		//ProjetPortable pp = new ProjetPortable();
            ProjetPortable.test();
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		/*
		 * RÃ©cupÃ©rer les Ã©lÃ©ments prÃ©sents dans les cases
		 * Ouvrir le fichier puis Ã©crire la requÃªte Ã  la fin du fichier
		 * Vider les champs
		 */
		ProjetPortable.test();
	}
	
	public static void ecrireFinFichier(String texte){
		FileWriter fw = null;
		try {
			fw = new FileWriter("insert.txt", true);
			BufferedWriter output = new BufferedWriter(fw);
			output.write(texte);
			output.write("\r\n");
			output.write("\r\n");
			output.flush();
			output.close();
		} catch (IOException ex) {
			System.err.println(ex.getMessage());
		}
	}
	
	public static void insertObjet(String nom, String image, String niveau, String recette, String type, String panoplie, String prerequis){
		int idObjet = 1; //TODO récup l'id maximum
		if(recette.isEmpty()){
			recette = "Inconnue/Incraftable";
		}
		panoplie = panoplie.trim(); // retrait des espaces
		String reqtype = "Select idType from type where designation = \"" + type + "\"";
		String reqpano = "Select idPanoplie from Panoplie where label = \"" + panoplie + "\"";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/projetappli", "root", "root");
			Statement sttype = con.createStatement();
			ResultSet resulttype = sttype.executeQuery(reqtype);
			resulttype.next();
			int idType = resulttype.getInt(1);
			String requete;
			if(!panoplie.equals("Aucune")){
				Statement stpano = con.createStatement();
				ResultSet resultpano = stpano.executeQuery(reqpano);
				int idPano;
				if(resultpano.next()){
					idPano = resultpano.getInt(1);
				}
				else{
					String reqpanoplie = "Select max(idpanoplie) from Panoplie";
					Statement stpanoplie = con.createStatement();
					ResultSet resultpanoplie = stpanoplie.executeQuery(reqpanoplie);
					if(resultpanoplie.next()){
						idPano = resultpanoplie.getInt(1) + 1;
					}
					else{
						idPano = 1;
					}
					String requetePanoplie = "insert into Panoplie(idpanoplie, label) values ("+idPano+", \""+panoplie+"\" )";
					ProjetPortable.ecrireFinFichier(requetePanoplie);
				}
				requete = "insert into objet(idObjet, nom, image, niveau, recette, idType, Panoplie_idPanoplie) "
					+ "values ("+idObjet+", \""+nom+"\", \""+image+"\", "+niveau+", \""+recette+"\", "+idType+", "+idPano+" )";
			}
			else{
				requete = "insert into objet(idObjet, nom, image, niveau, recette, idType) "
					+ "values ("+idObjet+", \""+nom+"\", \""+image+"\", "+niveau+", \""+recette+"\", "+idType+" )";
			}
			ProjetPortable.ecrireFinFichier(requete);
			if(!prerequis.equals("0")){
				int idCond;
				String reqcondition = "Select max(idcondition) from `condition`";
				Statement stcond = con.createStatement();
				ResultSet resultcond = stcond.executeQuery(reqcondition);
				if(resultcond.next()){
					idCond = resultcond.getInt(1) + 1;
				}
				else{
					idCond = 1;
				}
				String requeteCond = "insert into Condition(idcondition, label) values ("+idCond+", \""+prerequis+"\" )";
				ProjetPortable.ecrireFinFichier(requeteCond);
				String requeteCondObjet = "insert into Objet_has_Condition(Objet_idObjet, Condition_idCondition) values ("+idObjet+", "+idCond+" )";
				ProjetPortable.ecrireFinFichier(requeteCondObjet);
			}
		} catch (Exception ex) {
			System.err.println("erreur dans la récup des types ou des panos");
			System.err.println(ex.getMessage());
		}
	}
	
	public static void test() {
		try {
			String contenu = "";
			URL url = new URL("http://www.dofusbook.net/encyclopedie/liste/anneau-151-200.html");
			BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
			String inputLine;
			while ((inputLine = in.readLine()) != null)
				contenu+=inputLine;
			in.close();
			int cpt = 0;
			do{
				//dÃ©but d'item
				contenu = contenu.substring(contenu.indexOf("<form class=\"item\" id="));
				contenu = contenu.substring(contenu.indexOf("<h2>")+4);//juste avant le nom de l'objet
				int fin = contenu.indexOf("&nbsp");
				String nomObjet = contenu.substring(0,fin);
				contenu = contenu.substring(contenu.indexOf("<span>")+6);//juste avant le type
				String typeObjet = contenu.substring(0,contenu.indexOf(" "));
				contenu = contenu.substring(contenu.indexOf("Niveau ")+7);//juste avant le niveau
				String lvlObjet = contenu.substring(0,contenu.indexOf("<"));
				contenu = contenu.substring(contenu.indexOf("relative'><img src=")+20);//juste avant l'image
				String imgObjet = contenu.substring(0,contenu.indexOf("\""));
				String minDom;
				String maxDom;
				String typeDom;
				contenu = contenu.substring(contenu.indexOf("Effets")+6);//dÃ©but des dommages et caracs.
				if(typeObjet.equals("Arc")||typeObjet.equals("Baguette")||typeObjet.equals("BÃ¢ton")||typeObjet.equals("Dague")||typeObjet.equals("Ã‰pÃ©e")||
						typeObjet.equals("Hache")||typeObjet.equals("Marteau")||typeObjet.equals("Pelle")||typeObjet.equals("Faux")||typeObjet.equals("Pioche")){
					do{
						contenu = contenu.substring(contenu.indexOf("\">")+2);
						minDom = contenu.substring(0,contenu.indexOf(" "));
						contenu = contenu.substring(contenu.indexOf(" Ã  ")+3);
						maxDom = contenu.substring(0,contenu.indexOf(" "));
						contenu = contenu.substring(contenu.indexOf("dommages ")+9);
						typeDom = contenu.substring(0,contenu.indexOf(")"));
						System.out.println("min Dom : "+minDom);
						System.out.println("max Dom : "+maxDom);
						System.out.println("type Dom : "+typeDom);
					}while(contenu.indexOf("<span") != -1 && contenu.indexOf("<span") < contenu.indexOf("<hr"));
					contenu = contenu.substring(contenu.indexOf("hr"));//On quitte les dommages
				}
				int indexDiv = contenu.indexOf("</div>");
				int indexSpan = contenu.indexOf("<span");
				String minCarac;
				String maxCarac = "";
				String typeCarac;
				String PA;
				String portee;
				String bonusCC;
				String chanceCC;
				String frappe;
				while( indexSpan != -1 && indexSpan < indexDiv){
					boolean max = false;
					contenu = contenu.substring(contenu.indexOf("<span"));//On passe le span
					contenu = contenu.substring(contenu.indexOf(">")+1);
					minCarac = contenu.substring(0,contenu.indexOf(" "));
					if(contenu.indexOf(" à ") != -1 && contenu.indexOf(" à ") < contenu.indexOf("<br")){ // une seule valeure possible, pas de max
						max = true;
						contenu = contenu.substring(contenu.indexOf(" à ")+3);
						maxCarac = contenu.substring(0,contenu.indexOf(" "));
					}
					contenu = contenu.substring(contenu.indexOf(" ")+1);
					typeCarac = contenu.substring(0,contenu.indexOf("<"));
					indexSpan = contenu.indexOf("<span");
					indexDiv = contenu.indexOf("</div>");
					if(max)
						System.out.println("Carac : " + minCarac + " à " + maxCarac + " en " + typeCarac);
					else
						System.out.println("Carac : " + minCarac + " en " + typeCarac);
				}
				contenu = contenu.substring(contenu.indexOf("</div>")+6);
				if(typeObjet.equals("Arc")||typeObjet.equals("Baguette")||typeObjet.equals("Bâton")||typeObjet.equals("Dague")||typeObjet.equals("Ã‰pÃ©e")||
						typeObjet.equals("Hache")||typeObjet.equals("Marteau")||typeObjet.equals("Pelle")||typeObjet.equals("Faux")||typeObjet.equals("Pioche")){
					contenu = contenu.substring(contenu.indexOf("Caracs")+6);
					contenu = contenu.substring(contenu.indexOf("PA : ")+5);
					PA = contenu.substring(0, contenu.indexOf("<"));
					contenu = contenu.substring(contenu.indexOf("PortÃ©e : ")+9);
					portee = contenu.substring(0, contenu.indexOf("<"));
					contenu = contenu.substring(contenu.indexOf("CC : ")+5);
					bonusCC = contenu.substring(0, contenu.indexOf("<"));
					contenu = contenu.substring(contenu.indexOf("Critique : ")+11);
					chanceCC = contenu.substring(0, contenu.indexOf("<"));
					contenu = contenu.substring(contenu.indexOf("tour : ")+7);
					frappe = contenu.substring(0, contenu.indexOf("<"));
					System.out.println("PA : " + PA);
					System.out.println("Portée : " + portee);
					System.out.println("CC : " + bonusCC);
					System.out.println("Critique : " + chanceCC);
					System.out.println("Frapp / tour : " + frappe);
				}
				
			//Partie recette
				contenu = contenu.substring(contenu.indexOf("item-recette")+13);//dÃ©but de la recette
				String elementRecette = "";
				while(contenu.indexOf("<br") != -1 && contenu.indexOf("hide-min") > contenu.indexOf("<br")){ // Ca veut dire que la recette est renseignÃ©e et qu'il reste encore un Ã©lÃ©ment au moins
					contenu = contenu.substring(contenu.indexOf("<br")+3);
					contenu = contenu.substring(contenu.indexOf(">")+1);
					elementRecette += contenu.substring(0, contenu.indexOf("<"))+" / ";
				}
				if(!elementRecette.equals("")){
					elementRecette = elementRecette.substring(0, elementRecette.length()-3);
				}
			//Partie recette END
			//Partie Panoplie
				contenu = contenu.substring(contenu.indexOf("hide-min")+8);
				contenu = contenu.substring(contenu.indexOf("Panoplie")+8);
				contenu = contenu.substring(contenu.indexOf(">")+1);
				if(contenu.indexOf("<a") != -1 && contenu.indexOf("<a") < contenu.indexOf("<em"))
					contenu = contenu.substring(contenu.indexOf(">")+1);
				String panoplie = contenu.substring(0, contenu.indexOf("<"));
			//Partie Panoplie END
			//Partie prerequis
				String prerequis = "0";
				contenu = contenu.substring(contenu.indexOf("</div>")+6);
				if(contenu.indexOf("item-info") != -1 && contenu.indexOf("item-actions") > contenu.indexOf("item-info")){//Il y a des prÃ©requis ou des infos
					if(contenu.indexOf("Pré-requis") != -1 && contenu.indexOf("Pré-requis") < contenu.indexOf("</div>")){ //il y a des prÃ©-requis
						contenu = contenu.substring(contenu.indexOf("Pré-requis")+10);
						contenu = contenu.substring(contenu.indexOf(">")+1);
						prerequis = contenu.substring(0, contenu.indexOf("<"));
					}
				}
			//Partie prerequis END
				contenu = contenu.substring(contenu.indexOf("</form>")+7);
				System.out.println("");
				System.out.println("");
				cpt++;
				
				ProjetPortable.insertObjet(nomObjet, imgObjet, lvlObjet, elementRecette, typeObjet, panoplie, prerequis);
			}while(contenu.indexOf("<form ") != -1);
			
			System.out.println("Nombre d'items récup : " +cpt);
		} catch (MalformedURLException e) {
			System.err.println(e);
		} catch (IOException e) {
			System.err.println(e);
		}
	}
}
 

