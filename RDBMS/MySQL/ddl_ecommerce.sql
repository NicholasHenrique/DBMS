CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

CREATE TABLE IF NOT EXISTS cliente(
idCliente INT AUTO_INCREMENT PRIMARY KEY,
endereco VARCHAR(45),
email VARCHAR(45)
);

ALTER TABLE cliente AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS cliente_pf(
idClientePF INT PRIMARY KEY,
CPF CHAR(11) NOT NULL UNIQUE,
nomeInicial VARCHAR(10) NOT NULL,
sobrenome VARCHAR(25),
sexo ENUM('M','F','Outro'),
dataNascimento DATE NOT NULL,
FOREIGN KEY (idClientePf) REFERENCES cliente (idCliente)
);

ALTER TABLE cliente_pf AUTO_INCREMENT=1;

ALTER TABLE cliente_pf ADD CONSTRAINT u_nome UNIQUE (nomeInicial, sobrenome);

CREATE TABLE IF NOT EXISTS cliente_pj(
idClientePJ INT PRIMARY KEY,
CNPJ CHAR(14),
razaoSocial VARCHAR(45),
FOREIGN KEY (idClientePJ) REFERENCES cliente (idCLiente)
);

CREATE TABLE IF NOT EXISTS pix(
idPix INT AUTO_INCREMENT PRIMARY KEY,
idCliente INT NOT NULL,
CPF CHAR(11),
email VARCHAR(45),
telefone VARCHAR(11),
FOREIGN KEY (idCliente) REFERENCES cliente (idCliente)
);

ALTER TABLE pix AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS cartao_credito(
idCartaoCredito INT AUTO_INCREMENT PRIMARY KEY,
idCliente INT NOT NULL,
nome VARCHAR(45),
numeroCartao CHAR(16) NOT NULL UNIQUE,
validade DATE NOT NULL,
codigoSeguranca CHAR(3),
FOREIGN KEY (idCliente) REFERENCES cliente (idCliente)
);

ALTER TABLE cartao_credito AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS pedido(
idPedido INT AUTO_INCREMENT PRIMARY KEY,
idCliente INT,
idCartaoCredito INT,
idPix INT,
statusPedido ENUM('Em analise', 'Separacao', 'Enviado para transportadora', 'Entregue', 'Cancelado') NOT NULL DEFAULT 'Em analise',
descricao VARCHAR(45),
frete FLOAT DEFAULT 10.0,
FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
FOREIGN KEY (idCartaoCredito) REFERENCES cartao_credito (idCartaoCredito),
FOREIGN KEY (idPix) REFERENCES pix (idPix)
);

ALTER TABLE pedido AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS entrega(
idEntrega INT AUTO_INCREMENT PRIMARY KEY,
idPedido INT,
endereco VARCHAR(45) NOT NULL,
statusEntrega ENUM('Pedido recebido', 'Indo para entrega', 'Entregue', 'Comprador(a) nao localizado', 'Pedido retornou a transportadora', 'Carga roubada'),
codigoRastreio VARCHAR(45) UNIQUE,
FOREIGN KEY (idPedido) REFERENCES pedido (idPedido)
);

ALTER TABLE entrega AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS produto(
idProduto INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(45) NOT NULL,
infantil BOOLEAN NOT NULL DEFAULT FALSE,
categoria ENUM('Alimentos', 'Vestuario', 'Eletronico', 'Eletrodomestico', 'Mesa/Banho', 'Moveis', 'Outro') NOT NULL,
descricao VARCHAR(45),
avaliacao FLOAT DEFAULT 0,
valor FLOAT NOT NULL,
tamanho VARCHAR(20)
);

ALTER TABLE produto AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS pedido_produto(
idProduto INT,
idPedido INT,
quantidade INT NOT NULL,
PRIMARY KEY (idProduto, idPedido),
FOREIGN KEY (idProduto) REFERENCES produto(idProduto),
FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)
);

CREATE TABLE IF NOT EXISTS vendedorTerceiro(
idTerceiro INT AUTO_INCREMENT PRIMARY KEY,
razaoSocial VARCHAR(45) NOT NULL UNIQUE,
endereco VARCHAR(45) NOT NULL,
email VARCHAR(60) NOT NULL,
nomeFantasia VARCHAR(45) NOT NULL
);

ALTER TABLE vendedorTerceiro AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS produto_vendedor_terceiro(
idTerceiro INT,
idProduto INT,
quantidade INT NOT NULL,
PRIMARY KEY (idTerceiro, idProduto),
FOREIGN KEY (idTerceiro) REFERENCES vendedorTerceiro(idTerceiro),
FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

CREATE TABLE IF NOT EXISTS fornecedor(
idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
razaoSocial VARCHAR(45) NOT NULL UNIQUE,
cnpj VARCHAR(14) NOT NULL UNIQUE,
email VARCHAR(45) NOT NULL UNIQUE
);

ALTER TABLE fornecedor AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS produto_fornecedor(
idFornecedor INT,
idProduto INT,
quantidade INT NOT NULL,
PRIMARY KEY (idFornecedor, idProduto),
FOREIGN KEY (idFornecedor) REFERENCES fornecedor(idFornecedor),
FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

CREATE TABLE IF NOT EXISTS estoque(
idEstoque INT AUTO_INCREMENT PRIMARY KEY,
idFornecedor INT NOT NULL,
endereco VARCHAR(45) NOT NULL,
FOREIGN KEY (idFornecedor) REFERENCES fornecedor (idFornecedor)
);

ALTER TABLE estoque AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS produto_estoque(
idProduto INT,
idEstoque INT,
quantidade INT NOT NULL,
PRIMARY KEY (idProduto, idEstoque),
CONSTRAINT fk_produto_estoque_idProduto FOREIGN KEY (idProduto) REFERENCES produto (idProduto),
CONSTRAINT fk_produto_estoque_idEstoque FOREIGN KEY (idEstoque) REFERENCES estoque (idEstoque)
);