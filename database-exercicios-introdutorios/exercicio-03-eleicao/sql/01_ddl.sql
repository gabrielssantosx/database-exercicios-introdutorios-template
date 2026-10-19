-- =========================================================
-- DDL — criação do banco, tabelas, PK, FK e constraints
-- =========================================================

-- Desenvolva sua solução abaixo.

CREATE TABLE CARGO (
  Codigo_Cargo  INT           NOT NULL,
  Nome_Cargo    VARCHAR(30)   NOT NULL,
  Salario       DECIMAL(10,2) NOT NULL DEFAULT 17000.00,
  Numero_Vagas  INT           NOT NULL,
  CONSTRAINT pk_cargo PRIMARY KEY (Codigo_Cargo),
  CONSTRAINT uq_cargo_nome  UNIQUE (Nome_Cargo),
  CONSTRAINT uq_cargo_vagas UNIQUE (Numero_Vagas),
  CONSTRAINT ck_cargo_nome  CHECK (Nome_Cargo NOT IN ('Prefeito','Vereador')),
  CONSTRAINT ck_cargo_vagas CHECK (Numero_Vagas > 0)
);
 
CREATE TABLE PARTIDO (
  Codigo_Partido INT         NOT NULL,
  Sigla          CHAR(5)     NOT NULL,
  Nome           VARCHAR(40) NOT NULL,
  Numero         INT         NOT NULL,
  CONSTRAINT pk_partido PRIMARY KEY (Codigo_Partido),
  CONSTRAINT uq_partido_sigla  UNIQUE (Sigla),
  CONSTRAINT uq_partido_nome   UNIQUE (Nome),
  CONSTRAINT uq_partido_numero UNIQUE (Numero)
);
 
CREATE TABLE CANDIDATO (
  Numero_Candidato INT         NOT NULL,
  Nome             VARCHAR(40) NOT NULL,
  Codigo_Cargo     INT         NOT NULL,
  Codigo_Partido   INT         NOT NULL,
  CONSTRAINT pk_candidato PRIMARY KEY (Numero_Candidato),
  CONSTRAINT uq_candidato_nome UNIQUE (Nome),
  CONSTRAINT fk_cand_cargo   FOREIGN KEY (Codigo_Cargo)   REFERENCES CARGO (Codigo_Cargo),
  CONSTRAINT fk_cand_partido FOREIGN KEY (Codigo_Partido) REFERENCES PARTIDO (Codigo_Partido)
);
 
CREATE TABLE ELEITOR (
  Titulo_Eleitor   VARCHAR(30) NOT NULL,
  Zona_Eleitoral   CHAR(5)     NOT NULL,
  Sessao_Eleitoral CHAR(5)     NOT NULL,
  Nome             VARCHAR(40) NOT NULL,
  CONSTRAINT pk_eleitor PRIMARY KEY (Titulo_Eleitor)
);
 

CREATE TABLE VOTO (
  Titulo_Eleitor   VARCHAR(30) NOT NULL,
  Numero_Candidato INT         NOT NULL,
  CONSTRAINT pk_voto PRIMARY KEY (Titulo_Eleitor),
  CONSTRAINT fk_voto_eleitor   FOREIGN KEY (Titulo_Eleitor)   REFERENCES ELEITOR (Titulo_Eleitor),
  CONSTRAINT fk_voto_candidato FOREIGN KEY (Numero_Candidato) REFERENCES CANDIDATO (Numero_Candidato)
);