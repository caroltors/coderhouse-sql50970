import random

# Número de registros desejados
num_records = 300

# Range de id_product permitido
id_product_range = list(range(48, 95))

# Caminho absoluto para o diretório de destino
output_directory = r'C:\Users\caroltors\Downloads'
output_file = 'order_items_data.sql'

# Abre o arquivo para escrita no modo absoluto
with open(output_directory + '\\' + output_file, 'w') as file:
    # Inicia o script SQL
    sql_script = "INSERT INTO order_items (id_order, id_product, amount) VALUES\n"

    for i in range(1, num_records + 1):
        id_order = i
        id_product = random.choice(id_product_range)
        amount = random.randint(1, 3)
        
        # Adiciona os valores à string SQL
        sql_script += f"({id_order}, {id_product}, {amount}),\n"

    # Remove a vírgula extra no final e adiciona o ponto e vírgula
    sql_script = sql_script.rstrip(',\n') + ';\n'

    # Escreve a string SQL no arquivo
    file.write(sql_script)

print(f'Dados gerados para a tabela `order_items` foram salvos em {output_directory}\\{output_file}')

