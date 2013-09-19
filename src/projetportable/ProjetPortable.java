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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/projetappli", "root", "");
			Statement st = con.createStatement();
			ResultSet result = st.executeQuery(req);
			while (result.next()) {
				liste_carac.add(result.getString(2));
			}
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	public void rempli_liste_type(){
		String req = "Select * from type order by idtype";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/projetappli", "root", "");
			Statement st = con.createStatement();
			ResultSet result = st.executeQuery(req);
			while (result.next()) {
				liste_type.add(result.getString(2));
				type.addItem(result.getString(2));
			}
		} catch (Exception ex) {
			System.out.println("erreur dans la récupération des types d'item");
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
		 * Ouvrir le fichier puis écrire la requête à la fin du fichier
		 * Vider les champs
		 */
		ProjetPortable.test();
	}
	
	public static void test() {
		try {
			int nbreDeFois = 0;
			String contenu = "";
			URL url = new URL("http://www.dofusbook.net/encyclopedie/liste/pioche.html");
			URLConnection con = url.openConnection();
			InputStream input = con.getInputStream();
			while (input.available() > 0) {
				contenu += (char) input.read();
			}
			//début d'item
			contenu = contenu.substring(contenu.indexOf("<form class=\"item\" id="));
                        contenu = contenu.substring(contenu.indexOf("<h2>")+4);//juste avant le nom de l'objet
                        int fin = contenu.indexOf("&nbsp");
                        String nomObjet = contenu.substring(0,fin);
                        System.out.println("Nom objet : "+nomObjet);
			contenu = contenu.substring(contenu.indexOf("<span>")+6);//juste avant le type
                        String typeObjet = contenu.substring(0,contenu.indexOf(" "));
                        System.out.println("Type objet : "+typeObjet);
			contenu = contenu.substring(contenu.indexOf("Niveau ")+7);//juste avant le niveau
                        String lvlObjet = contenu.substring(0,contenu.indexOf(" "));
                        System.out.println("Niveau objet : "+lvlObjet);
			contenu = contenu.substring(contenu.indexOf("relative'><img src=")+20);//juste avant l'image
                        String imgObjet = contenu.substring(0,contenu.indexOf("\""));
                        System.out.println("Image objet : "+imgObjet);
                        contenu = contenu.substring(contenu.indexOf("Effets")+6);//début des dommages et caracs.
                        System.out.println(contenu);
                        
			/*
			String pattern = ".*<body>.*";
			Pattern pat = Pattern.compile(pattern);
			Matcher matcher = pat.matcher(contenu);
			while (matcher.find()) {
				nbreDeFois++;
				System.out.println("nbreDeFois: " + nbreDeFois);
			}*/
		} catch (MalformedURLException e) {
			System.out.println(e);
		} catch (IOException e) {
			System.out.println(e);
		}
	}
}
 

