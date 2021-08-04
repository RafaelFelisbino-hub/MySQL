CREATE DATABASE atividade15;

USE atividade15;

CREATE TABLE itens_de_venda (
	cod_venda INT,
    cod_produto INT,
    qtd_item INT,
    valor_item FLOAT,
    PRIMARY KEY(cod_venda, cod_produto)
);

INSERT INTO itens_de_venda 
(cod_venda, cod_produto, qtd_item, valor_item) VALUES 
(1, 1, 1, 790.50),
(2, 2, 5, 10.00),
(3, 3, 1, 225.99),
(4, 4, 1, 10.00),
(5, 5, 2, 10.00);

SELECT * FROM itens_de_venda;

DELIMITER //
-- Saber o valor total de um item (qtd * valor)
CREATE FUNCTION valorTotalItens(cod INT)
RETURNS VARCHAR(55) 
BEGIN
DECLARE quantidade, valor, res FLOAT;
SET res = 0, quantidade = 0, valor = 0;
SELECT qtd_item INTO quantidade FROM itens_de_venda WHERE cod = itens_de_venda.cod_produto;
SELECT valor_item INTO valor FROM itens_de_venda WHERE cod = itens_de_venda.cod_produto;
SET res = res + (valor * quantidade);
RETURN 
    (select res FROM itens_de_venda WHERE cod = itens_de_venda.cod_produto);
END; //
DELIMITER ;

SELECT valorTotalItens(1);

-- Alterar o valor de um item
DELIMITER //
CREATE PROCEDURE updateValor (cod INT,valor FLOAT)
BEGIN
	UPDATE itens_de_venda SET valor_item = valor WHERE cod = cod_venda;
END; //
DELIMITER ;

CALL updateValor(4,20);

SELECT * FROM itens_de_venda;