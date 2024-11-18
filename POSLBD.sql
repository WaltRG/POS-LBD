USE POSLBD;
GO
-- Crear la tabla Usuario
CREATE TABLE Usuario (
    usuario_id INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    contraseña VARCHAR(100),
    rol INT
);

-- Crear la tabla Proveedor
CREATE TABLE Proveedor (
    proveedor_id INT PRIMARY KEY,
    nombre_proveedor VARCHAR(100),
    contacto VARCHAR(100)
);

-- Crear la tabla Inventario
CREATE TABLE Inventario (
    producto_id INT PRIMARY KEY,
    proveedor_id INT,
    cant_producto INT,
    nombre_producto VARCHAR(100),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedor(proveedor_id)
);

-- Crear la tabla Menu
CREATE TABLE Menu (
    plato_id INT PRIMARY KEY,
    nombre_plato VARCHAR(100),
    precio DECIMAL(10, 2),
    tipo VARCHAR(50)
);

-- Crear la tabla Promoción
CREATE TABLE Promocion (
    promo_id INT PRIMARY KEY,
    tipo VARCHAR(50),
    descuento DECIMAL(5, 2)
);

-- Crear la tabla Pedido
CREATE TABLE Pedido (
    pedido_id INT PRIMARY KEY,
    usuario_id INT,
    plato_id INT,
    promocion_id INT,
    cantidad INT,
    precio DECIMAL(10, 2),
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (plato_id) REFERENCES Menu(plato_id),
    FOREIGN KEY (promocion_id) REFERENCES Promocion(promo_id) -- Esta relación es opcional, puede aceptar NULL
);

-- Crear la tabla Pago
CREATE TABLE Pago (
    pago_id INT PRIMARY KEY,
    pedido_id INT,
    total DECIMAL(10, 2),
    total_pago DECIMAL(10, 2),
    fecha_pago DATE,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

-- Crear la tabla Cierre
CREATE TABLE Cierre (
    cierre_id INT PRIMARY KEY,
    pago_id INT,
    usuario_id INT,
    totales DECIMAL(10, 2),
    fecha_cierre DATE,
    FOREIGN KEY (pago_id) REFERENCES Pago(pago_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id)
	);

-- Crear la tabla Venta
CREATE TABLE Venta (
    venta_id INT PRIMARY KEY,
    pago_id INT,
    fecha_venta DATE,
    pedido_id INT,
    FOREIGN KEY (pago_id) REFERENCES Pago(pago_id),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

-- Crear la tabla Reporte
CREATE TABLE Reporte (
    reporte_id INT PRIMARY KEY,
    venta_id INT,
    fecha_reporte DATE,
    inicio_reporte DATE,
    final_reporte DATE,
    FOREIGN KEY (venta_id) REFERENCES Venta(venta_id)
);