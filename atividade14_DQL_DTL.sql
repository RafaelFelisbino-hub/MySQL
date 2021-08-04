CREATE DATABASE detran_db;

USE detran_db;

CREATE TABLE condutor (
	id_condutor INT AUTO_INCREMENT,
    nome_condutor VARCHAR(15),
    registro_cnh BIGINT(15),
    PRIMARY KEY (id_condutor)
);

INSERT INTO condutor VALUES
(DEFAULT, "Rafael", 47056145803),
(DEFAULT, "Maria", 94696375302),
(DEFAULT, "Tomás", 94696375302),
(DEFAULT, "Paula", 68203244003);

CREATE TABLE veiculo (
	id_veiculo INT AUTO_INCREMENT,
    nome_veiculo VARCHAR(15),
    placa_veiculo CHAR(7),
    condutor_id_condutor INT,
    PRIMARY KEY (id_veiculo),
    FOREIGN KEY (condutor_id_condutor) REFERENCES condutor (id_condutor)
);

INSERT INTO veiculo VALUES
(DEFAULT, "Ford Ka", "HNG6639", 1),
(DEFAULT, "Fusca", "HNU8814", 2),
(DEFAULT, "Kombi", "GXB8547", 3),
(DEFAULT, "Brasilia", "GLL3036", 4);

CREATE TABLE autuacao (
	id_autuacao INT AUTO_INCREMENT,
    data_autuacao TIMESTAMP,
    situacao BOOLEAN,
    veiculo_id_veiculo INT,
    condutor_id_condutor INT,
    PRIMARY KEY (id_autuacao),
    FOREIGN KEY (veiculo_id_veiculo) REFERENCES veiculo (id_veiculo),
    FOREIGN KEY (condutor_id_condutor) REFERENCES condutor (id_condutor)
);

-- USUÁRIO RADAR
CREATE USER radar@'localhost' IDENTIFIED BY '123';
GRANT INSERT ON detran_db.autuacao TO radar@'localhost';

-- USUÁRIO CONDUTOR
CREATE USER condutor@'localhost' IDENTIFIED BY '123';
GRANT SELECT ON detran_db.autuacao TO condutor@'localhost';

-- USUÁRIO JURI
CREATE USER juri@'localhost' IDENTIFIED BY '123';
GRANT SELECT, UPDATE ON detran_db.* TO juri@'localhost';

START TRANSACTION;

-- Rafael na pressa para ir ao trabalho passou pelo radar de 60km/h à 80km/h
INSERT INTO autuacao VALUES
(DEFAULT, CURRENT_TIMESTAMP(), TRUE, 1, 1);

SAVEPOINT autuacao_rafael;

-- Maria indo levar a tia de carro para o hospital passou pelo radar de 60km/h à 90km/
INSERT INTO autuacao VALUES
(DEFAULT, CURRENT_TIMESTAMP(), TRUE, 2, 2);

SAVEPOINT autuacao_maria;

-- AÇÃO DO JURI

-- O júri bateu o martelo, Rafael foi realmente multado, fim de caso.
-- O júri entendo a situação de Maria, não persistiu com a multa:
UPDATE autuacao SET situacao = FALSE WHERE veiculo_id_veiculo = 2 AND condutor_id_condutor = 2;

-- Rafael descontente com a situação, xingou as pessoas do júri e perdeu a CNH:
UPDATE condutor SET registro_cnh = null WHERE id_condutor = 1;

COMMIT;

-- CONSULTA SITUAÇÃO DE MULTA
SELECT IF(situacao = 1, 'Multado','Sem multa') AS Situação, data_autuacao, placa_veiculo, nome_condutor, registro_cnh
FROM autuacao
INNER JOIN veiculo ON autuacao.veiculo_id_veiculo = veiculo.id_veiculo
INNER JOIN condutor ON autuacao.condutor_id_condutor = condutor.id_condutor
WHERE nome_condutor LIKE "%Maria%";