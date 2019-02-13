CREATE SCHEMA IF NOT EXISTS `insee_data` DEFAULT CHARACTER SET utf8 ;
USE `insee_data` ;

CREATE TABLE IF NOT EXISTS `insee_data`.`departement` (
  `code` VARCHAR(3) NOT NULL,
  `population` INT NOT NULL,
  `nombre_hotel` INT NOT NULL,
  `commune_plus_grande` VARCHAR(255) NOT NULL,
  `commune_plus_petite` VARCHAR(255) NOT NULL,
  `last_update` DATETIME NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;