CREATE DATABASE atividade10;

USE atividade10;

CREATE TABLE mae (
	id_mae INT AUTO_INCREMENT,
    nome_mae VARCHAR(60),
    PRIMARY KEY (id_mae)
);

INSERT INTO mae 
(nome_mae) VALUES
("Maria"),
("Josefina"), 
("Karina");

CREATE TABLE filho (
	id_filho INT AUTO_INCREMENT,
    nome_filho VARCHAR(60),
    mae_id_mae INT,
    PRIMARY KEY (id_filho),
    FOREIGN KEY (mae_id_mae) REFERENCES mae (id_mae)
);

INSERT INTO filho 
(mae_id_mae, nome_filho) VALUES 
(1, "Rafael"),
(2, "Paula"),
(3, "Yumi");

-- Com o INNER JOIN, faça uma busca por todas as mães e seus respectivos filhos.
SELECT nome_mae AS Mãe ,nome_filho AS Filho
FROM mae
INNER JOIN filho ON filho.mae_id_mae = mae.id_mae;

--  Insira 2 mães.
INSERT INTO mae 
(nome_mae) VALUES 
("Carla"),
("Pamela");

-- Insira 4 filhos sem mães. 
INSERT INTO filho 
(mae_id_mae,nome_filho) VALUES 
(null,"Lucas"),
(null,"Kaka"),
(null,"Lulu"),
(null,"José");

--  Faça um LEFT JOIN nas duas tabelas
SELECT nome_mae AS Mãe ,nome_filho AS Filho
FROM mae
LEFT JOIN filho ON filho.mae_id_mae = mae.id_mae;

-- Faça um RIGHT JOIN nas duas tabelas. 
SELECT nome_mae AS Mãe ,nome_filho AS Filho
FROM mae
RIGHT JOIN filho ON filho.mae_id_mae = mae.id_mae;

SELECT * from filho;

-- Relacione os filhos às 2 mães novas, 2 filhos para cada mãe com o UPDATE.
UPDATE filho SET mae_id_mae = 4 WHERE nome_filho = "Lucas";
UPDATE filho SET mae_id_mae = 4 WHERE nome_filho = "Kaka";
UPDATE filho SET mae_id_mae = 5 WHERE nome_filho = "Lulu";
UPDATE filho SET mae_id_mae = 5 WHERE nome_filho = "José";