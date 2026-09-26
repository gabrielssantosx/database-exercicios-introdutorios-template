-- =========================================================
-- DDL — criação do banco, tabelas, PK, FK e constraints
-- =========================================================

-- Desenvolva sua solução abaixo.


create database if not exists Catalago_Musical;

use Catalago_Musical;

create table cd (
    id_cd int auto_increment primary key,
    gravadora varchar(30),
    nome_cd varchar(50),
    data_lançamento date
);

create table cantor (
    cod_cantor int auto_increment primary key,
    nome varchar(100) not null,
    biografia varchar(100) not null
);

create table musica (
    id_cd int not null,
    numero_musica int not null,
    titulo varchar(100) not null,
    cod_cantor int not null,
    tempo_segundos int not null,
    genero varchar(30),
    primary key (id_cd, numero_musica),
    foreign key (id_cd) references cd(id_cd),
    foreign key (cod_cantor) references cantor(cod_cantor)
);
