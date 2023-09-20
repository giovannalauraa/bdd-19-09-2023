/* criar banco de dados */
drop database if exists Aula19_09;
create database if not exists Aula19_09;
/* colocar em uso */
use Aula19_09;
/* mostrar os bancos existentes na minha máquina*/
show databases;
/*criar uma tabela*/
create table if not exists fornecedor (
idFornecedor int not null,
nome varchar(45) not null,
endereco varchar(45),
telefone int,
cidade varchar(25),
email varchar(25),
primary key (idFornecedor)
)engine innodb;
/*mostras as tabelas */
show tables;

/*mostrar a estrutura da tabela*/
desc fornecedor;

create table if not exists produto(
idProduto int not null,
descricao varchar(45),
preco decimal(7,2),
unidade varchar(10),
idFornecedor int not null,
primary key (idProduto),
foreign key (idFornecedor) references fornecedor(idFornecedor)
)engine innodb;

desc produto;

INSERT INTO FORNECEDOR VALUES
(1, "Papel reciclado", "Rua Brasil,1000","44441212", "Bragança", "reci@gmail");
select * from fornecedor; 

/* o comando insert pode ter + de 1 registro */
insert into fornecedor values
(2, "Casas Bahia", "Rua do Mercado,1000", 40338787, "Bragança", "casasbahia@gmail.com"), 
(3, "Lojas Cem", "Rua do comércio,9000", 40334455, "Atibaia", "lojascem@gmail.com"),
(4, "Magazine Luiza", "Rua Pires Pimentel,500", 4033333, "Bragança", "luiza@gmail.com");
select * from fornecedor;

# provocando alguns errros no insert
# ao mandar executar denovo -> da erro de duplicidade (não pode existir + de uma vez a mesma chave primária)
INSERT INTO FORNECEDOR VALUES
(1, "Papel reciclado", "Rua Brasil,1000", 44441212, "Bragança", "reci@gmail");
select * from fornecedor; 

# dado muito longo -> o atributo ultrapassa a quantidade de caracteres
INSERT INTO FORNECEDOR VALUES
(10, "Papel reciclado", "Rua Brasil,1000", 44441212, "Bragança", "reci@gmailxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
select * from fornecedor; 


# erro relativo a falta de um valor a ser inserido (se não for obrigatório deve-se colocar null) -> se for not null deve ter valor
INSERT INTO FORNECEDOR VALUES
(10, "Papel reciclado", "Rua Brasil,1000","44441212", "Bragança");

# erro de sintaxe -> esperava um tipo e veio outro (ex: espera int e vem varchar)
INSERT INTO FORNECEDOR VALUES
(10, "Papel reciclado", "Rua Brasil,1000","AAAAAA", "Bragança", "reci@gmail.com");

/* Inserindo dados na tabela de produtos */
DESC PRODUTO;
INSERT INTO PRODUTO VALUES
(100, "FOGÃO", 800.5, 'PC', 2); /* aspas símples == representa uma unidade */
SELECT * FROM PRODUTO;

insert into produto values
(110, "GELADEIRA", 2000.7, 'PC', 2),
(150, "FOGÃO COOKTOP", 1307.4, 'PC', 3),
(160, "AR CONDICIONADO", 1800, 'PC', 4);
SELECT * FROM produto;

/* alterando dados já inseridos */
UPDATE PRODUTO  /* atualiza o dado pelo id que é passado (se não passar id altera todos) */
SET PRECO=2000
WHERE IDPRODUTO=160;

/* alterando mais de 1 dado de uma vez de um id */
UPDATE PRODUTO
SET PRECO=2001,
	UNIDADE="cx"
WHERE IDPRODUTO=160;

/* EXCLUINDO um REGISTRO (TUPLA) ->  a linha inteira */
DELETE FROM PRODUTO WHERE IDPRODUTO=100;

/* mostrando apenas colunas desejadas */
SELECT DESCRICAO, PRECO FROM PRODUTO;

/* realizando ordenação */
SELECT * FROM FORNECEDOR ORDER BY NOME; # ordenando por ordem alfabética de nome
SELECT * FROM FORNECEDOR ORDER BY NOME ASC; /* ESTÁ IMPLÍCITO NO COMANDO ACIMA -> ASCENDENTE*/

/* realizando ordenação inversa */
SELECT * FROM FORNECEDOR ORDER BY NOME DESC; /* ordem descendente */ 

/* realizando ordem por nome (pelo número da coluna) */
SELECT * FROM FORNECEDOR ORDER BY 2 DESC;

/* mostrando (em ordem alfabética) NOME e CIDADE*/
SELECT  NOME, CIDADE FROM FORNECEDOR ORDER BY 2;

/* outra forma do exemplo acima*/
SELECT  NOME, CIDADE FROM FORNECEDOR ORDER BY 2, 1;


/* update -> altera dado, alter table -> altera tabela
	delete -> apaga registro, drop table -> apaga tabela*/ # prova

SELECT * FROM PRODUTO WHERE PRECO<=2000;
SELECT * FROM PRODUTO WHERE PRECO>=2000 AND IDFORNECEDOR=2; # mostrando na tela por características

/* mostrando na tela registros aonde o nome comece a letra C*/
SELECT * FROM FORNECEDOR WHERE NOME LIKE "C%";

/* mostrando na tela registros aonde o nome NÃO começe com a letra C*/
SELECT * FROM FORNECEDOR WHERE NOME NOT LIKE "C%";

/* mostra apenas um se houver mais de 1 (se houver mais de 1 escolhe aleatoriamente qual vai mostrar)*/
SELECT distinct DESCRICAO FROM PRODUTO;


