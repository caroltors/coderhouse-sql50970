CREATE TABLE `categoria_produto` (
  `id_categoria` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
);

CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL,
  `cpf` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `sobrenome` varchar(100) NOT NULL,
  `telefone` varchar(12) NOT NULL,
  `e-mail` varchar(45) NOT NULL,
  `senha` varchar(45) NOT NULL,
  PRIMARY KEY (`id_cliente`)
);

CREATE TABLE `endereco_cliente` (
  `id_endereco` int NOT NULL,
  `id_cliente` int NOT NULL,
  `cep` int NOT NULL,
  `estado` varchar(45) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `logradouro` varchar(100) NOT NULL,
  PRIMARY KEY (`id_endereco`),
  KEY `id_cliente_idx` (`id_cliente`),
  CONSTRAINT `id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
);

CREATE TABLE `entrega` (
  `id_entrega` int NOT NULL,
  `id_pedido` int NOT NULL,
  `transportadora` varchar(100) NOT NULL,
  `altura` varchar(45) DEFAULT NULL,
  `largura` varchar(45) DEFAULT NULL,
  `valor_frete` decimal(10,0) NOT NULL,
  `status` varchar(45) NOT NULL,
  `data_entrega` datetime NOT NULL,
  PRIMARY KEY (`id_entrega`),
  KEY `pedido_idx` (`id_pedido`),
  CONSTRAINT `pedidofinal` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`)
);

CREATE TABLE `estoque_produto` (
  `id_estoque` int NOT NULL,
  `id_produto` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`id_estoque`),
  KEY `id_produto_idx` (`id_produto`),
  CONSTRAINT `id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
);

CREATE TABLE `historico_compras` (
  `id_historico` int NOT NULL,
  `id_cliente` int NOT NULL,
  `id_status` int NOT NULL,
  `id_pagamento` int NOT NULL,
  `id_pedido` int NOT NULL,
  `id_itens` int NOT NULL,
  PRIMARY KEY (`id_historico`),
  KEY `cliente_idx` (`id_cliente`),
  KEY `status_idx` (`id_status`),
  KEY `pagamento_idx` (`id_pagamento`),
  KEY `pedido_idx` (`id_pedido`),
  KEY `itens_idx` (`id_itens`),
  CONSTRAINT `clienteped` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `itensped` FOREIGN KEY (`id_itens`) REFERENCES `itens_pedido` (`id_itens`),
  CONSTRAINT `pagamentoped` FOREIGN KEY (`id_pagamento`) REFERENCES `pagamento` (`id_pagamento`),
  CONSTRAINT `pedidoped` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `statusped` FOREIGN KEY (`id_status`) REFERENCES `status_pedido` (`id_status`)
);

CREATE TABLE `itens_pedido` (
  `id_itens` int NOT NULL,
  `id_produto` int NOT NULL,
  `quantidade_itens` int NOT NULL,
  PRIMARY KEY (`id_itens`),
  KEY `id_produto_idx` (`id_produto`),
  CONSTRAINT `produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
);

CREATE TABLE `pagamento` (
  `id_pagamento` int NOT NULL,
  `id_cliente` int NOT NULL,
  `id_pedido` int NOT NULL,
  `valor_total` decimal(10,0) NOT NULL,
  `meio_pgto` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id_pagamento`),
  KEY `id_cliente_idx` (`id_cliente`),
  KEY `pedido_idx` (`id_pedido`),
  CONSTRAINT `cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`)
);

CREATE TABLE `pedido` (
  `id_pedido` int NOT NULL,
  `id_cliente` int NOT NULL,
  `id_status` int NOT NULL,
  `id_pagamento` int NOT NULL,
  `id_itens` int NOT NULL,
  `criado` timestamp(6) NOT NULL,
  `modificado` timestamp(6) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `cliente_idx` (`id_cliente`),
  KEY `status_idx` (`id_status`),
  KEY `pagamento_idx` (`id_pagamento`),
  KEY `itens_idx` (`id_itens`),
  CONSTRAINT `cli` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `itens` FOREIGN KEY (`id_itens`) REFERENCES `itens_pedido` (`id_itens`),
  CONSTRAINT `pagamento` FOREIGN KEY (`id_pagamento`) REFERENCES `pagamento` (`id_pagamento`),
  CONSTRAINT `status` FOREIGN KEY (`id_status`) REFERENCES `status_pedido` (`id_status`)
);

CREATE TABLE `produto` (
  `id_produto` int NOT NULL,
  `id_categoria` int NOT NULL,
  `id_estoque` int NOT NULL,
  `SKU` varchar(255) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `preco` varchar(45) NOT NULL,
  `peso` varchar(45) NOT NULL,
  `altura` varchar(45) DEFAULT NULL,
  `largura` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_produto`),
  KEY `id_categoria_idx` (`id_categoria`),
  KEY `id_estoque_idx` (`id_estoque`),
  CONSTRAINT `id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria_produto` (`id_categoria`),
  CONSTRAINT `id_estoque` FOREIGN KEY (`id_estoque`) REFERENCES `estoque_produto` (`id_estoque`)
);

CREATE TABLE `status_pedido` (
  `id_status` int NOT NULL,
  `status` varchar(45) NOT NULL,
  `criado` timestamp(6) NOT NULL,
  `modificado` timestamp(6) NOT NULL,
  PRIMARY KEY (`id_status`)
);