CREATE DATABASE MinhaVida_db;
USE MinhaVida_db;

CREATE TABLE pacientes(
	cod_paciente INT(5) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50),
    endereco VARCHAR(50),
    bairro VARCHAR(40),
    cidade VARCHAR(40),
    estado CHAR(2),
    cep CHAR(9),
    data_nascimento DATE
);

-- Cadastrar 10 Pacientes preenchendo todos os campos.

INSERT INTO pacientes
(nome, endereco, bairro, cidade, estado, cep, data_nascimento) VALUES
("Rafael", "Rua A", "Alípio de Melo", "Belo Horizonte", "MG", "71536-321", STR_TO_DATE("01-02-1974", "%d-%m-%Y")),
("Rafaela", "Rua B", "Castelo", "Contagem", "MG", "75522-478", STR_TO_DATE("03-05-1975", "%d-%m-%Y")),
("Luiz", "Rua C", "Piratininga", "Belo Horizonte", "MG", "59075-979", STR_TO_DATE("13-08-1972", "%d-%m-%Y")),
("Luiza", "Rua D", "Tupi", "Belo Horizonte", "MG", "79823-680", STR_TO_DATE("28-02-1996", "%d-%m-%Y")),
("Maria", "Rua E", "Lindeia", "Contagem", "MG", "13453-042", STR_TO_DATE("16-02-2002", "%d-%m-%Y")),
("Carlos", "Rua F", "Bom Retiro", "São Paulo", "SP", "77500-970", STR_TO_DATE("19-11-1995", "%d-%m-%Y")),
("Paulo", "Rua G", "Vila Formosa", "São Paulo", "SP", "91787-779", STR_TO_DATE("29-07-1991", "%d-%m-%Y")),
("Paula", "Rua H", "Aricanduva", "São Paulo", "SP", "64002-275", STR_TO_DATE("12-05-1984", "%d-%m-%Y")),
("Katia", "Rua I", "Campo Limpo", "São Paulo", "SP", "29164-023", STR_TO_DATE("21-04-1962", "%d-%m-%Y")),
("Marcos", "Rua J", "Vila Andrade", "São Paulo", "SP", "25925-310", STR_TO_DATE("07-01-2000", "%d-%m-%Y"));

-- Fazer uma consulta para mostrar todos os pacientes de MG.

SELECT * FROM pacientes WHERE estado = 'MG';

-- Fazer uma consulta para mostrar todos os pacientes de SP.

SELECT * FROM pacientes WHERE estado = 'SP';

-- Fazer uma consulta para mostrar todos os pacientes com a inicial do nome P.

SELECT * FROM pacientes WHERE nome LIKE 'p%';

-- Fazer uma consulta para mostrar todos os pacientes da cidade de contagem e estado de MG.

SELECT * FROM pacientes WHERE estado = 'MG' AND cidade = 'Contagem';

-- Fazer uma consulta para mostrar todos os pacientes que nasceram antes de 20/01/1976.

SELECT * FROM pacientes WHERE data_nascimento < STR_TO_DATE("20-01-1976", "%d-%m-%Y"); -- alterado para DT_NASC

-- Alterar o nome do campo Data de Nascimento para DT_NASC.

ALTER TABLE pacientes CHANGE data_nascimento DT_NASC DATE;

-- Excluir todos os registros de pacientes do estado de SP.

DELETE FROM pacientes WHERE estado = 'SP'; -- COMANDO NÃO EXECUTADO

SELECT * FROM pacientes;