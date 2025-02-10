
CREATE DATABASE lanchonete;
USE lanchonete;



CREATE TABLE  `lanchonete`.`lanchonete` (
  `id_lanchonete` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`id_lanchonete`));




CREATE TABLE `lanchonete`.`orgao_emissor_rg` (
  `id_orgao_emissor` INT NOT NULL AUTO_INCREMENT,
  `orgao_emissor_sigla` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_orgao_emissor`));



CREATE TABLE `lanchonete`.`funcionario` (
  `id_funcionario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(55) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `rg` VARCHAR(10) NOT NULL,
  `cargo_trabalho` ENUM('cozinheiro', 'garçom', 'barman') NOT NULL,
  `orgao_emissor_rg_id_orgao_emissor` INT NOT NULL,
  PRIMARY KEY (`id_funcionario`, `orgao_emissor_rg_id_orgao_emissor`),
  CONSTRAINT `fk_funcionario_orgao_emissor_rg1`
    FOREIGN KEY (`orgao_emissor_rg_id_orgao_emissor`)
    REFERENCES `lanchonete`.`orgao_emissor_rg` (`id_orgao_emissor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE  `lanchonete`.`mesa` (
  `id_mesa` INT NOT NULL AUTO_INCREMENT,
  `quantidade_lugares` INT NOT NULL,
  `mesa_fumante` ENUM('sim', 'não') NULL,
  `funcionario_id_funcionario` INT NOT NULL,
  PRIMARY KEY (`id_mesa`, `funcionario_id_funcionario`),
  CONSTRAINT `fk_mesa_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `lanchonete`.`funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE  `lanchonete`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `data_emissao` DATETIME NOT NULL,
  `mesa_id_mesa` INT NOT NULL,
  PRIMARY KEY (`id_pedido`, `mesa_id_mesa`),
  CONSTRAINT `fk_pedido_mesa1`
    FOREIGN KEY (`mesa_id_mesa`)
    REFERENCES `lanchonete`.`mesa` (`id_mesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE  `lanchonete`.`unidade_medida_produto` (
  `id_unidade_medida` INT NOT NULL AUTO_INCREMENT,
  `unidade_medida` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`id_unidade_medida`));



CREATE TABLE IF NOT EXISTS `lanchonete`.`produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(55) NOT NULL,
  `preco` FLOAT NOT NULL,
  `unidade_medida_produto_id_unidade_medida` INT NOT NULL,
  PRIMARY KEY (`id_produto`, `unidade_medida_produto_id_unidade_medida`),
  CONSTRAINT `fk_produto_unidade_medida_produto1`
    FOREIGN KEY (`unidade_medida_produto_id_unidade_medida`)
    REFERENCES `lanchonete`.`unidade_medida_produto` (`id_unidade_medida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




CREATE TABLE  `lanchonete`.`funcionario_lanchonete` (
  `lanchonete_id_lanchonete` INT NOT NULL,
  `funcionario_id_funcionario` INT NOT NULL,
  `turno_trabalho` ENUM('manha', 'noite', 'tarde') NOT NULL,
  `dia_semana` ENUM('terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sabado', 'domingo') NOT NULL,
  PRIMARY KEY (`lanchonete_id_lanchonete`, `funcionario_id_funcionario`, `turno_trabalho`, `dia_semana`),
  CONSTRAINT `fk_lanchonete_has_funcionario_lanchonete`
    FOREIGN KEY (`lanchonete_id_lanchonete`)
    REFERENCES `lanchonete`.`lanchonete` (`id_lanchonete`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lanchonete_has_funcionario_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `lanchonete`.`funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE  `lanchonete`.`produto_has_pedido` (
  `produto_id_produto` INT NOT NULL,
  `pedido_id_pedido` INT NOT NULL,
  `pedido_mesa_id_mesa` INT NOT NULL,
  PRIMARY KEY (`produto_id_produto`, `pedido_id_pedido`, `pedido_mesa_id_mesa`),
  CONSTRAINT `fk_produto_has_pedido_produto1`
    FOREIGN KEY (`produto_id_produto`)
    REFERENCES `lanchonete`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_pedido_pedido1`
    FOREIGN KEY (`pedido_id_pedido` , `pedido_mesa_id_mesa`)
    REFERENCES `lanchonete`.`pedido` (`id_pedido` , `mesa_id_mesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE  `lanchonete`.`telefone_funcionario` (
  `id_telefone` INT NOT NULL AUTO_INCREMENT,
  `telefone` VARCHAR(14) NOT NULL,
  `funcionario_id_funcionario` INT NOT NULL,
  PRIMARY KEY (`id_telefone`, `funcionario_id_funcionario`),
  CONSTRAINT `fk_telefone_funcionario_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `lanchonete`.`funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE  `lanchonete`.`estado` (
  `sigla_estado` VARCHAR(2) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sigla_estado`));


CREATE TABLE  `lanchonete`.`cidade` (
  `cep` VARCHAR(8) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `estado_sigla_estado` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`cep`, `estado_sigla_estado`),
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`estado_sigla_estado`)
    REFERENCES `lanchonete`.`estado` (`sigla_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE `lanchonete`.`endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade_cep` VARCHAR(8) NOT NULL,
  `funcionario_id_funcionario` INT NOT NULL,
  `lanchonete_id_lanchonete` INT NOT NULL,
  PRIMARY KEY (`id_endereco`, `cidade_cep`, `funcionario_id_funcionario`, `lanchonete_id_lanchonete`),
  CONSTRAINT `fk_endereco_cidade1`
    FOREIGN KEY (`cidade_cep`)
    REFERENCES `lanchonete`.`cidade` (`cep`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_funcionario1`
    FOREIGN KEY (`funcionario_id_funcionario`)
    REFERENCES `lanchonete`.`funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_lanchonete1`
    FOREIGN KEY (`lanchonete_id_lanchonete`)
    REFERENCES `lanchonete`.`lanchonete` (`id_lanchonete`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


