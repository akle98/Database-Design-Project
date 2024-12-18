-- MySQL Script generated by MySQL Workbench
-- Thu Nov 16 12:04:40 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema testing2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema testing2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `testing2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `testing2` ;

-- -----------------------------------------------------
-- Table `testing2`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`location` (
  `locationID` INT NOT NULL,
  `Street` VARCHAR(255) NULL DEFAULT NULL,
  `City` VARCHAR(255) NULL DEFAULT NULL,
  `State` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`locationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`employee` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `location_locationID` INT NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `fk_employee_location1_idx` (`location_locationID` ASC) VISIBLE,
  CONSTRAINT `fk_employee_location1`
    FOREIGN KEY (`location_locationID`)
    REFERENCES `testing2`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`asphalt_layer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`asphalt_layer` (
  `employee_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`employee_EmployeeID`),
  INDEX `fk_asphalt_layer_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_asphalt_layer_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`client` (
  `ClientID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Phone` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ClientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`employee_error_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`employee_error_record` (
  `ErrorRecordID` INT NOT NULL,
  `date` DATE NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`ErrorRecordID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`project_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`project_type` (
  `ProjectTypeName` VARCHAR(255) NOT NULL,
  `minJobSquareFootage` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ProjectTypeName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`supplier` (
  `SupplierID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`SupplierID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`purchaseOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`purchaseOrder` (
  `PONumber` INT NOT NULL AUTO_INCREMENT,
  `Item` VARCHAR(45) NOT NULL,
  `unitPrice` DECIMAL(2) NOT NULL,
  `quantity` INT NOT NULL,
  `amount` DECIMAL(2) NOT NULL,
  `supplier_SupplierID` INT NOT NULL,
  `employee_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`PONumber`),
  INDEX `fk_purchaseOrder_supplier1_idx` (`supplier_SupplierID` ASC) VISIBLE,
  INDEX `fk_purchaseOrder_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_purchaseOrder_supplier1`
    FOREIGN KEY (`supplier_SupplierID`)
    REFERENCES `testing2`.`supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchaseOrder_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testing2`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`project` (
  `PID` INT NOT NULL AUTO_INCREMENT,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `location_locationID` INT NOT NULL,
  `client_ClientID` INT NOT NULL,
  `project_type_ProjectTypeName` VARCHAR(255) NOT NULL,
  `purchaseOrder_PONumber` INT NOT NULL,
  PRIMARY KEY (`PID`),
  INDEX `fk_project_location1_idx` (`location_locationID` ASC) VISIBLE,
  INDEX `fk_project_client1_idx` (`client_ClientID` ASC) VISIBLE,
  INDEX `fk_project_project_type1_idx` (`project_type_ProjectTypeName` ASC) VISIBLE,
  INDEX `fk_project_purchaseOrder1_idx` (`purchaseOrder_PONumber` ASC) VISIBLE,
  CONSTRAINT `fk_project_location1`
    FOREIGN KEY (`location_locationID`)
    REFERENCES `testing2`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_client1`
    FOREIGN KEY (`client_ClientID`)
    REFERENCES `testing2`.`client` (`ClientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_project_type1`
    FOREIGN KEY (`project_type_ProjectTypeName`)
    REFERENCES `testing2`.`project_type` (`ProjectTypeName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_purchaseOrder1`
    FOREIGN KEY (`purchaseOrder_PONumber`)
    REFERENCES `testing2`.`purchaseOrder` (`PONumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`feedback` (
  `FeedbackID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `employee_EmployeeID` INT NOT NULL,
  `project_PID` INT NOT NULL,
  PRIMARY KEY (`FeedbackID`),
  INDEX `fk_feedback_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  INDEX `fk_feedback_project1_idx` (`project_PID` ASC) VISIBLE,
  CONSTRAINT `fk_feedback_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_feedback_project1`
    FOREIGN KEY (`project_PID`)
    REFERENCES `testing2`.`project` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`qa_inspector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`qa_inspector` (
  `inspectorID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`inspectorID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`report` (
  `ReportID` INT NOT NULL AUTO_INCREMENT,
  `DateIssued` DATE NOT NULL,
  `project_PID` INT NOT NULL,
  `qa_inspector_inspectorID` INT NOT NULL,
  PRIMARY KEY (`ReportID`),
  INDEX `fk_report_project1_idx` (`project_PID` ASC) VISIBLE,
  INDEX `fk_report_qa_inspector1_idx` (`qa_inspector_inspectorID` ASC) VISIBLE,
  CONSTRAINT `fk_report_project1`
    FOREIGN KEY (`project_PID`)
    REFERENCES `testing2`.`project` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_qa_inspector1`
    FOREIGN KEY (`qa_inspector_inspectorID`)
    REFERENCES `testing2`.`qa_inspector` (`inspectorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`inspection_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`inspection_record` (
  `Date` DATE NULL DEFAULT NULL,
  `report_ReportID` INT NOT NULL,
  PRIMARY KEY (`report_ReportID`),
  CONSTRAINT `fk_inspection_record_report1`
    FOREIGN KEY (`report_ReportID`)
    REFERENCES `testing2`.`report` (`ReportID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`warehouse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`warehouse` (
  `WarehouseID` INT NOT NULL,
  `location_locationID` INT NOT NULL,
  `employee_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`WarehouseID`),
  INDEX `fk_warehouse_location1_idx` (`location_locationID` ASC) VISIBLE,
  INDEX `fk_warehouse_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_warehouse_location1`
    FOREIGN KEY (`location_locationID`)
    REFERENCES `testing2`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_warehouse_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`material` (
  `MaterialID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`MaterialID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`inventory_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`inventory_item` (
  `ItemName` VARCHAR(255) NOT NULL,
  `Quantity` INT NOT NULL,
  `Issue` VARCHAR(255) NOT NULL,
  `warehouse_WarehouseID` INT NOT NULL,
  `project_PID` INT NOT NULL,
  `material_MaterialID` INT NOT NULL,
  PRIMARY KEY (`ItemName`, `material_MaterialID`),
  INDEX `fk_inventory_item_warehouse1_idx` (`warehouse_WarehouseID` ASC) VISIBLE,
  INDEX `fk_inventory_item_project1_idx` (`project_PID` ASC) VISIBLE,
  INDEX `fk_inventory_item_material1_idx` (`material_MaterialID` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_item_warehouse1`
    FOREIGN KEY (`warehouse_WarehouseID`)
    REFERENCES `testing2`.`warehouse` (`WarehouseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_item_project1`
    FOREIGN KEY (`project_PID`)
    REFERENCES `testing2`.`project` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_item_material1`
    FOREIGN KEY (`material_MaterialID`)
    REFERENCES `testing2`.`material` (`MaterialID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`invoice` (
  `InvoiceID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Amount` DECIMAL(2) NOT NULL,
  `employee_EmployeeID` INT NOT NULL,
  `project_PID` INT NOT NULL,
  PRIMARY KEY (`InvoiceID`),
  INDEX `fk_invoice_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  INDEX `fk_invoice_project1_idx` (`project_PID` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_project1`
    FOREIGN KEY (`project_PID`)
    REFERENCES `testing2`.`project` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`liaison`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`liaison` (
  `LiaisonID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `supplier_SupplierID` INT NOT NULL,
  PRIMARY KEY (`LiaisonID`, `supplier_SupplierID`),
  INDEX `fk_liaison_supplier1_idx` (`supplier_SupplierID` ASC) VISIBLE,
  CONSTRAINT `fk_liaison_supplier1`
    FOREIGN KEY (`supplier_SupplierID`)
    REFERENCES `testing2`.`supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`machine_operator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`machine_operator` (
  `employee_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`employee_EmployeeID`),
  INDEX `fk_machine_operator_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_machine_operator_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`machinery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`machinery` (
  `MachineryID` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `purchaseDate` DATE NOT NULL,
  `description` VARCHAR(225) NOT NULL,
  `own` BINARY(2) NULL,
  PRIMARY KEY (`MachineryID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`maintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`maintenance` (
  `ProjectTypeName` VARCHAR(255) NOT NULL,
  `MaintenanceFrequency` VARCHAR(255) NOT NULL,
  `project_type_ProjectTypeName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ProjectTypeName`, `project_type_ProjectTypeName`),
  INDEX `fk_maintenance_project_type1_idx` (`project_type_ProjectTypeName` ASC) VISIBLE,
  CONSTRAINT `fk_maintenance_project_type1`
    FOREIGN KEY (`project_type_ProjectTypeName`)
    REFERENCES `testing2`.`project_type` (`ProjectTypeName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`paving`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`paving` (
  `Thickness` VARCHAR(255) NULL DEFAULT NULL,
  `Width` VARCHAR(255) NULL DEFAULT NULL,
  `project_type_ProjectTypeName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`project_type_ProjectTypeName`),
  CONSTRAINT `fk_paving_project_type1`
    FOREIGN KEY (`project_type_ProjectTypeName`)
    REFERENCES `testing2`.`project_type` (`ProjectTypeName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`permit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`permit` (
  `PermitID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`PermitID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`repair`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`repair` (
  `StructuralOrCosmetic` VARCHAR(255) NULL DEFAULT NULL,
  `Techniques` VARCHAR(255) NULL DEFAULT NULL,
  `project_type_ProjectTypeName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`project_type_ProjectTypeName`),
  CONSTRAINT `fk_repair_project_type1`
    FOREIGN KEY (`project_type_ProjectTypeName`)
    REFERENCES `testing2`.`project_type` (`ProjectTypeName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`resurfacing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`resurfacing` (
  `ResurfacingMaterials` VARCHAR(255) NULL DEFAULT NULL,
  `Thickness` VARCHAR(255) NULL DEFAULT NULL,
  `project_type_ProjectTypeName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`project_type_ProjectTypeName`),
  INDEX `fk_resurfacing_project_type1_idx` (`project_type_ProjectTypeName` ASC) VISIBLE,
  CONSTRAINT `fk_resurfacing_project_type1`
    FOREIGN KEY (`project_type_ProjectTypeName`)
    REFERENCES `testing2`.`project_type` (`ProjectTypeName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`safety_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`safety_record` (
  `SafetyViolations` VARCHAR(255) NOT NULL,
  `report_ReportID` INT NOT NULL,
  PRIMARY KEY (`report_ReportID`),
  CONSTRAINT `fk_safety_record_report`
    FOREIGN KEY (`report_ReportID`)
    REFERENCES `testing2`.`report` (`ReportID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`salesperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`salesperson` (
  `employee_EmployeeID` INT NOT NULL,
  `Expertise` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_EmployeeID`),
  INDEX `fk_salesperson_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_salesperson_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`supervisor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`supervisor` (
  `employee_EmployeeID` INT NOT NULL,
  `SuperviseeID` INT NULL,
  PRIMARY KEY (`employee_EmployeeID`),
  INDEX `fk_supervisor_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_supervisor_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`location_has_client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`location_has_client` (
  `location_locationID` INT NOT NULL,
  `client_ClientID` INT NOT NULL,
  `city` VARCHAR(45) NULL,
  `street` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  PRIMARY KEY (`location_locationID`, `client_ClientID`),
  INDEX `fk_location_has_client_client1_idx` (`client_ClientID` ASC) VISIBLE,
  INDEX `fk_location_has_client_location1_idx` (`location_locationID` ASC) VISIBLE,
  CONSTRAINT `fk_location_has_client_location1`
    FOREIGN KEY (`location_locationID`)
    REFERENCES `testing2`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_has_client_client1`
    FOREIGN KEY (`client_ClientID`)
    REFERENCES `testing2`.`client` (`ClientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`Files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`Files` (
  `client_ClientID` INT NOT NULL,
  `feedback_FeedbackID` INT NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`client_ClientID`, `feedback_FeedbackID`),
  INDEX `fk_client_has_feedback_feedback1_idx` (`feedback_FeedbackID` ASC) VISIBLE,
  INDEX `fk_client_has_feedback_client1_idx` (`client_ClientID` ASC) VISIBLE,
  CONSTRAINT `fk_client_has_feedback_client1`
    FOREIGN KEY (`client_ClientID`)
    REFERENCES `testing2`.`client` (`ClientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_feedback_feedback1`
    FOREIGN KEY (`feedback_FeedbackID`)
    REFERENCES `testing2`.`feedback` (`FeedbackID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`Works_on_project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`Works_on_project` (
  `project_PID` INT NOT NULL,
  `employee_EmployeeID` INT NOT NULL,
  `numDays` INT NULL,
  `projectType` VARCHAR(45) NULL,
  PRIMARY KEY (`project_PID`, `employee_EmployeeID`),
  INDEX `fk_project_has_employee_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  INDEX `fk_project_has_employee_project1_idx` (`project_PID` ASC) VISIBLE,
  CONSTRAINT `fk_project_has_employee_project1`
    FOREIGN KEY (`project_PID`)
    REFERENCES `testing2`.`project` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_has_employee_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`provide_materials_for`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`provide_materials_for` (
  `project_PID` INT NOT NULL,
  `supplier_SupplierID` INT NOT NULL,
  PRIMARY KEY (`project_PID`, `supplier_SupplierID`),
  INDEX `fk_project_has_supplier_supplier1_idx` (`supplier_SupplierID` ASC) VISIBLE,
  INDEX `fk_project_has_supplier_project1_idx` (`project_PID` ASC) VISIBLE,
  CONSTRAINT `fk_project_has_supplier_project1`
    FOREIGN KEY (`project_PID`)
    REFERENCES `testing2`.`project` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_has_supplier_supplier1`
    FOREIGN KEY (`supplier_SupplierID`)
    REFERENCES `testing2`.`supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`file_permit_for`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`file_permit_for` (
  `permit_PermitID` INT NOT NULL,
  `project_PID` INT NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`permit_PermitID`, `project_PID`),
  INDEX `fk_permit_has_project_project1_idx` (`project_PID` ASC) VISIBLE,
  INDEX `fk_permit_has_project_permit1_idx` (`permit_PermitID` ASC) VISIBLE,
  CONSTRAINT `fk_permit_has_project_permit1`
    FOREIGN KEY (`permit_PermitID`)
    REFERENCES `testing2`.`permit` (`PermitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permit_has_project_project1`
    FOREIGN KEY (`project_PID`)
    REFERENCES `testing2`.`project` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`employee_has_employee_error_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`employee_has_employee_error_record` (
  `employee_EmployeeID` INT NOT NULL,
  `employee_error_record_ErrorRecordID` INT NOT NULL,
  PRIMARY KEY (`employee_EmployeeID`, `employee_error_record_ErrorRecordID`),
  INDEX `fk_employee_has_employee_error_record_employee_error_record_idx` (`employee_error_record_ErrorRecordID` ASC) VISIBLE,
  INDEX `fk_employee_has_employee_error_record_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_employee_error_record_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_employee_error_record_employee_error_record1`
    FOREIGN KEY (`employee_error_record_ErrorRecordID`)
    REFERENCES `testing2`.`employee_error_record` (`ErrorRecordID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`supplier_has_material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`supplier_has_material` (
  `supplier_SupplierID` INT NOT NULL,
  `material_MaterialID` INT NOT NULL,
  PRIMARY KEY (`supplier_SupplierID`, `material_MaterialID`),
  INDEX `fk_supplier_has_material_material1_idx` (`material_MaterialID` ASC) VISIBLE,
  INDEX `fk_supplier_has_material_supplier1_idx` (`supplier_SupplierID` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_has_material_supplier1`
    FOREIGN KEY (`supplier_SupplierID`)
    REFERENCES `testing2`.`supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supplier_has_material_material1`
    FOREIGN KEY (`material_MaterialID`)
    REFERENCES `testing2`.`material` (`MaterialID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`Bid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`Bid` (
  `bidID` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(2) NOT NULL,
  `client_ClientID` INT NOT NULL,
  `employee_EmployeeID` INT NOT NULL,
  `project_type_ProjectTypeName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`bidID`),
  INDEX `fk_Bid_client1_idx` (`client_ClientID` ASC) VISIBLE,
  INDEX `fk_Bid_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  INDEX `fk_Bid_project_type1_idx` (`project_type_ProjectTypeName` ASC) VISIBLE,
  CONSTRAINT `fk_Bid_client1`
    FOREIGN KEY (`client_ClientID`)
    REFERENCES `testing2`.`client` (`ClientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bid_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bid_project_type1`
    FOREIGN KEY (`project_type_ProjectTypeName`)
    REFERENCES `testing2`.`project_type` (`ProjectTypeName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testing2`.`Advertisement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`Advertisement` (
  `adID` INT NOT NULL AUTO_INCREMENT,
  `medium` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `employee_EmployeeID` INT NOT NULL,
  `locationPosted` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`adID`),
  INDEX `fk_Advertisement_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Advertisement_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testing2`.`inspect_project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`inspect_project` (
  `project_PID` INT NOT NULL,
  `qa_inspector_inspectorID` INT NOT NULL,
  PRIMARY KEY (`project_PID`, `qa_inspector_inspectorID`),
  INDEX `fk_project_has_qa_inspector_qa_inspector1_idx` (`qa_inspector_inspectorID` ASC) VISIBLE,
  INDEX `fk_project_has_qa_inspector_project1_idx` (`project_PID` ASC) VISIBLE,
  CONSTRAINT `fk_project_has_qa_inspector_project1`
    FOREIGN KEY (`project_PID`)
    REFERENCES `testing2`.`project` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_has_qa_inspector_qa_inspector1`
    FOREIGN KEY (`qa_inspector_inspectorID`)
    REFERENCES `testing2`.`qa_inspector` (`inspectorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`client_has_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`client_has_location` (
  `client_ClientID` INT NOT NULL,
  `location_locationID` INT NOT NULL,
  PRIMARY KEY (`client_ClientID`, `location_locationID`),
  INDEX `fk_client_has_location_location1_idx` (`location_locationID` ASC) VISIBLE,
  INDEX `fk_client_has_location_client1_idx` (`client_ClientID` ASC) VISIBLE,
  CONSTRAINT `fk_client_has_location_client1`
    FOREIGN KEY (`client_ClientID`)
    REFERENCES `testing2`.`client` (`ClientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_location_location1`
    FOREIGN KEY (`location_locationID`)
    REFERENCES `testing2`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`is_operated_by`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`is_operated_by` (
  `machinery_MachineryID` INT NOT NULL,
  `machine_operator_employee_EmployeeID` INT NOT NULL,
  `certificationDate` DATE NULL,
  PRIMARY KEY (`machinery_MachineryID`, `machine_operator_employee_EmployeeID`),
  INDEX `fk_machinery_has_machine_operator_machine_operator1_idx` (`machine_operator_employee_EmployeeID` ASC) VISIBLE,
  INDEX `fk_machinery_has_machine_operator_machinery1_idx` (`machinery_MachineryID` ASC) VISIBLE,
  CONSTRAINT `fk_machinery_has_machine_operator_machinery1`
    FOREIGN KEY (`machinery_MachineryID`)
    REFERENCES `testing2`.`machinery` (`MachineryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_machinery_has_machine_operator_machine_operator1`
    FOREIGN KEY (`machine_operator_employee_EmployeeID`)
    REFERENCES `testing2`.`machine_operator` (`employee_EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`meets_with`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`meets_with` (
  `employee_EmployeeID` INT NOT NULL,
  `client_ClientID` INT NOT NULL,
  PRIMARY KEY (`employee_EmployeeID`, `client_ClientID`),
  INDEX `fk_employee_has_client_client1_idx` (`client_ClientID` ASC) VISIBLE,
  INDEX `fk_employee_has_client_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_client_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_client_client1`
    FOREIGN KEY (`client_ClientID`)
    REFERENCES `testing2`.`client` (`ClientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`specialize_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`specialize_in` (
  `project_type_ProjectTypeName` VARCHAR(255) NOT NULL,
  `employee_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`project_type_ProjectTypeName`, `employee_EmployeeID`),
  INDEX `fk_project_type_has_employee_employee1_idx` (`employee_EmployeeID` ASC) VISIBLE,
  INDEX `fk_project_type_has_employee_project_type1_idx` (`project_type_ProjectTypeName` ASC) VISIBLE,
  CONSTRAINT `fk_project_type_has_employee_project_type1`
    FOREIGN KEY (`project_type_ProjectTypeName`)
    REFERENCES `testing2`.`project_type` (`ProjectTypeName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_type_has_employee_employee1`
    FOREIGN KEY (`employee_EmployeeID`)
    REFERENCES `testing2`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`provided_by`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`provided_by` (
  `supplier_SupplierID` INT NOT NULL,
  `material_MaterialID` INT NOT NULL,
  PRIMARY KEY (`supplier_SupplierID`, `material_MaterialID`),
  INDEX `fk_supplier_has_material1_material1_idx` (`material_MaterialID` ASC) VISIBLE,
  INDEX `fk_supplier_has_material1_supplier1_idx` (`supplier_SupplierID` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_has_material1_supplier1`
    FOREIGN KEY (`supplier_SupplierID`)
    REFERENCES `testing2`.`supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supplier_has_material1_material1`
    FOREIGN KEY (`material_MaterialID`)
    REFERENCES `testing2`.`material` (`MaterialID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `testing2`.`location_of_ads`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testing2`.`location_of_ads` (
  `Advertisement_adID` INT NOT NULL,
  `location_locationID` INT NOT NULL,
  PRIMARY KEY (`Advertisement_adID`, `location_locationID`),
  INDEX `fk_Advertisement_has_location_location1_idx` (`location_locationID` ASC) VISIBLE,
  INDEX `fk_Advertisement_has_location_Advertisement1_idx` (`Advertisement_adID` ASC) VISIBLE,
  CONSTRAINT `fk_Advertisement_has_location_Advertisement1`
    FOREIGN KEY (`Advertisement_adID`)
    REFERENCES `testing2`.`Advertisement` (`adID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Advertisement_has_location_location1`
    FOREIGN KEY (`location_locationID`)
    REFERENCES `testing2`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;