GRANT ALL PRIVILEGES ON oficina.* TO 'dono'@'localhost' WITH GRANT OPTION; -- GRANT ALL PRIVILEGES ON `&` TO 'dono'@'localhost';

GRANT SELECT ON oficina.* TO 'mecanico'@'localhost', 'gerente'@'localhost', 'responsavel_equipe'@'localhost'; -- GRANT SELECT ON *.* TO 'mecanico'@'localhost';

GRANT UPDATE, INSERT ON oficina.equipe_mecanico TO 'responsavel_equipe'@'localhost';
GRANT UPDATE, INSERT ON oficina.ordemDeServico TO 'responsavel_equipe'@'localhost';
GRANT UPDATE, INSERT ON oficina.servico_ordemDeServico TO 'responsavel_equipe'@'localhost';

GRANT INSERT, DELETE, UPDATE ON oficina.* TO 'gerente'@'localhost';

-- REVOKE ALL PRIVILEGES ON *.* FROM 'dono'@'localhost';

-- REVOKE SELECT ON oficina.* FROM 'mecanico'@'localhost';

GRANT INSERT, DELETE, UPDATE, SELECT ON oficina.* TO role_ins_del_upt_sel;

-- GRANT role_ins_del_upt_sel TO 'gerente'@'localhost';

FLUSH PRIVILEGES;

-- SHOW GRANTS FOR 'gerente'@'localhost'; -- SHOW GRANTS;