-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`customer` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`booking` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `booking_date` DATE NOT NULL,
  `table_number` INT UNSIGNED NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `fk_booking_customer_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_booking_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATE NOT NULL,
  `quantity` INT UNSIGNED NOT NULL DEFAULT 1,
  `total_cost` DECIMAL(9) UNSIGNED NOT NULL DEFAULT 0,
  `booking_id` INT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_booking_idx` (`booking_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_booking`
    FOREIGN KEY (`booking_id`)
    REFERENCES `LittleLemonDB`.`booking` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`order_delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`order_delivery_status` (
  `delivery_id` INT NOT NULL AUTO_INCREMENT,
  `delivery_date` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `fk_delivery_status_order_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_status_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `LittleLemonDB`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `price` DECIMAL(9) UNSIGNED NOT NULL DEFAULT 0,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menu_id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`order_item` (
  `order_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  `price` DECIMAL(9) NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_id`, `menu_id`),
  INDEX `fk_order_item_menu_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_item_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `LittleLemonDB`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_item_menu`
    FOREIGN KEY (`menu_id`)
    REFERENCES `LittleLemonDB`.`menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(9) NOT NULL DEFAULT 0,
  PRIMARY KEY (`staff_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
