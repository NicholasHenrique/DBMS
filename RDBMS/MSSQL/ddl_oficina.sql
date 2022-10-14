GO
CREATE DATABASE oficina;
GO

USE oficina;

CREATE TABLE cliente(
cpf CHAR(11),
nome VARCHAR(45) NOT NULL UNIQUE,
genero VARCHAR(5) NOT NULL CHECK (genero IN('M', 'F', 'Outro')),
dataNascimento DATE NOT NULL,
endereco VARCHAR(100) NOT NULL,
cnh CHAR(10) NOT NULL UNIQUE,
CONSTRAINT pk_cliente PRIMARY KEY (cpf)
);

CREATE TABLE veiculo(
placa CHAR(7),
cpfCliente CHAR(11) NOT NULL,
modelo VARCHAR(30) NOT NULL,
marca VARCHAR(30) NOT NULL,
ano CHAR(4) NOT NULL,
PRIMARY KEY (placa),
CONSTRAINT fk_veiculo FOREIGN KEY (cpfCliente) REFERENCES cliente(cpf) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE mecanico(
cpf CHAR(11),
nome VARCHAR(45) NOT NULL,
genero VARCHAR(5) NOT NULL,
dataNascimento DATE NOT NULL,
endereco VARCHAR(100) NOT NULL,
especialidade VARCHAR(30) NOT NULL,
UNIQUE(nome)
);

ALTER TABLE mecanico ADD CHECK (genero IN('M', 'F', 'Outro'));

ALTER TABLE mecanico ALTER COLUMN cpf CHAR(11) NOT NULL;
ALTER TABLE mecanico ADD PRIMARY KEY (cpf);

-- ALTER TABLE mecanico ADD UNIQUE (nome);
-- ALTER TABLE mecanico ADD CONSTRAINT u_nome UNIQUE (nome);

CREATE TABLE equipe(
id TINYINT IDENTITY NOT NULL,
responsavel VARCHAR(45) NOT NULL
);

ALTER TABLE equipe ADD CONSTRAINT pk_equipe PRIMARY KEY (id);
ALTER TABLE equipe ADD CONSTRAINT fk_equipe FOREIGN KEY (responsavel) REFERENCES mecanico(nome) ON DELETE CASCADE ON UPDATE CASCADE;
GO

CREATE TABLE equipe_mecanico(
idEquipe TINYINT,
mecanico VARCHAR(45),
PRIMARY KEY (idEquipe, mecanico),
FOREIGN KEY (idEquipe) REFERENCES equipe(id) ON DELETE CASCADE ON UPDATE CASCADE,
-- FOREIGN KEY (mecanico) REFERENCES mecanico(nome) ON DELETE NO ACTION ON UPDATE NO ACTION
);
-- a table cannot appear more than one time in a list of all the cascading referential actions that are started by either a DELETE or an UPDATE statement. The tree of cascading referential actions must only have one path to a particular table on the cascading referential actions tree.
GO

CREATE TRIGGER del_mecanico_nome_equipe_mecanico
ON mecanico
FOR DELETE
AS
BEGIN
    DELETE FROM equipe_mecanico
    WHERE mecanico = (SELECT nome FROM DELETED)
END
GO

CREATE TRIGGER upt_mecanico_nome_equipe_mecanico
ON mecanico
FOR UPDATE
AS
BEGIN
	IF UPDATE (nome)
	BEGIN
		DECLARE
		@del_nome VARCHAR(45)

		SELECT @del_nome = nome FROM DELETED

		UPDATE equipe_mecanico SET equipe_mecanico.mecanico = i.nome
		FROM INSERTED i WHERE equipe_mecanico.mecanico = @del_nome
	END
END
GO

CREATE TABLE pedido(
id INT IDENTITY(1,1) PRIMARY KEY,
cpfCliente CHAR(11) NOT NULL,
placaVeiculo CHAR(7) NOT NULL,
idEquipe TINYINT,
tipoRequisicao VARCHAR(45) NOT NULL,
FOREIGN KEY (cpfCliente) REFERENCES cliente(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
-- FOREIGN KEY (placaVeiculo) REFERENCES veiculo(placa) ON DELETE NO ACTION ON UPDATE NO ACTION,
-- FOREIGN KEY (idEquipe) REFERENCES equipe(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

CREATE TRIGGER del_veiculo_placa_pedido
ON veiculo
FOR DELETE
AS
BEGIN
    DELETE FROM pedido
    WHERE placaVeiculo = (SELECT placa FROM DELETED)
END
GO

CREATE TRIGGER upt_veiculo_placa_pedido
ON veiculo
FOR UPDATE
AS
BEGIN
	IF UPDATE (placa)
	BEGIN
		DECLARE
		@del_placa CHAR(7)

		SELECT @del_placa = placa FROM DELETED

		UPDATE pedido SET placaVeiculo = i.placa
		FROM INSERTED i WHERE placaVeiculo = @del_placa
	END
END
GO

CREATE TRIGGER del_equipe_id_pedido
ON equipe
FOR DELETE
AS
BEGIN
    DELETE FROM pedido
    WHERE idEquipe = (SELECT id FROM DELETED)
END
GO

CREATE TRIGGER upt_equipe_id_pedido
ON equipe
FOR UPDATE
AS
BEGIN
	IF UPDATE (id)
	BEGIN
		DECLARE
		@del_id INT

		SELECT @del_id = id FROM DELETED

		UPDATE pedido SET idEquipe = i.id
		FROM INSERTED i WHERE idEquipe = @del_id
	END
END
GO

CREATE TABLE ordemDeServico(
id INT IDENTITY(1,1) PRIMARY KEY,
idEquipe TINYINT NOT NULL,
idPedido INT NOT NULL,
dataEntrega DATE NOT NULL,
dataEmissao DATE NOT NULL,
valor FLOAT NOT NULL DEFAULT 0,
FOREIGN KEY (idEquipe) REFERENCES equipe(id) ON DELETE CASCADE ON UPDATE CASCADE,
-- FOREIGN KEY (idPedido) REFERENCES pedido(id) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE ordemDeServico ADD CHECK (dataEmissao <= dataEntrega);
GO

CREATE TRIGGER del_pedido_id_ordemDeServico
ON pedido
FOR DELETE
AS
BEGIN
    DELETE FROM ordemDeServico
    WHERE idPedido = (SELECT id FROM DELETED)
END
GO

CREATE TRIGGER upt_pedido_id_ordemDeServico
ON pedido
FOR UPDATE
AS
BEGIN
	IF UPDATE (id)
	BEGIN
		DECLARE
		@del_id INT

		SELECT @del_id = id FROM DELETED

		UPDATE ordemDeServico SET idPedido = i.id
		FROM INSERTED i WHERE idPedido = @del_id
	END
END
GO

CREATE TABLE servico(
id TINYINT IDENTITY(1,1) PRIMARY KEY,
nome VARCHAR(45) NOT NULL,
descricao VARCHAR(45) NOT NULL,
valor FLOAT NOT NULL,
CHECK (valor>=0)
);

CREATE TABLE servico_ordemDeServico(
idOrdemDeServico INT,
idServico TINYINT,
quantidade TINYINT NOT NULL,
valor FLOAT NOT NULL,
autorizado CHAR(3),
PRIMARY KEY (idOrdemDeServico, idServico),
FOREIGN KEY (idOrdemDeServico) REFERENCES ordemDeServico(id) ON DELETE CASCADE ON UPDATE CASCADE,
-- FOREIGN KEY (idServico) REFERENCES servico(id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ch_valor CHECK (valor>=0)
);
GO

-- ALTER TABLE servico ADD CONSTRAINT ck_valor CHECK (valor>0);

CREATE TRIGGER del_servico_id_servico_ordemDeServico
ON servico
FOR DELETE
AS
BEGIN
    DELETE FROM servico_ordemDeServico
    WHERE idServico = (SELECT id FROM DELETED)
END
GO

CREATE TRIGGER upt_servico_id_servico_ordemDeServico
ON servico
FOR UPDATE
AS
BEGIN
	IF UPDATE (id)
	BEGIN
		DECLARE
		@del_id INT

		SELECT @del_id = id FROM DELETED

		UPDATE servico_ordemDeServico SET idServico = i.id
		FROM INSERTED i WHERE idServico = @del_id
	END
END
GO

CREATE VIEW vw_carro_cliente
AS
(
SELECT placa, modelo, marca, ano, nome
FROM veiculo
INNER JOIN cliente ON cliente.cpf = veiculo.cpfCliente
);
GO

-- DROP VIEW vw_carro_cliente;

CREATE NONCLUSTERED INDEX servico_nome ON servico (nome);
GO

-- ALTER TABLE servico DROP INDEX servico_nome;

CREATE PROCEDURE count_veiculo_cpf
@cpf CHAR(11),
@qtd INT OUT
AS
BEGIN
	SELECT @qtd = COUNT(*)
	FROM veiculo
	WHERE cpfCliente = @cpf;
END
GO
-- DROP PROCEDURE count_veiculo_cpf;


CREATE FUNCTION desconto (@o_s TINYINT, @d FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @valor_final FLOAT;
	SELECT @valor_final = valor*(1-@d)
    FROM ordemDeServico
    WHERE id = @o_s;
    RETURN @valor_final;
END

-- DROP FUNCTION desconto;
GO

CREATE TRIGGER ins_ordemDeServico
ON servico_ordemDeServico
AFTER INSERT
AS
BEGIN
	UPDATE ordemDeServico SET ordemDeServico.valor = ordemDeServico.valor + (i.valor * i.quantidade)
	FROM INSERTED i
    WHERE ordemDeServico.id = i.idOrdemDeServico;
END
GO
-- DROP TRIGGER ins_ordemServico;

CREATE LOGIN dono WITH PASSWORD = 'dono';
CREATE USER dono FOR LOGIN dono;
CREATE LOGIN gerente WITH PASSWORD = 'gerente';
CREATE USER gerente FOR LOGIN gerente;
CREATE LOGIN mecanico WITH PASSWORD = 'mecanico';
CREATE USER mecanico FOR LOGIN mecanico;
CREATE LOGIN responsavel_equipe WITH PASSWORD = 'responsavel_equipe';
CREATE USER responsavel_equipe FOR LOGIN responsavel_equipe;

CREATE ROLE role_ins_del_upt_sel;

-- DROP USER dono;
-- DROP LOGIN responsavel_equipe;

-- DROP DATABASE oficina;
