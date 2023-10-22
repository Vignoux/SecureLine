
CREATE TABLE tb_usuarios
(
    id      NUMBER        NOT NULL,
    nome    VARCHAR2(100) NOT NULL,
    cpf     number(13)    NOT NULL,
    cep     number(8)     NOT NULL,
    numero  number(5)     NOT NULL,
    foto    varchar2(100) NOT NULL,
    senha   varchar2(8)   NOT NULL,
    email   varchar2(200) NOT NULL,
    celular number(9)     NOT NULL,
    CONSTRAINT pk_tb_usuarios PRIMARY KEY(id)
);


create table tb_categorias(
id              NUMBER        NOT NULL,
CATEGORIA       vARCHAR2(50)  NOT NULL,
CONSTRAINT pk_tb_categoria PRIMARY KEY(id)
);

create table tb_alertas (
id              NUMBER        NOT NULL,
id_usuario      NUMBER        NOT NULL,
id_categoria    NUMBER        NOT NULL,
localidade      VARCHAR2(100) NOT NULL,
descricao       varchar2(200) NOT NULL,
severidade      NUMBER(1)     NOT NULL,
data            date          NOT NULL,
CONSTRAINT pk_tb_alertas PRIMARY KEY(id),
CONSTRAINT fk_tb_alertas_usuarios FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id),
CONSTRAINT fk_tb_alertas_categorias FOREIGN KEY (id_categoria) REFERENCES tb_categorias(id)
)

create table tb_avaliacoes (
id              NUMBER        NOT NULL,
id_alerta       NUMBER        NOT NULL,
aprovado        NUMBER        NOT NULL,
reprovado       NUMBER        NOT NULL,
CONSTRAINT pk_tb_avaliacoes PRIMARY KEY(id),
CONSTRAINT fk_tb_avaliacoes_alertas FOREIGN KEY (id_alerta) REFERENCES tb_alertas(id)
)

create table tb_tutores (
id              NUMBER        NOT NULL,
id_usuario      NUMBER        NOT NULL,
id_usu_tutor    NUMBER        NOT NULL,
CONSTRAINT pk_tb_tutores PRIMARY KEY(id),
CONSTRAINT fk_tb_tutores_usuarios FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id),
CONSTRAINT fk_tb_tutores_usuarios_tutor FOREIGN KEY (id_usu_tutor) REFERENCES tb_usuarios(id)
)
