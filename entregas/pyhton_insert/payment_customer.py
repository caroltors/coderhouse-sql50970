import random

def generate_payment_script():
    script = "INSERT INTO payment_customer (id_customer, pay_type, card_number, exp_date) VALUES\n"

    payment_types = ["Credit", "Debit", "Pix", "Billet"]

    for i in range(1, 101):
        id_customer = random.randint(1, 100)
        
        # Escolhe aleatoriamente um tipo de pagamento
        pay_type = random.choice(payment_types)

        # Gera número de cartão e data de expiração apenas se o tipo de pagamento for Crédito ou Débito
        if pay_type in ["Credit", "Debit"]:
            card_number = f"****-****-****-{random.randint(1000, 9999)}"
            exp_date = f"'{random.randint(1, 12)}/{random.randint(23, 30)}'"
        else:
            card_number = "NULL"
            exp_date = "NULL"

        script += f"({id_customer}, '{pay_type}', '{card_number}', {exp_date})"

        if i != 100:
            script += ",\n"
        else:
            script += ";"

    return script

# Chama a função para gerar o script
generated_script = generate_payment_script()

# Imprime o script gerado
print(generated_script)
