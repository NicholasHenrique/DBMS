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
SELECT *
FROM servico_ordemDeServico
GROUP BY idServico 
HAVING valor >= 200;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
SELECT c.nome cliente, e.responsavel
FROM cliente c
JOIN pedido p ON p.cpfCliente = c.cpf
JOIN equipe e ON p.idEquipe = e.id;