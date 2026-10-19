-- =========================================================
-- DDL — criação do banco, tabelas, PK, FK e constraints
-- =========================================================

-- Desenvolva sua solução abaixo.

CREATE TABLE SALA (
  Numero_Sala INT NOT NULL,
  Andar       INT NOT NULL,
  CONSTRAINT pk_sala PRIMARY KEY (Numero_Sala),
  CONSTRAINT uq_sala_andar UNIQUE (Andar),            
  CONSTRAINT ck_sala_numero CHECK (Numero_Sala > 1 AND Numero_Sala < 50),
  CONSTRAINT ck_sala_andar  CHECK (Andar < 12)
);
 
CREATE TABLE MEDICOS (
  CRM           VARCHAR(15) NOT NULL,
  Nome          VARCHAR(40) NOT NULL,
  Idade         INT,
  Especialidade CHAR(20)    NOT NULL DEFAULT 'Ortopedia',
  CPF           VARCHAR(15) NOT NULL,
  Data_Admissao DATE,
  Numero_Sala   INT,   
  CONSTRAINT pk_medicos PRIMARY KEY (CRM),
  CONSTRAINT uq_medicos_cpf UNIQUE (CPF),
  CONSTRAINT ck_medicos_idade CHECK (Idade > 23),
  CONSTRAINT fk_medicos_sala FOREIGN KEY (Numero_Sala) REFERENCES SALA (Numero_Sala)
);
 
CREATE TABLE PACIENTES (
  RG              VARCHAR(15) NOT NULL,
  Nome            VARCHAR(40) NOT NULL,
  Data_Nascimento DATE,
  Cidade          CHAR(30)    DEFAULT 'Itabuna',
  Doenca          VARCHAR(40) NOT NULL,
  Plano_Saude     VARCHAR(40) NOT NULL DEFAULT 'SUS',
  CONSTRAINT pk_pacientes PRIMARY KEY (RG)
);
 

CREATE TABLE FUNCIONARIOS (
  Matricula       VARCHAR(15)   NOT NULL,
  Nome            VARCHAR(40)   NOT NULL,
  Data_Nascimento DATE          NOT NULL,
  Data_Admissao   DATE          NOT NULL,
  Cargo           VARCHAR(40)   NOT NULL DEFAULT 'Assistente Médico',
  Salario         DECIMAL(10,2) NOT NULL DEFAULT 510.00,
  CONSTRAINT pk_funcionarios PRIMARY KEY (Matricula)
);
 
CREATE TABLE CONSULTAS (
  Codigo_Consulta INT         NOT NULL,
  Data_Horario    DATETIME,
  CRM             VARCHAR(15) NOT NULL,   
  RG              VARCHAR(15) NOT NULL,   
  CONSTRAINT pk_consultas PRIMARY KEY (Codigo_Consulta),
  CONSTRAINT fk_cons_medico   FOREIGN KEY (CRM) REFERENCES MEDICOS (CRM),
  CONSTRAINT fk_cons_paciente FOREIGN KEY (RG)  REFERENCES PACIENTES (RG),
 
  CONSTRAINT uq_cons_medico_hora   UNIQUE (CRM, Data_Horario),
  CONSTRAINT uq_cons_paciente_hora UNIQUE (RG,  Data_Horario)
);