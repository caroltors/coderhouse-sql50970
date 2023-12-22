import random
from datetime import datetime, timedelta

# Lista de id_pay e id_customer
id_pay_customer_list = [
    (1, 12), (2, 94), (3, 44), (4, 20), (5, 75), (6, 88), (7, 40), (8, 87), (9, 62), (10, 67),
    (11, 39), (12, 96), (13, 41), (14, 10), (15, 40), (16, 79), (17, 94), (18, 53), (19, 53), (20, 19),
    (21, 67), (22, 6), (23, 79), (24, 96), (25, 6), (26, 98), (27, 39), (28, 43), (29, 12), (30, 27),
    (31, 2), (32, 25), (33, 51), (34, 74), (35, 31), (36, 73), (37, 31), (38, 65), (39, 30), (40, 87),
    (41, 3), (42, 46), (43, 73), (44, 50), (45, 49), (46, 2), (47, 43), (48, 55), (49, 93), (50, 87),
    (51, 9), (52, 76), (53, 87), (54, 41), (55, 53), (56, 77), (57, 42), (58, 52), (59, 83), (60, 91),
    (61, 27), (62, 78), (63, 2), (64, 42), (65, 33), (66, 82), (67, 59), (68, 29), (69, 60), (70, 61),
    (71, 22), (72, 59), (73, 38), (74, 89), (75, 3), (76, 86), (77, 69), (78, 34), (79, 18), (80, 44),
    (81, 88), (82, 50), (83, 46), (84, 42), (85, 10), (86, 36), (87, 28), (88, 90), (89, 26), (90, 41),
    (91, 47), (92, 14), (93, 13), (94, 36), (95, 13), (96, 41), (97, 32), (98, 4), (99, 72), (100, 66)
]

# Lista de id_status
id_status_list = [1, 2, 3, 4, 5, 6, 7]

# Número de registros desejados
num_records = 300

# Caminho absoluto para o diretório de destino
output_directory = r'C:\Users\caroltors\Downloads'
output_file = 'orders_data.sql'

# Abre o arquivo para escrita no modo absoluto
with open(output_directory + '\\' + output_file, 'w') as file:
    # Inicia o script SQL
    sql_script = "INSERT INTO `order` (id_pay, id_customer, id_status, created_at, updated_at) VALUES\n"

    for i in range(1, num_records + 1):
        id_pay, id_customer = random.choice(id_pay_customer_list)
        id_status = random.choice(id_status_list)
        created_at = datetime.now() - timedelta(days=random.randint(1, 365), hours=random.randint(1, 24), minutes=random.randint(1, 60))
        
        # Se id_status for 1 ou 2, updated_at deve ser nulo
        if id_status in [1, 2]:
            updated_at = 'NULL'
        else:
            updated_at = created_at + timedelta(days=random.randint(1, 30), hours=random.randint(1, 24), minutes=random.randint(1, 60))
            updated_at = f"'{updated_at.strftime('%Y-%m-%d %H:%M:%S.%f')}'"
        
        # Adiciona os valores à string SQL
        sql_script += f"({id_pay}, {id_customer}, {id_status}, '{created_at.strftime('%Y-%m-%d %H:%M:%S.%f')}', {updated_at}),\n"

    # Remove a vírgula extra no final e adiciona o ponto e vírgula
    sql_script = sql_script.rstrip(',\n') + ';\n'

    # Escreve a string SQL no arquivo
    file.write(sql_script)

print(f'Dados gerados para a tabela `order` foram salvos em {output_directory}\\{output_file}')
