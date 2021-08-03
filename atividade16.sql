CREATE DATABASE atividade16;
USE atividade16;

CREATE TABLE peso_pessoa (
    observacao VARCHAR(45)
);

CREATE TABLE papel (
	observacao VARCHAR(80)
);

-- Saber o peso de acordo com o IMC
DELIMITER //
CREATE FUNCTION fn_calculo_imc (peso DECIMAL(4,1), altura DECIMAL(3,2))
RETURNS DECIMAL(4,1)
BEGIN
	DECLARE imc DECIMAL(4,1);
    SET imc = 0;
    SET imc = peso / (altura * altura);
    RETURN imc;
END; //
DELIMITER ;

SELECT fn_calculo_imc(70,1.74) AS Seu_peso_IMC;

-- Saber em qual faixa se encaixa seu peso IMC
DELIMITER //
CREATE FUNCTION fn_calculo_peso_ideal_imc (valor_peso DECIMAL(4,1))
RETURNS VARCHAR(45)
BEGIN
	IF(valor_peso < 18.5) THEN 
		UPDATE peso_pessoa SET observacao = 'Abaixo do peso';
    ELSEIF (valor_peso >= 18.5 AND valor_peso < 25) THEN
		UPDATE peso_pessoa SET observacao = 'Peso normal';
	ELSEIF (valor_peso >= 24 AND valor_peso < 30) THEN
		UPDATE peso_pessoa SET observacao = 'Sobrepeso';
	ELSEIF (valor_peso >= 29 AND valor_peso < 35) THEN
		UPDATE peso_pessoa SET observacao = 'Obesidade Grau 1';
	ELSEIF (valor_peso >= 35 AND valor_peso < 40) THEN
		UPDATE peso_pessoa SET observacao = 'Obesidade Grau 2';
	ELSE
		UPDATE peso_pessoa SET observacao = 'Obesidade Grau 3';
    END IF;
    RETURN (SELECT observacao FROM peso_pessoa);
END; //
DELIMITER ;
SELECT fn_calculo_peso_ideal_imc(39) AS Resultado;

-- Saber o equivalente em tamanho ou largura de acordo com o número de dobras em um papel (1-10)
DELIMITER //
CREATE FUNCTION fn_dobra_papel (num_dobras INT)
RETURNS VARCHAR(80)
BEGIN
	CASE
		WHEN num_dobras = 1  THEN
        UPDATE papel SET observacao = 'Seu papel possui 0.2mm de altura, da espessura do cabelo humano';
		WHEN num_dobras = 2 THEN
        UPDATE papel SET observacao = 'Seu papel possui 0.4mm de altura, da largura de um grão de areia';
        WHEN num_dobras = 3 THEN
        UPDATE papel SET observacao = 'Seu papel possui 0.8mm de altura, da largura da ponta de um lápis';
		WHEN num_dobras = 4 THEN
        UPDATE papel SET observacao = 'Seu papel possui 1.6mm de altura, da espessura de um espaguete';
        WHEN num_dobras = 5 THEN
        UPDATE papel SET observacao = 'Seu papel possui 3.2mm de altura, da altura de uma joaninha';
        WHEN num_dobras = 6 THEN
        UPDATE papel SET observacao = 'Seu papel possui 6.4mm de altura, da espessura de um grão de girassol';
        WHEN num_dobras = 7 THEN
        UPDATE papel SET observacao = 'Seu papel possui 12.8mm de altura, da largura de um grão de café';
        WHEN num_dobras = 8 THEN
        UPDATE papel SET observacao = 'Seu papel possui 25.6mm de altura, da largura de uma moeda';
		WHEN num_dobras = 9 THEN
        UPDATE papel SET observacao = 'Seu papel possui 51.2mm de altura, da altura de um ovo';
        WHEN num_dobras = 10 THEN
        UPDATE papel SET observacao = 'Seu papel possui 10.2cm de altura, da altura de um beija flor';
    END CASE;
    RETURN (SELECT observacao FROM papel);
END; //
DELIMITER ;

SELECT fn_dobra_papel(10) AS Resultado;

CREATE TABLE carros (
	id_carro INT AUTO_INCREMENT PRIMARY KEY,
    nome_carro VARCHAR(45),
    quantidade INT,
    fk_carro INT,
    FOREIGN KEY(fk_carro) REFERENCES carros (id_carro)
);

CREATE TABLE venda_carro (
	id_venda INT AUTO_INCREMENT PRIMARY KEY,
    nome_carro VARCHAR(45),
    quantidade INT
);

-- Atualizar a quantidade de um carro
DELIMITER //
CREATE TRIGGER tr_qtd_carro AFTER INSERT
ON venda_carro
FOR EACH ROW
BEGIN
	UPDATE carros SET quantidade = quantidade - NEW.quantidade
    WHERE NEW.nome_carro = carros.nome_carro;
END; //
DELIMITER ;

SELECT * FROM carros;
SELECT * FROM venda_carro;

INSERT INTO venda_carro VALUES (DEFAULT, "Ford Ka", 2);





