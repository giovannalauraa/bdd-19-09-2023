#scrip ativiade aula 4 a ser executado para deenvolvimento da ativiade 4
create database if not exists academico;
use ACADEMICO;

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
values ('ADS', 'Analise de Sistemas','Clara'),
       ('MSI','Informatica','Maria'),
	   ('ECA','Engenharia','Moises'),
       ('GET','Especialização','Joana');

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
       
# 1. Exibir os dados dos alunos e o nome do respectivo curso que está matriculado. 
SELECT A.PRONTUARIO, A.NOME, A.ENDERECO, A.RG, C.NOME AS "NOME CURSO", C.IDCURSO
FROM ALUNO A INNER JOIN CURSO C
ON A.IDCURSO=C.IDCURSO;

# 2. Listar da tabela ALUNO, o prontuário e o nome e da tabela DISCIPLINA o nome da disciplina que cursa atualmente. 
SELECT A.PRONTUARIO, A.NOME, D.NOMEDIS
FROM ALUNO A INNER JOIN DISCIPLINA D
ON A.IDCURSO=D.IDCURSO;

# 3. Alterar o script anterior para ordenar por disciplina.  
SELECT A.PRONTUARIO, A.NOME, D.NOMEDIS, D.IDCURSO, D.IDDISCIPLINA
FROM ALUNO A INNER JOIN DISCIPLINA D
ON A.IDCURSO=D.IDCURSO
ORDER BY D.IDDISCIPLINA;
       
# 4. Exibir os cursos existentes e as disciplinas já cadastradas no sistema. 
SELECT C.NOME, C.IDCURSO, D.NOMEDIS
FROM CURSO C INNER JOIN DISCIPLINA D
ON C.IDCURSO=D.IDCURSO;

# 5. Exibir todos os cursos existentes e suas respectivas disciplinas (caso o curso não tenha disciplina cadastrada tb exibir) 
SELECT C.NOME, C.IDCURSO, D.NOMEDIS
FROM CURSO C LEFT JOIN DISCIPLINA D
ON C.IDCURSO=D.IDCURSO;

# 6. Listar da tabela ALUNO, o prontuário e o nome e da tabela BOLETIM a identificação da disciplina que cursa e a nota obtida. 
SELECT A.PRONTUARIO, A.NOME, B.IDDISCIPLINA, B.NOTA
FROM ALUNO A INNER JOIN BOLETIM B
ON A.PRONTUARIO=B.PRONTUARIO;

# 7. Listar da tabela ALUNO, o prontuário e o nome e da tabela BOLETIM a identificação da disciplina que cursa e cujas notas maior que 6 
SELECT A.PRONTUARIO, A.NOME, B.IDDISCIPLINA, B.NOTA
FROM ALUNO A INNER JOIN BOLETIM B
ON A.PRONTUARIO=B.PRONTUARIO 
WHERE NOTA>6;

# 8. Listar da tabela ALUNO, o prontuário e o nome e da tabela BOLETIM a identificação 
# da disciplina que cursa e a nota obtida para os alunos cujos nomes iniciem com M. 
SELECT A.PRONTUARIO, A.NOME, B.IDDISCIPLINA, B.NOTA
FROM ALUNO A INNER JOIN BOLETIM B
ON A.PRONTUARIO=B.PRONTUARIO 
WHERE A.NOME LIKE "M%";

# 9. Exibir a nota média por disciplina. (Visualizar idDisciplina, nomeDisciplina e média das notas). 
SELECT D.IDDISCIPLINA, D.NOMEDIS, AVG(B.NOTA) 
FROM DISCIPLINA D INNER JOIN BOLETIM B
ON D.IDDISCIPLINA=B.IDDISCIPLINA
GROUP BY D.IDDISCIPLINA;

# 10. Exibir o nome, o prontuário do aluno com a maior nota. (Visualizar nome, prontuário e nota) 
SELECT A.NOME, A.PRONTUARIO, B.NOTA
FROM ALUNO A INNER JOIN BOLETIM B
ON A.PRONTUARIO=B.PRONTUARIO
ORDER BY B.NOTA DESC LIMIT 1; # OU ORDER BY 3 PQ NOTA ESTA NA TERCEIRA POSIÇÃO

# 11. Exibir o nome da disciplina com as duas menores notas. (Visualizar, nome disciplina e nota) 
SELECT D.NOMEDIS, B.NOTA
FROM DISCIPLINA D INNER JOIN BOLETIM B
ON D.IDDISCIPLINA=B.IDDISCIPLINA
ORDER BY 2
LIMIT 2;

# 12. Criar uma consulta de modo que selecione dados de duas tabelas. 
SELECT D.NOMEDIS, B.NOTA
FROM DISCIPLINA D INNER JOIN BOLETIM B
ON D.IDDISCIPLINA=B.IDDISCIPLINA
WHERE D.NOMEDIS="Informática";
      