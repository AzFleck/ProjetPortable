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
			System.err.println("erreur dans la récupération des types d'item");
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
		 * Récupérer les éléments présents dans les cases
		 * Ouvrir le fichier puis écrire la requéte à la fin du fichier
		 * Vider les champs
		 */
		ProjetPortable.test();
	}
	
	public static void ecrireFinFichier(String texte, Connection con){
		FileWriter fw = null;
		try {
			fw = new FileWriter("insert.txt", true);
			BufferedWriter output = new BufferedWriter(fw);
			output.write(texte);
			output.write("\r\n");
			output.write("\r\n");
			output.flush();
			output.close();
			Statement stateEcriture = con.createStatement();
			stateEcriture.executeUpdate(texte);
		} catch (Exception ex) {
			ProjetPortable.ecrireLog(ex.getMessage());
		}
	}
	
	public static void ecrireLog(String texte){
		FileWriter fw = null;
		try {
			fw = new FileWriter("logs.txt", true);
			BufferedWriter output = new BufferedWriter(fw);
			output.write(texte);
			output.write("\r\n");
			output.flush();
			output.close();
		} catch (Exception ex) {
			System.err.println(ex.getMessage());
		}
	}
	
	public static boolean insertObjet(String nom, String image, String niveau, String recette, String type, String panoplie, String prerequis){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/projetappli", "root", "root");
			String reqTestExist = "select count(*) from objet where nom = \"" + nom + "\"";
			Statement sttest = con.createStatement();
			ResultSet resulttest = sttest.executeQuery(reqTestExist);
			resulttest.next();
			int test = resulttest.getInt(1);
			if(test == 0){
				String reqMaxObjet = "select max(idobjet) from objet";
				Statement stmaxobj = con.createStatement();
				ResultSet resultmaxobj = stmaxobj.executeQuery(reqMaxObjet);
				int idObjet = 1;;
				if(resultmaxobj.next()){
					idObjet = resultmaxobj.getInt(1) +1;
				}
				if(recette.isEmpty()){
					recette = "Inconnue/Incraftable";
				}
				panoplie = panoplie.trim(); // retrait des espaces
				String reqtype = "Select idType from type where designation = \"" + type + "\"";
				String reqpano = "Select idPanoplie from Panoplie where label = \"" + panoplie + "\"";
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
						String requetePanoplie = "insert into Panoplie(idpanoplie, label) values ("+idPano+", \""+panoplie+"\" );";
						ProjetPortable.ecrireFinFichier(requetePanoplie, con);
					}
					requete = "insert into objet(idObjet, nom, image, niveau, recette, Type_idType, Panoplie_idPanoplie) "
						+ "values ("+idObjet+", \""+nom+"\", \""+image+"\", "+niveau+", \""+recette+"\", "+idType+", "+idPano+" );";
				}
				else{
					requete = "insert into objet(idObjet, nom, image, niveau, recette, Type_idType, Panoplie_idPanoplie) "
						+ "values ("+idObjet+", \""+nom+"\", \""+image+"\", "+niveau+", \""+recette+"\", "+idType+", 0 );";
				}
				ProjetPortable.ecrireFinFichier(requete, con);
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
					String requeteCond = "insert into `Condition`(idcondition, label) values ("+idCond+", \""+prerequis+"\" );";
					ProjetPortable.ecrireFinFichier(requeteCond, con);
					String requeteCondObjet = "insert into Objet_has_Condition(Objet_idObjet, Condition_idCondition) values ("+idObjet+", "+idCond+" );";
					ProjetPortable.ecrireFinFichier(requeteCondObjet, con);
				}
				return true;
			}
			return false;
		} catch (Exception ex) {
			ProjetPortable.ecrireLog("erreur dans la récup des types ou des panos");
			ProjetPortable.ecrireLog(ex.getMessage());
			return false;
		}
	}
	
	public static int insertDommages(String nomObjet, String min, String max, String type){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/projetappli", "root", "root");
			String reqEle = "select idElement from element where label = \"" + type + "\"";
			Statement stateEle = con.createStatement();
			ResultSet resultEle = stateEle.executeQuery(reqEle);
			String reqidobj = "select idObjet from objet where nom = \"" + nomObjet + "\"";
			Statement stateidobj = con.createStatement();
			ResultSet resultidobj = stateidobj.executeQuery(reqidobj);
			int idEle = 1;
			int idDom = 1;
			int idObj = 1;
			if(resultEle.next()){
				idEle = resultEle.getInt(1);
			}
			if(resultidobj.next()){
				idObj = resultidobj.getInt(1);
			}
			String reqdom = "Select max(iddommages) from `dommages`";
			Statement stdom = con.createStatement();
			ResultSet resultdom = stdom.executeQuery(reqdom);
			if(resultdom.next()){
				idDom = resultdom.getInt(1) + 1;
			}
			String reqDom = "insert into Dommages(iddommages, min, max, element_idelement) values ("+idDom+", "+min+", "+max+", " + idEle + ");";
			ProjetPortable.ecrireFinFichier(reqDom, con);
			String reqObjDom = "insert into Objet_has_Dommages(Objet_idObjet, Dommages_idDommages, Dommages_Element_idElement) values ("+idObj+", "+idDom+", "+idEle+");";
			ProjetPortable.ecrireFinFichier(reqObjDom, con);
			return idObj;
		} catch (Exception ex) {
			ProjetPortable.ecrireLog(ex.getMessage());
			return 0;
		}
	}
	
	public static void insertCarac(int idObjet, String min, String max, String carac){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/projetappli", "root", "root");
			String reqCarac = "select idcaracteristique from caracteristique where label = \"" + carac + "\"";
			Statement stateCarac = con.createStatement();
			ResultSet resultCarac = stateCarac.executeQuery(reqCarac);
			int idCarac = 1;
			if(resultCarac.next()){
				idCarac = resultCarac.getInt(1);
			}
			String reqObjBas;
			if(max.equals("")){
				reqObjBas = "insert into objetbasique(Caracteristique_idCaracteristique, Objet_idObjet, Minimum, Maximum) values ("+idCarac+", "+idObjet+", "+min+", "+min+");";
			}
			else{
				reqObjBas = "insert into objetbasique(Caracteristique_idCaracteristique, Objet_idObjet, Minimum, Maximum) values ("+idCarac+", "+idObjet+", "+min+", " + max + ");";
			}
			ProjetPortable.ecrireFinFichier(reqObjBas, con);
		} catch (Exception ex) {
			ProjetPortable.ecrireLog(ex.getMessage());
		}
	}
	
	public static void insertCritere(int idObjet, String pa, String portee, String bonuscc, String chancecc, String nbpartour){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/projetappli", "root", "root");
			String reqcrit = "Select max(iddommages) from `dommages`";
			Statement stcrit = con.createStatement();
			ResultSet resultcrit = stcrit.executeQuery(reqcrit);
			int idCrit = 1;
			if(resultcrit.next()){
				idCrit = resultcrit.getInt(1) + 1;
			}
			String reqCritere = "insert into critere(idCritere, pa, portee, bonuscc, chancecc, nbpartour) values ("+idCrit+", \""+pa+"\", \""+portee+"\", \"" + bonuscc + "\", \"" + chancecc + "\", " + nbpartour + ");";
			ProjetPortable.ecrireFinFichier(reqCritere, con);
			String reqCritObj = "insert into Critere_has_Objet(Critere_idCritere, Objet_idObjet) values ("+idCrit+", "+idObjet+");";
			ProjetPortable.ecrireFinFichier(reqCritObj, con);
		} catch (Exception ex) {
			ProjetPortable.ecrireLog(ex.getMessage());
		}
	}
	
	public static void test() {
		try {
			boolean testDommage = false;
			String contenu = "";
			URL url = new URL("http://www.dofusbook.net/encyclopedie/liste/arc-151-200.html");
			BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(), "UTF8"));
			String inputLine;
			while ((inputLine = in.readLine()) != null)
				contenu+=inputLine;
			in.close();
			int cpt = 0;
			do{
			//début d'item
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
				String minDom = "";
				String maxDom = "";
				String typeDom = "";
				contenu = contenu.substring(contenu.indexOf("Effets")+6);
				
			//début des dommages
				if(typeObjet.equals("Arc")||typeObjet.equals("Baguette")||typeObjet.equals("Bâton")||typeObjet.equals("Dague")||typeObjet.equals("Épée")||
						typeObjet.equals("Hache")||typeObjet.equals("Marteau")||typeObjet.equals("Pelle")||typeObjet.equals("Faux")||typeObjet.equals("Pioche")){
					testDommage = true;
					do{
						contenu = contenu.substring(contenu.indexOf("\">")+2);
						minDom = contenu.substring(0,contenu.indexOf(" "));
						contenu = contenu.substring(contenu.indexOf(" à ")+3);
						maxDom = contenu.substring(0,contenu.indexOf(" "));
						contenu = contenu.substring(contenu.indexOf("dommages ")+9);
						typeDom = contenu.substring(0,contenu.indexOf(")"));
					}while(contenu.indexOf("<span") != -1 && contenu.indexOf("<span") < contenu.indexOf("<hr"));
					contenu = contenu.substring(contenu.indexOf("hr"));//On quitte les dommages
				}
			//fin des dommages
				int indexDiv = contenu.indexOf("</div>");
				int indexSpan = contenu.indexOf("<span");
				String minCarac = "";
				String maxCarac = "";
				String typeCarac = "";
				String PA = "";
				String portee = "";
				String bonusCC = "";
				String chanceCC = "";
				String frappe = "";
				ArrayList<Carac> caracs = new ArrayList<Carac>();
				
			//début des carac
				while( indexSpan != -1 && indexSpan < indexDiv){
					contenu = contenu.substring(contenu.indexOf("<span"));//On passe le span
					contenu = contenu.substring(contenu.indexOf(">")+1);
					minCarac = contenu.substring(0,contenu.indexOf(" "));
					if(contenu.indexOf(" à ") != -1 && contenu.indexOf(" à ") < contenu.indexOf("<br")){ // une seule valeure possible, pas de max
						contenu = contenu.substring(contenu.indexOf(" à ")+3);
						maxCarac = contenu.substring(0,contenu.indexOf(" "));
					}
					contenu = contenu.substring(contenu.indexOf(" ")+1);
					typeCarac = contenu.substring(0,contenu.indexOf("<"));
					indexSpan = contenu.indexOf("<span");
					indexDiv = contenu.indexOf("</div>");
					Carac c = new Carac(minCarac, maxCarac, typeCarac);
					caracs.add(c);
				}
			//fin des caracs
				
			//début des critères
				contenu = contenu.substring(contenu.indexOf("</div>")+6);
				if(typeObjet.equals("Arc")||typeObjet.equals("Baguette")||typeObjet.equals("Bâton")||typeObjet.equals("Dague")||typeObjet.equals("Épée")||
						typeObjet.equals("Hache")||typeObjet.equals("Marteau")||typeObjet.equals("Pelle")||typeObjet.equals("Faux")||typeObjet.equals("Pioche")){
					contenu = contenu.substring(contenu.indexOf("Caracs")+6);
					contenu = contenu.substring(contenu.indexOf("PA : ")+5);
					PA = contenu.substring(0, contenu.indexOf("<"));
					contenu = contenu.substring(contenu.indexOf("Portée : ")+9);
					portee = contenu.substring(0, contenu.indexOf("<"));
					contenu = contenu.substring(contenu.indexOf("CC : ")+5);
					bonusCC = contenu.substring(0, contenu.indexOf("<"));
					contenu = contenu.substring(contenu.indexOf("Critique : ")+11);
					chanceCC = contenu.substring(0, contenu.indexOf("<"));
					contenu = contenu.substring(contenu.indexOf("tour : ")+7);
					frappe = contenu.substring(0, contenu.indexOf("<"));
				}
			//fin des critères
				
			//Partie recette
				contenu = contenu.substring(contenu.indexOf("item-recette")+13);//début de la recette
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
				cpt++;
				
				boolean exist = ProjetPortable.insertObjet(nomObjet, imgObjet, lvlObjet, elementRecette, typeObjet, panoplie, prerequis);//true si existait pas
				if(testDommage && exist){
					int idObj = ProjetPortable.insertDommages(nomObjet, minDom, maxDom, typeDom);
					if(idObj != 0){
						for(int i = 0; i < caracs.size(); i++){
							Carac c = caracs.get(i);
							if(!c.minCarac.equals("Résistance"))
								ProjetPortable.insertCarac(idObj, c.minCarac, c.maxCarac, c.typeCarac);
						}
						ProjetPortable.insertCritere(idObj, PA, portee, bonusCC, chanceCC, frappe);
					}
				}
			}while(contenu.indexOf("<form ") != -1);
			
			System.out.println("Nombre d'items récup : " +cpt);
		} catch (Exception ex) {
			ProjetPortable.ecrireLog(ex.getMessage());
		}
	}
}
 

