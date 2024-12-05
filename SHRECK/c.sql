-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ccsopi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ccsopi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ccsopi` DEFAULT CHARACTER SET utf8 ;
USE `ccsopi` ;

-- -----------------------------------------------------
-- Table `ccsopi`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccsopi`.`film` (
  `idfilm` INT NOT NULL AUTO_INCREMENT,
  `ev` YEAR(4) NOT NULL,
  `cim` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfilm`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccsopi`.`ertekelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccsopi`.`ertekelo` (
  `idertekelo` INT NOT NULL AUTO_INCREMENT,
  `nev` VARCHAR(45) NOT NULL,
  `ertek` INT NOT NULL,
  `film_idfilm` INT NOT NULL,
  PRIMARY KEY (`idertekelo`, `film_idfilm`),
  INDEX `fk_ertekelo_film_idx` (`film_idfilm` ASC),
  CONSTRAINT `fk_ertekelo_film`
    FOREIGN KEY (`film_idfilm`)
    REFERENCES `ccsopi`.`film` (`idfilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
INSERT INTO film(ev,cim)
VALUES
('2001','Shrek'),
('2011','Thor'),
('2021','Dune');
select * from film;

INSERT INTO ertekelo(nev,ertek,film_idfilm)
VALUES
('Zozo',5,1),
('Tomi',4,1),
('Peter',5,2),
('Anna',4,2),
('Zoltan',3,2);
select * from ertekelo;

select 
film.cim AS cim ,film.ev AS ev,film.idfilm AS idfilm,
count(ertekelo.idertekelo) as valaszok,
avg(ertekelo.ertek) as atlag from film
LEFT JOIN ertekelo ON ertekelo.film_idfilm=film.idfilm
WHERE  film.ev>'2000'
GROUP BY film.cim
ORDER BY film.ev ASC;


select ertekelo.nev,ertekelo.ertek,ertekelo.film_idfilm from ertekelo;
select * from film;





SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
