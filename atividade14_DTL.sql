CREATE DATABASE db_demonstracao_transaction;
USE db_demonstracao_transaction;

CREATE TABLE IF NOT EXISTS tbl_usuario (
	id_usuario INT(5) PRIMARY KEY AUTO_INCREMENT,
    nome_txt_usuario VARCHAR(50),
    login_txt_usuario VARCHAR(50),
    senha_txt_usuario CHAR(128),
    data_cadastro TIMESTAMP,
    status BOOLEAN
);

INSERT INTO tbl_usuario VALUES
( DEFAULT, "Rubem", "rubao", MD5(123456), CURRENT_TIMESTAMP(), TRUE),
( DEFAULT, "Camila", "pitanga", MD5(234567), CURRENT_TIMESTAMP(), TRUE),
( DEFAULT, "Ana", "arosio", MD5(345678), CURRENT_TIMESTAMP(), FALSE),
( DEFAULT, "Paula", "fernandinha", MD5(456789), CURRENT_TIMESTAMP(), TRUE),
( DEFAULT, "Luana", "piovani", MD5(567890), CURRENT_TIMESTAMP(), FALSE);

SELECT * FROM tbl_usuario;

BEGIN; 

DELETE FROM tbl_usuario 
WHERE id_usuario = 3;

ROLLBACK;

START TRANSACTION;
	UPDATE tbl_usuario 
	SET status = TRUE
    WHERE id_usuario = 5;

SAVEPOINT ativos;
	DELETE FROM tbl_usuario
    WHERE id_usuario = 3;
   
ROLLBACK TO ativos;

COMMIT;

START TRANSACTION;

INSERT INTO tbl_usuario VALUES
(DEFAULT, "Rafael", "fael", MD5(4565687), CURRENT_TIMESTAMP(), TRUE),
(DEFAULT, "Rafaela", "faela", MD5("874A2365"), CURRENT_TIMESTAMP(), TRUE);

ROLLBACK;

START TRANSACTION;

UPDATE tbl_usuario SET nome_txt_usuario = 'Kaka' WHERE nome_txt_usuario = 'Rafael';

SAVEPOINT reroll_name;

DELETE FROM tbl_usuario WHERE nome_txt_usuario = 'Kaka';

ROLLBACK TO reroll_name;

COMMIT;

START TRANSACTION;

UPDATE tbl_usuario SET status = 
	CASE
		WHEN status = 0 THEN 1
        ELSE status = 1
	END
WHERE status = 0;

COMMIT;