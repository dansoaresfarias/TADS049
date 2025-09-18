-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PousaBeiraMar
-- -----------------------------------------------------
-- Porjeto de banco de dados para o ensino da disciplina de Banco de Dados: DDL e DML.

-- -----------------------------------------------------
-- Schema PousaBeiraMar
--
-- Porjeto de banco de dados para o ensino da disciplina de Banco de Dados: DDL e DML.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PousaBeiraMar` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `PousaBeiraMar` ;

-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Funcionario` (
  `CPF` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `nomeSocial` VARCHAR(45) NULL,
  `dataNasc` DATE NOT NULL,
  `genero` VARCHAR(25) NOT NULL,
  `estadoCivil` VARCHAR(25) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `carteiraTrab` VARCHAR(45) NOT NULL,
  `cargaHoraria` INT UNSIGNED NOT NULL,
  `salario` DECIMAL(7,2) ZEROFILL UNSIGNED NOT NULL,
  `chavePIX` VARCHAR(45) NOT NULL,
  `status` TINYINT NOT NULL,
  `fg` DECIMAL(6,2) NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `carteiraTrab_UNIQUE` (`carteiraTrab` ASC) VISIBLE,
  UNIQUE INDEX `chavePIX_UNIQUE` (`chavePIX` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Endereco` (
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  `UF` CHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `comp` VARCHAR(45) NULL,
  `cep` VARCHAR(9) NOT NULL,
  INDEX `fk_Endereco_Fucnionario_idx` (`Funcionario_CPF` ASC) VISIBLE,
  PRIMARY KEY (`Funcionario_CPF`),
  CONSTRAINT `fk_Endereco_Fucnionario`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaBeiraMar`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Telefone` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(15) NOT NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  INDEX `fk_Telefone_Fucnionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  PRIMARY KEY (`idTelefone`),
  CONSTRAINT `fk_Telefone_Fucnionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaBeiraMar`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Dependente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Dependente` (
  `CPF` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `parentesco` VARCHAR(15) NOT NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_Dependente_Fucnionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Dependente_Fucnionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaBeiraMar`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`OcorrenciaInterna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`OcorrenciaInterna` (
  `idOcorrenciaInterna` INT NOT NULL AUTO_INCREMENT,
  `gravidade` VARCHAR(15) NOT NULL,
  `dataHora` DATETIME NOT NULL,
  `descricao` VARCHAR(250) NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idOcorrenciaInterna`),
  INDEX `fk_OcorrenciaInterna_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_OcorrenciaInterna_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaBeiraMar`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`RegistroPonto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`RegistroPonto` (
  `idRegistroPonto` INT NOT NULL AUTO_INCREMENT,
  `dataHora` DATETIME NOT NULL,
  `tipoES` VARCHAR(15) NOT NULL,
  `justificativa` VARCHAR(250) NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idRegistroPonto`),
  INDEX `fk_RegistroPonto_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_RegistroPonto_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaBeiraMar`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Ferias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Ferias` (
  `idFerias` INT NOT NULL AUTO_INCREMENT,
  `anoRef` INT NOT NULL,
  `dataInicio` DATE NOT NULL,
  `qtdDias` INT NOT NULL,
  `valor` DECIMAL(6,2) UNSIGNED ZEROFILL NOT NULL,
  `status` VARCHAR(25) NOT NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idFerias`),
  INDEX `fk_Ferias_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Ferias_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaBeiraMar`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `local` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(250) NULL,
  `Gerente_CPF` VARCHAR(14) NULL,
  PRIMARY KEY (`idDepartamento`),
  INDEX `fk_Departamento_Funcionario1_idx` (`Gerente_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_Funcionario1`
    FOREIGN KEY (`Gerente_CPF`)
    REFERENCES `PousaBeiraMar`.`Funcionario` (`CPF`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Cargo` (
  `CBO` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `faixaSalarial` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CBO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Trabalhar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Trabalhar` (
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  `Departamento_idDepartamento` INT NOT NULL,
  `Cargo_CBO` INT NOT NULL,
  `dataInicio` DATETIME NOT NULL,
  `dataFim` DATETIME NULL,
  PRIMARY KEY (`Funcionario_CPF`, `Departamento_idDepartamento`, `Cargo_CBO`),
  INDEX `fk_Funcionario_has_Departamento_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  INDEX `fk_Funcionario_has_Departamento_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  INDEX `fk_Trabalhar_Cargo1_idx` (`Cargo_CBO` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_has_Departamento_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaBeiraMar`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Funcionario_has_Departamento_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `PousaBeiraMar`.`Departamento` (`idDepartamento`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabalhar_Cargo1`
    FOREIGN KEY (`Cargo_CBO`)
    REFERENCES `PousaBeiraMar`.`Cargo` (`CBO`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Hospede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Hospede` (
  `docIdentificacao` VARCHAR(25) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(25) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `telefone` VARCHAR(15) NULL,
  `email` VARCHAR(45) NULL,
  `Responsavel_docIdentificacao` VARCHAR(25) NULL,
  PRIMARY KEY (`docIdentificacao`),
  INDEX `fk_Hospede_Hospede1_idx` (`Responsavel_docIdentificacao` ASC) VISIBLE,
  CONSTRAINT `fk_Hospede_Hospede1`
    FOREIGN KEY (`Responsavel_docIdentificacao`)
    REFERENCES `PousaBeiraMar`.`Hospede` (`docIdentificacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Reserva` (
  `idReserva` INT NOT NULL AUTO_INCREMENT,
  `dataInicio` DATETIME NOT NULL,
  `dataFim` DATETIME NOT NULL,
  `qtdPessoas` INT NOT NULL,
  `status` VARCHAR(15) NOT NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  `Responsavel_docIdentificacao` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_Reserva_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  INDEX `fk_Reserva_Hospede1_idx` (`Responsavel_docIdentificacao` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaBeiraMar`.`Funcionario` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Reserva_Hospede1`
    FOREIGN KEY (`Responsavel_docIdentificacao`)
    REFERENCES `PousaBeiraMar`.`Hospede` (`docIdentificacao`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`TipoUH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`TipoUH` (
  `idTipoUH` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idTipoUH`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`UH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`UH` (
  `idUH` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(25) NOT NULL,
  `local` VARCHAR(25) NOT NULL,
  `qtdPessoas` INT NOT NULL,
  `TipoUH_idTipoUH` INT NOT NULL,
  PRIMARY KEY (`idUH`),
  INDEX `fk_UH_TipoUH1_idx` (`TipoUH_idTipoUH` ASC) VISIBLE,
  CONSTRAINT `fk_UH_TipoUH1`
    FOREIGN KEY (`TipoUH_idTipoUH`)
    REFERENCES `PousaBeiraMar`.`TipoUH` (`idTipoUH`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`UH_Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`UH_Reserva` (
  `UH_idUH` INT NOT NULL,
  `Reserva_idReserva` INT NOT NULL,
  PRIMARY KEY (`UH_idUH`, `Reserva_idReserva`),
  INDEX `fk_UH_has_Reserva_Reserva1_idx` (`Reserva_idReserva` ASC) VISIBLE,
  INDEX `fk_UH_has_Reserva_UH1_idx` (`UH_idUH` ASC) VISIBLE,
  CONSTRAINT `fk_UH_has_Reserva_UH1`
    FOREIGN KEY (`UH_idUH`)
    REFERENCES `PousaBeiraMar`.`UH` (`idUH`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UH_has_Reserva_Reserva1`
    FOREIGN KEY (`Reserva_idReserva`)
    REFERENCES `PousaBeiraMar`.`Reserva` (`idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Hospedagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Hospedagem` (
  `Reserva_idReserva` INT NOT NULL,
  `checkIn` DATETIME NOT NULL,
  `chekOut` DATETIME NULL,
  `valorTotal` DECIMAL(7,2) ZEROFILL UNSIGNED NOT NULL,
  INDEX `fk_Hospedagem_Reserva1_idx` (`Reserva_idReserva` ASC) VISIBLE,
  PRIMARY KEY (`Reserva_idReserva`),
  CONSTRAINT `fk_Hospedagem_Reserva1`
    FOREIGN KEY (`Reserva_idReserva`)
    REFERENCES `PousaBeiraMar`.`Reserva` (`idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Hospedar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Hospedar` (
  `Hospedagem_Reserva_idReserva` INT NOT NULL,
  `Hospede_docIdentificacao` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Hospedagem_Reserva_idReserva`, `Hospede_docIdentificacao`),
  INDEX `fk_Hospedagem_has_Hospede_Hospede1_idx` (`Hospede_docIdentificacao` ASC) VISIBLE,
  INDEX `fk_Hospedagem_has_Hospede_Hospedagem1_idx` (`Hospedagem_Reserva_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_Hospedagem_has_Hospede_Hospedagem1`
    FOREIGN KEY (`Hospedagem_Reserva_idReserva`)
    REFERENCES `PousaBeiraMar`.`Hospedagem` (`Reserva_idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hospedagem_has_Hospede_Hospede1`
    FOREIGN KEY (`Hospede_docIdentificacao`)
    REFERENCES `PousaBeiraMar`.`Hospede` (`docIdentificacao`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `quantidade` INT NOT NULL,
  `valor` DECIMAL(5,2) UNSIGNED ZEROFILL NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`ItensHospedagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`ItensHospedagem` (
  `Hospedagem_Reserva_idReserva` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `qtd` INT NOT NULL,
  `valorUnd` DECIMAL(5,2) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`Hospedagem_Reserva_idReserva`, `Produto_idProduto`),
  INDEX `fk_Hospedagem_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Hospedagem_has_Produto_Hospedagem1_idx` (`Hospedagem_Reserva_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_Hospedagem_has_Produto_Hospedagem1`
    FOREIGN KEY (`Hospedagem_Reserva_idReserva`)
    REFERENCES `PousaBeiraMar`.`Hospedagem` (`Reserva_idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hospedagem_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `PousaBeiraMar`.`Produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`Ocorrencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`Ocorrencia` (
  `idOcorrencia` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `obs` VARCHAR(250) NULL,
  `valor` DECIMAL(7,2) UNSIGNED ZEROFILL NULL,
  `Hospedagem_Reserva_idReserva` INT NOT NULL,
  PRIMARY KEY (`idOcorrencia`),
  INDEX `fk_Ocorrencia_Hospedagem1_idx` (`Hospedagem_Reserva_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_Ocorrencia_Hospedagem1`
    FOREIGN KEY (`Hospedagem_Reserva_idReserva`)
    REFERENCES `PousaBeiraMar`.`Hospedagem` (`Reserva_idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaBeiraMar`.`FormaPag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaBeiraMar`.`FormaPag` (
  `idFormaPag` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(25) NOT NULL,
  `valorPago` DECIMAL(7,2) UNSIGNED ZEROFILL NOT NULL,
  `qtdParcelas` INT NULL,
  `Hospedagem_Reserva_idReserva` INT NOT NULL,
  PRIMARY KEY (`idFormaPag`),
  INDEX `fk_FormaPag_Hospedagem1_idx` (`Hospedagem_Reserva_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPag_Hospedagem1`
    FOREIGN KEY (`Hospedagem_Reserva_idReserva`)
    REFERENCES `PousaBeiraMar`.`Hospedagem` (`Reserva_idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
