/*Giovanna Laura -- BP3039391*/

create database if not exists financeira6;
use financeira6;

/* Criando as tabelas do BDD financeira6: */
create table if not exists cliente
(codCliente  int not null,
nomCliente  varchar (45),
ruaCliente 	varchar	(45),
cidadeCliente varchar	(45),
primary key (codCliente)
)engine innodb;
select * from cliente;

create table if not exists contaCorrente
(numConta int not null,
saldo decimal(10,2),
codCliente int not null,
codAgencia int not null,
primary key (numConta, codAgencia),
foreign key (codCliente)  references cliente(codCliente),
foreign key (codAgencia) references agencia(codAgencia)
)engine innodb;
select * from contaCorrente;

create table if not exists agencia 
(codAgencia int not null,
nomAgencia varchar(45),
cidadeAgencia varchar(45),
primary key (codAgencia)
)engine innodb;
select * from agencia;

create table if not exists emprestimo
(numEmprestimo int not null,
valor decimal(10,2),
codCliente int not null,
codAgencia int not null,
primary key (numEmprestimo),
foreign key (codCliente)  references cliente(codCliente),
foreign key (codAgencia) references agencia(codAgencia)
)engine innodb;
select * from emprestimo;


/* Inserindo os dados solicitados nas tabelas */
insert into cliente values
(1, "Luís Sampaio", "Rua A", "Rio de Janeiro"),
(2, "Carlos Pereira", "Rua B", "Niterói"),
(3, "José Alves", "Rua C", "Rio de Janeiro"),
(4, "Luís Paulo Souza", "Rua D", "Niterói");
select * from cliente;

insert into agencia values
(1, "Rio Branco", "Rio de Janeiro"),
(2, "Icaraí", "Niteói"),
(3, "Leblon", "Rio de Janeiro"),
(4, "Ipanema", "Rio de Janeiro"),
(5, "Copacabana", "Rio de Janeiro");
select * from agencia;

insert into contaCorrente 
values (256589, 1200.00, 1, 1),
	   (328941, 845.00, 1, 3),
	   (749621, 512.00,3, 4),
       (856200, 2650.00, 2, 2),
       (454501, 800.00, 4, 3),
       (468952, 6920.00, 3, 2),
       (278156, 10000.00, 1, 4);
select * from contaCorrente;

insert into emprestimo values
(902230, 500.00, 1, 1),
(902231, 1500.00, 1, 3),
(902240, 1200.00, 2, 4),
(902289, 3000.00, 3, 2),
(902255, 850.00, 1, 3),
(902299, 700.00, 3, 1),
(902212, 400.00, 3, 4);
select * from emprestimo;

/* Queries */

/* 1. Exibir os dados da conta 
com os respectivos nomes de clientes. */
select c.numConta, c.saldo, c.codCliente, 
c.codAgencia, p.nomCliente as "Nome cliente"
from contaCorrente c inner join cliente p
on p.codCliente=c.codCliente;

/*2. Exibir a soma de todos os 
empréstimos por agência. */	
select a.nomAgencia, a.codAgencia, sum(e.valor) as "soma de todos empréstimos:"
from agencia a left join emprestimo e
on e.codAgencia=a.codAgencia group by a.nomAgencia order by 2 asc;

/*3. Exibir o somatório de empréstimo por 
agência bancária apresentando o nome
da agência e a cidade. */
select a.nomAgencia, a.cidadeAgencia, sum(e.valor) as "Somatório de empréstimo por agência:" 
from agencia a left join emprestimo e
on e.codAgencia=a.codAgencia group by a.nomAgencia order by a.cidadeAgencia;

/* 4. Mostrar o maior valor de empréstimo de 
cada cliente com o respectivo nome. */
select c.nomCliente, max(e.valor) as "Maior valor de empréstimo:"
from cliente c left join emprestimo e
on e.codCliente=c.codCliente group by c.codCliente, c.nomCliente;

/*5. Mostrar o cliente com o
 menor valor de empréstimo. */
 select c.nomCliente as "Cliente com o menor empréstimo", 
 min(e.valor) as "Valor do menor empréstimo do banco: "
 from cliente c inner join emprestimo e
 on e.codCliente=c.codCliente order by 1;
 
/*6. Mostrar o valor médio 
dos empréstimos por agência. */
select a.nomAgencia, round(avg(e.valor), 2) as "Valor médio dos empréstimos:"
from agencia a left join emprestimo e
on e.codAgencia=a.codAgencia group by a.nomAgencia;

/*7. Mostrar os dois menores valores 
médios dos empréstimos e as respectivas
agencias. */
select a.nomAgencia, round(avg(e.valor), 2) as "Média de Empréstimos"
from agencia a inner join emprestimo e 
on e.codAgencia=a.codAgencia group by a.nomAgencia 
order by "Média de Empréstimos" 
limit 2;

/*8. Exibir o saldo 
total por agência. */
select a.nomAgencia, sum(s.saldo)
from agencia a inner join contaCorrente s
on s.codAgencia=a.codAgencia group by s.codAgencia;

/*9. Quantos clientes estão 
com saldo inferior a R$1.000,00. */
select count(*) as "Clientes com saldo inferior a R$1.000,00"
from cliente c inner join contaCorrente s 
on s.codCliente = c.codCliente
where s.saldo < 1000.00;

/*10.Quais são os clientes cujo 
saldo é maior que R$ 2.500,00.*/
select c.nomCliente, s.saldo 
from cliente c inner  join contaCorrente s
on s.codCliente = c.codCliente
where s.saldo > 2.500;

/*11.Qual o saldo médio 
por cliente. */
select c.nomCliente, round(avg(s.saldo), 2)
from cliente c inner join contaCorrente s
on s.codCliente = c.codCliente
group by c.codCliente;

/*12.Qual o comando para alterar 
o saldo da conta corrente = 278156 
para saldo=6500. */
update contaCorrente
set saldo=6500.00
where numConta=278156;
select * from contaCorrente;

/*13.Reduzir em 10% o saldo 
dos empréstimos da agência código=2. */
update emprestimo
set valor = valor * 0.9
where codAgencia = 2;
select * from emprestimo;

/*14.Corrigir o saldo das contas 
em 15% de acréscimo da agência =3. */
update contaCorrente
set saldo = saldo * 1.15
where codAgencia = 3;
select * from contaCorrente;

/*15.Qual cliente não 
possui empréstimo? */
select c.nomCliente, e.valor
from cliente c left join emprestimo e
on e.codCliente=c.codCliente
where e.valor is null;

/*16.Qual cliente tem empréstimo 
com valor de R$ 500? */
select c.nomCliente, e.valor
from cliente c inner join emprestimo e 
on e.codCliente=c.codCliente
where e.valor = 500;

/*17.Qual cliente tem 
saldo maior que R$ 6500? */
select c.nomCliente, s.saldo
from cliente c inner join contaCorrente s
on s.codCliente=c.codCliente
where s.saldo > 6500;

/*18.Quais são os clientes 
que tem conta corrente na agência=2?*/
select c.nomCliente, a.codAgencia
from cliente c inner join contaCorrente a
on a.codCliente=c.codCliente
where a.codAgencia=2;

/*19.Quais são os clientes que tem 
conta corrente na agência=2 
com saldo >3000?*/
select c.nomCliente, a.codAgencia, a.saldo
from cliente c inner join contaCorrente a
on a.codCliente=c.codCliente
where a.codAgencia=2 and a.saldo > 3000;

/*20.Qual agência não 
tem cliente cadastrado? */
select a.codAgencia
from agencia a left join contaCorrente c 
on a.codAgencia = c.codAgencia
where c.codCliente is null;

/*21.Qual a agência não 
realizou empréstimo?*/
select a.codAgencia
from agencia a left join emprestimo e
on e.codAgencia = a.codAgencia
where numEmprestimo is null
group by a.codAgencia;


