-- =========================================================
-- DDL — criação do banco, tabelas, PK, FK e constraints
-- =========================================================

-- Desenvolva sua solução abaixo.

drop database if exists revendedora_carros;
create database revendedora_carros;
 
use revendedora_carros;
 
create table automovel (
renavam char(11) primary key,
placa char(7) not null unique,
marca varchar(50) not null,
modelo varchar(60) not null,
ano_fabricacao smallint not null,
ano_modelo smallint not null,
cor varchar(30) not null,
motor varchar(30) not null,
numero_portas tinyint not null,
tipo_combustivel varchar(20) not null,
preco decimal(12,2) not null,
constraint ck_automovel_renavam check (renavam regexp '^[0-9]{11}$'),
constraint ck_automovel_placa check (placa regexp '^[A-Z]{3}[0-9][A-Z0-9][0-9]{2}$'),
constraint ck_automovel_ano_fab check (ano_fabricacao between 1950 and 2100),
constraint ck_automovel_ano_mod check (ano_modelo between ano_fabricacao and ano_fabricacao + 1),
constraint ck_automovel_portas check (numero_portas between 2 and 5),
constraint ck_automovel_combustivel check (tipo_combustivel in ('Flex','Gasolina','Etanol','Diesel','Híbrido','Elétrico')),
constraint ck_automovel_preco check (preco > 0)
);
 
create table vendedor (
cod_vendedor int auto_increment primary key,
nome varchar(60) not null,
sobrenome varchar(60) not null,
telefone varchar(20) not null,
rua varchar(100) not null,
numero varchar(10) not null,
complemento varchar(80) null,
bairro varchar(60) not null,
cidade varchar(60) not null,
estado char(2) not null,
cep char(8) not null,
data_admissao date not null,
salario_fixo decimal(10,2) not null,
constraint ck_vendedor_cep check (cep regexp '^[0-9]{8}$'),
constraint ck_vendedor_salario check (salario_fixo >= 0)
);
 
create table cliente (
cod_cliente int auto_increment primary key,
nome varchar(60) not null,
sobrenome varchar(60) not null,
telefone varchar(20) not null,
rua varchar(100) not null,
numero varchar(10) not null,
complemento varchar(80) null,
bairro varchar(60) not null,
cidade varchar(60) not null,
estado char(2) not null,
cep char(8) not null,
constraint ck_cliente_cep check (cep regexp '^[0-9]{8}$')
);
 
create table negocio (
codigo_negocio int auto_increment primary key,
data_negocio date not null,
preco_pago decimal(12,2) not null,
fk_codigo_cliente int not null,
fk_codigo_vendedor int not null,
renavam char(11) not null unique,
constraint ck_negocio_preco check (preco_pago > 0),
constraint fk_negocio_cliente foreign key (fk_codigo_cliente)
references cliente(cod_cliente) on update cascade on delete restrict,
constraint fk_negocio_vendedor foreign key (fk_codigo_vendedor)
references vendedor(cod_vendedor) on update cascade on delete restrict,
constraint fk_negocio_automovel foreign key (renavam)
references automovel(renavam) on update cascade on delete restrict
);