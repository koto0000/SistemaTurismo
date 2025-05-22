-- Paso 1: Crear la base de datos si no existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'SistemaTurismo')
BEGIN
    CREATE DATABASE SistemaTurismo;
END
GO

-- Paso 2: Cambiar al contexto de la base de datos recién creada
USE SistemaTurismo;

-- Paso 3: Crear las tablas

-- Tabla: Turista
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Turista' AND xtype='U')
CREATE TABLE Turista (
    DNI VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(50),
    Dirección VARCHAR(100),
    Teléfono VARCHAR(15),
    Género VARCHAR(10)
);

-- Tabla: Destino
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Destino' AND xtype='U')
CREATE TABLE Destino (
    ID_Destino INT IDENTITY(1,1) PRIMARY KEY,
    Categoría VARCHAR(30),
    LugarTurístico VARCHAR(100),
    Fotos TEXT,
    DescripciónGeneral VARCHAR(500),
    Costo DECIMAL(12,2)
);

-- Tabla: Reserva
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Reserva' AND xtype='U')
CREATE TABLE Reserva (
    ID_Reserva INT IDENTITY(1,1) PRIMARY KEY,
    DNI_Turista VARCHAR(10),
    FechaHora DATETIME,
    DetallesLugar VARCHAR(500),
    NumeroPersonas INT CHECK (NumeroPersonas BETWEEN 1 AND 99),
    DuracionEstadia INT CHECK (DuracionEstadia BETWEEN 1 AND 99),
    Hospedaje VARCHAR(100),
    ID_Destino INT,
    FOREIGN KEY (DNI_Turista) REFERENCES Turista(DNI),
    FOREIGN KEY (ID_Destino) REFERENCES Destino(ID_Destino)
);

-- tabla: Metodo de Pago
CREATE TABLE MetodoPago (
    ID_Pago INT IDENTITY(1,1) PRIMARY KEY,
    ID_Reserva INT,
    BoletaFactura VARCHAR(100),
    MontoTotal DECIMAL(12,2),
    IGV DECIMAL(12,2),
    DetalleCompra VARCHAR(500),
    TarjetaCredito VARCHAR(30),
    FOREIGN KEY (ID_Reserva) REFERENCES Reserva(ID_Reserva)
);


INSERT INTO Turista (DNI, Nombre, Dirección, Teléfono, Género)
VALUES
('70234567', 'Carlos Mendoza Rojas', 'Av. Larco 456, Miraflores, Lima', '987654321', 'Masculino'),
('71345678', 'Ana Lucía Fernández Cruz', 'Calle Libertad 1020, Cusco', '956789012', 'Femenino'),
('72456789', 'Javier Torres Sánchez', 'Jr. Huaylas 345, Arequipa', '934567890', 'Masculino'),
('73567890', 'Sofía Ríos Mejía', 'Calle Grau 789, Trujillo', '923456789', 'Femenino');


INSERT INTO Destino (Categoría, LugarTurístico, Fotos, DescripciónGeneral, Costo)
VALUES
('Naturaleza', 'Machu Picchu', 'https://ejemplo.com/machupicchu.jpg ', 'Ciudadela inca ubicada entre las montañas de los Andes.', 150.00),
('Cultural', 'Lima Histórica', 'https://ejemplo.com/limacentro.jpg ', 'Centro histórico de Lima, patrimonio cultural de la humanidad.', 50.00),
('Aventura', 'Canyon de Colca', 'https://ejemplo.com/colca.jpg ', 'Uno de los cañones más profundos del mundo en Arequipa.', 120.00),
('Playa', 'Máncora', 'https://ejemplo.com/mancora.jpg ', 'Playa tropical famosa por sus fiestas y aguas cálidas.', 80.00);

INSERT INTO Reserva (DNI_Turista, FechaHora, DetallesLugar, NumeroPersonas, DuracionEstadia, Hospedaje, ID_Destino)
VALUES
('70234567', '2025-04-10 09:30:00', 'Visita guiada Machu Picchu', 2, 3, 'Hotel Terrazas del Inca', 1),
('71345678', '2025-05-15 10:00:00', 'Recorrido por Plaza Mayor', 1, 2, 'Hostal San Blas', 2),
('72456789', '2025-06-20 08:00:00', 'Trekking en el Cañón', 4, 2, 'Hospedaje Valle Colca', 3),
('73567890', '2025-07-25 11:00:00', 'Paseo en bote por el río', 2, 4, 'Hotel Sol de Oro', 4);


INSERT INTO MetodoPago (ID_Reserva, BoletaFactura, MontoTotal, IGV, DetalleCompra, TarjetaCredito)
VALUES
(1, 'BOL-20250410-001', 450.00, 45.00, 'Entradas + alojamiento + guía', 'VISA-4532********1234'),
(2, 'BOL-20250515-002', 200.00, 20.00, 'Tour guiado por Lima', 'MAST-5496********5678'),
(3, 'BOL-20250620-003', 480.00, 48.00, 'Paquete trekking y hospedaje', 'VISA-4556********9876'),
(4, 'BOL-20250725-004', 800.00, 80.00, 'Vacaciones en Máncora todo incluido', 'MAST-5178********4321');

INSERT INTO Turista (DNI, Nombre, Dirección, Teléfono, Género)
VALUES
('74678901', 'Luis Enrique Huamán', 'Calle San Martín 505, Piura', '912345678', 'Masculino'),
('75789012', 'María del Carmen Vega', 'Av. La Marina 1234, Callao', '988776655', 'Femenino'),
('76890123', 'Diego Armando Quispe', 'Jr. Puno 789, Tacna', '977665544', 'Masculino');


INSERT INTO Destino (Categoría, LugarTurístico, Fotos, DescripciónGeneral, Costo)
VALUES
('Naturaleza', 'Parque Nacional del Manu', 'https://ejemplo.com/manu.jpg ', 'Área protegida con biodiversidad única en la selva amazónica.', 180.00),
('Cultural', 'Nazca - Líneas de Nazca', 'https://ejemplo.com/nazca.jpg ', 'Misteriosos geoglifos antiguos visibles desde el aire.', 200.00),
('Aventura', 'Montaña Arcoiris - Vinicunca', 'https://ejemplo.com/vinicunca.jpg ', 'Formación geológica colorida cerca de Cusco.', 130.00);

INSERT INTO Reserva (DNI_Turista, FechaHora, DetallesLugar, NumeroPersonas, DuracionEstadia, Hospedaje, ID_Destino)
VALUES
('74678901', '2025-08-01 09:00:00', 'Visita al Parque Nacional del Manu', 3, 5, 'Amazonas Lodge', 5),
('75789012', '2025-09-10 08:30:00', 'Vuelo sobre las líneas de Nazca', 1, 2, 'Hotel Sol Nazca', 6),
('76890123', '2025-10-15 07:45:00', 'Excursión a la Montaña Arcoíris', 2, 3, 'Hostal Valle Sagrado', 7);
INSERT INTO MetodoPago (ID_Reserva, BoletaFactura, MontoTotal, IGV, DetalleCompra, TarjetaCredito)
VALUES
(5, 'BOL-20250801-005', 1000.00, 100.00, 'Paquete completo Amazonía Peruana', 'VISA-4929********9876'),
(6, 'BOL-20250910-006', 600.00, 60.00, 'Tour aéreo por líneas de Nazca', 'MAST-5496********1234'),
(7, 'BOL-20251015-007', 520.00, 52.00, 'Ingreso + transporte a Vinicunca', 'VISA-4532********4321');



SELECT * FROM Turista;
SELECT * FROM Destino;
SELECT * FROM Reserva;
SELECT * FROM MetodoPago;



