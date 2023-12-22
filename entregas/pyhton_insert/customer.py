from faker import Faker

fake = Faker()

def generate_unique_data():
    cpf = fake.numerify(text='###########')
    name = fake.first_name()
    last_name = fake.last_name()
    mail = fake.email()

    return cpf, name, last_name, mail

unique_data_set = set()

# Caminho absoluto para o diretório de destino
output_directory = r'C:\Users\caroltors\Downloads\generate_sql'
output_file = 'dados_gerados.sql'

# Abre o arquivo para escrita no modo absoluto
with open(output_directory + '\\' + output_file, 'w') as file:
    for i in range(1, 101):
        id = i

        # Garante dados únicos
        while True:
            data = generate_unique_data()
            if data not in unique_data_set:
                unique_data_set.add(data)
                break

        cpf, name, last_name, mail = data

        created_at = fake.date_time_between(start_date='-30d', end_date='now').strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]

        # Gera a string SQL
        sql_insert = f"INSERT INTO customer (id, cpf, name, last_name, mail, created_at) VALUES ({id}, '{cpf}', '{name}', '{last_name}', '{mail}', '{created_at}');\n"

        # Escreve a string SQL no arquivo
        file.write(sql_insert)

print(f"Dados gerados foram salvos em {output_directory}\\{output_file}")
