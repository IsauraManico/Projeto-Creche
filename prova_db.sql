/* Estudante: Isaura Manico

Id: 20507

Creche YUSA
*/

CREATE SEQUENCE "public".criancas_pk_crianca_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".encarregado_pk_encarregado_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".horario_pk_horario_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".professor_pk_prof_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".programa_pk_programa_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".tipo_programa_pk_programa_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".turma_pk_turma_seq START WITH 1 INCREMENT BY 1;

CREATE TYPE "public".sexo AS ENUM ( 'Masculino', 'Feminino'  );

CREATE  TABLE "public".encarregado ( 
	pk_encarregado       integer DEFAULT nextval('encarregado_pk_encarregado_seq'::regclass) NOT NULL  ,
	endereco             varchar  NOT NULL  ,
	telefone             varchar  NOT NULL  ,
	email                varchar    ,
	sexo                 varchar  NOT NULL  ,
	nome                 varchar  NOT NULL  ,
	CONSTRAINT encarregado_pkey PRIMARY KEY ( pk_encarregado )
 );

CREATE  TABLE "public".horario ( 
	pk_horario           integer DEFAULT nextval('horario_pk_horario_seq'::regclass) NOT NULL  ,
	descricao            varchar    ,
	CONSTRAINT horario_pkey PRIMARY KEY ( pk_horario )
 );

CREATE  TABLE "public".tipo_programa ( 
	pk_programa          integer DEFAULT nextval('tipo_programa_pk_programa_seq'::regclass) NOT NULL  ,
	descricao            varchar  NOT NULL  ,
	fk_horario           integer    ,
	CONSTRAINT tipo_programa_pkey PRIMARY KEY ( pk_programa )
 );

CREATE  TABLE "public".turma ( 
	pk_turma             integer DEFAULT nextval('turma_pk_turma_seq'::regclass) NOT NULL  ,
	descricao            varchar  NOT NULL  ,
	CONSTRAINT turma_pkey PRIMARY KEY ( pk_turma )
 );

CREATE  TABLE "public".criancas ( 
	pk_crianca           integer DEFAULT nextval('criancas_pk_crianca_seq'::regclass) NOT NULL  ,
	nome                 varchar  NOT NULL  ,
	fk_encarregado       integer    ,
	data_nasc            date  NOT NULL  ,
	fk_turma             integer    ,
	sexo                 "public".sexo    ,
	CONSTRAINT criancas_pkey PRIMARY KEY ( pk_crianca )
 );

CREATE  TABLE "public".programa ( 
	pk_programa          integer DEFAULT nextval('programa_pk_programa_seq'::regclass) NOT NULL  ,
	"desc"               varchar  NOT NULL  ,
	fk_tipoprograma      integer    ,
	CONSTRAINT programa_pkey PRIMARY KEY ( pk_programa )
 );

CREATE  TABLE "public".professor ( 
	pk_prof              integer DEFAULT nextval('professor_pk_prof_seq'::regclass) NOT NULL  ,
	nome                 varchar  NOT NULL  ,
	data_nasc            date  NOT NULL  ,
	fk_programa          integer    ,
	fk_turma             integer    ,
	sexo                 "public".sexo    ,
	CONSTRAINT professor_pkey PRIMARY KEY ( pk_prof )
 );

ALTER TABLE "public".horario ADD CONSTRAINT horario_descricao_check CHECK ( (((descricao)::text = 'Manhã'::text) OR ((descricao)::text = 'Tarde'::text) OR ((descricao)::text = 'Noite'::text)) );

ALTER TABLE "public".criancas ADD CONSTRAINT criancas_fk_encarregado_fkey FOREIGN KEY ( fk_encarregado ) REFERENCES "public".encarregado( pk_encarregado );

ALTER TABLE "public".criancas ADD CONSTRAINT criancas_fk_turma_fkey FOREIGN KEY ( fk_turma ) REFERENCES "public".turma( pk_turma );

ALTER TABLE "public".professor ADD CONSTRAINT professor_fk_programa_fkey FOREIGN KEY ( fk_programa ) REFERENCES "public".programa( pk_programa ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "public".professor ADD CONSTRAINT professor_fk_turma_fkey FOREIGN KEY ( fk_turma ) REFERENCES "public".turma( pk_turma ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "public".programa ADD CONSTRAINT programa_fk_tipoprograma_fkey FOREIGN KEY ( fk_tipoprograma ) REFERENCES "public".tipo_programa( pk_programa );

ALTER TABLE "public".tipo_programa ADD CONSTRAINT tipo_programa_fk_horario_fkey FOREIGN KEY ( fk_horario ) REFERENCES "public".horario( pk_horario );

