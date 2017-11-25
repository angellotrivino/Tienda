/*
SQLyog Enterprise - MySQL GUI v8.1 
MySQL - 5.5.39-log : Database - tienda
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`tienda` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `tienda`;

/*Table structure for table `carrito` */

DROP TABLE IF EXISTS `carrito`;

CREATE TABLE `carrito` (
  `idcarrito` int(50) NOT NULL,
  `cantidadProducto` int(50) DEFAULT NULL,
  `codigoProducto` int(50) DEFAULT NULL,
  PRIMARY KEY (`idcarrito`),
  KEY `FK_carrito` (`codigoProducto`),
  CONSTRAINT `FK_carrito` FOREIGN KEY (`codigoProducto`) REFERENCES `producto` (`codigoProducto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `carrito` */

insert  into `carrito`(idcarrito,cantidadProducto,codigoProducto) values (2,3,123),(3,9,1313),(4,4,14),(5,3,25);

/*Table structure for table `producto` */

DROP TABLE IF EXISTS `producto`;

CREATE TABLE `producto` (
  `codigoProducto` int(50) NOT NULL,
  `nombreProducto` varchar(50) DEFAULT NULL,
  `precioProducto` double DEFAULT NULL,
  `imagenProducto` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigoProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `producto` */

insert  into `producto`(codigoProducto,nombreProducto,precioProducto,imagenProducto) values (13,'papaya',2000,'papaya.jpg'),(14,'fresa',1200,'fresa.jpg'),(25,'manzana',500,'manzana.jpg'),(123,'PapasFritas',700,'papasfritas.jpg'),(1313,'Pollo',500,'Pollo.jpg'),(1918,'Yuca',2000,'Yuca.jpg'),(1919,'tomate',3000,'tomate.jpg'),(12123,'kiwi',500,'kiwi.jpg');

/*Table structure for table `rol` */

DROP TABLE IF EXISTS `rol`;

CREATE TABLE `rol` (
  `idRol` int(11) NOT NULL,
  `nombreRol` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rol` */

insert  into `rol`(idRol,nombreRol) values (1,'Administrador'),(2,'Cajero');

/*Table structure for table `usuario` */

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `nombres` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `loggin` varchar(50) DEFAULT NULL,
  `contraseña` varchar(50) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `FK_usuario` (`idRol`),
  CONSTRAINT `FK_usuario` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `usuario` */

insert  into `usuario`(idUsuario,nombres,apellidos,edad,correo,loggin,contraseña,idRol) values (0,'SUPER ADMINISTRADOR','',0,'','superadministrador','123',1),(1,'Angello Snheider','Triviño Umaña',20,'snheider_14_@hotmail.com','administrador','12345',1),(2,'Diego Fernando','Rincon',21,'slipkdiego@gmail.com','diego','diego',2);

/* Procedure structure for procedure `SP_EliminarCarrito` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_EliminarCarrito` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EliminarCarrito`(IN _idcarrito INT)
BEGIN
	delete from carrito where idcarrito=_idcarrito;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_EliminarProducto` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_EliminarProducto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EliminarProducto`(IN _codigo INT)
BEGIN
	delete from producto where codigoProducto=_codigo;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_EliminarUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_EliminarUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EliminarUsuario`(IN _codigo INT)
BEGIN
	delete from usuario where idUsuario=_codigo;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_ExtraerImagen` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_ExtraerImagen` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ExtraerImagen`(in _nombreProducto VARCHAR(50))
BEGIN
    
   SELECT  imagenProducto FROM producto WHERE _nombreProducto=nombreProducto;
   
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_InsertarCarrito` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_InsertarCarrito` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarCarrito`(in _nombre varchar(50), in _cantidad int)
begin
declare _id int;
declare _codigo varchar(50);
SET _id = (SELECT MAX(idcarrito)+1 FROM (SELECT 0 AS idcarrito UNION ALL SELECT idcarrito FROM carrito) AS tabla);
set _codigo =(SELECT codigoProducto from producto where nombreProducto = _nombre);
    
	insert into carrito(
	    idcarrito,
	    cantidadProducto,
	    codigoProducto	    		
	)values(
	    _id,
	    _cantidad,
	    _codigo
	);
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_InsertarProducto` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_InsertarProducto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarProducto`(In _codigo INT, in _nombre varchar(50), in _precio double, in _imagenProducto VARCHAR(50))
BEGIN
insert into producto(
	codigoProducto,
	nombreProducto,
	precioProducto,
	imagenProducto	
	
	)values(
	
	_codigo,
	_nombre,
	_precio,
	_imagenProducto
	
	);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_InsertarUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_InsertarUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarUsuario`(in _idUsuario int, in _nombres VARCHAR(50), in _apellidos varchar(50), in _edad int, in _correo varchar(50), in _loggin varchar(50), in _contraseña varchar(50), in _idRol int)
BEGIN
    
    INSERT into usuario(
	idUsuario,
	nombres,
	apellidos,
	edad,
	correo,
	loggin,
	contraseña,
	idRol
    )values(
	_idUsuario,
	_nombres,
	_apellidos,
	_edad,
	_correo,
	_loggin,
	_contraseña,
	_idRol
    );
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_ModificarCarrito` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_ModificarCarrito` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ModificarCarrito`(in _idcarrito int, in _cantidadProducto int)
BEGIN
	update carrito set cantidadProducto=_cantidadProducto where idcarrito=_idcarrito; 
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_ModificarProducto` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_ModificarProducto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ModificarProducto`(IN _codigoProducto INT, IN _nombreProducto VARCHAR(50), IN _precioProducto DOUBLE, in _imagenProducto VARCHAR(50))
BEGIN
	update producto set nombreProducto=_nombreProducto, precioProducto=_precioProducto, imagenProducto=_imagenProducto where codigoProducto=_codigoProducto; 
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_ModificarUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_ModificarUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ModificarUsuario`(IN _idUsuario INT, IN _nombres VARCHAR(50), IN _apellidos VARCHAR(50), IN _edad INT, IN _correo VARCHAR(50), IN _loggin VARCHAR(50), IN _contraseña VARCHAR(50), IN _idRol INT)
BEGIN
	update usuario set nombres=_nombres, apellidos=_apellidos, edad=_edad, correo=_correo, loggin=_loggin, contraseña=_contraseña, idRol=_idRol where idUsuario=_idUsuario; 
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_MostrarCarrito` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_MostrarCarrito` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MostrarCarrito`()
BEGIN
	SELECT idcarrito, nombreProducto, cantidadProducto, precioProducto, cantidadProducto*precioProducto as Total, imagenProducto from carrito inner JOIN producto on carrito.codigoProducto=producto.codigoProducto order by idcarrito;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_MostrarProducto` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_MostrarProducto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MostrarProducto`()
BEGIN
   
    select codigoProducto,nombreProducto,precioProducto,imagenProducto from producto order by codigoProducto;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_MostrarUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_MostrarUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MostrarUsuario`()
BEGIN
	SELECT * from usuario where idUsuario!=0;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_ProductoExistente` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_ProductoExistente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductoExistente`(in _nombreProducto varchar(50))
BEGIN
    
    SELECT nombreProducto from carrito inner join producto on nombreProducto=_nombreProducto and carrito.codigoProducto=producto.codigoProducto;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_Rol` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_Rol` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Rol`()
BEGIN
    
    SELECT 
	    loggin, contraseña, usuario.idRol, nombres, apellidos, edad, correo FROM usuario INNER JOIN rol ON usuario.idRol=rol.idRol;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_SeleccionarProducto` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_SeleccionarProducto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SeleccionarProducto`()
BEGIN
    SELECT '0' as codigoProducto, '' as nombreProducto, '0' as precioProducto, '' as imagenProducto
    union all
    
    select codigoProducto,nombreProducto,precioProducto,imagenProducto from producto order by nombreProducto;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `SP_VaciarCarrito` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_VaciarCarrito` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VaciarCarrito`()
BEGIN
truncate carrito;
    END */$$
DELIMITER ;

/*Table structure for table `t` */

DROP TABLE IF EXISTS `t`;

/*!50001 DROP VIEW IF EXISTS `t` */;
/*!50001 DROP TABLE IF EXISTS `t` */;

/*!50001 CREATE TABLE `t` (
  `idcarrito` int(50) NOT NULL,
  `nombreProducto` varchar(50) DEFAULT NULL,
  `cantidadProducto` int(50) DEFAULT NULL,
  `precioProducto` double DEFAULT NULL,
  `Total` double DEFAULT NULL,
  `imagenProducto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 */;

/*Table structure for table `tabla` */

DROP TABLE IF EXISTS `tabla`;

/*!50001 DROP VIEW IF EXISTS `tabla` */;
/*!50001 DROP TABLE IF EXISTS `tabla` */;

/*!50001 CREATE TABLE `tabla` (
  `idcarrito` int(50) NOT NULL,
  `nombreProducto` varchar(50) DEFAULT NULL,
  `cantidadProducto` int(50) DEFAULT NULL,
  `precioProducto` double DEFAULT NULL,
  `Total` double DEFAULT NULL,
  `imagenProducto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 */;

/*View structure for view t */

/*!50001 DROP TABLE IF EXISTS `t` */;
/*!50001 DROP VIEW IF EXISTS `t` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `t` AS select `carrito`.`idcarrito` AS `idcarrito`,`producto`.`nombreProducto` AS `nombreProducto`,`carrito`.`cantidadProducto` AS `cantidadProducto`,`producto`.`precioProducto` AS `precioProducto`,(`carrito`.`cantidadProducto` * `producto`.`precioProducto`) AS `Total`,`producto`.`imagenProducto` AS `imagenProducto` from (`carrito` join `producto` on((`carrito`.`codigoProducto` = `producto`.`codigoProducto`))) order by `carrito`.`idcarrito` */;

/*View structure for view tabla */

/*!50001 DROP TABLE IF EXISTS `tabla` */;
/*!50001 DROP VIEW IF EXISTS `tabla` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tabla` AS select `carrito`.`idcarrito` AS `idcarrito`,`producto`.`nombreProducto` AS `nombreProducto`,`carrito`.`cantidadProducto` AS `cantidadProducto`,`producto`.`precioProducto` AS `precioProducto`,(`carrito`.`cantidadProducto` * `producto`.`precioProducto`) AS `Total`,`producto`.`imagenProducto` AS `imagenProducto` from (`carrito` join `producto` on((`carrito`.`codigoProducto` = `producto`.`codigoProducto`))) order by `carrito`.`idcarrito` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
