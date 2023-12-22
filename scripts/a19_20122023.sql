USE MYSQL;
SHOW TABLES;

SELECT * FROM USER; -- verificar informações de usuarios cadastrados

CREATE USER teste1@localhost; -- criar user nome+dominio

CREATE USER teste2@localhost IDENTIFIED BY 'teste'; -- criar user nome+dominio+senha

ALTER USER teste@localhost IDENTIFIED BY 'teste2'; -- alterar senha do usuario com ALTER

RENAME USER teste@localhost TO teste10@localhost; -- renomear usuario

DROP USER teste10@localhost; -- eliminar usuario

SHOW GRANTS FOR teste1@localhost; -- verificar permissões

GRANT ALL ON *.* TO teste1@localhost; -- dar todas permissoes

GRANT ALL ON sakila.actor TO teste1@localhost; -- permissao para tabela especifica

GRANT SELECT, UPDATE ON sakila.city TO teste1@localhost; -- permissoes seletivas 

GRANT UPDATE, SELECT (last_update) ON sakila.customer TO teste1@localhost; -- permissoes seletivas especificando coluna

REVOKE privileges ON *.* FROM 'teste1@localhost'; -- remover todos privelegios do usuario

REVOKE UPDATE ON *.* FROM 'teste1@localhost'; -- remover privelgio de update do usuario

-- desafio generico

/*
Utilizaremos o banco de dados GAMERS para criar um novo usuário e
concederemos determinadas permissões a ele.*/

-- Crie um usuário chamado coderhouse, com uma senha de mesmo nome.
CREATE USER coderhouse@localhost IDENTIFIED BY 'coderhouse';
-- Estabeleça permissões apenas para leitura de dados sobre a tabela GAME.
GRANT SELECT ON gamer.game TO coderhouse@localhost;
-- Estabeleça permissões de leitura e inserção sobre a tabela CLASS.
GRANT SELECT, INSERT ON gamer.class TO coderhouse@localhost;

-- Abra uma nova aba de conexão e inicie a sessão com esse usuário.
-- Modifique um registro qualquer da tabela GAME e aplique as modificações.
-- Adicione um registro na tabela CLASS.
-- Elimine esse último registro adicionado.
-- Elimine esse último registro adicionado.