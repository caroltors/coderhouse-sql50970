

/* TABELA CUSTOMER
1. Na primeira tabela, se tiver registros, deverá eliminar alguns deles iniciando previamente uma transação. Se não 
tiver registros, substitua eliminação por inserção.
2. Deixe em uma próxima linha a sentença Rollback e em uma linha posterior a sentença Commit.
3. Se eliminar registros importantes, deixe as sentenças preparadas para reinseri-los.
*/


START TRANSACTION; -- iniciar transação
DELETE FROM customer WHERE id BETWEEN 1 AND 5; -- deletar dados

ROLLBACK; -- desfazer delete, possibilitado antes de COMMIT

COMMIT;


/* TABELA CARRIER
1. Na segunda tabela, insira oito novos registros, iniciando também uma transação. 
2. Adicione um savepoint após a inserção do registro #4 e outro savepoint após o registro #8.
3. Adicione em uma linha comentada a sentença de eliminação do savepoint dos primeiros 4 registros inseridos.
*/

START TRANSACTION; -- iniciar transação
INSERT INTO carrier (id, name, value) VALUES ('FastExpress', 5.25);
INSERT INTO carrier (id, name, value) VALUES ('SpeedyShip', 6.10);
INSERT INTO carrier (id, name, value) VALUES ('SwiftLogistics', 4.90);
INSERT INTO carrier (id, name, value) VALUES ('RapidTransit', 7.50);
SAVEPOINT c1;
INSERT INTO carrier (id, name, value) VALUES ('QuickMovers', 5.75);
INSERT INTO carrier (id, name, value) VALUES ('DynamicFreight', 6.80);
INSERT INTO carrier (id, name, value) VALUES ('PrimeCargo', 5.40);
INSERT INTO carrier (id, name, value) VALUES('ReliableLogistics', 7.20);
SAVEPOINT c2;

ROLLBACK TO c1; -- voltar para o primeiro savepoint c1, removerá os registros após o savepoint c1
RELEASE SAVEPOINT c1; -- eliminar primeiro savepoint c1
