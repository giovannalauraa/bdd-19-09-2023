# Aluna: Giovanna Laura Cravo e Silva -- BP3039391
#script ativiade aula 5 a ser executado para desenvolvimento da atividade 5
create database if not exists academico5;
use ACADEMICO5;

create table if not exists curso
(idCurso        char(3)      not null,
 nome           varchar(30)  not null,
 coordenador    Varchar(20)  not null,
 primary key(idCurso));


create table if not exists aluno
(prontuario     char(8)      not null,
 nome           varchar(30)  not null,
 endereco       Varchar(30)  not null,
 RG             char(11)     not null,
 idCurso        char(3)      not null,
 primary key(prontuario),
 foreign key (idCurso) references curso(idCurso));


create table if not exists disciplina
(idDisciplina   integer      not null,
 idCurso        char(3)      not null,
 nomeDis        varchar(30)  not null,
 numCreditos    integer      not null,
 primary key(idDisciplina),
 foreign key (idCurso) references curso(idCurso));

create table if not exists boletim
(idDisciplina   integer      not null,
 prontuario     char(8)      not null,
 nota           decimal(4,2)  not null,
 primary key (idDisciplina,prontuario),
 foreign key(idDisciplina) references disciplina(idDisciplina),
 foreign key(prontuario) references aluno(prontuario));
 
insert into CURSO
values ('ADS', 'Analise de Sistemas','João'),
       ('MSI','Informatica','Joana'),
	   ('ECA','Engenharia','Carlos'),
       ('GET','Especialização','Benedita');

/* inserir dados na tabela aluno*/
insert into ALUNO
values ('12345678','Maria das Dores','Rua das Flores,100','010101','ADS'),
       ('12345677','Joao do Pulo','Rua das Flores,200','02020202','MSI'),
       ('12345688','Almerinda de Jesus','Rua das Orquideas,500','303030','ADS');

/* inserir dados na tabela disciplina*/
insert into DISCIPLINA
values (1,'ADS','Banco de Dados',5),
       (2,'ADS','Lógica de Programação',5),
       (3,'ADS','Informática',3),
       (4,'ADS','Engenharia de Software',5);

/* inserir dados na tabela boletim*/
insert into BOLETIM
values (1,'12345678',6.0),
       (1,'12345677',8.0),
       (1,'12345688',2.3),
       (2,'12345678',5.0),
       (2,'12345677',10.0),
       (3,'12345688',2.3);
       

# 1. Alterar a estrutura da tabela CURSO para incluir o atributo dataCurso tipo date.
ALTER TABLE CURSO ADD dataCurso date;
select * from curso;

# 2. Alterar os dados para atualizar as respectivas datas.
# Alterando os dados para respectivas datas
UPDATE CURSO
SET coordenador="Letícia"
WHERE idCurso="ADS";

UPDATE CURSO
SET coordenador="Adilson"
WHERE idCurso="ECA";

UPDATE CURSO
SET coordenador="Cristina"
WHERE idCurso="GET";

UPDATE CURSO
SET coordenador="Rubens"
WHERE idCurso="MSI";

# Atualizando as datas dos cursos
UPDATE CURSO
SET dataCurso="2008-02-01"
WHERE idCurso="ADS";

UPDATE CURSO
SET dataCurso="2019-03-20"
WHERE idCurso="ECA";

UPDATE CURSO
SET dataCurso="2017-08-01"
WHERE idCurso="GET";

UPDATE CURSO
SET dataCurso="2015-12-10"
WHERE idCurso="MSI";

# Apresentando os cursos conforme a ordem apresentada no pdf
SELECT * FROM CURSO ORDER BY IDCURSO;

# 3. Alterar a estrutura da tabela ALUNO para incluir o atributo dataNasc tipo date e 
# atualizar os dados conforme imagem.
ALTER TABLE ALUNO ADD dataNasc date;
SELECT * FROM ALUNO;

UPDATE ALUNO
SET dataNasc = "1991-05-22"
WHERE prontuario = "12345678";

UPDATE ALUNO
SET dataNasc = "1977-04-27"
WHERE prontuario = "12345688";

UPDATE ALUNO
SET dataNasc = "1960-10-10"
WHERE prontuario = "12345677";

# Apresentando os alunos conforme a ordem apresentada no pdf
SELECT * FROM ALUNO ORDER BY PRONTUARIO;

# 4. Exibir os alunos que nasceram no ano de 1991.
SELECT * FROM ALUNO WHERE YEAR(dataNasc) = 1991;

# 5. Exibir o nome do aluno, a data nascimento e idade de cada aluno, conforme imagem.
SELECT nome, dataNasc,
       TIMESTAMPDIFF(YEAR, dataNasc, CURDATE()) AS idade
FROM aluno;

# 6. Exibir os dados do curso mais antigo.
SELECT dataCurso AS "curso mais antigo" FROM curso 
ORDER BY dataCurso ASC
LIMIT 1;

# 7. Exibir os dados conforme print a seguir. 
SELECT a.prontuario, a.nome, c.nome as "curso",
       DATE_FORMAT(a.dataNasc, '%d/%M/%y') AS Aniversario
FROM aluno AS a
INNER JOIN curso AS c
ON a.idCurso = c.idCurso;

# 8. Repetir a query anterior e mostrar também os cursos q ainda não tem aluno 
# cadastrado
SELECT a.prontuario, a.nome, c.nome as "curso",
       DATE_FORMAT(a.dataNasc, '%d/%M/%y') AS Aniversario
FROM aluno AS a
RIGHT JOIN curso AS c
ON a.idCurso = c.idCurso;

# 9. Repetir a query anterior e mostrar apenas os alunos cujos nomes iniciem com J 
SELECT a.prontuario, a.nome, c.nome as "curso",
       DATE_FORMAT(a.dataNasc, '%d/%M/%y') AS Aniversario
FROM aluno AS a
RIGHT JOIN curso AS c
ON a.idCurso = c.idCurso WHERE c.nome LIKE "%J";

# 10. Há quantos dias os cursos estão em funcionamento.
SELECT nome, DATEDIFF(CURDATE(), dataCurso) AS "dias em funcionamento"
FROM curso;

# 11. Exibir por nome da disciplina e a média das notas obtidas
SELECT d.idDisciplina, d.nomeDis AS Nome_Disciplina, AVG(b.nota) AS Media_Notas
FROM disciplina AS d
INNER JOIN boletim AS b 
ON d.idDisciplina = b.idDisciplina
GROUP BY d.nomeDis;

