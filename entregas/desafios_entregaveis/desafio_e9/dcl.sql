-- desafio entregavel 9: DCL

/*
Instruções: deverá criar dois usuários novos e conceder a eles uma série de permissões,
nomeadamente:

>> Aspectos a serem incluídos na entrega:
	Um dos usuários criados deverá ter permissões apenas de leitura sobre todas as tabelas.
	O outro usuário deverá ter permissões de Leitura, Inserção e Modificação de Dados.
	Nenhum deles poderá eliminar registros das tabelas.
	Cada sentença GRANT e CREATE USER deverá ter um comentário detalhando o que faz.*/

-- criacao dos usuarios
CREATE USER adm@localhost IDENTIFIED BY 'adm123';
CREATE USER vendedor@localhost IDENTIFIED BY 'teste123';

-- permissoes de leitura para todas as tabelas de ecommerce
GRANT SELECT ON ecommerce.* TO vendedor@localhost;

-- permissoes de leitura, insercao e modificacao
GRANT SELECT, INSERT, UPDATE ON ecommerce.* TO adm@localhost;
