USE oficina;

INSERT INTO cliente (cpf, nome, genero, dataNascimento, endereco, cnh) VALUES ('00000000001', 'Nicholas', 'M', '1996-12-19', 'Rua Professor', '0000000001'), 
	('00000000002', 'Marcio', 'M', '2001-07-12', 'Rua Principe', '0000000002'),
    ('00000000003', 'Leticia', 'F', '1995-01-30', 'Rua Riacho', '0000000003'),
    ('00000000004', 'Heloisa', 'F', '2003-10-07', 'Rua Paraiso', '0000000004'),
    ('00000000005', 'Barbara', 'F', '2000-06-25', 'Rua Rio', '0000000005'),
    ('00000000006', 'Miguel', 'M', '1999-11-28', 'Rua Modelo', '0000000006'),
    ('00000000007', 'Renan', 'M', '1997-05-06', 'Rua Patria', '0000000007');

INSERT INTO veiculo (placa, cpfCliente, modelo, marca, ano) VALUES
	('AAA1111', '00000000001', 'RX-7', 'Mazda', '1994'),
    ('SD874SE', '00000000001', 'Supra', 'Toyota', '1993'),
    ('47SEC7D', '00000000001', 'Fiesta', 'Ford', '2020'),
    ('BBB2222', '00000000002', 'Prisma', 'Chevrolet', '2019'),
    ('CCC3333', '00000000002', 'CG150', 'Honda', '2019'),
    ('DDD4444', '00000000003', 'Palio', 'Fiat', '2002'),
    ('EEE5555', '00000000004', 'R1000', 'BMW', '2021'),
    ('FFF6666', '00000000005', 'Corsa', 'Chevrolet', '2000'),
    ('GGG7777', '00000000006', 'Etios', 'Toyota', '2018'),
    ('HHH8888', '00000000007', 'CRV', 'Honda', '2022');

INSERT INTO mecanico (cpf, nome, genero, dataNascimento, endereco, especialidade) VALUES
	('00000000008', 'Roberto', 'M', '1988-07-15', 'Rua Mar', 'Transmissao'),
    ('00000000009', 'Marcelo', 'M', '1980-04-11', 'Rua Oceano', 'Cambio'),
    ('00000000010', 'Lucas', 'M', '1979-03-26', 'Rua Salvador', 'Motor'),
    ('00000000011', 'Marcia', 'F', '1990-08-05', 'Rua Presidente', 'Transmissao'),
    ('00000000012', 'Mario', 'M', '1983-09-30', 'Rua Rei', 'Eletrica'),
    ('00000000013', 'Bruna', 'F', '1981-02-28', 'Rua Castelo', 'Eletrica'),
    ('00000000014', 'Pedro', 'M', '1995-09-22', 'Rua Porto', 'Motor'),
    ('00000000015', 'Fred', 'M', '1981-01-03', 'Rua Marte', 'Interior'),
    ('00000000016', 'Gustavo', 'M', '1999-10-09', 'Rua Muralha', 'Lataria');

-- SET IDENTITY_INSERT [dbo].[equipe] ON;

--INSERT INTO [dbo].[equipe] ( [id], [responsavel] ) VALUES ( 1, 'Marcia');

-- SET IDENTITY_INSERT [dbo].[equipe] OFF;

INSERT INTO equipe (responsavel) VALUES
	('Marcia'),
    ('Pedro'),
    ('Fred'),
    ('Gustavo');

INSERT INTO equipe_mecanico (idEquipe, mecanico) VALUES
	(1, 'Marcia'),
    (1, 'Marcelo'),
    (1, 'Lucas'),
    (1, 'Mario'),
    (2, 'Pedro'),
    (2, 'Bruna'),
    (2, 'Marcelo'),
    (2, 'Roberto'),
    (3, 'Fred'),
    (3, 'Pedro'),
    (3, 'Marcia'),
    (4, 'Gustavo'),
    (4, 'Fred');
    
INSERT INTO pedido (cpfCliente, placaVeiculo, idEquipe, tipoRequisicao) VALUES 
	('00000000001', '47SEC7D', 1, 'Troca de Oleo'),
    ('00000000001', 'SD874SE', 2, 'Alinhamento e Balanceamento'),
    ('00000000002', 'BBB2222', 1, 'Troca do parabrisa'),
    ('00000000004', 'EEE5555', 1, 'Troca dos freios'),
    ('00000000006', 'GGG7777', 2, 'Remap'),
    ('00000000007', 'HHH8888', 4, 'Troca dos bancos');
    
INSERT INTO ordemDeServico (idEquipe, idPedido, dataEntrega, dataEmissao, valor) VALUES
	(1, 1, '2022-09-28', '2022-09-26', 70),
    (2, 2, '2022-09-29', '2022-09-23', 850.99),
    (1, 3, '2022-09-26', '2022-09-20', 750.50),
    (1, 4, '2022-09-30', '2022-09-21', 375.65),
    (2, 5, '2022-09-30', '2022-09-20', 1125.98),
    (4, 6, '2022-09-27', '2022-09-23', 298.84);
    
INSERT INTO servico (nome, descricao, valor) VALUES
	('Troca de Oleo do Motor', 'Troca de Oleo do Motor', 50),
    ('Troca de Pneu', 'Retirada do Pneu', 100),
    ('Alinhamento e Balanceamento', 'Alinhamento e Balanceamento', 75),
    ('Troca do parabrisa', 'Troca do parabrisa', 500),
    ('Polimento de Vidro', 'Polimento de Vidro', 90),
    ('Troca do freio', 'Troca do freio', 110.45),
    ('Troca do fluido do freio', 'Troca do fluido do freio', 65.24),
    ('Troca de Motor', 'Remocao de Motor', 415.48),
    ('Troca de Mangueira', 'Troca de Mangueira', 54.87),
    ('Mapeamento Eletrico', 'Mapeamento Eletrico', 89.87),
    ('Fluxo Ar/Combustivel', 'Fluxo Ar/Combustivel', 215.84),
    ('Nivelamento Cabecote', 'Nivelamento Cabecote', 89.71),
    ('Troca de Banco', 'Troca de Banco', 125.41);

INSERT INTO servico_ordemDeServico (idOrdemDeServico, idServico, quantidade, valor, autorizado) VALUES
	(1, 1, 1, 50, 'SIM'),
    (2, 2, 4, 400, 'SIM'),
    (2, 3, 4, 300, 'SIM'),
    (3, 4, 1, 220.90, 'NAO'),
    (4, 6, 2, 500, 'SIM'),
    (5, 8, 1, 415.48, 'SIM'),
    (5, 9, 3, 164.61, 'SIM'),
    (5, 10, 1, 89.87, 'SIM'),
    (5, 11, 1, 215.84, 'SIM'),
    (5, 12, 6, 538.26, 'NAO'),
    (6, 13, 2, 250.82, 'SIM');