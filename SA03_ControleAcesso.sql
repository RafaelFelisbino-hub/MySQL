CREATE DATABASE servicos_gerais_ltda;

USE servicos_gerais_ltda;

CREATE TABLE diretor (
	id_diretor INT AUTO_INCREMENT,
    nome_diretor VARCHAR(20),
    PRIMARY KEY(id_diretor)
);

INSERT INTO diretor (nome_diretor) VALUES ("Luffy");

CREATE TABLE gerencia (
	id_gerente INT AUTO_INCREMENT,
    nome_gerente VARCHAR(20),
    diretor_id_diretor INT,
    PRIMARY KEY (id_gerente),
	FOREIGN KEY (diretor_id_diretor) REFERENCES diretor (id_diretor)
);

INSERT INTO gerencia (diretor_id_diretor, nome_gerente) VALUES 
(1, "Roronoa Zoro"),
(1, "Nami"),
(1, "Sanji");

CREATE TABLE departamento (
	id_departamento INT AUTO_INCREMENT,
    nome_departamento VARCHAR(20),
    gerencia_id_gerente INT,
    PRIMARY KEY (id_departamento),
    FOREIGN KEY (gerencia_id_gerente) REFERENCES gerencia (id_gerente)
);

INSERT INTO departamento (gerencia_id_gerente, nome_departamento) VALUES 
(1, "Administração"),
(2, "Finanças"),
(3, "Produção");

CREATE TABLE funcionarios (
	id_funcionario INT AUTO_INCREMENT,
    nome_funcionario VARCHAR(15),
    cargo VARCHAR(20),
    telefone VARCHAR(15),
    departamento_id_departamento INT,
    gerencia_id_gerente INT,
    PRIMARY KEY (id_funcionario),
    FOREIGN KEY (departamento_id_departamento) REFERENCES departamento (id_departamento),
    FOREIGN KEY (gerencia_id_gerente) REFERENCES gerencia (id_gerente)
);

INSERT INTO funcionarios (departamento_id_departamento, gerencia_id_gerente, nome_funcionario, cargo, telefone) VALUES 
(1, 1, "Usopp", "Comprador", "(31) 98062-3075"),
(1, 1, "Brook", "Logística", "(31) 92818-1541"),
(3, 3, "Tama", "Operário", "(31) 90333-9479"),
(3, 3, "Mr.7", "Operário", "(31) 91098-4685"),
(2, 2, "Donquixote", "Analista Financeiro", "(31) 92303-1959");

CREATE TABLE registro_ponto (
	id_registro INT AUTO_INCREMENT,
    horario_chegada DATETIME,
    horario_saida_almoco DATETIME,
    horario_retorno_almoco DATETIME,
    horario_saida DATETIME,
    funcionarios_id_funcionario INT,
    gerencia_id_gerente INT,
    diretor_id_diretor INT,
    PRIMARY KEY (id_registro),
    FOREIGN KEY (funcionarios_id_funcionario) REFERENCES funcionarios (id_funcionario),
    FOREIGN KEY (gerencia_id_gerente) REFERENCES gerencia (id_gerente),
    FOREIGN KEY (diretor_id_diretor) REFERENCES diretor (id_diretor)
);

INSERT INTO registro_ponto 
(funcionarios_id_funcionario, horario_chegada, horario_saida_almoco, horario_retorno_almoco, horario_saida) VALUES 
(1, "2021/07/26 08:00:00", "2021/07/26 12:00:00", "2021/07/26 13:00:00", "2021/07/26 17:00:00"),
(2, "2021/07/26 08:00:00", "2021/07/26 12:00:00", "2021/07/26 13:00:00", "2021/07/26 17:00:00"),
(3, "2021/07/26 07:00:00", "2021/07/26 11:30:00", "2021/07/26 12:30:00", "2021/07/26 16:00:00"),
(4, "2021/07/26 07:00:00", "2021/07/26 11:30:00", "2021/07/26 12:30:00", "2021/07/26 16:00:00"),
(5, "2021/07/26 08:00:00", "2021/07/26 12:00:00", "2021/07/26 13:00:00", "2021/07/26 17:00:00");

INSERT INTO registro_ponto 
(gerencia_id_gerente, horario_chegada, horario_saida_almoco, horario_retorno_almoco, horario_saida) VALUES 
(1, "2021/07/26 09:00:00", "2021/07/26 13:00:00", "2021/07/26 14:00:00", "2021/07/26 18:00:00"),
(2,	"2021/07/26 09:00:00", "2021/07/26 13:00:00", "2021/07/26 14:00:00", "2021/07/26 18:00:00"),
(3, "2021/07/26 09:00:00", "2021/07/26 13:00:00", "2021/07/26 14:00:00", "2021/07/26 18:00:00");

INSERT INTO registro_ponto 
(diretor_id_diretor, horario_chegada, horario_saida_almoco, horario_retorno_almoco, horario_saida) VALUES 
(1, "2021/07/26 09:00:00", "2021/07/26 13:00:00", "2021/07/26 14:00:00", "2021/07/26 18:00:00");

-- CONSULTAR PONTO DE FUNCIONÁRIOS
SELECT id_funcionario, nome_funcionario, horario_chegada, horario_saida_almoco, horario_retorno_almoco, horario_saida
FROM registro_ponto
INNER JOIN funcionarios ON registro_ponto.funcionarios_id_funcionario = funcionarios.id_funcionario;

-- CONSULTAR PONTO DE GERENTES
SELECT id_gerente, nome_gerente, horario_chegada, horario_saida_almoco, horario_retorno_almoco, horario_saida
FROM registro_ponto
INNER JOIN gerencia ON registro_ponto.gerencia_id_gerente = gerencia.id_gerente;

-- CONSULTAR PONTO DO DIRETOR
SELECT id_diretor, nome_diretor, horario_chegada, horario_saida_almoco, horario_retorno_almoco, horario_saida
FROM registro_ponto
INNER JOIN diretor ON registro_ponto.diretor_id_diretor = diretor.id_diretor;

-- CONSULTAR QUAL FUNCIONARIO TRABALHA EM QUAL DEPARTAMENTO E POSSUI QUAL GERENTE
SELECT nome_funcionario AS Funcionário, nome_departamento AS Departamento, nome_gerente AS Gerente
FROM funcionarios
INNER JOIN departamento ON funcionarios.departamento_id_departamento = departamento.id_departamento
INNER JOIN gerencia ON funcionarios.gerencia_id_gerente = gerencia.id_gerente
WHERE nome_funcionario LIKE "%Usopp%";

-- CRIAÇÃO DE ROLES, USUÁRIOS E ATRIBUIÇÃO DE PERMISSÕES

-- CRIAÇÃO DO USUÁRIO DBA
CREATE USER 'rafael'@'localhost' IDENTIFIED BY '123';
GRANT ALL ON servicos_gerais_ltda.* TO 'rafael'@'localhost' WITH GRANT OPTION;

-- CRIAÇÃO DO USUÁRIO DO DIRETOR
CREATE USER 'luffy'@'localhost' IDENTIFIED BY '654';

-- CRIAÇÃO DOS USUÁRIOS DA GERÊNCIA
CREATE USER 'zoro'@'localhost' IDENTIFIED BY "321";
CREATE USER 'nami'@'localhost' IDENTIFIED BY "213";
CREATE USER 'sanji'@'localhost' IDENTIFIED BY "421";

-- CRIAÇÃO DOS USUÁRIOS DE FUNCIONÁRIOS
CREATE USER 'usopp'@'localhost' IDENTIFIED BY "852";
CREATE USER 'brook'@'localhost' IDENTIFIED BY "741";
CREATE USER 'tama'@'localhost' IDENTIFIED BY "963";
CREATE USER 'mr7'@'localhost' IDENTIFIED BY "456";
CREATE USER 'donquixote'@'localhost' IDENTIFIED BY "789";


-- AO LOGAR NA CONTA COM ROLE DIGITAR 'SET DEFAULT ROLE nome_role OU SET ROLE nome_role'
-- NO ROOT = SET DEFAULT ROLE nome_role FOR nome_usuario;
-- CRIAÇÃO DE ROLE DO DIRETOR E ATRIBUIÇÃO
CREATE ROLE 'role_diretor';
GRANT SELECT, INSERT, UPDATE, DELETE ON servicos_gerais_ltda.* TO 'role_diretor';
GRANT 'role_diretor' TO 'luffy'@'localhost';
SET DEFAULT ROLE role_diretor FOR 'luffy'@'localhost'; -- Sinal de erro, mas é funcional e é a sintaxe correta de acordo com o MariaDB
SHOW GRANTS FOR 'role_diretor';
SHOW GRANTS FOR 'luffy'@'localhost';

-- CRIAÇÃO DE ROLE DA GERÊNCIA E ATRIBUIÇÃO
CREATE ROLE 'role_gerencia';
GRANT 'role_gerencia' TO 'zoro'@'localhost', 'nami'@'localhost', 'sanji'@'localhost';
GRANT SELECT, INSERT, UPDATE ON servicos_gerais_ltda.registro_ponto TO 'role_gerencia';
SHOW GRANTS FOR 'role_gerencia';
SET DEFAULT ROLE role_gerencia FOR 'zoro'@'localhost';
SET DEFAULT ROLE role_gerencia FOR 'nami'@'localhost';
SET DEFAULT ROLE role_gerencia FOR 'sanji'@'localhost';

-- CRIAÇÃO DE ROLE PARA FUNCIONÁRIOS E ATRIBUIÇÃO
CREATE ROLE 'role_funcionarios';
GRANT 'role_funcionarios' TO
'usopp'@'localhost',
'brook'@'localhost',
'tama'@'localhost',
'mr7'@'localhost',
'donquixote'@'localhost';
GRANT SELECT ON servicos_gerais_ltda.registro_ponto TO 'role_funcionarios';
SET DEFAULT ROLE role_funcionarios FOR 'usopp'@'localhost';
SET DEFAULT ROLE role_funcionarios FOR 'brook'@'localhost';
SET DEFAULT ROLE role_funcionarios FOR 'tama'@'localhost';
SET DEFAULT ROLE role_funcionarios FOR 'mr7'@'localhost';
SET DEFAULT ROLE role_funcionarios FOR 'donquixote'@'localhost';
SHOW GRANTS FOR 'role_funcionarios';

FLUSH PRIVILEGES;

select user, host from mysql.user;