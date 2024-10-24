-- MOSTRA O USUÁRIO LOGADO NO MOMENTO
SELECT session_user();

-- VER TABELA DE USUÁRIOS
SELECT * FROM mysql.user;
SELECT * FROM mysql.db;
SELECT * FROM mysql.tables_priv;
SELECT * FROM mysql.columns_priv;


-- CRIAR UM USUÁRIO 
CREATE USER 'homer'@'localhost';

CREATE USER 'adm'@'localhost' IDENTIFIED BY '12349';


-- MOSTRA OS PRIVILÉGIOS DE UM USUÁRIO
SHOW GRANTS FOR 'adm'@'localhost';

-- AUTORIZA ACESSAR BANCO ESPECÍFICO
GRANT ALL ON escolasenai.* TO 'adm'@'localhost';

-- RETIRA OS PRIVILEGIOS
REVOKE ALL PRIVILEGES , GRANT OPTION FROM 'adm'@'localhost';

-- RECARREGA OS PRIVILEGIOS
FLUSH PRIVILEGES;

-- DELETAR USUÁRIO DA TABELA
DROP USER 'homer'@'localhost';

-- CONCEDE ACESSOS ESPECÍFICOS
GRANT CREATE ON escolasenai.* TO 'adm'@'localhost';


GRANT SELECT, INSERT ON escolasenai.* TO 'adm'@'localhost';