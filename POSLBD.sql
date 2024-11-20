USE [master]
GO
CREATE DATABASE [POSLBD]
GO
USE [POSLBD]
GO

-- Crear usuario y asignar rol
CREATE USER [pos] FOR LOGIN [pos] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [pos]
GO

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    usuario_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    rol INT CHECK (rol IN (1, 2)) -- Restricción para valores válidos
);

-- Crear la tabla Proveedor
CREATE TABLE Proveedor (
    proveedor_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_proveedor VARCHAR(100),
    contacto VARCHAR(100)
);

-- Crear la tabla Inventario
CREATE TABLE Inventario (
    producto_id INT PRIMARY KEY IDENTITY(1,1),
    proveedor_id INT,
    cant_producto INT,
    nombre_producto VARCHAR(100),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedor(proveedor_id)
);

-- Crear la tabla Menu
CREATE TABLE Menu (
    plato_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_plato VARCHAR(100),
    precio DECIMAL(10, 2),
    tipo VARCHAR(50)
);

-- Crear la tabla Promoción
CREATE TABLE Promocion (
    promo_id INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(50),
    descuento DECIMAL(5, 2)
);

-- Crear la tabla Pedido
CREATE TABLE Pedido (
    pedido_id INT PRIMARY KEY IDENTITY(1,1),
    usuario_id INT NULL,
    plato_id INT NULL,
    promocion_id INT NULL,
    cantidad INT,
    precio DECIMAL(10, 2),
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (plato_id) REFERENCES Menu(plato_id),
    FOREIGN KEY (promocion_id) REFERENCES Promocion(promo_id)
);

-- Crear la tabla Pago
CREATE TABLE Pago (
    pago_id INT PRIMARY KEY IDENTITY(1,1),
    pedido_id INT,
    total DECIMAL(10, 2),
    total_pago DECIMAL(10, 2),
    fecha_pago DATE,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id) ON DELETE CASCADE
);

-- Crear la tabla Cierre
CREATE TABLE Cierre (
    cierre_id INT PRIMARY KEY IDENTITY(1,1),
    pago_id INT,
    usuario_id INT,
    totales DECIMAL(10, 2),
    fecha_cierre DATE,
    FOREIGN KEY (pago_id) REFERENCES Pago(pago_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id)
);

-- Crear la tabla Venta
CREATE TABLE Venta (
    venta_id INT PRIMARY KEY IDENTITY(1,1),
    pago_id INT,
    fecha_venta DATE,
    pedido_id INT NULL,
    FOREIGN KEY (pago_id) REFERENCES Pago(pago_id) ON DELETE CASCADE,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id) ON DELETE NO ACTION -- Cambiar a NO ACTION
);


-- Crear la tabla Reporte
CREATE TABLE Reporte (
    reporte_id INT PRIMARY KEY IDENTITY(1,1),
    venta_id INT null,
    fecha_reporte DATE,
    inicio_reporte DATE,
    final_reporte DATE,
    FOREIGN KEY (venta_id) REFERENCES Venta(venta_id)
);




--Insersion de datos: 

INSERT INTO Usuario (nombre, apellido, contraseña, rol) VALUES
('Juan', 'Pérez', 'password123', 1),
('Ana', 'Gómez', 'securePass1', 2),
('Carlos', 'López', 'carL123!', 1),
('Laura', 'Martínez', 'lauMtz21', 2),
('Diego', 'Sánchez', 'd123456!', 1),
('María', 'García', 'mPass1#', 2),
('Luis', 'Hernández', 'hSecure!', 1),
('Sofía', 'Torres', 'sofiaTor1', 2),
('Jorge', 'Vargas', 'jorVargas#', 1),
('Paula', 'Morales', 'paulaMrl$', 2);


INSERT INTO Proveedor (nombre_proveedor, contacto) VALUES
('Proveedor A', 'contactoA@example.com'),
('Proveedor B', 'contactoB@example.com'),
('Proveedor C', 'contactoC@example.com'),
('Proveedor D', 'contactoD@example.com'),
('Proveedor E', 'contactoE@example.com'),
('Proveedor F', 'contactoF@example.com'),
('Proveedor G', 'contactoG@example.com'),
('Proveedor H', 'contactoH@example.com'),
('Proveedor I', 'contactoI@example.com'),
('Proveedor J', 'contactoJ@example.com');

INSERT INTO Inventario (proveedor_id, cant_producto, nombre_producto) VALUES
(1, 50, 'Producto A1'),
(2, 30, 'Producto B1'),
(3, 20, 'Producto C1'),
(4, 40, 'Producto D1'),
(5, 15, 'Producto E1'),
(6, 35, 'Producto F1'),
(7, 25, 'Producto G1'),
(8, 45, 'Producto H1'),
(9, 10, 'Producto I1'),
(10, 50, 'Producto J1');


INSERT INTO Menu (nombre_plato, precio, tipo) VALUES
('Plato A', 10.50, 'Entrada'),
('Plato B', 12.00, 'Plato Fuerte'),
('Plato C', 15.00, 'Postre'),
('Plato D', 8.00, 'Entrada'),
('Plato E', 20.00, 'Plato Fuerte'),
('Plato F', 18.50, 'Postre'),
('Plato G', 9.00, 'Entrada'),
('Plato H', 25.00, 'Plato Fuerte'),
('Plato I', 7.50, 'Postre'),
('Plato J', 30.00, 'Plato Especial');


INSERT INTO Promocion (tipo, descuento) VALUES
('Descuento General', 10.00),
('Promoción Especial', 15.00),
('Descuento por Volumen', 20.00),
('2x1', 50.00),
('Descuento Aniversario', 25.00),
('Promoción Feriado', 30.00),
('Descuento Estudiante', 10.00),
('Oferta Exclusiva', 35.00),
('Descuento VIP', 40.00),
('Promoción Flash', 45.00);


INSERT INTO Pedido (usuario_id, plato_id, promocion_id, cantidad, precio) VALUES
(1, 1, 1, 2, 21.00),
(2, 2, 2, 1, 12.00),
(3, 3, 3, 3, 45.00),
(4, 4, NULL, 2, 16.00),
(5, 5, 4, 1, 20.00),
(6, 6, 5, 1, 18.50),
(7, 7, 6, 2, 18.00),
(8, 8, NULL, 1, 25.00),
(9, 9, 7, 1, 7.50),
(10, 10, 8, 1, 30.00);



INSERT INTO Pago (pedido_id, total, total_pago, fecha_pago) VALUES
(1, 21.00, 18.90, '2024-11-01'),
(2, 12.00, 10.20, '2024-11-02'),
(3, 45.00, 36.00, '2024-11-03'),
(4, 16.00, 16.00, '2024-11-04'),
(5, 20.00, 15.00, '2024-11-05'),
(6, 18.50, 14.80, '2024-11-06'),
(7, 18.00, 14.40, '2024-11-07'),
(8, 25.00, 20.00, '2024-11-08'),
(9, 7.50, 6.00, '2024-11-09'),
(10, 30.00, 24.00, '2024-11-10');

INSERT INTO Venta (pago_id, fecha_venta, pedido_id) VALUES
(1, '2024-11-01', 1),
(2, '2024-11-02', 2),
(3, '2024-11-03', 3),
(4, '2024-11-04', 4),
(5, '2024-11-05', 5),
(6, '2024-11-06', 6),
(7, '2024-11-07', 7),
(8, '2024-11-08', 8),
(9, '2024-11-09', 9),
(10, '2024-11-10', 10);



INSERT INTO Reporte (venta_id, fecha_reporte, inicio_reporte, final_reporte) VALUES
(1, '2024-11-01', '2024-11-01', '2024-11-01'),
(2, '2024-11-02', '2024-11-02', '2024-11-02'),
(3, '2024-11-03', '2024-11-03', '2024-11-03'),
(4, '2024-11-04', '2024-11-04', '2024-11-04'),
(5, '2024-11-05', '2024-11-05', '2024-11-05'),
(6, '2024-11-06', '2024-11-06', '2024-11-06'),
(7, '2024-11-07', '2024-11-07', '2024-11-07'),
(8, '2024-11-08', '2024-11-08', '2024-11-08'),
(9, '2024-11-09', '2024-11-09', '2024-11-09'),
(10, '2024-11-10', '2024-11-10', '2024-11-10');



--Store Procedures

--Tabla usuario

--CREATE
USE POSLBD;
GO

CREATE PROCEDURE sp_InsertarUsuario
    @nombre VARCHAR(100),
    @apellido VARCHAR(100),
    @contraseña VARCHAR(100),
    @rol INT
AS
BEGIN
    INSERT INTO Usuario (nombre, apellido, contraseña, rol)
    VALUES (@nombre, @apellido, @contraseña, @rol);
END;
GO

--READ

-- Procedimiento para obtener un solo usuario por usuario_id
CREATE PROCEDURE sp_ObtenerUsuario
    @usuario_id INT
AS
BEGIN
    SELECT usuario_id, nombre, apellido, contraseña, rol
    FROM Usuario
    WHERE usuario_id = @usuario_id;
END;
GO

-- Procedimiento para obtener todos los usuarios
CREATE PROCEDURE sp_ObtenerTodosUsuarios
AS
BEGIN
    SELECT usuario_id, nombre, apellido, contraseña, rol
    FROM Usuario;
END;
GO

--UPDATE
CREATE PROCEDURE sp_ActualizarUsuario
    @usuario_id INT,
    @nombre VARCHAR(100),
    @apellido VARCHAR(100),
    @contraseña VARCHAR(100),
    @rol INT
AS
BEGIN
    UPDATE Usuario
    SET nombre = @nombre, apellido = @apellido, contraseña = @contraseña, rol = @rol
    WHERE usuario_id = @usuario_id;
END;
GO

--DELETE

CREATE PROCEDURE sp_EliminarUsuarios
    @usuario_id INT
AS
BEGIN
    -- Actualizar los registros en la tabla Pedido para que usuario_id sea NULL
    UPDATE Pedido
    SET usuario_id = NULL
    WHERE usuario_id = @usuario_id;

    -- Ahora eliminar al usuario
    DELETE FROM Usuario
    WHERE usuario_id = @usuario_id;
END;
GO


/*Testing

EXEC sp_InsertarUsuario @nombre = 'Carlos', @apellido = 'González', @contraseña = 'newPassword123', @rol = 1;

EXEC sp_ObtenerUsuario @usuario_id = 2;

EXEC sp_ActualizarUsuario @usuario_id = 1, @nombre = 'Juan', @apellido = 'Pérez', @contraseña = 'newPassword456', @rol = 2;

EXEC sp_EliminarUsuarios @usuario_id = 2;

*/

--Tabla Menu

--CREATE

USE POSLBD;
GO

CREATE PROCEDURE sp_InsertarPlato
    @nombre_plato VARCHAR(100),
    @precio DECIMAL(10, 2),
    @tipo VARCHAR(50)
AS
BEGIN
    INSERT INTO Menu (nombre_plato, precio, tipo)
    VALUES (@nombre_plato, @precio, @tipo);
END;
GO
--READ

-- Procedimiento para obtener un solo plato por plato_id
CREATE PROCEDURE sp_ObtenerPlato
    @plato_id INT
AS
BEGIN
    SELECT plato_id, nombre_plato, precio, tipo
    FROM Menu
    WHERE plato_id = @plato_id;
END;
GO
-- Procedimiento para obtener todos los platos del menú
CREATE PROCEDURE sp_ObtenerTodosPlatos
AS
BEGIN
    SELECT plato_id, nombre_plato, precio, tipo
    FROM Menu;
END;
GO
--UPDATE

CREATE PROCEDURE sp_ActualizarPlato
    @plato_id INT,
    @nombre_plato VARCHAR(100),
    @precio DECIMAL(10, 2),
    @tipo VARCHAR(50)
AS
BEGIN
    UPDATE Menu
    SET nombre_plato = @nombre_plato, precio = @precio, tipo = @tipo
    WHERE plato_id = @plato_id;
END;
GO
--DELETE

CREATE PROCEDURE sp_EliminarPlatos
    @plato_id INT
AS
BEGIN
    -- Actualizar los registros en la tabla Pedido para que plato_id sea NULL
    UPDATE Pedido
    SET plato_id = NULL
    WHERE plato_id = @plato_id;

    -- Ahora eliminar el plato
    DELETE FROM Menu
    WHERE plato_id = @plato_id;
END;
GO


/*testing

EXEC sp_InsertarPlato @nombre_plato = 'Plato K', @precio = 12.50, @tipo = 'Postre';

EXEC sp_ObtenerPlato @plato_id = 1;

EXEC sp_ObtenerTodosPlatos;


EXEC sp_ActualizarPlato @plato_id = 1, @nombre_plato = 'Plato A Nuevo', @precio = 11.00, @tipo = 'Entrada';

EXEC sp_EliminarPlatos @plato_id = 1;
*/


--TABLA INVENTARIO

--CREATE

CREATE PROCEDURE sp_InsertarInventario
    @proveedor_id INT,
    @cant_producto INT,
    @nombre_producto VARCHAR(100)
AS
BEGIN
    INSERT INTO Inventario (proveedor_id, cant_producto, nombre_producto)
    VALUES (@proveedor_id, @cant_producto, @nombre_producto);
END;
GO
--READ

CREATE PROCEDURE sp_LeerInventario
AS
BEGIN
    SELECT * FROM Inventario;
END;
GO


--UPDATE
CREATE PROCEDURE sp_ActualizarInventario
    @producto_id INT,
    @cant_producto INT,
    @nombre_producto VARCHAR(100)
AS
BEGIN
    UPDATE Inventario
    SET cant_producto = @cant_producto,
        nombre_producto = @nombre_producto
    WHERE producto_id = @producto_id;
END;

GO
--DELETE
CREATE PROCEDURE sp_EliminarInventario
    @producto_id INT
AS
BEGIN
    DELETE FROM Inventario
    WHERE producto_id = @producto_id;
END;
GO

/*TESTING 

EXEC sp_InsertarInventario @proveedor_id = 1, @cant_producto = 100, @nombre_producto = 'Nuevo Producto';

EXEC sp_LeerInventario;

EXEC sp_ActualizarInventario @producto_id = 2, @cant_producto = 200, @nombre_producto = 'Producto Actualizado';

EXEC sp_EliminarInventario @producto_id = 2;
*/


--TABLA PROVEEDOR

--CREATE

CREATE PROCEDURE sp_InsertarProveedor
    @nombre_proveedor VARCHAR(100),
    @contacto VARCHAR(100)
AS
BEGIN
    INSERT INTO Proveedor (nombre_proveedor, contacto)
    VALUES (@nombre_proveedor, @contacto);
END;
GO

--READ

CREATE PROCEDURE sp_LeerProveedorPorId
    @proveedor_id INT
AS
BEGIN
    SELECT * FROM Proveedor
    WHERE proveedor_id = @proveedor_id;
END;
GO

--UPDATE

CREATE PROCEDURE sp_ActualizarProveedor
    @proveedor_id INT,
    @nombre_proveedor VARCHAR(100),
    @contacto VARCHAR(100)
AS
BEGIN
    UPDATE Proveedor
    SET nombre_proveedor = @nombre_proveedor,
        contacto = @contacto
    WHERE proveedor_id = @proveedor_id;
END;
GO

--DELETE

CREATE PROCEDURE sp_EliminarProveedores1
    @proveedor_id INT
AS
BEGIN
    -- Eliminar registros en la tabla Inventario donde proveedor_id sea el proveedor a eliminar
    DELETE FROM Inventario
    WHERE proveedor_id = @proveedor_id;

    -- Ahora eliminamos el proveedor
    DELETE FROM Proveedor WHERE proveedor_id = @proveedor_id;
END;
GO


/*TESTING

EXEC sp_InsertarProveedor @nombre_proveedor = 'Proveedor X', @contacto = 'contactoX@example.com';

EXEC sp_LeerProveedorPorId @proveedor_id = 1;

EXEC sp_ActualizarProveedor @proveedor_id = 1, @nombre_proveedor = 'Proveedor Y', @contacto = 'contactoY@example.com';

EXEC sp_EliminarProveedores1 @proveedor_id = 1;
*/



--TABLA PEDIDO

--CREATE
CREATE PROCEDURE sp_AgregarPedido
    @usuario_id INT,
    @plato_id INT,
    @promocion_id INT,
    @cantidad INT,
    @precio DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Pedido (usuario_id, plato_id, promocion_id, cantidad, precio)
    VALUES (@usuario_id, @plato_id, @promocion_id, @cantidad, @precio);
END;
GO

--READ

CREATE PROCEDURE sp_ObtenerPedidos
AS
BEGIN
    SELECT * FROM Pedido;
END;
GO
--READ POR ID

CREATE PROCEDURE sp_ObtenerPedidoPorId
    @pedido_id INT
AS
BEGIN
    SELECT 
        p.pedido_id,
        p.usuario_id,
        p.plato_id,
        p.promocion_id,
        p.cantidad,
        p.precio,
        u.nombre AS usuario_nombre,
        m.nombre_plato,
        pm.tipo AS promocion_tipo
    FROM Pedido p
    JOIN Usuario u ON p.usuario_id = u.usuario_id
    JOIN Menu m ON p.plato_id = m.plato_id
    LEFT JOIN Promocion pm ON p.promocion_id = pm.promo_id
    WHERE p.pedido_id = @pedido_id;
END;
GO


--UPDATE

CREATE PROCEDURE sp_ActualizarPedido
    @pedido_id INT,
    @usuario_id INT,
    @plato_id INT,
    @promocion_id INT,
    @cantidad INT,
    @precio DECIMAL(10, 2)
AS
BEGIN
    UPDATE Pedido
    SET usuario_id = @usuario_id,
        plato_id = @plato_id,
        promocion_id = @promocion_id,
        cantidad = @cantidad,
        precio = @precio
    WHERE pedido_id = @pedido_id;
END;
GO

--DELETE

CREATE PROCEDURE sp_EliminarPedido2
    @pedido_id INT
AS
BEGIN
    -- Eliminar el Pedido. Esto establecerá el pedido_id en Venta a NULL, lo cual a su vez establecerá venta_id en Reporte a NULL si es necesario.
    DELETE FROM Pedido WHERE pedido_id = @pedido_id;
END;
GO


/*TESTING

EXEC sp_AgregarPedido 
    @usuario_id = 5, 
    @plato_id = 2, 
    @promocion_id = 1, 
    @cantidad = 3, 
    @precio = 36.00;

	EXEC sp_ObtenerPedidos; -> TODOS

	EXEC sp_ObtenerPedidoPorId @pedido_id = 5; -> POR ID


	EXEC sp_ActualizarPedido 
    @pedido_id = 5, 
    @usuario_id = 3, 
    @plato_id = 4, 
    @promocion_id = NULL, 
    @cantidad = 4, 
    @precio = 64.00;


	EXEC sp_EliminarPedido2 @pedido_id = 3;*/


/*VISTAS

Pedido por usuario*/

CREATE VIEW vw_UsuarioPedidos AS
SELECT 
    u.usuario_id,
    u.nombre AS nombre_usuario,
    u.apellido AS apellido_usuario,
    p.pedido_id,
    p.plato_id,
    p.promocion_id,
    p.cantidad,
    p.precio
FROM Usuario u
LEFT JOIN Pedido p ON u.usuario_id = p.usuario_id;


--test SELECT * FROM vw_UsuarioPedidos;

--Detalle de usuario

CREATE VIEW vw_UsuariosConRoles AS
SELECT 
    usuario_id,
    nombre,
    apellido,
    CASE 
        WHEN rol = 1 THEN 'Administrador'
        WHEN rol = 2 THEN 'Usuario Regular'
        ELSE 'Desconocido'
    END AS rol_descripcion
FROM Usuario;
GO

-- test SELECT * FROM vw_UsuariosConRoles;

--Detalle de inventario con proveedor

CREATE VIEW vw_InventarioDetallado AS
SELECT 
    i.producto_id,
    i.nombre_producto,
    i.cant_producto,
    p.nombre_proveedor,
    p.contacto
FROM Inventario i
JOIN Proveedor p ON i.proveedor_id = p.proveedor_id;
GO


-- test SELECT * FROM  vw_InventarioDetallado;

--VENTAS

CREATE VIEW vw_VentasConDetalle AS
SELECT 
    v.venta_id,
    v.fecha_venta,
    p.pedido_id,
    u.nombre AS cliente_nombre,
    u.apellido AS cliente_apellido,
    m.nombre_plato,
    p.cantidad,
    p.precio,
    pm.tipo AS promocion_aplicada,
    pa.total_pago
FROM Venta v
JOIN Pedido p ON v.pedido_id = p.pedido_id
LEFT JOIN Usuario u ON p.usuario_id = u.usuario_id
LEFT JOIN Menu m ON p.plato_id = m.plato_id
LEFT JOIN Promocion pm ON p.promocion_id = pm.promo_id
LEFT JOIN Pago pa ON v.pago_id = pa.pago_id;
GO


--test SELECT * FROM vw_VentasConDetalle;

--REPORTES

CREATE VIEW vw_ReportesResumen AS
SELECT 
    r.reporte_id,
    r.fecha_reporte,
    r.inicio_reporte,
    r.final_reporte,
    COUNT(v.venta_id) AS total_ventas,
    SUM(p.precio * p.cantidad) AS total_ingresos
FROM Reporte r
LEFT JOIN Venta v ON r.venta_id = v.venta_id
LEFT JOIN Pedido p ON v.pedido_id = p.pedido_id
GROUP BY 
    r.reporte_id, r.fecha_reporte, r.inicio_reporte, r.final_reporte;
GO


--test SELECT * FROM vw_ReportesResumen;
