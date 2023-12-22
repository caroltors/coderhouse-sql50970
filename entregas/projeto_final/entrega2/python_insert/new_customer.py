from faker import Faker

fake = Faker()

def generate_unique_data():
    cpf = fake.numerify(text='###########')
    name = fake.first_name()
    last_name = fake.last_name()
    mail = fake.email()
    
    # Gera um número de telefone brasileiro com no máximo 13 dígitos
    phone = '55' + str(fake.random_number(digits=11))

    return cpf, name, last_name, mail, phone

unique_data_set = set()

# Caminho absoluto para o diretório de destino
output_directory = r'C:\Users\caroltors\Downloads'
output_file = 'dados_gerados.sql'

# Abre o arquivo para escrita no modo absoluto
with open(output_directory + '\\' + output_file, 'w') as file:
    # Inicia a string SQL com o comando INSERT INTO
    sql_insert = "INSERT INTO customer (cpf, name, last_name, mail, phone, created_at) VALUES\n"

    for i in range(1, 101):
        # Garante dados únicos
        while True:
            data = generate_unique_data()
            if data[:-1] not in unique_data_set:  # Ignora o último elemento da tupla (created_at)
                unique_data_set.add(data[:-1])
                break

        cpf, name, last_name, mail, phone = data
        created_at = fake.date_time_between(start_date='-30d', end_date='now').strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]

        # Adiciona os valores à string SQL
        sql_insert += f"('{cpf}', '{name}', '{last_name}', '{mail}', '{phone}', '{created_at}'),\n"

    # Remove a vírgula extra no final e adiciona o ponto e vírgula
    sql_insert = sql_insert.rstrip(',\n') + ';\n'

    # Escreve a string SQL no arquivo
    file.write(sql_insert)

print(f"Dados gerados foram salvos em {output_directory}\\{output_file}")
