SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `bdd` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `bdd` ;

-- -----------------------------------------------------
-- Table `bdd`.`Caracteristique`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Caracteristique` (
  `idCaracteristique` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCaracteristique`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Type` (
  `idType` INT NOT NULL,
  `designation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Panoplie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Panoplie` (
  `idPanoplie` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPanoplie`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Objet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Objet` (
  `idObjet` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `niveau` INT NOT NULL,
  `recette` VARCHAR(45) NOT NULL,
  `Type_idType` INT NOT NULL,
  `Panoplie_idPanoplie` INT NOT NULL,
  PRIMARY KEY (`idObjet`),
  INDEX `fk_Objet_Type1_idx` (`Type_idType` ASC),
  INDEX `fk_Objet_Panoplie1_idx` (`Panoplie_idPanoplie` ASC),
  CONSTRAINT `fk_Objet_Type1`
    FOREIGN KEY (`Type_idType`)
    REFERENCES `bdd`.`Type` (`idType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Objet_Panoplie1`
    FOREIGN KEY (`Panoplie_idPanoplie`)
    REFERENCES `bdd`.`Panoplie` (`idPanoplie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Element`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Element` (
  `idElement` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idElement`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Dommage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Dommage` (
  `idDommage` INT NOT NULL,
  `min` INT NOT NULL,
  `max` INT NOT NULL,
  `Element_idElement` INT NOT NULL,
  PRIMARY KEY (`idDommage`, `Element_idElement`),
  INDEX `fk_Dommage_Element1_idx` (`Element_idElement` ASC),
  CONSTRAINT `fk_Dommage_Element1`
    FOREIGN KEY (`Element_idElement`)
    REFERENCES `bdd`.`Element` (`idElement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`ObjetPersonnalise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`ObjetPersonnalise` (
  `Caracteristique_idCaracteristique` INT NOT NULL,
  `Objet_idObjet` INT NOT NULL,
  `valeur` INT NOT NULL,
  `Dommage_idDommage` INT NOT NULL,
  `Dommage_Element_idElement` INT NOT NULL,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Objet_idObjet`, `Dommage_idDommage`, `Dommage_Element_idElement`),
  INDEX `fk_Caracteristique_has_Objet_Objet1_idx` (`Objet_idObjet` ASC),
  INDEX `fk_Caracteristique_has_Objet_Caracteristique_idx` (`Caracteristique_idCaracteristique` ASC),
  INDEX `fk_ObjetPersonnalise_Dommage1_idx` (`Dommage_idDommage` ASC, `Dommage_Element_idElement` ASC),
  CONSTRAINT `fk_Caracteristique_has_Objet_Caracteristique`
    FOREIGN KEY (`Caracteristique_idCaracteristique`)
    REFERENCES `bdd`.`Caracteristique` (`idCaracteristique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Objet_Objet1`
    FOREIGN KEY (`Objet_idObjet`)
    REFERENCES `bdd`.`Objet` (`idObjet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ObjetPersonnalise_Dommage1`
    FOREIGN KEY (`Dommage_idDommage` , `Dommage_Element_idElement`)
    REFERENCES `bdd`.`Dommage` (`idDommage` , `Element_idElement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`ObjetBasique`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`ObjetBasique` (
  `Caracteristique_idCaracteristique` INT NOT NULL,
  `Objet_idObjet` INT NOT NULL,
  `Minimum` INT NOT NULL,
  `Maximum` INT NOT NULL,
  `Dommage_idDommage` INT NOT NULL,
  `Dommage_Element_idElement` INT NOT NULL,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Objet_idObjet`, `Dommage_idDommage`, `Dommage_Element_idElement`),
  INDEX `fk_Caracteristique_has_Objet1_Objet1_idx` (`Objet_idObjet` ASC),
  INDEX `fk_Caracteristique_has_Objet1_Caracteristique1_idx` (`Caracteristique_idCaracteristique` ASC),
  INDEX `fk_ObjetBasique_Dommage1_idx` (`Dommage_idDommage` ASC, `Dommage_Element_idElement` ASC),
  CONSTRAINT `fk_Caracteristique_has_Objet1_Caracteristique1`
    FOREIGN KEY (`Caracteristique_idCaracteristique`)
    REFERENCES `bdd`.`Caracteristique` (`idCaracteristique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Objet1_Objet1`
    FOREIGN KEY (`Objet_idObjet`)
    REFERENCES `bdd`.`Objet` (`idObjet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ObjetBasique_Dommage1`
    FOREIGN KEY (`Dommage_idDommage` , `Dommage_Element_idElement`)
    REFERENCES `bdd`.`Dommage` (`idDommage` , `Element_idElement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Race`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Race` (
  `idRace` INT NOT NULL,
  `designation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRace`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Personnage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Personnage` (
  `idPersonnage` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `niveau` VARCHAR(45) NOT NULL,
  `Race_idRace` INT NOT NULL,
  PRIMARY KEY (`idPersonnage`),
  INDEX `fk_Personnage_Race1_idx` (`Race_idRace` ASC),
  CONSTRAINT `fk_Personnage_Race1`
    FOREIGN KEY (`Race_idRace`)
    REFERENCES `bdd`.`Race` (`idRace`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Position` (
  `idPosition` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPosition`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Position_has_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Position_has_Type` (
  `Position_idPosition` INT NOT NULL,
  `Type_idType` INT NOT NULL,
  PRIMARY KEY (`Position_idPosition`, `Type_idType`),
  INDEX `fk_Position_has_Type_Type1_idx` (`Type_idType` ASC),
  INDEX `fk_Position_has_Type_Position1_idx` (`Position_idPosition` ASC),
  CONSTRAINT `fk_Position_has_Type_Position1`
    FOREIGN KEY (`Position_idPosition`)
    REFERENCES `bdd`.`Position` (`idPosition`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Position_has_Type_Type1`
    FOREIGN KEY (`Type_idType`)
    REFERENCES `bdd`.`Type` (`idType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Position_has_Objet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Position_has_Objet` (
  `Position_idPosition` INT NOT NULL,
  `Objet_idObjet` INT NOT NULL,
  `Personnage_idPersonnage` INT NOT NULL,
  PRIMARY KEY (`Position_idPosition`, `Objet_idObjet`, `Personnage_idPersonnage`),
  INDEX `fk_Position_has_Objet_Objet1_idx` (`Objet_idObjet` ASC),
  INDEX `fk_Position_has_Objet_Position1_idx` (`Position_idPosition` ASC),
  INDEX `fk_Position_has_Objet_Personnage1_idx` (`Personnage_idPersonnage` ASC),
  CONSTRAINT `fk_Position_has_Objet_Position1`
    FOREIGN KEY (`Position_idPosition`)
    REFERENCES `bdd`.`Position` (`idPosition`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Position_has_Objet_Objet1`
    FOREIGN KEY (`Objet_idObjet`)
    REFERENCES `bdd`.`Objet` (`idObjet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Position_has_Objet_Personnage1`
    FOREIGN KEY (`Personnage_idPersonnage`)
    REFERENCES `bdd`.`Personnage` (`idPersonnage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Sort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Sort` (
  `idSort` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  `porteeMin` INT NOT NULL,
  `porteeMax` INT NOT NULL,
  `dommageMin` INT NOT NULL,
  `dommageMax` INT NOT NULL,
  `autre` VARCHAR(45) NULL,
  PRIMARY KEY (`idSort`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Race_has_Sort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Race_has_Sort` (
  `Race_idRace` INT NOT NULL,
  `Sort_idSort` INT NOT NULL,
  PRIMARY KEY (`Race_idRace`, `Sort_idSort`),
  INDEX `fk_Race_has_Sort_Sort1_idx` (`Sort_idSort` ASC),
  INDEX `fk_Race_has_Sort_Race1_idx` (`Race_idRace` ASC),
  CONSTRAINT `fk_Race_has_Sort_Race1`
    FOREIGN KEY (`Race_idRace`)
    REFERENCES `bdd`.`Race` (`idRace`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Race_has_Sort_Sort1`
    FOREIGN KEY (`Sort_idSort`)
    REFERENCES `bdd`.`Sort` (`idSort`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Caracteristique_has_Personnage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Caracteristique_has_Personnage` (
  `Caracteristique_idCaracteristique` INT NOT NULL,
  `Personnage_idPersonnage` INT NOT NULL,
  `valeur` INT NOT NULL,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Personnage_idPersonnage`),
  INDEX `fk_Caracteristique_has_Personnage_Personnage1_idx` (`Personnage_idPersonnage` ASC),
  INDEX `fk_Caracteristique_has_Personnage_Caracteristique1_idx` (`Caracteristique_idCaracteristique` ASC),
  CONSTRAINT `fk_Caracteristique_has_Personnage_Caracteristique1`
    FOREIGN KEY (`Caracteristique_idCaracteristique`)
    REFERENCES `bdd`.`Caracteristique` (`idCaracteristique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Personnage_Personnage1`
    FOREIGN KEY (`Personnage_idPersonnage`)
    REFERENCES `bdd`.`Personnage` (`idPersonnage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Condition` (
  `idCondition` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCondition`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Objet_has_Condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Objet_has_Condition` (
  `Objet_idObjet` INT NOT NULL,
  `Condition_idCondition` INT NOT NULL,
  PRIMARY KEY (`Objet_idObjet`, `Condition_idCondition`),
  INDEX `fk_Objet_has_Condition_Condition1_idx` (`Condition_idCondition` ASC),
  INDEX `fk_Objet_has_Condition_Objet1_idx` (`Objet_idObjet` ASC),
  CONSTRAINT `fk_Objet_has_Condition_Objet1`
    FOREIGN KEY (`Objet_idObjet`)
    REFERENCES `bdd`.`Objet` (`idObjet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Objet_has_Condition_Condition1`
    FOREIGN KEY (`Condition_idCondition`)
    REFERENCES `bdd`.`Condition` (`idCondition`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Critere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Critere` (
  `idCritere` INT NOT NULL,
  `pa` INT NOT NULL,
  `portee` VARCHAR(45) NOT NULL,
  `bonuscc` VARCHAR(45) NOT NULL,
  `chancecc` VARCHAR(45) NOT NULL,
  `nbpartour` INT NOT NULL,
  PRIMARY KEY (`idCritere`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Critere_has_Objet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Critere_has_Objet` (
  `Critere_idCritere` INT NOT NULL,
  `Objet_idObjet` INT NOT NULL,
  PRIMARY KEY (`Critere_idCritere`, `Objet_idObjet`),
  INDEX `fk_Critere_has_Objet_Objet1_idx` (`Objet_idObjet` ASC),
  INDEX `fk_Critere_has_Objet_Critere1_idx` (`Critere_idCritere` ASC),
  CONSTRAINT `fk_Critere_has_Objet_Critere1`
    FOREIGN KEY (`Critere_idCritere`)
    REFERENCES `bdd`.`Critere` (`idCritere`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Critere_has_Objet_Objet1`
    FOREIGN KEY (`Objet_idObjet`)
    REFERENCES `bdd`.`Objet` (`idObjet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Race_has_Caracteristique`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Race_has_Caracteristique` (
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
    REFERENCES `bdd`.`Race` (`idRace`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Race_has_Caracteristique_Caracteristique1`
    FOREIGN KEY (`Caracteristique_idCaracteristique`)
    REFERENCES `bdd`.`Caracteristique` (`idCaracteristique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd`.`Parchemin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd`.`Parchemin` (
  `Caracteristique_idCaracteristique` INT NOT NULL,
  `Personnage_idPersonnage` INT NOT NULL,
  `valeur` INT NOT NULL,
  PRIMARY KEY (`Caracteristique_idCaracteristique`, `Personnage_idPersonnage`),
  INDEX `fk_Caracteristique_has_Personnage1_Personnage1_idx` (`Personnage_idPersonnage` ASC),
  INDEX `fk_Caracteristique_has_Personnage1_Caracteristique1_idx` (`Caracteristique_idCaracteristique` ASC),
  CONSTRAINT `fk_Caracteristique_has_Personnage1_Caracteristique1`
    FOREIGN KEY (`Caracteristique_idCaracteristique`)
    REFERENCES `bdd`.`Caracteristique` (`idCaracteristique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caracteristique_has_Personnage1_Personnage1`
    FOREIGN KEY (`Personnage_idPersonnage`)
    REFERENCES `bdd`.`Personnage` (`idPersonnage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
