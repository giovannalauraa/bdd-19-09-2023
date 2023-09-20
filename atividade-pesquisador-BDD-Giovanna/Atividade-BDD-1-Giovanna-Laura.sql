/*Aluna: Giovanna Laura Cravo e Silva -- BP3039391*/

/* criando o banco de dados pesquisador*/
create database if not exists pesquisador;

/* utilizando o banco pesquisador */
use pesquisador;

/* criando a tabela: instituição*/
create table if not exists instituicao(
idInstituicao int not null,
nome varchar(45) not null,
endereco varchar(45) not null,
primary key (idInstituicao)
)engine InnoDB;

/* mostrando a tabela: instituicao*/
desc instituicao;

/* criando a tabela: pesquisador */
create table if not exists pesquisador(
cpf varchar(45) not null,
nome varchar(45) not null,
dataNascimento date not null,
idInstituicao int not null,
primary key (cpf),
foreign key (idInstituicao) references instituicao(idInstituicao)
)engine InnoDB;

/* mostrando a tabela: pesquisador*/
desc pesquisador;

/* criando a tabela: veiculosPublicacao */
create table if not exists veiculosPublicacao(
idVeiculosPublicacao int not null,
titulo varchar(45) not null,
localPublicado varchar(45),
primary key(idVeiculosPublicacao)
)engine InnoDB;

/* mostrando a tabela: veiculosPublicacao */
desc veiculosPublicacao;

/* criando a tabela: artigo */
create table if not exists artigo(
idArtigo int not null,
titulo varchar(45) not null,
paginaInicial varchar(45),
paginaFinal varchar(45),
idVeiculosPublicacao int not null,
primary key (idArtigo),
foreign key (idVeiculosPublicacao) references veiculosPublicacao(idVeiculosPublicacao)
)engine InnoDB;

/* mostrando a tabela: artigo */
desc artigo;

/* criando a tabela de relacionamento n:n artigo -> pesquisador */
create table if not exists artigoPesquisador(
idArtigoPesquisador int not null,
idArtigo int not null,
cpf varchar(45) not null,
primary key (idArtigoPesquisador),
foreign key (idArtigo) references artigo(idArtigo),
foreign key (cpf) references pesquisador(cpf)
)engine InnoDB;

/* mostrando a tabela: artigoPesquisador */
desc artigoPesquisador;


select * from instituicao;

/*4- Inserindo no mínimo 5 registros no BDD pesquisador*/

/*Inserindo dados na tabela instituição*/
insert into instituicao values
(101, "instituição sempre unidos", "Rua das flores,1000"),
(201, "instituição juntos sempre", "Rua das margaridas,1001"),
(301, "instituição das pesquisas", "Rua das pétalas,1002"),
(401, "instituição dos pesquisadores", "Rua das pedras,1003"),
(501, "instituição das nações", "Rua dos lagos,1004");
select * from instituicao;

/*Inserindo dados na tabela pesquisador*/
insert into pesquisador values
(47854715687, "Maria", "1990-08-02", 101),
(14762574893, "João", "2000-07-03", 201),
(14754698712, "Julia", "1998-02-11", 301),
(98714572368, "Henry Carvil", "1980-07-10", 401),
(50147852074, "Juliette", "1997-03-12", 501);
select * from pesquisador;

/*Inserindo dados na tabela veiculosPublicacao*/
insert into veiculosPublicacao values
(11, "Biologia", "site"),
(12, "Estética", "site"),
(13, "Astronomia", "site"),
(14, "Biologia", "site"),
(15, "Química", "site");
select * from veiculosPublicacao;

/*Inserindo dados na tabela artigo*/
insert into artigo values
(1, "A célula que se regenera sozinha.", "1", "30", 11),
(2, "Os benefícios do sol para a pele.", "30", "40", 12),
(3, "Marte será nossa próxima casa?", "40", "60", 13),
(4, "A floresta Amazônica pede socorro!", "60", "80", 14),
(5, "Novo elemento químico descoberto!", "80", "90", 15);
select * from artigo;


/*Inserindo dados na tabela artigoPesquisador*/
insert into artigoPesquisador values
(99, 1, 47854715687),
(98, 2, 14762574893),
(97, 3, 14754698712),
(96, 4, 98714572368),
(95, 5, 50147852074);
select * from artigoPesquisador;

/*5- Criando um comando para excluir um registro; */
DELETE FROM artigoPesquisador WHERE idArtigoPesquisador=95;

/*6- Criando um comando para alterar algum dado na tabela*/
update veiculosPublicacao
set localPublicado="blog"
where idVeiculosPublicacao=15;

/*7- Aplicando 3 comandos de seleção conforme aprendido em aula; */

/* realizando ordenação inversa */
SELECT * FROM artigoPesquisador ORDER BY idArtigoPesquisador DESC;

/* realizando ordem por nome (pelo número da coluna) */
SELECT * FROM instituicao ORDER BY 2 DESC;

/*Realizando seleção pela inicial do nome*/
SELECT * FROM pesquisador WHERE nome LIKE "H%";