CREATE DATABASE sevendetudo_db;

USE sevendetudo_db;

CREATE TABLE gerente (
	id_gerente INT AUTO_INCREMENT,
    nome_gerente VARCHAR(45),
    PRIMARY KEY(id_gerente)
);

INSERT INTO gerente VALUES (DEFAULT, "Rafael");

CREATE TABLE subgerente (
	id_subgerente INT AUTO_INCREMENT,
    nome_subgerente VARCHAR(45),
    gerente_id_gerente INT,
    PRIMARY KEY(id_subgerente),
    FOREIGN KEY(gerente_id_gerente) REFERENCES gerente (id_gerente) 
);

INSERT INTO subgerente VALUES (DEFAULT, "Luisa", 1);

CREATE TABLE fornecedor (
	id_fornecedor INT AUTO_INCREMENT,
    nome_fornecedor VARCHAR(45),
    subgerente_id_subgerente INT,
    PRIMARY KEY(id_fornecedor),
    FOREIGN KEY(subgerente_id_subgerente) REFERENCES subgerente (id_subgerente)
);

INSERT INTO fornecedor VALUES 
(DEFAULT, "Lapa alimentação", 1),
(DEFAULT, "Olinda ltda", 1);

CREATE TABLE compras (
	id_compra INT AUTO_INCREMENT,
    nome_produto VARCHAR(45),
    quantidade INT,
    valor_compra FLOAT,
    prazo_pagamento DATE,
    subgerente_id_subgerente INT,
    fornecedor_id_fornecedor INT,
    PRIMARY KEY(id_compra),
    FOREIGN KEY(subgerente_id_subgerente) REFERENCES subgerente (id_subgerente),
    FOREIGN KEY(fornecedor_id_fornecedor) REFERENCES fornecedor (id_fornecedor)
);

CREATE TABLE operario (
	id_operario INT AUTO_INCREMENT,
    nome_operario VARCHAR(45),
    gerente_id_gerente INT,
    PRIMARY KEY(id_operario),
    FOREIGN KEY(gerente_id_gerente) REFERENCES gerente (id_gerente) 
);

INSERT INTO operario VALUES 
(DEFAULT, "Maria", 1),
(DEFAULT, "Roberto", 1),
(DEFAULT, "Marcos", 1);

CREATE TABLE estoque (
	id_estoque INT AUTO_INCREMENT,
    nome_produto VARCHAR(45),
    quantidade INT,
    categoria_produto VARCHAR(45),
    valor_produto FLOAT,
    gerente_id_gerente INT,
    subgerente_id_subgerente INT,
    PRIMARY KEY(id_estoque),
    FOREIGN KEY(gerente_id_gerente) REFERENCES gerente (id_gerente),
    FOREIGN KEY(subgerente_id_subgerente) REFERENCES subgerente (id_subgerente)
);

INSERT INTO estoque VALUES
(DEFAULT, "Molho de tomate", 105, "Alimentação", 1.69, 1, 1),
(DEFAULT, "Detergente", 105, "Limpeza", 1.89, 1, 1),
(DEFAULT, "Leite condensado", 105, "Alimentação", 6.39, 1, 1),
(DEFAULT, "Lava roupas", 105, "Limpeza", 11.90, 1, 1),
(DEFAULT, "Creme de leite", 105, "Alimentação", 2.59, 1, 1);

CREATE TABLE caixa (
	id_caixa INT AUTO_INCREMENT,
    valor_caixa FLOAT,
    operario_id_operario INT,
    gerente_id_gerente INT,
    PRIMARY KEY(id_caixa),
    FOREIGN KEY (operario_id_operario) REFERENCES operario (id_operario),
    FOREIGN KEY(gerente_id_gerente) REFERENCES gerente (id_gerente)
);

INSERT INTO caixa VALUES
(DEFAULT, 920, 1, 1),
(DEFAULT, 875, 2, 1),
(DEFAULT, 657, 3, 1);

CREATE TABLE retirada_caixa (
	id_retirada_caixa INT AUTO_INCREMENT,
    valor_retirada FLOAT,
    caixa_id_caixa INT,
	gerente_id_gerente INT,
    PRIMARY KEY(id_retirada_caixa),
    FOREIGN KEY(caixa_id_caixa) REFERENCES caixa (id_caixa),
    FOREIGN KEY(gerente_id_gerente) REFERENCES gerente (id_gerente)
);

INSERT INTO retirada_caixa VALUES (DEFAULT, 0, 1, 1);

CREATE TABLE cupom_fiscal (
	id_cupom_fiscal INT AUTO_INCREMENT,
    data_venda DATE,
    produto_vendido VARCHAR(45),
    quantidade_venda INT,
    valor_pedido FLOAT,
    forma_pagamento VARCHAR(45),
    caixa_id_caixa INT,
    PRIMARY KEY(id_cupom_fiscal),
    FOREIGN KEY(caixa_id_caixa) REFERENCES caixa (id_caixa)
);
select * from cupom_fiscal;
INSERT INTO cupom_fiscal VALUES 
(DEFAULT, "2021/08/01", "Molho de tomate", 1, 1.69, "Dinheiro", 1),
(DEFAULT, "2021/08/01", "Detergentee", 2, 1.89, "Dinheiro", 2),
(DEFAULT, "2021/08/01", "Lava roupas", 2, 11.90, "Dinheiro", 3);

-- Consulta de todos os funcionários e para quem respondem:
CREATE VIEW vw_funcionarios AS 
SELECT nome_gerente AS Gerente, nome_subgerente AS Subgerente, nome_operario AS Operador_de_caixa
FROM gerente
INNER JOIN operario ON operario.gerente_id_gerente = gerente.id_gerente
INNER JOIN subgerente ON subgerente.gerente_id_gerente = gerente.id_gerente
WHERE id_gerente = 1;

SELECT * FROM vw_funcionarios;

-- Consulta de qual caixa vendeu quais produtos, o valor e método de pagamento:
CREATE VIEW caixa AS
SELECT operario_id_operario AS Operário, produto_vendido AS Produto, 
valor_pedido AS Valor_venda, forma_pagamento AS Pagamento
FROM caixa
INNER JOIN cupom_fiscal ON cupom_fiscal.caixa_id_caixa = caixa.id_caixa;

SELECT * FROM vw_caixa;

-- Consulta dos produtos em estoque:
CREATE VIEW vw_estoque AS
SELECT nome_produto AS Produto, quantidade AS Quantidade, categoria_produto AS Categoria,
valor_produto AS Valor_Unitário FROM estoque;

SELECT * FROM vw_estoque;

-- Consulta de qual operário trabalha em qual caixa:
CREATE VIEW vw_operario AS
SELECT nome_operario AS Operário, id_caixa AS Caixa
FROM caixa
INNER JOIN operario ON caixa.operario_id_operario = operario.id_operario;

SELECT * FROM vw_operario;

-- Consulta do valor no caixa e o valor retirado do caixa:
CREATE VIEW vw_valor_caixa AS
SELECT valor_caixa AS Valor_caixa, valor_retirada AS Valor_retirado, id_caixa
FROM retirada_caixa
RIGHT JOIN caixa ON retirada_caixa.caixa_id_caixa = caixa.id_caixa;

SELECT * FROM vw_valor_caixa;

-- Consulta das compras feitas pela subgerente e de qual fornecedor:
CREATE VIEW vw_compras AS
SELECT nome_subgerente AS Subgerente, nome_produto AS Produto, quantidade_compra AS Quantidade, valor_compra AS Valor, nome_fornecedor AS Fornecedor
FROM compras
INNER JOIN subgerente ON compras.subgerente_id_subgerente = subgerente.id_subgerente
INNER JOIN fornecedor ON fornecedor_id_fornecedor = fornecedor.id_fornecedor;

SELECT * FROM vw_compras;

-- Consultar o prazo de pagamento de compras realizadas:
CREATE VIEW vw_prazo_pagamento AS
SELECT prazo_pagamento AS Prazo, id_compra AS Número_compra, nome_subgerente AS Responsável
FROM compras
RIGHT JOIN subgerente ON compras.subgerente_id_subgerente = subgerente.id_subgerente;

SELECT * FROM vw_prazo_pagamento;

-- Consulta de um produto se seu estoque for menor que 100:
CREATE VIEW vw_situacao_estoque AS
SELECT nome_produto AS Produto, IF(quantidade < 100, "Em falta", "OK") AS Situação, quantidade AS Quantidade
FROM estoque;

SELECT * FROM vw_situacao_estoque;

-- Trigger para atualizar o valor retirado do caixa sempre que o caixa atingir R$ 1000
DELIMITER //
CREATE TRIGGER Att_valor_retirado BEFORE UPDATE
ON caixa
FOR EACH ROW
BEGIN
    IF(NEW.valor_caixa >= 1000) THEN
    SET NEW.valor_caixa = new.valor_caixa - 800;
    UPDATE retirada_caixa SET valor_retirada = valor_retirada + 800 WHERE retirada_caixa.caixa_id_caixa = NEW.id_caixa;
    END IF;
END; //

DELIMITER ;
UPDATE caixa SET valor_caixa = 900 WHERE id_caixa = 2;

-- Trigger para atualizar o estoque ao realizar uma compra
DELIMITER //
CREATE TRIGGER tr_quantidade_estoque AFTER INSERT
ON compras
FOR EACH ROW
BEGIN
	UPDATE estoque SET quantidade = quantidade + NEW.quantidade_compra
    WHERE NEW.nome_produto = estoque.nome_produto;
END; //
DELIMITER ;

INSERT INTO compras VALUES
(DEFAULT, "Molho de tomate", 4, "Alimentação", 6.76, "2021/08/15", 1, 1);

-- Trigger para atualizar o estoque ao realizar uma venda
DELIMITER //
CREATE TRIGGER tr_quantidade_estoque_venda AFTER INSERT
ON cupom_fiscal
FOR EACH ROW
BEGIN
	UPDATE estoque SET quantidade = quantidade - NEW.quantidade_venda
	WHERE NEW.produto_vendido = estoque.nome_produto;
END; //
DELIMITER ;

INSERT INTO cupom_fiscal VALUES 
(DEFAULT, "2021/08/01", "Molho de tomate", 3, 5.07, "Dinheiro", 1);

-- Roles, usuários e permissões
CREATE USER gerente@'localhost' IDENTIFIED BY '123';
GRANT ALL ON sevendetudo_db.* TO gerente@'localhost' WITH GRANT OPTION;

CREATE USER subgerente@'localhost' IDENTIFIED BY '123';
GRANT SELECT, INSERT, UPDATE, DELETE ON sevendetudo_db.* TO subgerente@'localhost';

CREATE USER caixa1@'localhost' IDENTIFIED BY '123';
CREATE USER caixa2@'localhost' IDENTIFIED BY '123';
CREATE USER caixa3@'localhost' IDENTIFIED BY '123';

CREATE ROLE operador_caixa;
GRANT SELECT, INSERT, UPDATE on sevendetudo_db.caixa TO operador_caixa;
GRANT operador_caixa TO caixa1@'localhost', caixa2@'localhost', caixa3@'localhost';
SET DEFAULT ROLE operador_caixa FOR caixa1@'localhost';
SET DEFAULT ROLE operador_caixa FOR caixa2@'localhost';
SET DEFAULT ROLE operador_caixa FOR caixa3@'localhost';

-- Função para entrada de caixa, entrada somente feita se o valor do caixa for 0
DELIMITER //
CREATE FUNCTION fn_entrada_caixa (valor FLOAT, id INT)
RETURNS FLOAT
BEGIN
	UPDATE caixa SET valor_caixa = IF(valor_caixa = 0, valor, valor_caixa) WHERE id = id_caixa;
RETURN (valor);
END; //
DELIMITER ;

select fn_entrada_caixa(200, 2) AS Valor_de_entrada;
SELECT * FROM caixa;