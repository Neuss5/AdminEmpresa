-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-09-2023 a las 23:23:30
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `adminempresa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion`
--

CREATE TABLE `direccion` (
  `idDireccion` int(11) NOT NULL,
  `zona` enum('Urbana','Rural') DEFAULT NULL,
  `tipoCalle` enum('Avenida','Calle','Carrera','Circunvalar','Transversal','Otro') DEFAULT NULL,
  `numero1` varchar(9) NOT NULL,
  `numero2` varchar(9) NOT NULL,
  `numero3` varchar(9) NOT NULL,
  `nombreDepartamento` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`idDireccion`, `zona`, `tipoCalle`, `numero1`, `numero2`, `numero3`, `nombreDepartamento`) VALUES
(1, 'Urbana', 'Avenida', '1', '2', '3', 'Antioquia'),
(4, 'Urbana', 'Avenida', '100', '105', '65', 'Antioquia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idEmpleados` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `apellido` varchar(25) NOT NULL,
  `tipoDocumento` enum('CedulaCiudadania','CedulaExtranjera','LibretaMilitar','Pasaporte','Otro') DEFAULT NULL,
  `documento` varchar(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `FK_idSucursal` int(11) NOT NULL,
  `FK_idPuesto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleados`, `nombre`, `apellido`, `tipoDocumento`, `documento`, `email`, `FK_idSucursal`, `FK_idPuesto`) VALUES
(2, 'ROB', 'Stark', 'CedulaCiudadania', '65333123', 'rey.del.norte@gmail.com', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `nit` int(11) NOT NULL,
  `nombreEmpresa` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`nit`, `nombreEmpresa`) VALUES
(65230, 'Maria Maria`s Gastro Bar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puestotrabajo`
--

CREATE TABLE `puestotrabajo` (
  `idPuesto` int(11) NOT NULL,
  `nombrePuesto` varchar(50) NOT NULL,
  `salario` float NOT NULL,
  `FK_idSucursal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `puestotrabajo`
--

INSERT INTO `puestotrabajo` (`idPuesto`, `nombrePuesto`, `salario`, `FK_idSucursal`) VALUES
(1, 'gerente', 1000000, 1),
(2, 'Operario', 2000000, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `idSucursal` int(11) NOT NULL,
  `nombreSucursal` varchar(50) NOT NULL,
  `FK_nit` int(11) NOT NULL,
  `FK_idDireccion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`idSucursal`, `nombreSucursal`, `FK_nit`, `FK_idDireccion`) VALUES
(1, 'Turbaco', 65230, 1),
(4, 'El Cielo', 65230, 4);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD PRIMARY KEY (`idDireccion`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idEmpleados`),
  ADD UNIQUE KEY `documento` (`documento`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `FK_idSucursal` (`FK_idSucursal`),
  ADD KEY `FK_idPuesto` (`FK_idPuesto`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`nit`);

--
-- Indices de la tabla `puestotrabajo`
--
ALTER TABLE `puestotrabajo`
  ADD PRIMARY KEY (`idPuesto`),
  ADD KEY `FK_idSucursal` (`FK_idSucursal`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`idSucursal`),
  ADD UNIQUE KEY `nombreSucursal` (`nombreSucursal`),
  ADD KEY `FK_nit` (`FK_nit`),
  ADD KEY `FK_idDireccion` (`FK_idDireccion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `direccion`
--
ALTER TABLE `direccion`
  MODIFY `idDireccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idEmpleados` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `puestotrabajo`
--
ALTER TABLE `puestotrabajo`
  MODIFY `idPuesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `idSucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`FK_idSucursal`) REFERENCES `sucursal` (`idSucursal`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `empleado_ibfk_2` FOREIGN KEY (`FK_idPuesto`) REFERENCES `puestotrabajo` (`idPuesto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `puestotrabajo`
--
ALTER TABLE `puestotrabajo`
  ADD CONSTRAINT `puestotrabajo_ibfk_1` FOREIGN KEY (`FK_idSucursal`) REFERENCES `sucursal` (`idSucursal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD CONSTRAINT `sucursal_ibfk_1` FOREIGN KEY (`FK_nit`) REFERENCES `empresa` (`nit`),
  ADD CONSTRAINT `sucursal_ibfk_2` FOREIGN KEY (`FK_idDireccion`) REFERENCES `direccion` (`idDireccion`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
