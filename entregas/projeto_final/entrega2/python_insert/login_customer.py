import hashlib
import random
from datetime import datetime, timedelta

# Lista de nomes
names = [
    ('Susan', 'Smith'),
    ('Joel', 'Palmer'),
    ('Elizabeth', 'Johnston'),
    ('Eric', 'Becker'),
    ('Michael', 'Cummings'),
    ('Linda', 'Shields'),
    ('Robin', 'Ramos'),
    ('Kristin', 'Allen'),
    ('Brenda', 'Ramirez'),
    ('Linda', 'Simon'),
    ('Lindsey', 'Smith'),
    ('Yvette', 'Bell'),
    ('Thomas', 'Orozco'),
    ('Rebecca', 'Anthony'),
    ('Chad', 'Barrett'),
    ('Thomas', 'Lambert'),
    ('Steven', 'Sparks'),
    ('Ann', 'Brock'),
    ('Noah', 'Mccoy'),
    ('Wendy', 'Cuevas'),
    ('Emily', 'Jackson'),
    ('Frank', 'Anderson'),
    ('Ruben', 'Garcia'),
    ('Nicole', 'Davis'),
    ('Jacob', 'Smith'),
    ('Ryan', 'Roberts'),
    ('Christopher', 'Koch'),
    ('Erik', 'Cantu'),
    ('Aaron', 'Nelson'),
    ('Johnathan', 'Thomas'),
    ('Jennifer', 'Sullivan'),
    ('Justin', 'Rojas'),
    ('John', 'Dunn'),
    ('Shaun', 'Chen'),
    ('Patricia', 'Sutton'),
    ('Andrew', 'Adams'),
    ('Charles', 'Collins'),
    ('Brian', 'Perez'),
    ('Karen', 'Coleman'),
    ('David', 'Morales'),
    ('Joshua', 'Lawson'),
    ('Michael', 'Houston'),
    ('Daniel', 'Sparks'),
    ('Beth', 'Salazar'),
    ('Jennifer', 'Garcia'),
    ('John', 'Aguilar'),
    ('Mary', 'Stewart'),
    ('Timothy', 'Brown'),
    ('Vincent', 'Mills'),
    ('Debra', 'Nunez'),
    ('Stephanie', 'Adams'),
    ('Rebecca', 'Hill'),
    ('Dustin', 'Taylor'),
    ('Sarah', 'Cunningham'),
    ('Erica', 'Robertson'),
    ('Amy', 'Chavez'),
    ('Matthew', 'Williams'),
    ('Julia', 'Nelson'),
    ('Claudia', 'Moore'),
    ('Jennifer', 'Freeman'),
    ('Michael', 'Leonard'),
    ('Kimberly', 'Brown'),
    ('Kimberly', 'Perez'),
    ('Juan', 'Watts'),
    ('Mary', 'Gray'),
    ('April', 'Henderson'),
    ('Dustin', 'Garcia'),
    ('Jenny', 'Rogers'),
    ('Jamie', 'Richardson'),
    ('Matthew', 'Lopez'),
    ('James', 'Schmidt'),
    ('Ian', 'Lowe'),
    ('Duane', 'Jackson'),
    ('Matthew', 'Floyd'),
    ('Ashley', 'Maynard'),
    ('Olivia', 'Brown'),
    ('Kaitlin', 'Lambert'),
    ('Ryan', 'Lowe'),
    ('David', 'Young'),
    ('Breanna', 'Hughes'),
    ('Monique', 'Burns'),
    ('Christine', 'Hansen'),
    ('Caroline', 'Miller'),
    ('Frank', 'Frye'),
    ('Sarah', 'Walsh'),
    ('Kevin', 'Cohen'),
    ('Mark', 'Morse'),
    ('Kevin', 'Booth'),
    ('Kelli', 'Jenkins'),
    ('Whitney', 'Pruitt'),
    ('Dana', 'Romero'),
    ('Chad', 'Fox'),
    ('Colin', 'Salazar'),
    ('Robert', 'Lewis'),
    ('Lori', 'Hernandez'),
    ('Mikayla', 'Delgado'),
    ('Keith', 'Martinez'),
    ('Lori', 'Williams'),
    ('Brandi', 'Long'),
    ('Pamela', 'Young'),
    ]

def generate_customer_script():
    script = "INSERT INTO login_customer (id_customer, username, password, last_login) VALUES\n"

    for i, (first_name, last_name) in enumerate(names, start=1):
        id_customer = i

        # Gera um username combinando as primeiras letras do nome e sobrenome
        username = f"{first_name[0].lower()}{last_name.lower()}"

        # Gera uma senha aleatória e calcula a hash
        password = hashlib.sha256(f"password{i}".encode()).hexdigest()

        # Gera uma data de last_login aleatória nos últimos 365 dias
        last_login = datetime.now() - timedelta(days=random.randint(0, 365))

        script += f"({id_customer}, '{username}', '{password}', '{last_login.strftime('%Y-%m-%d %H:%M:%S')}')"

        if i != len(names):
            script += ",\n"
        else:
            script += ";"

    return script

# Chama a função para gerar o script
generated_script = generate_customer_script()

# Imprime o script gerado
print(generated_script)
