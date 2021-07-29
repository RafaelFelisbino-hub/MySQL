-- 1) Crie um banco de dados chamado SeuNomeSuaTurma.
CREATE DATABASE rafael_tii2001m;

-- 2) Use esse Banco de dados.
USE rafael_tii2001m;

-- 3) Crie as tabelas obedecendo o desenho acima, inclusive com as chaves primárias estrangeiras.
CREATE TABLE produto (
	cod_produto INT,
    nome_produto VARCHAR(45),
    qtd INT,
    valor FLOAT,
    PRIMARY KEY(cod_produto)
);

CREATE TABLE vendedor (
	registro INT,
    nome VARCHAR(45),
    sexo CHAR(1),
    PRIMARY KEY(registro)
);

CREATE TABLE vendas (
	cod_venda INT,
    data_venda DATE,
    valor_venda FLOAT,
    vendedor_registro INT,
    PRIMARY KEY(cod_venda),
    FOREIGN KEY (vendedor_registro) REFERENCES vendedor (registro)
);

CREATE TABLE itens_de_venda (
	cod_venda INT,
    cod_produto INT,
    qtd_item INT,
    valor_item FLOAT,
    vendas_cod_venda INT,
    produto_cod_produto INT,
    PRIMARY KEY(cod_venda, cod_produto),
    FOREIGN KEY (vendas_cod_venda) REFERENCES vendas (cod_venda),
    FOREIGN KEY (produto_cod_produto) REFERENCES produto (cod_produto)
);

-- 5) Faça o povoamento do banco, conforme as informações das tabelas acima.
INSERT INTO produto 
(cod_produto, nome_produto, qtd, valor) VALUES 
(10, "Mouse", 100, 10.00),
(11, "Office", 30, 790.50),
(12, "HD Externo", 80, 225.99),
(13, "Teclado", 100, 35.90);

INSERT INTO vendedor 
(registro, nome, sexo) VALUES 
(101, "Aldebaran Touro", "M"),
(102, "Carina Dias", "F"),
(103, "Paula Fernandes", "F"),
(104, "Seya", "M");

INSERT INTO vendas 
(cod_venda, vendedor_registro, data_venda, valor_venda) VALUES
(1001, 101, "2014/03/05",840.50),
(1002, 102, "2014/03/06",235.99),
(1003, 103, "2014/03/07",20.00);

INSERT INTO itens_de_venda 
(cod_venda, cod_produto, vendas_cod_venda, produto_cod_produto, qtd_item, valor_item) VALUES 
(1, 1, 1001, 11, 1, 790.50),
(2, 2, 1001, 10, 5, 10.00),
(3, 3, 1002, 12, 1, 225.99),
(4, 4, 1002, 10, 1, 10.00),
(5, 5, 1003, 10, 2, 10.00);

-- 6) Acrescentar na tabela vendedor uma coluna denominada loja varchar(50).
ALTER TABLE vendedor ADD loja varchar(50);

-- 7) Atribuir uma loja para cada funcionário cadastrado
UPDATE vendedor SET loja = "loja Centro" WHERE registro = 101;
UPDATE vendedor SET loja = "loja Santo Antônio" WHERE registro = 102;
UPDATE vendedor SET loja = "loja Cruzeiro" WHERE registro = 103;

-- 8) Incluir um novo produto com cod_produto =14; nome=”Mouse sem Fio” e valor do produto=R$ 49
INSERT INTO produto (cod_produto, nome_produto, valor) VALUES (14, "Mouse sem fio", 49);

-- 9) Criar na tabela vendedor um atributo chamado email e faça o povoamento do
-- mesmo seguindo a regra nome@praticabd.com.br; exemplo vendedor 102 ficaria
-- carina@praticabd.com.br
ALTER TABLE vendedor ADD email VARCHAR(45);
UPDATE vendedor SET email = "aldebaran@praticabd.com.br" WHERE registro = 101;
UPDATE vendedor SET email = "carina@praticabd.com.br" WHERE registro = 102;
UPDATE vendedor SET email = "paula@praticabd.com.br" WHERE registro = 103;
UPDATE vendedor SET email = "seya@praticabd.com.br" WHERE registro = 104;

-- 10) Gerar uma tabela de preços, com código do produto, nome do produto e valor do mesmo.
CREATE TABLE precos (
	cod_produto INT,
    nome_do_produto VARCHAR(45),
    valor FLOAT,
    produto_cod_produto INT,
    PRIMARY KEY (cod_produto),
    FOREIGN KEY (produto_cod_produto) REFERENCES produto (cod_produto)
);

-- 11) Aumentar em 10% todos os produtos de nossa empresa.
UPDATE produto SET valor = valor * 0.10 + valor;

-- 12) Insira mais dois vendedores na tabela vendedor de sua livre escolha.
INSERT INTO vendedor 
(registro, nome, sexo) values 
(105, "Rafael Silva", "M"),
(106, "Rafaela Silva", "F");

-- 13) Associe esses dois novos vendedores a loja centro.
UPDATE vendedor SET loja = "loja Centro" WHERE registro = 105;
UPDATE vendedor SET loja = "loja Centro" WHERE registro = 106;

-- 14) Listar o nome e matricula de todos os vendedores que trabalham na loja centro.
SELECT nome, registro FROM vendedor WHERE loja = "loja Centro";

-- 15) Listar o nome e matricula de todos os vendedores ordenados alfabeticamente.
SELECT nome, registro FROM vendedor ORDER BY nome;

-- 16) Listar o código, nome e quantidade de todos os produtos ordenados alfabeticamente.
SELECT cod_produto, nome_produto, qtd FROM produto ORDER BY nome_produto;

-- 17) Listar todas as vendas ordenados pelo valor da venda de forma decrescente.
SELECT valor_venda, data_venda, cod_venda, vendedor_registro FROM vendas ORDER BY valor_venda DESC;

-- 18) Listar o número de vendedores agrupados por sexo.
SELECT COUNT(registro) FROM vendedor WHERE sexo = "M";
SELECT COUNT(registro) FROM vendedor WHERE sexo = "F";

-- 19) Qual o produto mais caro?
SELECT nome_produto, valor FROM produto WHERE valor = (SELECT MAX(valor) FROM produto);

-- 20) Qual o produto mais barato?
SELECT nome_produto, valor FROM produto WHERE valor = (SELECT MIN(valor) FROM produto);

-- 21) Qual a média de preços dos produtos?
SELECT AVG(valor) FROM produto;

-- 22) Qual a quantidade de produtos que temos cadastrados? – Total de registros na tabela de produtos.
SELECT COUNT(cod_produto) FROM produto;

-- 23) Quais os produtos possuem seu preço superior a média de preços de nossa base.
SELECT nome_produto, valor FROM produto WHERE valor > (SELECT AVG(valor) FROM produto);

-- 24) Listar o nome dos produtos que nunca foram vendidos.
SELECT nome_produto, valor_item
FROM produto
LEFT JOIN itens_de_venda ON itens_de_venda.produto_cod_produto = produto.cod_produto
WHERE itens_de_venda.produto_cod_produto IS NULL;

-- 25) Listar o nome de todos os produtos que já foram vendidos.
SELECT nome_produto, valor_item
FROM produto
INNER JOIN itens_de_venda ON itens_de_venda.produto_cod_produto = produto.cod_produto
WHERE produto.cod_produto  is not null;

-- 26) Listar o nome de todos os vendedores que nunca realizam uma venda.
SELECT nome
FROM vendedor
LEFT JOIN vendas ON vendas.vendedor_registro = vendedor.registro
WHERE vendas.valor_venda IS NULL;

-- 27) Atualizar o nome do produto de código 11 para Office 2013 e seu valor para 579.00
UPDATE produto SET nome_produto = "Office 2013" WHERE cod_produto = 11;
UPDATE produto SET valor = 579.00 WHERE cod_produto = 11;

-- 28) Listar o nome do produto mais caro.
SELECT nome_produto, valor FROM produto WHERE valor = (SELECT MAX(valor) FROM produto);

-- 29) Listar o nome do produto mais barato.
SELECT nome_produto, valor FROM produto WHERE valor = (SELECT MIN(valor) FROM produto);

-- 30) Listar o nome de todos os produtos que tenham seu preço inferior à média de preços.
SELECT nome_produto, valor FROM produto WHERE valor < (SELECT AVG(valor) FROM produto);

-- 31) Listar o nome de todos os produtos que iniciam com a letra M.
SELECT nome_produto FROM produto WHERE nome_produto LIKE "m%";

-- 32) Listar o nome de todos os vendedores que tenha a palavra Dias em seu nome.
SELECT nome FROM vendedor WHERE nome LIKE "%Dias%";

-- 33) Exibir o total de venda da empresa.
SELECT SUM(valor_venda) FROM vendas;

-- 34) Exibir o total de vendas da empresa para o vendedor de matrícula 102.
SELECT nome, SUM(valor_venda)
FROM vendedor
INNER JOIN vendas ON vendas.vendedor_registro = vendedor.registro
WHERE vendedor.registro = 102;

-- 35) Exibir o total de vendas realizadas em um determinado período.
SELECT COUNT(valor_venda) FROM vendas WHERE data_venda >= "2014/03/05" AND data_venda <= "2014/03/07";

-- 36) Exiba o total de vendas realizadas no dia 05 de março de 2014.
SELECT COUNT(valor_venda) FROM vendas WHERE data_venda = "2014/03/05";

-- 37) Exiba os produtos vendidos no mês de março.
SELECT nome_produto, data_venda
FROM itens_de_venda
INNER JOIN produto ON itens_de_venda.produto_cod_produto = produto.cod_produto
INNER JOIN vendas ON itens_de_venda.vendas_cod_venda = vendas.cod_venda
WHERE MONTH("2014/03/05");

-- 38) Inserir uma nova venda com código 1004, valor total de 45.90 associada ao vendedor 101 no dia 10/05/2013.
INSERT INTO vendas (vendedor_registro, cod_venda, valor_venda, data_venda) VALUES (101, 1004, 45.90, "2013/05/10");

-- 39) Insira a venda feita pela vendedora Carina Dias de 01 teclado e 01 mouse. Observe
-- que para fazer isso é necessário inserir registros nas tabelas vendas e item de venda,
-- de modo que o valor da venda feche com o total de itens vendidos.
INSERT INTO vendas 
(vendedor_registro, cod_venda, data_venda, valor_venda) VALUES 
(102, 1005, "2014/05/03", 35.90),
(102, 1006, "2014/05/03", 10.00);

INSERT INTO itens_de_venda 
(vendas_cod_venda, produto_cod_produto, cod_venda, cod_produto, qtd_item, valor_item) VALUES 
(1005, 13, 6, 6, 1, 35.90),
(1006, 10, 7, 7, 1, 10.00);

-- 40) Listar o nome de todos os vendedores que realizaram alguma venda.
SELECT nome
FROM vendedor
INNER JOIN vendas ON vendas.vendedor_registro = vendedor.registro
WHERE valor_venda > 0;

-- 41) Listar o nome de todos os vendedores do sexo masculino que tenha a palavra Dias em seu nome
SELECT nome FROM vendedor WHERE sexo = "M" AND nome LIKE "%Dias%";

-- 42) Listar o nome de todos os produtos e a quantidade vendida para a venda de número 1001
SELECT nome_produto, qtd_item
FROM produto
INNER JOIN itens_de_venda ON itens_de_venda.produto_cod_produto = produto.cod_produto
WHERE vendas_cod_venda = 1001;

-- 43) Listar o nome e quantidade de todos os produtos vendidos na venda de número 1003
SELECT nome_produto, qtd_item
FROM produto
INNER JOIN itens_de_venda ON itens_de_venda.produto_cod_produto = produto.cod_produto
WHERE vendas_cod_venda = 1003;

-- 44) Listar o nome, matricula e sexo do vendedor responsável pela venda de número 1001
SELECT nome, sexo, registro, cod_venda
FROM vendedor
INNER JOIN vendas ON vendas.vendedor_registro = vendedor.registro
WHERE vendas.cod_venda = 1001;

-- 45) Insira um produto da sua escolha . Invente todos os dados
INSERT INTO produto 
(cod_produto, nome_produto, qtd, valor) VALUES 
(15, "SSD", 30, 350.00);

-- 46) Insira um vendedor da sua escolha . Invente todos os dados
INSERT INTO vendedor 
(registro, nome, sexo, loja, email) VALUES 
(107, "Luisa Pereira", "F", "loja Cruzeiro", "luiza@praticabd.com.br");

-- 47) Altere o nome do seu ultimo vendedor para Raimunda Souza, sexo feminino, email raiso@hotmail.com e loja cruzeiro
UPDATE vendedor SET nome = "Raimunda Souza" WHERE registro = 107;
UPDATE vendedor SET email = "raiso@hotmail.com" WHERE registro = 107;

-- 48) Insira uma venda da sua escolha . Invente todos os dados
INSERT INTO vendas 
(vendedor_registro, cod_venda, data_venda, valor_venda) VALUES 
(107, 1007, "2014/03/13", 350.00);

-- 49) Exclua a ultima venda cadastrada
DELETE FROM vendas WHERE cod_venda = 1007;

-- 50) Insira seus dados como sendo um vendedor da loja Santo Antônio
INSERT INTO vendedor 
(registro, nome, sexo, loja, email) VALUES 
(108, "Paulo Dias", "M", "loja Santo Antônio", "paulo@praticabd.com.br");

-- 51) Busque o nome de todos os vendedores que comecem com a letra do seu nome.
SELECT nome FROM vendedor WHERE nome LIKE "r%";

-- 52) Exiba na tela o nome de todos os vendedores que terminem com a primeira letra do seu nome
SELECT nome FROM vendedor WHERE nome LIKE "%r";

-- 53) Conte quantos vendedores do sexo masculino existem na base de dados
SELECT COUNT(registro) FROM vendedor WHERE sexo = "M";

-- 54) Exiba a quantidade de vendedores tem na loja Santo Antônio
SELECT COUNT(registro) FROM vendedor WHERE loja = "loja Santo Antônio";

-- 55) Insira os dados de um amigo como sendo da loja Santo Antônio e repita a consulta da questão anterior para testar
INSERT INTO vendedor 
(registro, nome, sexo, loja, email) VALUES 
(109, "Luiz Fernando", "M", "loja Santo Antônio", "luiz@praticabd.com.br");

-- 56) Altere a loja do seu amigo de Santo Antônio para Cruzeiro e repita a consulta da questão 54 para testar
UPDATE vendedor SET loja = "loja Cruzeiro" WHERE registro = 109;

-- 57) Exiba na tela os nomes dos vendedores da loja Cruzeiro
SELECT nome FROM vendedor WHERE loja = "loja Cruzeiro";

-- 58) Insira um produto da sua escolha e invente
INSERT INTO produto 
(cod_produto, nome_produto, qtd, valor) VALUES 
(16, "Pasta Térmica", 10, 89.99);

-- 59) Aumente em 50% o valor do produto cadastrado na questão 58
UPDATE produto SET valor = valor * 0.50 + valor WHERE cod_produto = 16;

-- 60) Exclua o produto cadastrado na questão 58
DELETE FROM produto WHERE cod_produto = 16;

-- 61) Acrescente o campo nascimento na tabela vendedor para receber a data de nascimento dos vendedores.
ALTER TABLE vendedor ADD nascimento DATE;

-- 62) Insira na tabela vendedor as datas de nascimento de todos os vendedores. Você pode escolher uma data qualquer.
UPDATE vendedor SET nascimento = "1985/05/12" WHERE registro = 101;
UPDATE vendedor SET nascimento = "1986/06/11" WHERE registro = 102;
UPDATE vendedor SET nascimento = "1987/07/10" WHERE registro = 103;
UPDATE vendedor SET nascimento = "1988/08/09" WHERE registro = 104;
UPDATE vendedor SET nascimento = "1989/09/08" WHERE registro = 105;
UPDATE vendedor SET nascimento = "1990/10/07" WHERE registro = 106;
UPDATE vendedor SET nascimento = "1991/11/06" WHERE registro = 107;
UPDATE vendedor SET nascimento = "1992/12/05" WHERE registro = 108;
UPDATE vendedor SET nascimento = "1993/01/04" WHERE registro = 109;

-- 63) Busque a data de nascimento do vendedor Aldebaran
SELECT nascimento, nome FROM vendedor WHERE nome = "Aldebaran Touro";

-- 64) Retorne a loja em que o vendedor Seiya trabalha
SELECT loja, nome FROM vendedor WHERE nome = "Seya";

-- 65) Insira um produto qualquer. Invente os dados.
INSERT INTO produto 
(cod_produto, nome_produto, qtd, valor) VALUES 
(16, "Pasta Térmica", 10, 89.99);

-- 66) Insira na tabela produto o pen drive 8GB, quantidade 30 valor 29.90
INSERT INTO produto 
(cod_produto, nome_produto, qtd, valor) VALUES 
(17, "Pen Drive 8GB", 30, 29.90);

-- 67) Diminua em 5% o valor do produto Pen drive 8 GB
UPDATE produto SET valor = valor -(valor * 0.05) WHERE cod_produto = 17;

-- 68) Aumente em 25% o valor do produto que você inseriu na questão 65
UPDATE produto SET valor = valor * 0.25 + valor WHERE cod_produto = 16;

-- 69) Exiba na tela todos os produtos que tenham o número oito “8” no nome.
SELECT nome_produto FROM produto WHERE nome_produto LIKE "%8%";

-- 70) Insira um produto qualquer. Invente os dados
INSERT INTO produto 
(cod_produto, nome_produto, qtd, valor) VALUES 
(18, "Gabinete", 15, 120.00);

-- 71) Insira um vendedor qualquer. Invente os dados
INSERT INTO vendedor 
(registro, nome, sexo, loja, email, nascimento) VALUES 
(110, "Maria Padilha", "F", "loja Centro", "maria@praticabd.com.br", "1994/02/25");

-- 72) Altere a loja do vendedor inserido na questão 71 para Cruzeiro.
UPDATE vendedor SET loja = "loja Cruzeiro" WHERE registro = 110;

-- 73) Atualize a data de nascimento do vendedor inserido na questão 71 para 25 de dezembro de 1994
UPDATE vendedor SET nascimento = "1994/12/25" WHERE registro = 110;

-- 74) Exiba na tela a data de nascimento do vendedor Seiya
SELECT nascimento, nome FROM vendedor WHERE nome = "Seya";

-- 75) Exclua o produto inserido na questão 70.
DELETE FROM produto WHERE cod_produto = 18;

-- 76) Efetue uma venda qualquer. Não se esqueça que para cada venda efetuada é
-- necessário inserir registros na tabela item_de_venda
INSERT INTO itens_de_venda 
(vendas_cod_venda, produto_cod_produto, cod_venda, cod_produto, qtd_item, valor_item) VALUES 
(1007, 16, 9, 9, 1, 112);

INSERT INTO vendas 
(vendedor_registro, cod_venda, data_venda, valor_venda) VALUES 
(102, 1007, "2014/05/21", 112);

-- 77) Quantos produtos a empresa comercializa?
SELECT COUNT(cod_produto) FROM produto;

-- 78) Qual é o produto mais caro que a empresa comercializa?
SELECT nome_produto, valor FROM produto WHERE valor = (SELECT MAX(valor) FROM produto);

-- 79) Qual é o produto mais barato que a empresa comercializa?
SELECT nome_produto, valor FROM produto WHERE valor = (SELECT MIN(valor) FROM produto);

-- 80) Qual foi a maior venda feita pela empresa até agora?
SELECT MAX(valor_item), nome_produto
FROM itens_de_venda
INNER JOIN produto ON itens_de_venda.produto_cod_produto = produto.cod_produto;

-- 81) Crie uma função para calcular a quantidade * o valor de um produto
CREATE FUNCTION valorTotal (qtd INT, valor FLOAT)
RETURNS FLOAT
RETURN qtd * valor;

SELECT nome_produto, valorTotal (qtd, valor) AS Total FROM produto WHERE nome_produto LIKE "%Office%"; 

-- 82) Função para saber o valor da venda em um determinado dia
CREATE FUNCTION valorDia(dia DATE)
RETURNS FLOAT
RETURN
	(SELECT valor_venda FROM vendas WHERE data_venda = dia);
    
SELECT valorDia('2014/03/05');
select * from vendedor;

-- 83) Função para se um vendedor nasceu depois de 1990
CREATE FUNCTION nascimentoVendedor(reg INT) 
RETURNS VARCHAR(55)
RETURN
	(SELECT IF(nascimento > "1990/12/30",CONCAT('Vendedor ', nome, ' nascido(a) dia: ', nascimento),"Nascido antes de 1990") 
    FROM vendedor WHERE reg = registro);

SELECT nascimentoVendedor(101);

-- 84)Função para saber qtd * valor na tabela itens_de_venda
DELIMITER //

CREATE FUNCTION valorTotalItens(cod INT)
RETURNS VARCHAR(55) 
BEGIN
DECLARE quantidade FLOAT;
DECLARE valor FLOAT;
DECLARE res FLOAT;
SET res = 0;
SET quantidade = 0;
SET valor = 0;
SELECT qtd_item INTO quantidade FROM itens_de_venda WHERE cod = itens_de_venda.cod_produto;
SELECT valor INTO valor FROM itens_de_venda WHERE cod = itens_de_venda.cod_produto;
SET res = res + (valor * quantidade);
RETURN 
	(SELECT CONCAT('Produto: ',produto_cod_produto, ' Valor total: ',res) FROM itens_de_venda WHERE cod = itens_de_venda.cod_produto);
END; //

DELIMITER ;

SELECT valorTotalItens(4);
drop function valorTotalItens;
select * from itens_de_venda;