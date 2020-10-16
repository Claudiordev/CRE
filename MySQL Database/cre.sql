#
# Structure for table "faturas"
#

DROP TABLE IF EXISTS `faturas`;
CREATE TABLE `faturas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `produtos` varchar(255) DEFAULT NULL,
  `nif` varchar(8) DEFAULT NULL,
  `precototal` decimal(10,0) DEFAULT NULL,
  `iva` int(3) DEFAULT NULL,
  `PVP` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "faturas"
#


#
# Structure for table "roles"
#

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

#
# Data for table "roles"
#

INSERT INTO `roles` VALUES (1,'Default'),(3,'Administrador');

#
# Structure for table "empregados"
#

DROP TABLE IF EXISTS `empregados`;
CREATE TABLE `empregados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `apelido` varchar(50) DEFAULT NULL,
  `login` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `empregados_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

#
# Data for table "empregados"
#

INSERT INTO `empregados` VALUES (1,'Claudio','Rebelo','claudior','123456',3),(2,'Pedro','Costa','pcosta','12345',1),(3,'Antonio','Teixeira','ateixeira','ate123',1);

#
# Structure for table "subcategoria"
#

DROP TABLE IF EXISTS `subcategoria`;
CREATE TABLE `subcategoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

#
# Data for table "subcategoria"
#

INSERT INTO `subcategoria` VALUES (1,'Geral'),(2,'TVs');

#
# Structure for table "categoria"
#

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `subcategoria_id` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `subcategoria_id` (`subcategoria_id`),
  CONSTRAINT `categoria_ibfk_1` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

#
# Data for table "categoria"
#

INSERT INTO `categoria` VALUES (1,'TV,Video e Som',2),(2,'Gaming',1);

#
# Structure for table "produto"
#

DROP TABLE IF EXISTS `produto`;
CREATE TABLE `produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria_id` int(11) NOT NULL DEFAULT '1',
  `nome` varchar(50) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `preco` double DEFAULT '0',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `categoria_id` (`categoria_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`),
  CONSTRAINT `produto_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `empregados` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

#
# Data for table "produto"
#

INSERT INTO `produto` VALUES (1,2,'Cadeira Gaming','A cadeira gaming de ultima geração. Melhor ergonomia no mercado!',750.25,1),(2,2,'Teclado Gaming','O melhor teclado mecânico do mercado. Perfeito para um PRO Gamer!',125.25,1),(3,1,'Monitor 8K','Monitor 8K, nada a mais a dizer!',3806,2),(6,1,'Teste','Teste',0.06,1),(8,1,'Coluna 8000','Uma simples coluna que faz estremeçer o prédio!',1500.5,2),(9,1,'Videoprojetor','O melhor video projector do mercado disponível até então.',550.35,3);
