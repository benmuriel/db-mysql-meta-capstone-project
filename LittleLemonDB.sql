-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LittleLemonDB` ;

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`customers` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`bookings` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `booking_date` DATE NOT NULL,
  `table_number` INT UNSIGNED NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `fk_booking_customer_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_booking_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`menus` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menus` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `menu_name` VARCHAR(255) NOT NULL,
  `price` DECIMAL(9,2) UNSIGNED NOT NULL DEFAULT 0,
  `category` VARCHAR(45) NULL,
  `cuisine` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menu_id`),
  UNIQUE INDEX `title_UNIQUE` (`menu_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`orders` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATE NOT NULL,
  `quantity` INT UNSIGNED NOT NULL DEFAULT 1,
  `total_cost` DECIMAL(9,2) UNSIGNED NOT NULL DEFAULT 0,
  `menu_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_menu_idx` (`menu_id` ASC) VISIBLE,
  INDEX `fk_order_customer_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_menu`
    FOREIGN KEY (`menu_id`)
    REFERENCES `LittleLemonDB`.`menus` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`order_delivery_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`order_delivery_status` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`order_delivery_status` (
  `delivery_id` INT NOT NULL AUTO_INCREMENT,
  `delivery_date` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `fk_delivery_status_order_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_status_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `LittleLemonDB`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staffs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`staffs` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staffs` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(9,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`staff_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`menu_items` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu_items` (
  `menu_item_id` INT NOT NULL AUTO_INCREMENT,
  `cours_name` VARCHAR(45) NULL,
  `starter_name` VARCHAR(45) NULL,
  `dessert_name` VARCHAR(45) NULL,
  `menu_id` INT NOT NULL,
  PRIMARY KEY (`menu_item_id`),
  INDEX `fk_menu_item_menu_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_item_menu`
    FOREIGN KEY (`menu_id`)
    REFERENCES `LittleLemonDB`.`menus` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
