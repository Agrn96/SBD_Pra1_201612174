CREATE DATABASE IF NOT EXISTS pra1_tienda;

USE pra1_tienda;

SET foreign_key_checks = 0;

-- Usuario table
CREATE TABLE Usuario (
    IDUsuario VARCHAR(10) PRIMARY KEY,
    NombreCompleto VARCHAR(255),
    Alias VARCHAR(255),
    Rol VARCHAR(50),
    Edad INT,
    Correo VARCHAR(255),
    Telefono VARCHAR(15),
    Direccion VARCHAR(255),
    Pais VARCHAR(50),
    Contrasena VARCHAR(20)
);

-- Desarrollador table
CREATE TABLE Desarrollador (
    IDDesarrollador VARCHAR(10) PRIMARY KEY,
    NombreCompleto VARCHAR(255),
    Alias VARCHAR(255)
);

-- Clasificacion table
CREATE TABLE Clasificacion (
    IDClasificacion VARCHAR(10) PRIMARY KEY,
    Tipo VARCHAR(10),
    RangoEdadMin INT,
    RangoEdadMax INT
);

-- Promociones table
CREATE TABLE Promociones (
    IDPromo VARCHAR(10) PRIMARY KEY,
    IDJuego VARCHAR(10), 
    FechaIni DATE,
    FechaFin DATE,
    Descuento DECIMAL(5,2)
);

-- Juegos table
CREATE TABLE Juegos (
    IDJuego VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(255),
    DescCor VARCHAR(255),
    DescDet TEXT,
    FechaLanz DATE,
    PrecioVenta DECIMAL(10,2),
    Genero VARCHAR(50),
    IDClasificacion VARCHAR(10), 
    IDPromo VARCHAR(10), 
    IDDesarrollador VARCHAR(10) 
);

-- InfoPago table
CREATE TABLE InfoPago (
    IDTarjeta VARCHAR(16) PRIMARY KEY,
    IDUsuario VARCHAR(10), 
    Nombre VARCHAR(255),
    NumTarjeta VARCHAR(16),
    FechaV DATE
);

-- Compras table
CREATE TABLE Compras (
    IDCompra VARCHAR(10) PRIMARY KEY,
    IDUsuario VARCHAR(10), 
    IDJuego VARCHAR(10), 
    IDTarjeta VARCHAR(16), 
    IDPromo VARCHAR(10), 
    FechaCompra DATE,
    PrecioPagado DECIMAL(10,2)
);

-- CompraDetalle table
CREATE TABLE CompraDetalle (
    IDCompra VARCHAR(10), 
    IDJuego VARCHAR(10),
    Precio DECIMAL(10,2),
    Descuento DECIMAL(5,2),
    PrecioFinal DECIMAL(10,2)
);

-- ListaDeseos table
CREATE TABLE ListaDeseos (
    UsuarioID VARCHAR(10),
    JuegoID VARCHAR(10)
);

-- BibliotecaJuegos table
CREATE TABLE BibliotecaJuegos (
    UsuarioID VARCHAR(10),
    JuegoID VARCHAR(10)
);

-- Calificacion table
CREATE TABLE Calificacion (
    UsuarioID VARCHAR(10),
    JuegoID VARCHAR(10),
    Valor INT
);

-- RestriccionPais table
CREATE TABLE RestriccionPais (
    JuegoID VARCHAR(10),
    Pais VARCHAR(50)
);

-- Add FK constraints to Juegos table
ALTER TABLE Juegos ADD FOREIGN KEY (IDClasificacion) REFERENCES Clasificacion(IDClasificacion);
ALTER TABLE Juegos ADD FOREIGN KEY (IDPromo) REFERENCES Promociones(IDPromo);
ALTER TABLE Juegos ADD FOREIGN KEY (IDDesarrollador) REFERENCES Desarrollador(IDDesarrollador);

-- Add FK constraint to Promociones table
ALTER TABLE Promociones ADD FOREIGN KEY (IDJuego) REFERENCES Juegos(IDJuego);

-- Add FK constraints to InfoPago table
ALTER TABLE InfoPago ADD FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario);

-- Add FK constraints to Compras table
ALTER TABLE Compras ADD FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario);
ALTER TABLE Compras ADD FOREIGN KEY (IDJuego) REFERENCES Juegos(IDJuego);
ALTER TABLE Compras ADD FOREIGN KEY (IDTarjeta) REFERENCES InfoPago(IDTarjeta);
ALTER TABLE Compras ADD FOREIGN KEY (IDPromo) REFERENCES Promociones(IDPromo);

-- Add FK constraints to CompraDetalle table
ALTER TABLE CompraDetalle ADD FOREIGN KEY (IDCompra) REFERENCES Compras(IDCompra);
ALTER TABLE CompraDetalle ADD FOREIGN KEY (IDJuego) REFERENCES Juegos(IDJuego);

-- Add FK constraints to ListaDeseos table
ALTER TABLE ListaDeseos ADD FOREIGN KEY (UsuarioID) REFERENCES Usuario(IDUsuario);
ALTER TABLE ListaDeseos ADD FOREIGN KEY (JuegoID) REFERENCES Juegos(IDJuego);

-- Add FK constraints to BibliotecaJuegos table
ALTER TABLE BibliotecaJuegos ADD FOREIGN KEY (UsuarioID) REFERENCES Usuario(IDUsuario);
ALTER TABLE BibliotecaJuegos ADD FOREIGN KEY (JuegoID) REFERENCES Juegos(IDJuego);

-- Add FK constraints to Calificacion table
ALTER TABLE Calificacion ADD FOREIGN KEY (UsuarioID) REFERENCES Usuario(IDUsuario);
ALTER TABLE Calificacion ADD FOREIGN KEY (JuegoID) REFERENCES Juegos(IDJuego);

-- Add FK constraints to RestriccionPais table
ALTER TABLE RestriccionPais ADD FOREIGN KEY (JuegoID) REFERENCES Juegos(IDJuego);


-- Insert sample data into Usuario
INSERT INTO Usuario VALUES 
    ('USR-000001', 'Jorge Garcia', 'George', 'Administrador', 29, 'JorGarcia@gmail.com', '50211112222', 'Direccion Random', 'GT', '1234'),
    ('USR-000002', 'George Garcia', 'Jorge', 'Cliente', 34, 'GeoGarcia@gmail.com', '50233334444', 'Direccion Random', 'GT', '2345');

-- Insert sample data into Desarrollador
INSERT INTO Desarrollador VALUES 
    ('DES-000001', 'Harold Kumar', 'HKGames');

-- Insert sample data into Clasificacion
INSERT INTO Clasificacion VALUES 
    ('CLA-000001', '13+', 13, 100);

-- Insert sample data into Promociones
INSERT INTO Promociones VALUES 
    ('PRO-000001', 'JGO-000001', '2023-08-23', '2023-08-26', 20.00);

-- Insert sample data into Juegos
INSERT INTO Juegos VALUES 
    ('JGO-000001', 'Raider', 'Juego RGP contra zombies', 'Juego RGP pero con mas detalles', '2023-08-21', 599, 'RGP', 'CLA-000001', 'PRO-000001', 'DES-000001');

-- Insert sample data into InfoPago
INSERT INTO InfoPago VALUES 
    ('TAR-000001', 'USR-000002', 'George Garcia', '1111222233334444', '2024-08-21');

-- Insert sample data into Compras
INSERT INTO Compras VALUES 
    ('CRA-000001', 'USR-000002', 'JGO-000001', 'TAR-000001', 'PRO-000001', '2023-08-21', 479.2); -- Assuming PrecioPagado is the final price after discount

-- Insert sample data into CompraDetalle
INSERT INTO CompraDetalle VALUES 
    ('CRA-000001', 'JGO-000001', 599, 20.00, 479.2);

-- Insert sample data into ListaDeseos
INSERT INTO ListaDeseos VALUES 
    ('USR-000002', 'JGO-000002');

-- Insert sample data into BibliotecaJuegos
INSERT INTO BibliotecaJuegos VALUES 
    ('USR-000002', 'JGO-000001');

-- Insert sample data into Calificacion
INSERT INTO Calificacion VALUES 
    ('USR-000002', 'JGO-000001', 9);

-- Insert sample data into RestriccionPais
INSERT INTO RestriccionPais VALUES 
    ('JGO-000001', 'MX');
	
SET foreign_key_checks = 1;

bibliotecajuegoscalificacion