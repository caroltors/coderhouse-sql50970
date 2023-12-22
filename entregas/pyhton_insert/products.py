import random

# Categorias: Eletronicos; Papelaria;Escritório;Ferramentas;Eletrica;Gamer;Casa e Utensilios;Decoração;Jogos e Entretenimento

# Lista de produtos e descrições associadas às categorias
products_and_descriptions = [
    ('1', 'Smartphone', 'Smartphone de última geração com tela AMOLED e câmera de alta resolução.'),
    ('1', 'Notebook Ultrabook', 'Notebook leve e potente, perfeito para produtividade e entretenimento.'),
    ('1', 'Caixa de Som Bluetooth', 'Caixa de som portátil com conectividade Bluetooth.'),
    ('1', 'Mouse sem Fio', 'Mouse ergonômico sem fio para facilitar a navegação no computador.'),
    ('1', 'HD Externo 1TB', 'Disco rígido externo de 1TB para armazenamento adicional.'),
    ('2', 'Livro "Dom Quixote"', 'Clássico da literatura mundial, a história de Dom Quixote e seu fiel escudeiro Sancho Pança.'),
    ('2', 'Calculadora Científica', 'Calculadora com funções avançadas para estudantes e profissionais.'),
    ('2', 'Câmera Digital Compacta', 'Câmera de alta resolução para capturar momentos especiais.'),
    ('3', 'Caneta Esferográfica', 'Caneta de escrita suave e design elegante para uso diário.'),
    ('3', 'Caderno de Anotações', 'Caderno pautado com capa dura, ideal para anotações e desenhos.'),
    ('3', 'Pasta Executiva', 'Pasta de couro para documentos e materiais de trabalho.'),
    ('4', 'Jogo de Chaves de Fenda', 'Conjunto de chaves de fenda de alta qualidade para trabalhos manuais.'),
    ('4', 'Parafusadeira Elétrica', 'Parafusadeira potente para trabalhos de montagem e desmontagem.'),
    ('4', 'Furadeira de Impacto', 'Furadeira potente para perfurações em diferentes materiais.'),
    ('4', 'Kit de Ferramentas', 'Kit completo com diversas ferramentas para trabalhos manuais.'),
    ('4', 'Alicate Universal', 'Alicate versátil para diversos tipos de trabalhos manuais.'),
    ('4', 'Chave de Fenda Phillips', 'Chave de fenda com ponta Phillips para trabalhos específicos.'),
    ('4', 'Chave de Fenda de Precisão', 'Chave de fenda pequena para trabalhos delicados.'),
    ('5', 'Lâmpada LED 15W', 'Lâmpada de LED econômica e durável para iluminação residencial.'),
    ('5', 'Estabilizador de Energia', 'Estabilizador para proteger seus eletrônicos contra variações de energia.'),
    ('6', 'Mousepad Gamer', 'Mousepad de grande tamanho e superfície otimizada para jogos.'),
    ('6', 'Teclado Mecânico para Games', 'Teclado resistente e responsivo para gamers.'),
    ('6', 'Mousepad', 'Tapete de mouse com superfície suave para movimentos precisos.'),
    ('6', 'Adaptador Universal de Tomadas', 'Adaptador para tomadas elétricas em padrões internacionais.'),
    ('7', 'Cadeira Executiva', 'Cadeira de escritório ergonômica com design executivo.'),
    ('7', 'Jogo de Toalhas de Banho', 'Conjunto de toalhas macias e absorventes para o banho.'),
    ('7', 'Máquina de Café Expresso', 'Máquina automática para preparar café expresso.'),
    ('7', 'Cadeira Gamer', 'Cadeira ergonômica para gamers, confortável durante longas sessões de jogo.'),
    ('8', 'Quadro Decorativo', 'Quadro abstrato para decorar sua casa ou escritório.'),
    ('8', 'Mesa de Centro', 'Mesa elegante para a sala de estar, com design moderno.'),
    ('8', 'Abajur Decorativo', 'Abajur com design moderno para iluminação decorativa.'),
    ('8', 'Organizador de Gavetas', 'Caixa organizadora para gavetas, mantenha tudo em ordem.'),
    ('8', 'Aparador de Livros', 'Aparador decorativo para organizar seus livros com estilo.'),
    ('8', 'Almofada Decorativa', 'Almofada com estampa decorativa para sofás e cadeiras.'),
    ('8', 'Tapete Antiderrapante', 'Tapete resistente e antiderrapante para ambientes diversos.'),
    ('8', 'Luminária de Mesa LED', 'Luminária com ajuste de intensidade e temperatura de cor.'),
    ('9', 'Jogo de Cartas "Poker"', 'Baralho profissional para jogar poker e outros jogos de cartas.'),
    ('9', 'Controle sem Fio para Games', 'Controle de videogame sem fio para uma experiência de jogo confortável.'),
    ('9', 'Controle sem Fio para PlayStation 5', 'Controle sem fio avançado para a última geração de consoles PlayStation, oferecendo uma experiência de jogo imersiva.'),
    ('9', 'Jogo de Tabuleiro Estratégico - Edição Especial', 'Edição especial de um jogo de tabuleiro estratégico desafiador, perfeito para horas de diversão com amigos e família.'),
    ('9', 'Headset Gamer com Cancelamento de Ruído', 'Headset gamer com tecnologia de cancelamento de ruído, proporcionando áudio nítido e imersivo durante suas sessões de jogo.'),
    ('9', 'Console de Video Game Portátil', 'Console de video game portátil com uma ampla variedade de jogos clássicos e modernos, perfeito para jogar em movimento.'),
    ('9', 'Coleção de Pôsteres de Jogos Clássicos', 'Coleção de pôsteres decorativos apresentando arte icônica de jogos clássicos, perfeita para os entusiastas de jogos.'),
    ('1', 'Tablet Android de Alto Desempenho - Modelo TabX Pro', 'Tablet Android com processador potente, tela de alta resolução e ampla capacidade de armazenamento para entretenimento e produtividade.'),
    ('1', 'Relógio Inteligente - Edição ConnectX', 'Relógio inteligente com monitor de saúde, notificações e conectividade avançada, projetado para uma vida conectada.'),
    ('1', 'Câmera de Segurança Residencial', 'Câmera de segurança com visão noturna e recursos de monitoramento remoto para proteger sua residência.'),
    ('1', 'Impressora Multifuncional a Laser', 'Impressora multifuncional a laser com alta velocidade de impressão e recursos avançados para escritórios e uso doméstico.'),
]

# Caminho absoluto para o diretório de destino
output_directory = r'C:\Users\caroltors\Downloads'
output_file = 'dados_gerados.sql'

# Abre o arquivo para escrita no modo absoluto
with open(output_directory + '\\' + output_file, 'w') as file:
    # Inicia a string SQL com o comando INSERT INTO
    sql_insert = "INSERT INTO product (id_category, name, desc, dimensions, weight, amount, value) VALUES\n"

    for category_id, product_name, product_desc in products_and_descriptions:
        product = {
            'id_category': category_id,
            'name': product_name,
            'desc': product_desc,
            'dimensions': f'{random.randint(1, 50)}x{random.randint(1, 50)}x{random.randint(1, 50)}',
            'weight': random.randint(50, 5000),
            'amount': random.randint(1, 100),
            'value': round(random.uniform(10.0, 500.0), 2)
        }

        # Adiciona os valores à string SQL
        sql_insert += f"('{product['id_category']}', '{product['name']}', '{product['desc']}', '{product['dimensions']}', {product['weight']}, {product['amount']}, {product['value']}),\n"

    # Remove a vírgula extra no final e adiciona o ponto e vírgula
    sql_insert = sql_insert.rstrip(',\n') + ';\n'

    # Escreve a string SQL no arquivo
    file.write(sql_insert)

print(f"Dados gerados foram salvos em {output_directory}\\{output_file}")