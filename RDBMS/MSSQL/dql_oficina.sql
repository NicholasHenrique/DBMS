USE oficina;

-- Recuperações simples com SELECT Statement
SELECT *
FROM ordemDeServico;

-- Filtros com WHERE Statement
SELECT placaVeiculo, tipoRequisicao
FROM pedido
WHERE id<5;

-- Crie expressões para gerar atributos derivados
SELECT ROUND(SUM(valor),2) valorTotalAcumulado
FROM ordemDeServico;

-- Defina ordenações dos dados com ORDER BY
SELECT *
FROM servico_ordemDeServico
ORDER BY autorizado DESC;

-- Condições de filtros aos grupos – HAVING Statement
SELECT idServico, SUM(valor)
FROM servico_ordemDeServico
GROUP BY idServico 
HAVING SUM(valor) >= 200;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
SELECT c.nome cliente, e.responsavel
FROM cliente c
JOIN pedido p ON p.cpfCliente = c.cpf
JOIN equipe e ON p.idEquipe = e.id;

-- select da view
SELECT * FROM vw_carro_cliente;

-- call procedure
DECLARE @res INT;
EXEC count_veiculo_cpf @cpf= '00000000001', @qtd=@res OUTPUT;
SELECT @res AS 'qtd';

-- call function
SELECT dbo.desconto(1,0.2) AS 'res';