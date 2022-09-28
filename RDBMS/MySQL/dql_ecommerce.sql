-- Quantos pedidos foram feitos por cada cliente?
SELECT cliente.idCliente, COUNT(*)
FROM cliente
INNER JOIN pedido ON pedido.idCliente = cliente.idCliente
GROUP BY cliente.idCliente;

-- Algum vendedor também é fornecedor?
SELECT fornecedor.razaoSocial
FROM fornecedor
INNER JOIN vendedorTerceiro ON fornecedor.razaoSocial = vendedorTerceiro.razaoSocial;

-- Relação de produtos fornecedores e estoques
SELECT *
FROM fornecedor
INNER JOIN estoque ON fornecedor.idFornecedor = estoque.idFornecedor;

-- Relação de nomes dos fornecedores e nomes dos produtos
SELECT fornecedor.razaoSocial, produto.nome
FROM fornecedor
INNER JOIN produto_fornecedor ON produto_fornecedor.idFornecedor = fornecedor.idFornecedor
INNER JOIN produto ON produto.idProduto = produto_fornecedor.idProduto;