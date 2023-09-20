/*1- criando o banco*/
create database if not exists escolateste;

/*inicializando o banco*/
use escolateste;

/*2- listando os bancos existentes*/
show databases;

/*3- Apagando o bd escolateste*/
drop database escolateste;

/*4- listando os bancos existentes*/
show databases;

/*5- criando o BD escola*/
create database if not exists escola;
use escola;


/*6- criando a tabela aluno teste*/
create table if not exists alunoteste (
	matricula int not null,
    nome varchar(45),
    fone int,
    sexo varchar(10),
    primary key (matricula)
)engine innoDB;

/*7- listando as tabelas existentes no BD escola*/
show tables;

/*8- Apagando a tabela alunoteste*/
drop table alunoteste;

/*9- listando as tabelas existentes no BD escola*/
show tables;

/*10- criando a tabela aluno checando sexo*/
create table if not exists aluno(
	matricula int not null,
    nome varchar(45),
    fone int,
    sexo varchar(10) check(sexo in ('F','M')),
    primary key (matricula)
)engine innoDB;

/*11- Inserindo a primeira tupla descrita*/
insert into aluno values
(25, "Cláudia Peres", 25345678, 'F');

/*12- Mostrando a tupla inserida*/
select * from aluno;

/*13- Inserindo demais tuplas*/
insert into aluno values
(37, "Edilson Silva", 45768900 , 'M'),
(45, "Marcelo Pereira", 45987690, 'M');

/*14- mostrar as tuplas */
select * from aluno;

/*15- Inserindo um campo sobrenome */
alter table aluno add sobrenome varchar(45);

/*16- Inserindo um sobrenome em cada registro*/
update aluno
set sobrenome="Silva"
where matricula=25;

update aluno
set sobrenome="Pereira"
where matricula=37;

update aluno
set sobrenome="Mendes"
where matricula=45;

/*Inserindo uma tupla com os meus dados */
insert into aluno values
(3039391, "Giovanna Laura", 91234567, 'F', "Cravo e Silva");

/* Mostrando todas as tuplas */
select * from aluno;

