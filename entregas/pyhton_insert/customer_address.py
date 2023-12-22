import random
from faker import Faker

fake = Faker('pt_BR')  # Configuração para dados fictícios brasileiros

def generate_customer_address_script():
    script = "INSERT INTO customer_address (id_customer, postal_code, country, state, city, address) VALUES\n"

    unique_customers = set()

    for i in range(1, 101):
        id_customer = random.randint(1, 100)

        # Garante que o id_customer seja único
        while id_customer in unique_customers:
            id_customer = random.randint(1, 100)
        unique_customers.add(id_customer)

        postal_code = random.randint(10000000, 99999999)  # CEPs do Brasil
        country = "Brasil"
        
        # Lista de estados brasileiros
        brazilian_states = ["Acre", "Alagoas", "Amapá", "Amazonas", "Bahia", "Ceará", "Distrito Federal",
                            "Espírito Santo", "Goiás", "Maranhão", "Mato Grosso", "Mato Grosso do Sul", 
                            "Minas Gerais", "Pará", "Paraíba", "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro", 
                            "Rio Grande do Norte", "Rio Grande do Sul", "Rondônia", "Roraima", "Santa Catarina", 
                            "São Paulo", "Sergipe", "Tocantins"]
        
        state = random.choice(brazilian_states)
        
        # Lista de cidades fictícias do Brasil
        brazilian_cities = ["São Paulo", "Rio de Janeiro", "Belo Horizonte", "Brasília", "Salvador", "Curitiba",
                            "Recife", "Fortaleza", "Porto Alegre", "Manaus", "Belém", "Goiânia", "Cuiabá", 
                            "Florianópolis", "Natal", "Campo Grande", "Teresina", "João Pessoa", "Vitória", 
                            "São Luís", "Aracaju", "Palmas", "Boa Vista", "Porto Velho", "Maceió", "Macapá", 
                            "Rio Branco"]
        
        city = random.choice(brazilian_cities)
        
        # Geração de endereço fictício usando a biblioteca faker
        address = fake.street_address()

        script += f"({id_customer}, {postal_code}, '{country}', '{state}', '{city}', '{address}')"
        
        if i != 100:
            script += ",\n"
        else:
            script += ";"

    return script

# Chama a função para gerar o script
generated_script = generate_customer_address_script()

# Imprime o script gerado
print(generated_script)
