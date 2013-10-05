-- -----------------------------------------------------
-- Table `Caracteristique`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS Caracteristique (
  `idCaracteristique` INT NOT NULL ,
  `label` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idCaracteristique`) );
  
insert into Caracteristique values (1, "Vitalité");
insert into Caracteristique values (2, "Force");
insert into Caracteristique values (3, "Intelligence");
insert into Caracteristique values (4, "Chance");
insert into Caracteristique values (5, "Agilité");
insert into Caracteristique values (6, "Sagesse");
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
-- Table `Dommages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dommages` (
  `idDommages` INT NOT NULL,
  `min` INT NOT NULL,
  `max` INT NOT NULL,
  `Element_idElement` INT NOT NULL,
  PRIMARY KEY (`idDommages`, `Element_idElement`),
  INDEX `fk_Dommages_Element1_idx` (`Element_idElement` ASC),
  CONSTRAINT `fk_Dommages_Element1`
    FOREIGN KEY (`Element_idElement`)
    REFERENCES `bdd`.`Element` (`idElement`)
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


-- -----------------------------------------------------
-- Table `Objet`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Objet` (
  `idObjet` INT NOT NULL ,
  `nom` VARCHAR(45) NOT NULL ,
  `image` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(255) NOT NULL ,
  `niveau` INT NOT NULL ,
  `Type_idType` INT NOT NULL ,
  PRIMARY KEY (`idObjet`) ,
  INDEX `fk_Objet_Type1_idx` (`Type_idType` ASC) ,
  CONSTRAINT `fk_Objet_Type1`
    FOREIGN KEY (`Type_idType` )
    REFERENCES `Type` (`idType` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ObjetPersonnalise`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ObjetPersonnalise` (
  `Caracteristique_idCaracteristique` INT NOT NULL ,
  `Objet_idObjet` INT NOT NULL ,
  `valeur` INT NOT NULL ,
  `Dommages_idDommages` INT NULL,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Objet_idObjet`) ,
  INDEX `fk_Caracteristique_has_Objet_Objet1_idx` (`Objet_idObjet` ASC) ,
  INDEX `fk_Caracteristique_has_Objet_Caracteristique_idx` (`Caracteristique_idCaracteristique` ASC) ,
  INDEX `fk_ObjetPersonnalise_Dommages1_idx` (`Dommages_idDommages` ASC),
  CONSTRAINT `fk_Caracteristique_has_Objet_Caracteristique`
    FOREIGN KEY (`Caracteristique_idCaracteristique` )
    REFERENCES `Caracteristique` (`idCaracteristique` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Objet_Objet1`
    FOREIGN KEY (`Objet_idObjet` )
    REFERENCES `Objet` (`idObjet` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  CONSTRAINT `fk_ObjetPersonnalise_Dommages1`
    FOREIGN KEY (`Dommages_idDommages`)
    REFERENCES `Dommages` (`idDommages`)
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
  `Dommages_idDommages` INT NULL,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Objet_idObjet`) ,
  INDEX `fk_Caracteristique_has_Objet1_Objet1_idx` (`Objet_idObjet` ASC) ,
  INDEX `fk_Caracteristique_has_Objet1_Caracteristique1_idx` (`Caracteristique_idCaracteristique` ASC) ,
  INDEX `fk_ObjetBasique_Dommages1_idx` (`Dommages_idDommages` ASC),
  CONSTRAINT `fk_Caracteristique_has_Objet1_Caracteristique1`
    FOREIGN KEY (`Caracteristique_idCaracteristique` )
    REFERENCES `Caracteristique` (`idCaracteristique` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Objet1_Objet1`
    FOREIGN KEY (`Objet_idObjet` )
    REFERENCES `Objet` (`idObjet` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  CONSTRAINT `fk_ObjetBasique_Dommages1`
    FOREIGN KEY (`Dommages_idDommages`)
    REFERENCES `Dommages` (`idDommages`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Race`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Race` (
  `idRace` INT NOT NULL ,
  `designation` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idRace`) );


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
  `value` INT NOT NULL,
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