INSERT INTO cliente (endereco, email) VALUES ('Rua Madeira', 'nicholas@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000001, 'Nicholas', 'Ferreira', 'M', '1996-12-19');
INSERT INTO cliente (endereco, email) VALUES ('Rua Cachoeira', 'miguel@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000002, 'Miguel', 'Augusto', 'M', '2003-05-02');
INSERT INTO cliente (endereco, email) VALUES ('Rua Riacho', 'heloisa@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000003, 'Heloisa', 'Carla', 'F', '2000-09-21');
INSERT INTO cliente (endereco, email) VALUES ('Rua Sertao', 'elcio@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000004, 'Elcio', 'Manoel', 'M', '1985-03-15');
INSERT INTO cliente (endereco, email) VALUES ('Rua Bela', 'isabela@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000005, 'Isabela', 'Maria', 'F', '2000-09-21');
INSERT INTO cliente (endereco, email) VALUES ('Rua Boa Vista', 'manoella@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000006, 'Manoella', 'Lapis', 'F', '2004-09-20');
INSERT INTO cliente (endereco, email) VALUES ('Rua Bonita', 'marcio@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000007, 'Marcio', 'Campos', 'M', '1999-11-12');
INSERT INTO cliente (endereco, email) VALUES ('Rua Morada', 'priscila@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000008, 'Priscila', 'Renata', 'F', '1996-03-04');
INSERT INTO cliente (endereco, email) VALUES ('Rua Oceano', 'roberto@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000009, 'Roberto', 'Candido', 'M', '1988-07-07');
INSERT INTO cliente (endereco, email) VALUES ('Rua Principal', 'marcio@email.com');
INSERT INTO cliente_pf (idClientePF, CPF, nomeInicial, sobrenome, sexo, dataNascimento) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000010, 'Marcio', 'Aparecido', 'M', '1960-10-11');

INSERT INTO cliente (endereco, email) VALUES ('Rua Magalia', 'botascouro@email.com');
INSERT INTO cliente_pj (idClientePJ, CNPJ, razaoSocial) VALUES (1, 00000000000001, 'Botas de Couro');
INSERT INTO cliente (endereco, email) VALUES ('Rua Sorocaba', 'fabricatecido@email.com');
INSERT INTO cliente_pj (idClientePJ, CNPJ, razaoSocial) VALUES (2, 00000000000002, 'Fabrica de Tecido');
INSERT INTO cliente (endereco, email) VALUES ('Rua Pernambuco', 'padariaquente@email.com');
INSERT INTO cliente_pj (idClientePJ, CNPJ, razaoSocial) VALUES (3, 00000000000003, 'Padaria Quente');
INSERT INTO cliente (endereco, email) VALUES ('Rua Recife', 'materiaaisoconstrucaofornaziero@email.com');
INSERT INTO cliente_pj (idClientePJ, CNPJ, razaoSocial) VALUES (4 , 00000000000004, 'Materiais de Construcao Fornaziero');
INSERT INTO cliente (endereco, email) VALUES ('Rua Sao Paulo', 'desentupidoracano@email.com');
INSERT INTO cliente_pj (idClientePJ, CNPJ, razaoSocial) VALUES ((SELECT MAX(idCliente) NEWID FROM cliente), 00000000000005, 'Desentupidora Cano');

INSERT INTO pix (idCliente, CPF, email, telefone) VALUES (8, 8, NULL, NULL), (4, NULL, 'elcio@email.com', NULL), (3, NULL, 'heloisa@email.com', NULL), (7, NULL, NULL, '1532323232');
INSERT INTO cartao_credito (idCliente, nome, numeroCartao, validade, codigoSeguranca) VALUES (11, 'Botas Couro', '0000000000000001', '2025-08-01', '888'), (13, 'Padaria Quente', '0000000000000002', '2026-10-01', '478'), (14, 'Materiais de Construcao Fornaziero', '0000000000000003', '2025-03-01', '668'), (1, 'Nicholas Ferreira', '0000000000000004', '2024-10-01', '254'), (4, 'Elcio Manoel', '0000000000000005', '2027-05-01', '364'), (5, 'Isabela Maria', '0000000000000006', '2027-12-01', '457');

INSERT INTO pedido (idCliente, idCartaoCredito, idPix, statusPedido, descricao, frete) VALUES (7, NULL, NULL, 'Em analise', 'Nao deixar na portaria', 15.75), (9, NULL, 2, 'Enviado para transportadora', 'Campainha com mau contato', 30), (10, 6, NULL, 'Separacao', NULL, 89.74), (12, NULL, 3, 'Cancelado', NULL, 7.36), (1, 1, NULL, 'Enviado para transportadora', NULL, 124.48), (3, 2, NULL, 'Separacao', NULL, 24.60), (5, NULL, NULL, 'Entregue', NULL, 69.84);

INSERT INTO entrega (idPedido, endereco, statusEntrega, codigoRastreio) VALUES (2, 'Rua Oceano', 'Indo para entrega', 2),  (5, 'Rua Madeira', 'Comprador(a) nao localizado', 5), (7, 'Rua Bela', 'Entregue', 7);
-- (1, 'Rua Bonita', 'Pedido ainda nao recebido', 1), 
INSERT INTO produto (nome, infantil, categoria, descricao, avaliacao, valor, tamanho) VALUES ('Arroz Integral', FALSE, 'Alimentos', 'Arroz Integral', 8.7, 13.65, NULL), ('Bermuda Tactel', TRUE, 'Vestuario', 'Estampa com desenhos de carros', 7, 25, 'P'), ('Teclado Gamer', FALSE, 'Eletronico', 'Teclado Gamer com LED', 6, 99, NULL), ('Geladeira', FALSE, 'Eletrodomestico', 'Geladeira Inox de 2 Portas', 8.8, 2565.99, '180cm x 70cm'), ('Toalha', FALSE, 'Mesa/Banho', 'Toalha de Algodao', 7.9, 29.99, '150cm x 35ccm'), ('Mesa', FALSE, 'Moveis', 'Mesa de Jantar Para 6 Pessoas', 9.5, 255.99, '180cm x 60cm');

INSERT INTO pedido_produto (idProduto, idPedido, quantidade) VALUES (1, 1, 1), (5, 2, 3), (3, 3, 2), (4, 4, 1), (2, 5, 15), (4, 6, 1), (2, 6, 3);

INSERT INTO vendedorTerceiro (razaoSocial, endereco, email, nomeFantasia) VALUES ('Light Produtos LTDA', 'Rua Barros', 'light@email.com', 'Light'), ('Loja Estouro LTDA', 'Rua Silva', 'estouro@email.com', 'Estouro'), ('Eletronicos Santan LTDA', 'Rua Pera', 'santana@email.com', 'Santana');

INSERT INTO produto_vendedor_terceiro (idTerceiro, idProduto, quantidade) VALUES (1, 1, 600), (1, 4, 30), (1, 6, 15), (2, 2, 60), (2, 5, 10), (3, 3, 50), (3, 4, 40);

INSERT INTO fornecedor (razaoSocial, cnpj, email) VALUES ('Eletro Marques LTDA', '00000000000011', 'marques@email.com'), ('Moveis Brilho LTDA', '00000000000012', 'brilho@email.com'), ('Roupas Chiqui LTDA', '00000000000013', 'chiqui@email.com'), ('Loja Estouro LTDA', '00000000000014', 'estouro@email.com');

INSERT INTO produto_fornecedor (idFornecedor, idProduto, quantidade) VALUES (1, 3, 10), (1, 4, 15), (2, 5, 10), (3, 2, 50), (4, 2, 60), (4, 5, 10);

INSERT INTO estoque (idFornecedor, endereco) VALUES (1, 'Rua Ibirapuera'), (2, 'Rua Mantiqueira'), (3, 'Rua Sol'), (4, 'Rua Brilho');

INSERT INTO produto_estoque (idProduto, idEstoque, quantidade) VALUES (3, 1, 10), (4, 1, 15), (5, 2, 10), (2, 3, 50), (2, 4, 60), (5, 4, 10);