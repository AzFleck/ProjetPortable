-- -----------------------------------------------------
-- Table `Caracteristique`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS Caracteristique (
  `idCaracteristique` INT NOT NULL ,
  `label` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idCaracteristique`) );
  
insert into Caracteristique values (1, "Vitalité");
insert into Caracteristique values (2, "Sagesse");
insert into Caracteristique values (3, "Force");
insert into Caracteristique values (4, "Intelligence");
insert into Caracteristique values (5, "Chance");
insert into Caracteristique values (6, "Agilité");
insert into Caracteristique values (7, "PA");
insert into Caracteristique values (8, "PM");
insert into Caracteristique values (9, "PO");
insert into Caracteristique values (10, "Résistance neutre");
insert into Caracteristique values (11, "Résistance terre");
insert into Caracteristique values (12, "Résistance feu");
insert into Caracteristique values (13, "Résistance eau");
insert into Caracteristique values (14, "Résistance air");
insert into Caracteristique values (15, "Résistance % neutre");
insert into Caracteristique values (16, "Résistance % terre");
insert into Caracteristique values (17, "Résistance % feu");
insert into Caracteristique values (18, "Résistance % eau");
insert into Caracteristique values (19, "Résistance % air");
insert into Caracteristique values (20, "Retrait PA");
insert into Caracteristique values (21, "Retrait PM");
insert into Caracteristique values (22, "Esquive PA");
insert into Caracteristique values (23, "Esquive PM");
insert into Caracteristique values (24, "Initiative");
insert into Caracteristique values (25, "Prospection");
insert into Caracteristique values (26, "Soin");
insert into Caracteristique values (27, "Coup critique");
insert into Caracteristique values (28, "Résistance Critique");
insert into Caracteristique values (29, "Dommage");
insert into Caracteristique values (30, "Dommage neutre");
insert into Caracteristique values (31, "Dommage terre");
insert into Caracteristique values (32, "Dommage feu");
insert into Caracteristique values (33, "Dommage eau");
insert into Caracteristique values (34, "Dommage air");
insert into Caracteristique values (35, "Dommage critique");
insert into Caracteristique values (36, "Fuite");
insert into Caracteristique values (37, "Tacle");
insert into Caracteristique values (38, "Renvoi Dommages");
insert into Caracteristique values (39, "Dommage poussée");
insert into Caracteristique values (40, "Résistance poussée");
insert into Caracteristique values (41, "Puissance");
insert into Caracteristique values (42, "Dommage piège");
insert into Caracteristique values (43, "Dommage % piège");

-- -----------------------------------------------------
-- Table `Panoplie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Panoplie` (
  `idPanoplie` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPanoplie`));

-- -----------------------------------------------------
-- Table `Element`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Element` (
  `idElement` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idElement`));

insert into Element values (1, "Neutre");
insert into Element values (2, "Terre");
insert into Element values (3, "Feu");
insert into Element values (4, "Eau");
insert into Element values (5, "Air");

-- -----------------------------------------------------
-- Table `TypeDommages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TypeDommages` (
  `idTypeDom` INT NOT NULL,
  `designation` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idTypeDom`) );
insert into TypeDommages values (1, "Dommages");
insert into TypeDommages values (2, "Vol");
insert into TypeDommages values (3, "Soin");

-- -----------------------------------------------------
-- Table `Dommages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dommages` (
  `idDommages` INT NOT NULL,
  `min` INT NOT NULL,
  `max` INT NOT NULL,
  `Element_idElement` INT NOT NULL,
  `idTypeDom` INT NOT NULL,
  PRIMARY KEY (`idDommages`, `Element_idElement`),
  INDEX `fk_Dommages_Element1_idx` (`Element_idElement` ASC),
  CONSTRAINT `fk_Dommages_Element1`
    FOREIGN KEY (`Element_idElement`)
    REFERENCES `Element` (`idElement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dommages_TypeDommages`
    FOREIGN KEY (`idTypeDom`)
    REFERENCES `TypeDommages` (`idTypeDom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
-- -----------------------------------------------------
-- Table `Type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Type` (
  `idType` INT NOT NULL ,
  `designation` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idType`) );
  
insert into Type values (1, "Coiffe");
insert into Type values (2, "Cape");
insert into Type values (3, "Ceinture");
insert into Type values (4, "Bottes");
insert into Type values (5, "Anneau");
insert into Type values (6, "Amulette");
insert into Type values (7, "Dofus");
insert into Type values (8, "Trophé");
insert into Type values (9, "Familier");
insert into Type values (10, "Dragodinde");
insert into Type values (11, "Montilier");
insert into Type values (12, "Epée");
insert into Type values (13, "Marteau");
insert into Type values (14, "Dagues");
insert into Type values (15, "Hache");
insert into Type values (16, "Pelle");
insert into Type values (17, "Faux");
insert into Type values (18, "Pioche");
insert into Type values (19, "Baton");
insert into Type values (20, "Baguette");
insert into Type values (21, "Arc");
insert into Type values (22, "Bouclier");


-- -----------------------------------------------------
-- Table `Objet`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Objet` (
  `idObjet` INT NOT NULL ,
  `nom` VARCHAR(45) NOT NULL ,
  `image` VARCHAR(255) NOT NULL ,
  `niveau` INT NOT NULL ,
  `recette` VARCHAR(255) NOT NULL,
  `Type_idType` INT NOT NULL ,
  `Panoplie_idPanoplie` INT NOT NULL,
  PRIMARY KEY (`idObjet`) ,
  INDEX `fk_Objet_Type1_idx` (`Type_idType` ASC) ,
  INDEX `fk_Objet_Panoplie1_idx` (`Panoplie_idPanoplie` ASC),
  CONSTRAINT `fk_Objet_Type1`
    FOREIGN KEY (`Type_idType` )
    REFERENCES `Type` (`idType` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Objet_Panoplie1`
    FOREIGN KEY (`Panoplie_idPanoplie`)
    REFERENCES `Panoplie` (`idPanoplie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ObjetPersonnalise`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ObjetPersonnalise` (
  `Caracteristique_idCaracteristique` INT NOT NULL ,
  `Objet_idObjet` INT NOT NULL ,
  `valeur` INT NOT NULL ,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Objet_idObjet`),
  INDEX `fk_Caracteristique_has_Objet_Objet1_idx` (`Objet_idObjet` ASC) ,
  INDEX `fk_Caracteristique_has_Objet_Caracteristique_idx` (`Caracteristique_idCaracteristique` ASC) ,
  CONSTRAINT `fk_Caracteristique_has_Objet_Caracteristique`
    FOREIGN KEY (`Caracteristique_idCaracteristique` )
    REFERENCES `Caracteristique` (`idCaracteristique` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Objet_Objet1`
    FOREIGN KEY (`Objet_idObjet` )
    REFERENCES `Objet` (`idObjet` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ObjetBasique`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ObjetBasique` (
  `Caracteristique_idCaracteristique` INT NOT NULL ,
  `Objet_idObjet` INT NOT NULL ,
  `Minimum` INT NOT NULL ,
  `Maximum` INT NOT NULL ,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Objet_idObjet`),
  INDEX `fk_Caracteristique_has_Objet1_Objet1_idx` (`Objet_idObjet` ASC) ,
  INDEX `fk_Caracteristique_has_Objet1_Caracteristique1_idx` (`Caracteristique_idCaracteristique` ASC) ,
  CONSTRAINT `fk_Caracteristique_has_Objet1_Caracteristique1`
    FOREIGN KEY (`Caracteristique_idCaracteristique` )
    REFERENCES `Caracteristique` (`idCaracteristique` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Objet1_Objet1`
    FOREIGN KEY (`Objet_idObjet` )
    REFERENCES `Objet` (`idObjet` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
CREATE TABLE IF NOT EXISTS `Objet_has_Dommages` (
	`Objet_idObjet` INT NOT NULL ,
	`Dommages_idDommages` INT NULL,
	`Dommages_Element_idElement` INT NOT NULL,
  CONSTRAINT `fk_Objet_Dommages`
    FOREIGN KEY (`Dommages_idDommages` , `Dommages_Element_idElement`)
    REFERENCES `Dommages` (`idDommages` , `Element_idElement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Objet_has_Dommages_Objet`
    FOREIGN KEY (`Objet_idObjet` )
    REFERENCES `Objet` (`idObjet` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Race`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Race` (
  `idRace` INT NOT NULL ,
  `designation` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idRace`) );
  
insert into Race values (1, "Cra");
insert into Race values (2, "Sram");
insert into Race values (3, "Ecaflip");
insert into Race values (4, "Eniripsa");
insert into Race values (5, "Enutrof");
insert into Race values (6, "Feca");
insert into Race values (7, "Sacrieur");
insert into Race values (8, "Pandawa");
insert into Race values (9, "Steamer");
insert into Race values (10, "Roublard");
insert into Race values (11, "Zobal");
insert into Race values (12, "Sadida");
insert into Race values (13, "Osamodas");
insert into Race values (14, "Iop");
insert into Race values (15, "Xelor");


-- -----------------------------------------------------
-- Table `Personnage`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Personnage` (
  `idPersonnage` INT NOT NULL ,
  `nom` VARCHAR(45) NOT NULL ,
  `niveau` VARCHAR(45) NOT NULL ,
  `Race_idRace` INT NOT NULL ,
  PRIMARY KEY (`idPersonnage`) ,
  INDEX `fk_Personnage_Race1_idx` (`Race_idRace` ASC) ,
  CONSTRAINT `fk_Personnage_Race1`
    FOREIGN KEY (`Race_idRace` )
    REFERENCES `Race` (`idRace` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Position`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Position` (
  `idPosition` INT NOT NULL ,
  `label` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idPosition`) );
  
  
insert into Position values (1, "Coiffe");
insert into Position values (2, "Cape");
insert into Position values (3, "Ceinture");
insert into Position values (4, "Familier");
insert into Position values (5, "Anneau1");
insert into Position values (6, "Anneau2");
insert into Position values (7, "Amulette");
insert into Position values (8, "Bottes");
insert into Position values (9, "Arme");
insert into Position values (10, "Bouclier");
insert into Position values (11, "Dofus1");
insert into Position values (12, "Dofus2");
insert into Position values (13, "Dofus3");
insert into Position values (14, "Dofus4");
insert into Position values (15, "Dofus5");
insert into Position values (16, "Dofus6");


-- -----------------------------------------------------
-- Table `Position_has_Type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Position_has_Type` (
  `Position_idPosition` INT NOT NULL ,
  `Type_idType` INT NOT NULL ,
  PRIMARY KEY (`Position_idPosition`, `Type_idType`) ,
  INDEX `fk_Position_has_Type_Type1_idx` (`Type_idType` ASC) ,
  INDEX `fk_Position_has_Type_Position1_idx` (`Position_idPosition` ASC) ,
  CONSTRAINT `fk_Position_has_Type_Position1`
    FOREIGN KEY (`Position_idPosition` )
    REFERENCES `Position` (`idPosition` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Position_has_Type_Type1`
    FOREIGN KEY (`Type_idType` )
    REFERENCES `Type` (`idType` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
	
insert into Position_has_Type values (1, 1);
insert into Position_has_Type values (2, 2);
insert into Position_has_Type values (3, 3);
insert into Position_has_Type values (4, 9);
insert into Position_has_Type values (4, 10);
insert into Position_has_Type values (4, 11);
insert into Position_has_Type values (5, 5);
insert into Position_has_Type values (6, 5);
insert into Position_has_Type values (7, 6);
insert into Position_has_Type values (8, 4);
insert into Position_has_Type values (9, 12);
insert into Position_has_Type values (9, 13);
insert into Position_has_Type values (9, 14);
insert into Position_has_Type values (9, 15);
insert into Position_has_Type values (9, 16);
insert into Position_has_Type values (9, 17);
insert into Position_has_Type values (9, 18);
insert into Position_has_Type values (9, 19);
insert into Position_has_Type values (9, 20);
insert into Position_has_Type values (9, 21);
insert into Position_has_Type values (10, 22);
insert into Position_has_Type values (11, 7);
insert into Position_has_Type values (12, 7);
insert into Position_has_Type values (13, 7);
insert into Position_has_Type values (14, 7);
insert into Position_has_Type values (15, 7);
insert into Position_has_Type values (16, 7);
insert into Position_has_Type values (11, 8);
insert into Position_has_Type values (12, 8);
insert into Position_has_Type values (13, 8);
insert into Position_has_Type values (14, 8);
insert into Position_has_Type values (15, 8);
insert into Position_has_Type values (16, 8);


-- -----------------------------------------------------
-- Table `Position_has_Objet`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Position_has_Objet` (
  `Position_idPosition` INT NOT NULL ,
  `Objet_idObjet` INT NOT NULL ,
  `Personnage_idPersonnage` INT NOT NULL ,
  PRIMARY KEY (`Position_idPosition`, `Objet_idObjet`, `Personnage_idPersonnage`) ,
  INDEX `fk_Position_has_Objet_Objet1_idx` (`Objet_idObjet` ASC) ,
  INDEX `fk_Position_has_Objet_Position1_idx` (`Position_idPosition` ASC) ,
  INDEX `fk_Position_has_Objet_Personnage1_idx` (`Personnage_idPersonnage` ASC) ,
  CONSTRAINT `fk_Position_has_Objet_Position1`
    FOREIGN KEY (`Position_idPosition` )
    REFERENCES `Position` (`idPosition` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Position_has_Objet_Objet1`
    FOREIGN KEY (`Objet_idObjet` )
    REFERENCES `Objet` (`idObjet` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Position_has_Objet_Personnage1`
    FOREIGN KEY (`Personnage_idPersonnage` )
    REFERENCES `Personnage` (`idPersonnage` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Sort`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sort` (
  `idSort` INT NOT NULL ,
  `label` VARCHAR(45) NOT NULL ,
  `porteeMin` INT NOT NULL ,
  `porteeMax` INT NOT NULL ,
  `dommageMin` INT NOT NULL ,
  `dommageMax` INT NOT NULL ,
  `autre` VARCHAR(45) NULL ,
  PRIMARY KEY (`idSort`) );


-- -----------------------------------------------------
-- Table `Race_has_Sort`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Race_has_Sort` (
  `Race_idRace` INT NOT NULL ,
  `Sort_idSort` INT NOT NULL ,
  PRIMARY KEY (`Race_idRace`, `Sort_idSort`) ,
  INDEX `fk_Race_has_Sort_Sort1_idx` (`Sort_idSort` ASC) ,
  INDEX `fk_Race_has_Sort_Race1_idx` (`Race_idRace` ASC) ,
  CONSTRAINT `fk_Race_has_Sort_Race1`
    FOREIGN KEY (`Race_idRace` )
    REFERENCES `Race` (`idRace` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Race_has_Sort_Sort1`
    FOREIGN KEY (`Sort_idSort` )
    REFERENCES `Sort` (`idSort` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Caracteristique_has_Personnage`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Caracteristique_has_Personnage` (
  `Caracteristique_idCaracteristique` INT NOT NULL ,
  `Personnage_idPersonnage` INT NOT NULL ,
  `valeur` INT NOT NULL,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Personnage_idPersonnage`) ,
  INDEX `fk_Caracteristique_has_Personnage_Personnage1_idx` (`Personnage_idPersonnage` ASC) ,
  INDEX `fk_Caracteristique_has_Personnage_Caracteristique1_idx` (`Caracteristique_idCaracteristique` ASC) ,
  CONSTRAINT `fk_Caracteristique_has_Personnage_Caracteristique1`
    FOREIGN KEY (`Caracteristique_idCaracteristique` )
    REFERENCES `Caracteristique` (`idCaracteristique` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Personnage_Personnage1`
    FOREIGN KEY (`Personnage_idPersonnage` )
    REFERENCES `Personnage` (`idPersonnage` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	

-- -----------------------------------------------------
-- Table `Condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Condition` (
  `idCondition` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCondition`));


-- -----------------------------------------------------
-- Table `Objet_has_Condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Objet_has_Condition` (
  `Objet_idObjet` INT NOT NULL,
  `Condition_idCondition` INT NOT NULL,
  PRIMARY KEY (`Objet_idObjet`, `Condition_idCondition`),
  INDEX `fk_Objet_has_Condition_Condition1_idx` (`Condition_idCondition` ASC),
  INDEX `fk_Objet_has_Condition_Objet1_idx` (`Objet_idObjet` ASC),
  CONSTRAINT `fk_Objet_has_Condition_Objet1`
    FOREIGN KEY (`Objet_idObjet`)
    REFERENCES `Objet` (`idObjet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Objet_has_Condition_Condition1`
    FOREIGN KEY (`Condition_idCondition`)
    REFERENCES `Condition` (`idCondition`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Critere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Critere` (
  `idCritere` INT NOT NULL,
  `pa` INT NOT NULL,
  `portee` VARCHAR(45) NOT NULL,
  `bonuscc` VARCHAR(45) NOT NULL,
  `chancecc` VARCHAR(45) NOT NULL,
  `nbpartour` INT NOT NULL,
  PRIMARY KEY (`idCritere`));


-- -----------------------------------------------------
-- Table `bdd`.`Critere_has_Objet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Critere_has_Objet` (
  `Critere_idCritere` INT NOT NULL,
  `Objet_idObjet` INT NOT NULL,
  PRIMARY KEY (`Critere_idCritere`, `Objet_idObjet`),
  INDEX `fk_Critere_has_Objet_Objet1_idx` (`Objet_idObjet` ASC),
  INDEX `fk_Critere_has_Objet_Critere1_idx` (`Critere_idCritere` ASC),
  CONSTRAINT `fk_Critere_has_Objet_Critere1`
    FOREIGN KEY (`Critere_idCritere`)
    REFERENCES `Critere` (`idCritere`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Critere_has_Objet_Objet1`
    FOREIGN KEY (`Objet_idObjet`)
    REFERENCES `Objet` (`idObjet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bdd`.`Race_has_Caracteristique`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Race_has_Caracteristique` (
  `Race_idRace` INT NOT NULL,
  `Caracteristique_idCaracteristique` INT NOT NULL,
  `palier1` VARCHAR(45) NULL,
  `palier2` VARCHAR(45) NULL,
  `palier3` VARCHAR(45) NULL,
  `palier4` VARCHAR(45) NULL,
  PRIMARY KEY (`Race_idRace`, `Caracteristique_idCaracteristique`),
  INDEX `fk_Race_has_Caracteristique_Caracteristique1_idx` (`Caracteristique_idCaracteristique` ASC),
  INDEX `fk_Race_has_Caracteristique_Race1_idx` (`Race_idRace` ASC),
  CONSTRAINT `fk_Race_has_Caracteristique_Race1`
    FOREIGN KEY (`Race_idRace`)
    REFERENCES `Race` (`idRace`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Race_has_Caracteristique_Caracteristique1`
    FOREIGN KEY (`Caracteristique_idCaracteristique`)
    REFERENCES `Caracteristique` (`idCaracteristique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- Vitalité (soucis du sacri mais on le gère pas dans le sql au pire)
insert into Race_has_Caracteristique values (1,1,null,null,null,null);
insert into Race_has_Caracteristique values (2,1,null,null,null,null);
insert into Race_has_Caracteristique values (3,1,null,null,null,null);
insert into Race_has_Caracteristique values (4,1,null,null,null,null);
insert into Race_has_Caracteristique values (5,1,null,null,null,null);
insert into Race_has_Caracteristique values (6,1,null,null,null,null);
insert into Race_has_Caracteristique values (7,1,null,null,null,null);
insert into Race_has_Caracteristique values (8,1,null,null,null,null);
insert into Race_has_Caracteristique values (9,1,null,null,null,null);
insert into Race_has_Caracteristique values (10,1,null,null,null,null);
insert into Race_has_Caracteristique values (11,1,null,null,null,null);
insert into Race_has_Caracteristique values (12,1,null,null,null,null);
insert into Race_has_Caracteristique values (13,1,null,null,null,null);
insert into Race_has_Caracteristique values (14,1,null,null,null,null);
insert into Race_has_Caracteristique values (15,1,null,null,null,null);

-- Sagesse 
insert into Race_has_Caracteristique values (1,2,0,0,null,null);
insert into Race_has_Caracteristique values (2,2,0,0,null,null);
insert into Race_has_Caracteristique values (3,2,0,0,null,null);
insert into Race_has_Caracteristique values (4,2,0,0,null,null);
insert into Race_has_Caracteristique values (5,2,0,0,null,null);
insert into Race_has_Caracteristique values (6,2,0,0,null,null);
insert into Race_has_Caracteristique values (7,2,0,0,null,null);
insert into Race_has_Caracteristique values (8,2,0,0,null,null);
insert into Race_has_Caracteristique values (9,2,0,0,null,null);
insert into Race_has_Caracteristique values (10,2,0,0,null,null);
insert into Race_has_Caracteristique values (11,2,0,0,null,null);
insert into Race_has_Caracteristique values (12,2,0,0,null,null);
insert into Race_has_Caracteristique values (13,2,0,0,null,null);
insert into Race_has_Caracteristique values (14,2,0,0,null,null);
insert into Race_has_Caracteristique values (15,2,0,0,null,null);

-- Cra
insert into Race_has_Caracteristique values (1,3,51,151,251,351);
insert into Race_has_Caracteristique values (1,4,51,151,251,351);
insert into Race_has_Caracteristique values (1,5,21,41,61,81);
insert into Race_has_Caracteristique values (1,6,51,101,151,201);

-- Sram
insert into Race_has_Caracteristique values (2,3,101,201,301,401);
insert into Race_has_Caracteristique values (2,4,0,51,151,251);
insert into Race_has_Caracteristique values (2,5,21,41,61,81);
insert into Race_has_Caracteristique values (2,6,101,201,301,401);

-- Ecaflip
insert into Race_has_Caracteristique values (3,3,101,201,301,401);
insert into Race_has_Caracteristique values (3,4,21,41,61,81);
insert into Race_has_Caracteristique values (3,5,21,41,61,81);
insert into Race_has_Caracteristique values (3,6,51,101,151,201);

-- Eniripsa
insert into Race_has_Caracteristique values (4,3,0,51,151,251);
insert into Race_has_Caracteristique values (4,4,101,201,301,401);
insert into Race_has_Caracteristique values (4,5,21,41,61,81);
insert into Race_has_Caracteristique values (4,6,21,41,61,81);

-- Enutrof
insert into Race_has_Caracteristique values (5,3,51,151,251,351);
insert into Race_has_Caracteristique values (5,4,21,61,101,141);
insert into Race_has_Caracteristique values (5,5,101,151,231,331);
insert into Race_has_Caracteristique values (5,6,21,41,61,81);

-- Feca
insert into Race_has_Caracteristique values (6,3,0,51,151,251);
insert into Race_has_Caracteristique values (6,4,101,201,301,401);
insert into Race_has_Caracteristique values (6,5,21,41,61,81);
insert into Race_has_Caracteristique values (6,6,21,41,61,81);

-- Sacrieur
insert into Race_has_Caracteristique values (7,3,0,0,101,151);
insert into Race_has_Caracteristique values (7,4,0,0,101,151);
insert into Race_has_Caracteristique values (7,5,0,0,101,151);
insert into Race_has_Caracteristique values (7,6,0,0,101,151);

-- Pandawa
insert into Race_has_Caracteristique values (8,3,51,201,null,null);
insert into Race_has_Caracteristique values (8,4,51,201,null,null);
insert into Race_has_Caracteristique values (8,5,51,201,null,null);
insert into Race_has_Caracteristique values (8,6,51,201,null,null);

-- Steamer
insert into Race_has_Caracteristique values (9,3,51,201,null,null);
insert into Race_has_Caracteristique values (9,4,51,201,null,null);
insert into Race_has_Caracteristique values (9,5,51,201,null,null);
insert into Race_has_Caracteristique values (9,6,51,201,null,null);

-- Roublard
insert into Race_has_Caracteristique values (10,3,51,201,null,null);
insert into Race_has_Caracteristique values (10,4,51,201,null,null);
insert into Race_has_Caracteristique values (10,5,51,201,null,null);
insert into Race_has_Caracteristique values (10,6,51,201,null,null);

-- Zobal
insert into Race_has_Caracteristique values (11,3,100,200,300,400);
insert into Race_has_Caracteristique values (11,4,100,200,300,400);
insert into Race_has_Caracteristique values (11,5,100,200,300,400);
insert into Race_has_Caracteristique values (11,6,100,200,300,400);

-- Sadida
insert into Race_has_Caracteristique values (12,3,51,251,301,401);
insert into Race_has_Caracteristique values (12,4,101,201,301,401);
insert into Race_has_Caracteristique values (12,5,101,201,301,401);
insert into Race_has_Caracteristique values (12,6,21,41,61,81);

-- Osamodas
insert into Race_has_Caracteristique values (13,3,0,51,151,251);
insert into Race_has_Caracteristique values (13,4,101,201,301,401);
insert into Race_has_Caracteristique values (13,5,101,201,301,401);
insert into Race_has_Caracteristique values (13,6,21,41,61,81);

-- Iop
insert into Race_has_Caracteristique values (14,3,101,201,301,401);
insert into Race_has_Caracteristique values (14,4,21,41,61,81);
insert into Race_has_Caracteristique values (14,5,21,41,61,81);
insert into Race_has_Caracteristique values (14,6,21,41,61,81);

-- Xelor
insert into Race_has_Caracteristique values (15,3,0,51,151,251);
insert into Race_has_Caracteristique values (15,4,101,201,301,401);
insert into Race_has_Caracteristique values (15,5,21,41,61,81);
insert into Race_has_Caracteristique values (15,6,21,41,61,81);


-- -----------------------------------------------------
-- Table `bdd`.`Parchemin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Parchemin` (
  `Caracteristique_idCaracteristique` INT NOT NULL,
  `Personnage_idPersonnage` INT NOT NULL,
  `valeur` INT NOT NULL,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Personnage_idPersonnage`),
  INDEX `fk_Caracteristique_has_Personnage1_Personnage1_idx` (`Personnage_idPersonnage` ASC),
  INDEX `fk_Caracteristique_has_Personnage1_Caracteristique1_idx` (`Caracteristique_idCaracteristique` ASC),
  CONSTRAINT `fk_Caracteristique_has_Personnage1_Caracteristique1`
    FOREIGN KEY (`Caracteristique_idCaracteristique`)
    REFERENCES `Caracteristique` (`idCaracteristique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Personnage1_Personnage1`
    FOREIGN KEY (`Personnage_idPersonnage`)
    REFERENCES `Personnage` (`idPersonnage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

