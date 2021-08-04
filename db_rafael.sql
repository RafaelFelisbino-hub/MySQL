CREATE DATABASE db_rafael;
USE db_rafael;

CREATE TABLE clinicas (
	id_clinica INT AUTO_INCREMENT,
    nome_clinica VARCHAR(30),
    endereco VARCHAR(30),
    telefone VARCHAR(15),
    PRIMARY KEY(id_clinica)
);

INSERT INTO clinicas 
(nome_clinica, endereco, telefone) VALUES 
("Guajajara", "Rua A", "(31) 75004-5807"),
("Bem Viver", "Rua B", "(31) 47130-2179");

CREATE TABLE funcionarios (
	id_funcionario INT AUTO_INCREMENT,
    nome_funcionario VARCHAR(30),
    cargo_funcionario VARCHAR(30),
    clinicas_id_clinica INT,
    PRIMARY KEY(id_funcionario),
    FOREIGN KEY (clinicas_id_clinica) REFERENCES clinicas (id_clinica)
);

INSERT INTO funcionarios 
(clinicas_id_clinica, nome_funcionario, cargo_funcionario) VALUES 
(1, "Rafael", "Atendente"),
(2, "Rafaela", "Gerente"),
(1, "Paula", "Médica");

CREATE TABLE cliente (
	id_cliente INT AUTO_INCREMENT,
    nome_cliente VARCHAR(30),
    telefone_cliente VARCHAR(15),
    tipo_de_atendimento VARCHAR(30),
	funcionarios_id_funcionario INT,
    clinicas_id_clinica INT,
    PRIMARY KEY(id_cliente),
    FOREIGN KEY (funcionarios_id_funcionario) REFERENCES funcionarios (id_funcionario),
    FOREIGN KEY (clinicas_id_clinica) REFERENCES clinicas (id_clinica)
);

INSERT INTO cliente 
(funcionarios_id_funcionario, clinicas_id_clinica, nome_cliente, telefone_cliente, tipo_de_atendimento) VALUES 
(1, 1, "Kaka", "(31) 70848-3054", "Consulta"),
(2, 2, "Lulu", "(31) 70848-4054", "Operação"),
(3, 1, "Juju", "(31) 70848-5054", "Consulta");

-- 1) Consultar quantos clientes possuem a primeira clinica
SELECT COUNT(id_cliente), nome_clinica
FROM cliente
INNER JOIN clinicas ON cliente.clinicas_id_clinica = clinicas.id_clinica
WHERE id_clinica = 1;

-- 2) Consultar quantos clientes possuem a segunda clinica
SELECT COUNT(id_cliente), nome_clinica
FROM cliente
INNER JOIN clinicas ON cliente.clinicas_id_clinica = clinicas.id_clinica
WHERE id_clinica = 2;
-- 3) Consultar somente o número máximo de clientes
SELECT COUNT(id_cliente) FROM cliente;

-- 4) Consultar a clinica que o funcionario Rafael ttrabalha
SELECT nome_clinica, nome_funcionario
FROM clinicas
INNER JOIN funcionarios ON funcionarios.clinicas_id_clinica = clinicas.id_clinica
WHERE nome_funcionario = "Rafael";

-- 5) Consultar a clinica que a funcionaria Rafaela trabalha
SELECT nome_clinica, nome_funcionario
FROM clinicas
INNER JOIN funcionarios ON funcionarios.clinicas_id_clinica = clinicas.id_clinica
WHERE nome_funcionario = "Rafaela";

-- 6) Trocar o cargo_funcionario de Rafael para Serviços Gerais
UPDATE funcionarios SET cargo_funcionario = "Serviços Gerais" WHERE nome_funcionario = "Rafael";

-- 7) Trocar o telefone da Lulu para (78) 37423-8475
UPDATE cliente SET telefone_cliente = "(78) 37423-8475" WHERE nome_cliente = "Lulu";

-- 8) Trocar o telefone do Kaka para (61) 80864-5676
UPDATE cliente SET telefone_cliente = "(61) 80864-5676" WHERE nome_cliente = "Kaka";

-- 9) Trocar o endereco da segunda clinica para Rua B
UPDATE clinicas SET endereco = "Rua B" WHERE id_clinica = 2;

-- 10) Consultar qual funcionario atendeu qual cliente e em qual clinica
SELECT nome_funcionario, nome_cliente, nome_clinica
FROM funcionarios
INNER JOIN cliente ON cliente.funcionarios_id_funcionario = funcionarios.id_funcionario
INNER JOIN clinicas ON cliente.clinicas_id_clinica = clinicas.id_clinica
WHERE nome_funcionario = "Paula";