CREATE DATABASE computar_db;

USE computar_db;

-- INSTRUTOR
CREATE TABLE instrutores (
	id_instrutor INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    curso VARCHAR(10) NOT NULL,
    turno CHAR(5) NOT NULL,
    PRIMARY KEY (id_instrutor)
);

INSERT INTO instrutores 
(nome, curso, turno) VALUES
("Rafael","TI","Manhã"),
("Rafaela","TI","Tarde"),
("Yuri","Redes","Noite"),
("Pamela","Redes","Tarde"),
("Ricardo","Redes","Manhã");

-- CURSO
CREATE TABLE cursos (
	codigo_curso INT AUTO_INCREMENT NOT NULL,
    curso VARCHAR(10) NOT NULL,
    turno CHAR(5) NOT NULL,
    carga_horaria INT,
    data_inicio DATE,
    data_termino DATE,
    observacoes VARCHAR(120),
    instrutores_id_instrutor INT,
    PRIMARY KEY (codigo_curso),
    FOREIGN KEY (instrutores_id_instrutor) REFERENCES instrutores (id_instrutor)
);

INSERT INTO cursos 
(instrutores_id_instrutor, curso, turno, carga_horaria, data_inicio, data_termino, observacoes) VALUES
(1,"TI","Manhã",800,"2021/01/21","2023/01/18","Web"),
(2,"TI","Tarde",800,"2021/01/21","2023/01/18","Web"),
(3,"TI","Noite",800,"2021/01/21","2023/01/18","Web"),
(4,"Redes","Noite",800,"2021/01/21","2023/01/18","Rede"),
(5,"Redes","Tarde",800,"2021/01/21","2023/01/18","Rede");

-- ALUNOS
CREATE TABLE alunos (
	codigo_aluno INT AUTO_INCREMENT NOT NULL,
    nome_do_aluno VARCHAR(20) NOT NULL,
    endereco VARCHAR(50),
    telefone VARCHAR(15),
    observacoes VARCHAR(120),
    cursos_id_cursos INT,
    PRIMARY KEY (codigo_aluno),
    FOREIGN KEY (cursos_id_cursos) REFERENCES cursos (codigo_curso)
);

INSERT INTO alunos 
(cursos_id_cursos, nome_do_aluno, endereco, telefone, observacoes) VALUES
(1,"Rafael","Rua A","(57) 38820-8321","TI"),
(2,"Luiz","Rua B","(56) 56163-7406","TI"),
(3,"Luiza","Rua C","(23) 69043-1458","TI"),
(3,"Yumi","Rua D","(70) 88484-2633","TI"),
(4,"Carlos","Rua E","(66) 54730-0252","Redes"),
(5,"Guilherme","Rua F","(74) 67358-6017","Redes"),
(4,"Lucas","Rua G","(73) 67516-7291","Redes"),
(5,"Paula","Rua H","(15) 15735-6428","Redes");

-- Verificar se os relacionamentos permitem: Consultar quais são os alunos de uma determinada turma e qual o instrutor
SELECT alunos.nome_do_aluno, cursos.curso, instrutores.nome, cursos.turno
FROM alunos
INNER JOIN cursos ON alunos.cursos_id_cursos = cursos.codigo_curso
INNER JOIN instrutores ON cursos.instrutores_id_instrutor = instrutores.id_instrutor
WHERE cursos.curso = "TI"; -- ALTERA-SE PARA "Redes" 

-- Verificar se os relacionamentos permitem: Consultar um aluno e mostrar qual é sua turma e qual instrutor da turma
SELECT alunos.nome_do_aluno, cursos.curso, instrutores.nome, cursos.turno
FROM alunos
INNER JOIN cursos ON alunos.cursos_id_cursos = cursos.codigo_curso
INNER JOIN instrutores ON cursos.instrutores_id_instrutor = instrutores.id_instrutor
WHERE alunos.nome_do_aluno = "Yumi"; -- ALTERA-SE OS NOMES

CREATE VIEW alunosTI AS
SELECT alunos.nome_do_aluno, cursos.curso, instrutores.nome, cursos.turno
FROM alunos
INNER JOIN cursos ON alunos.cursos_id_cursos = cursos.codigo_curso
INNER JOIN instrutores ON cursos.instrutores_id_instrutor = instrutores.id_instrutor
WHERE cursos.curso = "TI";

SELECT * FROM alunosTI;

CREATE VIEW alunosRedes AS
SELECT alunos.nome_do_aluno, cursos.curso, instrutores.nome, cursos.turno
FROM alunos
INNER JOIN cursos ON alunos.cursos_id_cursos = cursos.codigo_curso
INNER JOIN instrutores ON cursos.instrutores_id_instrutor = instrutores.id_instrutor
WHERE cursos.curso = "Redes";

SELECT * FROM alunosRedes;
SELECT nome_do_aluno FROM alunosRedes;

SELECT curso, data_inicio, data_termino FROM cursos WHERE curso = "TI";