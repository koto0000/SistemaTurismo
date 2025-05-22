USE master
create database dbTurismo
go
use dbTurismo
CREATE TABLE [Destino]
(
[Lugar_Turistico] char(50) NOT NULL ,
[Categoria] char(20) NOT NULL ,
[Fotos] integer NOT NULL ,
[Descripcion] char(50) NOT NULL ,
[Costo] money NOT NULL ,
[Sugerencias] char(50) NOT NULL ,
[DNI_Turista] char(9) NOT NULL
)
go
ALTER TABLE [Destino]
ADD CONSTRAINT [XPKDestino] PRIMARY KEY CLUSTERED ([Lugar_Turistico] ASC)
go
CREATE TABLE [Metodo_de_Pago]
(
[Detalle_Compra] char(20) NOT NULL ,
[I_G_V] money NOT NULL ,
[Monto_Total] money NOT NULL ,
[Visa] char(20) NOT NULL ,
[Boleta] char(20) NOT NULL
)
go
ALTER TABLE [Metodo_de_Pago]
ADD CONSTRAINT [XPKMetodo_de_Pago] PRIMARY KEY CLUSTERED ([Detalle_Compra] ASC)
go
CREATE TABLE [Reserva]
(
[Hospedaje] char(50) NOT NULL ,
[Detalles] char(50) NOT NULL ,
[Numero_Personas] integer NOT NULL ,
[Duracion] integer NOT NULL ,
[FechaHora] datetime NOT NULL ,
[Lugar_Turistico] char(50) NOT NULL ,
[Detalle_Compra] char(20) NOT NULL
)
go
ALTER TABLE [Reserva]
ADD CONSTRAINT [XPKReserva] PRIMARY KEY CLUSTERED ([Hospedaje] ASC)
go
CREATE TABLE [Turista]
(
[DNI_Turista] char(9) NOT NULL ,
[Nombre] char(50) NOT NULL ,
[Genero] binary NULL ,
[Telefono] numeric(15) NOT NULL ,
[Direccion] char(50) NOT NULL
)
go
ALTER TABLE [Turista]
ADD CONSTRAINT [XPKTurista] PRIMARY KEY CLUSTERED ([DNI_Turista] ASC)
go
ALTER TABLE [Destino]
ADD CONSTRAINT [R_1] FOREIGN KEY ([DNI_Turista]) REFERENCES [Turista]([DNI_Turista])
ON DELETE NO ACTION
ON UPDATE NO ACTION
go
ALTER TABLE [Reserva]
ADD CONSTRAINT [R_2] FOREIGN KEY ([Lugar_Turistico]) REFERENCES [Destino]([Lugar_Turistico])
ON DELETE NO ACTION
ON UPDATE NO ACTION
go
ALTER TABLE [Reserva]
ADD CONSTRAINT [R_4] FOREIGN KEY ([Detalle_Compra]) REFERENCES
[Metodo_de_Pago]([Detalle_Compra])
ON DELETE NO ACTION
ON UPDATE NO ACTION
go
INSERT INTO Turista (DNI_Turista, Nombre, Genero, Telefono, Direccion) VALUES
('123456789', 'Ana Torres', 1, 987654321, 'Calle Luna 123'),
('987654321', 'Luis Gómez', 0, 912345678, 'Av. Sol 456'),
('456789123', 'María Pérez', 1, 934567890, 'Jr. Estrella 789'),
('321654987', 'Carlos Ruiz', 0, 956789432, 'Calle Mar 222'),
('654987321', 'Lucía Vargas', 1, 901234567, 'Av. Monte 111'),
('789123456', 'Pedro Medina', 0, 923456781, 'Calle Lomas 789'),
('147258369', 'Elena Ramírez', 1, 945612378, 'Av. Río 654');
INSERT INTO Destino (Lugar_Turistico, Categoria, Fotos, Descripcion, Costo, Sugerencias, DNI_Turista)
VALUES
('Machu Picchu', 'Aventura', 5, 'Ciudadela inca en Cusco', 350.00, 'Llevar protector solar', '123456789'),
('Paracas', 'Playa', 3, 'Reserva nacional costera', 200.00, 'Llevar gafas de sol', '987654321'),
('Lago Titicaca', 'Cultural', 4, 'Lago navegable más alto del mundo', 250.00, 'Abrigo para el frío',
'456789123'),
('Arequipa', 'Ciudad', 2, 'Ciudad blanca de volcanes', 300.00, 'Probar comida local', '321654987'),
('Huacachina', 'Aventura', 6, 'Oasis en el desierto', 150.00, 'Llevar agua', '654987321'),
('Cusco', 'Histórico', 7, 'Capital del imperio inca', 400.00, 'Comprar entradas online', '789123456'),
('Puno', 'Folklore', 3, 'Festividades tradicionales', 220.00, 'Participar en danzas', '147258369');
INSERT INTO Metodo_de_Pago (Detalle_Compra, I_G_V, Monto_Total, Visa, Boleta) VALUES
('MP001', 18.00, 368.00, 'VISA001', 'B001'),
('MP002', 18.00, 218.00, 'VISA002', 'B002'),
('MP003', 18.00, 268.00, 'VISA003', 'B003'),
('MP004', 18.00, 318.00, 'VISA004', 'B004'),
('MP005', 18.00, 168.00, 'VISA005', 'B005'),
('MP006', 18.00, 418.00, 'VISA006', 'B006'),
('MP007', 18.00, 238.00, 'VISA007', 'B007');
INSERT INTO Reserva (Hospedaje, Detalles, Numero_Personas, Duracion, FechaHora, Lugar_Turistico,
Detalle_Compra) VALUES
('Hotel Inka', 'Incluye desayuno', 2, 3, '2025-07-10 10:00:00', 'Machu Picchu', 'MP001'),
('Hostal Paracas', 'Vista al mar', 1, 2, '2025-06-15 09:30:00', 'Paracas', 'MP002'),
('Eco Lodge', 'Cabañas frente al lago', 4, 4, '2025-08-01 12:00:00', 'Lago Titicaca', 'MP003'),
('Hotel Volcán', 'Con piscina', 3, 3, '2025-06-20 08:45:00', 'Arequipa', 'MP004'),
('Refugio Oasis', 'Tours incluidos', 2, 1, '2025-05-30 14:20:00', 'Huacachina', 'MP005'),
('Hotel Imperial', 'Cerca al centro', 5, 5, '2025-09-10 11:15:00', 'Cusco', 'MP006'),
('Casa Folklórica', 'Desayuno regional', 2, 2, '2025-07-25 13:30:00', 'Puno', 'MP007');