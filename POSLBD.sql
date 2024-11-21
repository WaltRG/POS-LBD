-- Crear la tabla Usuario
CREATE TABLE Usuario (
    usuario_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    contrase�a VARCHAR(100) NOT NULL,
    rol INT CHECK (rol IN (1, 2)) -- Restricci�n para valores v�lidos
);

-- Proveedor
CREATE TABLE Proveedor (
    proveedor_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre_proveedor VARCHAR2(100),
    contacto VARCHAR2(100)
);

-- Inventario
CREATE TABLE Inventario (
    producto_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    proveedor_id NUMBER,
    cant_producto NUMBER,
    nombre_producto VARCHAR2(100),
    CONSTRAINT fk_proveedor FOREIGN KEY (proveedor_id) REFERENCES Proveedor(proveedor_id)
);


-- Menu
CREATE TABLE Menu (
    plato_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre_plato VARCHAR2(100),
    precio NUMBER(10, 2),
    tipo VARCHAR2(50)
);

-- Promocion
CREATE TABLE Promocion (
    promo_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo VARCHAR2(50),
    descuento NUMBER(5, 2)
);

-- Pedido
CREATE TABLE Pedido (
    pedido_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id NUMBER,
    plato_id NUMBER,
    promocion_id NUMBER,
    cantidad NUMBER,
    precio NUMBER(10, 2),
    CONSTRAINT fk_usuario FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
    CONSTRAINT fk_plato FOREIGN KEY (plato_id) REFERENCES Menu(plato_id),
    CONSTRAINT fk_promocion FOREIGN KEY (promocion_id) REFERENCES Promocion(promo_id)
);

-- Pago
CREATE TABLE Pago (
    pago_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    pedido_id NUMBER,
    total NUMBER(10, 2),
    total_pago NUMBER(10, 2),
    fecha_pago DATE,
    CONSTRAINT fk_pago_pedido FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id) ON DELETE CASCADE
);


-- Cierre
CREATE TABLE Cierre (
    cierre_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    pago_id NUMBER,
    usuario_id NUMBER,
    totales NUMBER(10, 2),
    fecha_cierre DATE,
    CONSTRAINT fk_cierre_pago FOREIGN KEY (pago_id) REFERENCES Pago(pago_id),
    CONSTRAINT fk_cierre_usuario FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id)
);



-- Venta
CREATE TABLE Venta (
    venta_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    pago_id NUMBER,
    fecha_venta DATE,
    pedido_id NUMBER,
    CONSTRAINT fk_venta_pago FOREIGN KEY (pago_id) REFERENCES Pago(pago_id),
    CONSTRAINT fk_venta_pedido FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

-- Reporte
CREATE TABLE Reporte (
    reporte_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    venta_id NUMBER,
    fecha_reporte DATE,
    inicio_reporte DATE,
    final_reporte DATE,
    CONSTRAINT fk_reporte_venta FOREIGN KEY (venta_id) REFERENCES Venta(venta_id)
);



-- Inserci�n de datos en Usuario
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Juan', 'P�rez', 'password123', 1);
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Ana', 'G�mez', 'securePass1', 2);
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Carlos', 'L�pez', 'carL123!', 1);
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Laura', 'Mart�nez', 'lauMtz21', 2);
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Diego', 'S�nchez', 'd123456!', 1);
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Mar�a', 'Garc�a', 'mPass1#', 2);
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Luis', 'Hern�ndez', 'hSecure!', 1);
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Sof�a', 'Torres', 'sofiaTor1', 2);
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Jorge', 'Vargas', 'jorVargas#', 1);
INSERT INTO Usuario (nombre, apellido, contrase�a, rol) VALUES ('Paula', 'Morales', 'paulaMrl$', 2);


-- Inserci�n de datos en Proveedor
INSERT INTO Proveedor (nombre_proveedor, contacto) VALUES ('Proveedor A', 'contactoA@example.com');
INSERT INTO Proveedor (nombre_proveedor, contacto) VALUES ('Proveedor B', 'contactoB@example.com');
INSERT INTO Proveedor (nombre_proveedor, contacto) VALUES ('Proveedor C', 'contactoC@example.com');
INSERT INTO Proveedor (nombre_proveedor, contacto) VALUES ('Proveedor D', 'contactoD@example.com');
INSERT INTO Proveedor (nombre_proveedor, contacto) VALUES ('Proveedor E', 'contactoE@example.com');


-- Inserci�n de datos en Inventario
INSERT INTO Inventario (proveedor_id, cant_producto, nombre_producto) VALUES (1, 50, 'Producto A1');
INSERT INTO Inventario (proveedor_id, cant_producto, nombre_producto) VALUES (2, 30, 'Producto B1');
INSERT INTO Inventario (proveedor_id, cant_producto, nombre_producto) VALUES (3, 20, 'Producto C1');
INSERT INTO Inventario (proveedor_id, cant_producto, nombre_producto) VALUES (4, 40, 'Producto D1');
INSERT INTO Inventario (proveedor_id, cant_producto, nombre_producto) VALUES (5, 15, 'Producto E1');


-- Inserci�n de datos en Menu
INSERT INTO Menu (nombre_plato, precio, tipo) VALUES ('Plato A', 10.50, 'Entrada');
INSERT INTO Menu (nombre_plato, precio, tipo) VALUES ('Plato B', 12.00, 'Plato Fuerte');
INSERT INTO Menu (nombre_plato, precio, tipo) VALUES ('Plato C', 15.00, 'Postre');
INSERT INTO Menu (nombre_plato, precio, tipo) VALUES ('Plato D', 8.00, 'Entrada');
INSERT INTO Menu (nombre_plato, precio, tipo) VALUES ('Plato E', 20.00, 'Plato Fuerte');


-- Inserci�n de datos en Promocion
INSERT INTO Promocion (tipo, descuento) VALUES ('Descuento General', 10.00);
INSERT INTO Promocion (tipo, descuento) VALUES ('Promoci�n Especial', 15.00);
INSERT INTO Promocion (tipo, descuento) VALUES ('Descuento por Volumen', 20.00);
INSERT INTO Promocion (tipo, descuento) VALUES ('2x1', 50.00);
INSERT INTO Promocion (tipo, descuento) VALUES ('Descuento Aniversario', 25.00);


INSERT INTO Pedido (usuario_id, plato_id, promocion_id, cantidad, precio) 
VALUES (1, 1, 1, 2, 21.00);
INSERT INTO Pedido (usuario_id, plato_id, promocion_id, cantidad, precio) 
VALUES (2, 2, 2, 1, 12.00);
INSERT INTO Pedido (usuario_id, plato_id, promocion_id, cantidad, precio) 
VALUES (3, 3, 3, 3, 45.00);
INSERT INTO Pedido (usuario_id, plato_id, promocion_id, cantidad, precio) 
VALUES (4, 4, NULL, 2, 16.00);
INSERT INTO Pedido (usuario_id, plato_id, promocion_id, cantidad, precio) 
VALUES (5, 5, 4, 1, 20.00);

INSERT INTO Pago (pedido_id, total, total_pago, fecha_pago) 
VALUES (1, 21.00, 18.90, TO_DATE('2024-11-01', 'YYYY-MM-DD'));
INSERT INTO Pago (pedido_id, total, total_pago, fecha_pago) 
VALUES (2, 12.00, 10.20, TO_DATE('2024-11-02', 'YYYY-MM-DD'));
INSERT INTO Pago (pedido_id, total, total_pago, fecha_pago) 
VALUES (3, 45.00, 36.00, TO_DATE('2024-11-03', 'YYYY-MM-DD'));
INSERT INTO Pago (pedido_id, total, total_pago, fecha_pago) 
VALUES (4, 16.00, 16.00, TO_DATE('2024-11-04', 'YYYY-MM-DD'));
INSERT INTO Pago (pedido_id, total, total_pago, fecha_pago) 
VALUES (5, 20.00, 15.00, TO_DATE('2024-11-05', 'YYYY-MM-DD'));


-- Inserci�n de datos en Venta con los pagos y pedidos correctos
INSERT INTO Venta (pago_id, fecha_venta, pedido_id) 
VALUES (6, TO_DATE('2024-11-01', 'YYYY-MM-DD'), 1);
INSERT INTO Venta (pago_id, fecha_venta, pedido_id) 
VALUES (7, TO_DATE('2024-11-02', 'YYYY-MM-DD'), 2);
INSERT INTO Venta (pago_id, fecha_venta, pedido_id) 
VALUES (8, TO_DATE('2024-11-03', 'YYYY-MM-DD'), 3);
INSERT INTO Venta (pago_id, fecha_venta, pedido_id) 
VALUES (9, TO_DATE('2024-11-04', 'YYYY-MM-DD'), 4);
INSERT INTO Venta (pago_id, fecha_venta, pedido_id) 
VALUES (10, TO_DATE('2024-11-05', 'YYYY-MM-DD'), 5);


-- Inserci�n de datos en Reporte
INSERT INTO Reporte (venta_id, fecha_reporte, inicio_reporte, final_reporte) 
VALUES (31, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-01', 'YYYY-MM-DD'));
INSERT INTO Reporte (venta_id, fecha_reporte, inicio_reporte, final_reporte) 
VALUES (32, TO_DATE('2024-11-02', 'YYYY-MM-DD'), TO_DATE('2024-11-02', 'YYYY-MM-DD'), TO_DATE('2024-11-02', 'YYYY-MM-DD'));
INSERT INTO Reporte (venta_id, fecha_reporte, inicio_reporte, final_reporte) 
VALUES (33, TO_DATE('2024-11-03', 'YYYY-MM-DD'), TO_DATE('2024-11-03', 'YYYY-MM-DD'), TO_DATE('2024-11-03', 'YYYY-MM-DD'));
INSERT INTO Reporte (venta_id, fecha_reporte, inicio_reporte, final_reporte) 
VALUES (34, TO_DATE('2024-11-04', 'YYYY-MM-DD'), TO_DATE('2024-11-04', 'YYYY-MM-DD'), TO_DATE('2024-11-04', 'YYYY-MM-DD'));
INSERT INTO Reporte (venta_id, fecha_reporte, inicio_reporte, final_reporte) 
VALUES (35, TO_DATE('2024-11-05', 'YYYY-MM-DD'), TO_DATE('2024-11-05', 'YYYY-MM-DD'), TO_DATE('2024-11-05', 'YYYY-MM-DD'));


--PROCEDIMIENTOS ALMACENADOS

--SP USUARIOS
--CREATE
CREATE OR REPLACE PROCEDURE sp_InsertarUsuario (
    nombre IN VARCHAR2,
    apellido IN VARCHAR2,
    contrase�a IN VARCHAR2,
    rol IN NUMBER
) AS
BEGIN
    INSERT INTO Usuario (nombre, apellido, contrase�a, rol)
    VALUES (nombre, apellido, contrase�a, rol);
END sp_InsertarUsuario;
/


--READ
CREATE OR REPLACE PROCEDURE sp_ObtenerUsuario (
    usuario_id IN NUMBER
) AS
BEGIN
    -- Seleccionar usuario por usuario_id
    FOR rec IN (
        SELECT usuario_id, nombre, apellido, contrase�a, rol
        FROM Usuario
        WHERE usuario_id = usuario_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Usuario ID: ' || rec.usuario_id || ', Nombre: ' || rec.nombre || ', Apellido: ' || rec.apellido);
    END LOOP;
END sp_ObtenerUsuario;
/

CREATE OR REPLACE PROCEDURE sp_ObtenerTodosUsuarios AS
BEGIN
    -- Seleccionar todos los usuarios
    FOR rec IN (
        SELECT usuario_id, nombre, apellido, contrase�a, rol
        FROM Usuario
    ) LOOP
        -- Aqu� tambi�n podr�as usar DBMS_OUTPUT para mostrar los resultados
        DBMS_OUTPUT.PUT_LINE('Usuario ID: ' || rec.usuario_id || ', Nombre: ' || rec.nombre || ', Apellido: ' || rec.apellido);
    END LOOP;
END sp_ObtenerTodosUsuarios;
/


--UPDATE

CREATE OR REPLACE PROCEDURE sp_ActualizarUsuario (
    usuario_id IN NUMBER,
    nombre IN VARCHAR2,
    apellido IN VARCHAR2,
    contrase�a IN VARCHAR2,
    rol IN NUMBER
) AS
BEGIN
    UPDATE Usuario
    SET nombre = nombre,
        apellido = apellido,
        contrase�a = contrase�a,
        rol = rol
    WHERE usuario_id = usuario_id;
END sp_ActualizarUsuario;
/

--DELETE
CREATE OR REPLACE PROCEDURE sp_EliminarUsuarios (
    usuario_id IN NUMBER
) AS
BEGIN
    -- Actualizar los registros en la tabla Pedido para que usuario_id sea NULL
    UPDATE Pedido
    SET usuario_id = NULL
    WHERE usuario_id = usuario_id;

    -- Ahora eliminar al usuario
    DELETE FROM Usuario
    WHERE usuario_id = usuario_id;
END sp_EliminarUsuarios;
/


/*TESING
BEGIN
    sp_InsertarUsuario('Juan', 'P�rez', 'password123', 1);
END;
/

BEGIN
    sp_ObtenerUsuario(1);
END;
/

BEGIN
    sp_ActualizarUsuario(1, 'Carlos', 'P�rez', 'newPassword123', 2);
END;
/
BEGIN
    sp_EliminarUsuarios(1);
END;
/

SELECT * FROM Usuario WHERE usuario_id = 1;

*/

-- SP MENU
--CREATE

-- Crear procedimiento para insertar un plato
CREATE OR REPLACE PROCEDURE sp_InsertarPlato (
    nombre_plato IN VARCHAR2,
    precio IN NUMBER,
    tipo IN VARCHAR2
) AS
BEGIN
    INSERT INTO Menu (nombre_plato, precio, tipo)
    VALUES (nombre_plato, precio, tipo);
END;
/

--READ
-- Crear procedimiento para obtener un solo plato
CREATE OR REPLACE PROCEDURE sp_ObtenerPlato (
    plato_id IN NUMBER
) AS
    v_plato_id NUMBER;
    v_nombre_plato VARCHAR2(100);
    v_precio NUMBER;
    v_tipo VARCHAR2(50);
BEGIN
    -- Realizamos el SELECT y guardamos el resultado en variables locales
    SELECT plato_id, nombre_plato, precio, tipo
    INTO v_plato_id, v_nombre_plato, v_precio, v_tipo
    FROM Menu
    WHERE plato_id = plato_id;

    -- Mostrar los resultados usando DBMS_OUTPUT
    DBMS_OUTPUT.PUT_LINE('Plato ID: ' || v_plato_id);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_plato);
    DBMS_OUTPUT.PUT_LINE('Precio: ' || v_precio);
    DBMS_OUTPUT.PUT_LINE('Tipo: ' || v_tipo);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontr� el plato con ID: ' || plato_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_ObtenerTodosPlatos AS
    CURSOR c_platos IS
        SELECT plato_id, nombre_plato, precio, tipo
        FROM Menu;
    v_plato_id NUMBER;
    v_nombre_plato VARCHAR2(100);
    v_precio NUMBER;
    v_tipo VARCHAR2(50);
BEGIN
    OPEN c_platos;

    LOOP
        FETCH c_platos INTO v_plato_id, v_nombre_plato, v_precio, v_tipo;
        EXIT WHEN c_platos%NOTFOUND;

        -- Mostrar los resultados usando DBMS_OUTPUT
        DBMS_OUTPUT.PUT_LINE('Plato ID: ' || v_plato_id);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_plato);
        DBMS_OUTPUT.PUT_LINE('Precio: ' || v_precio);
        DBMS_OUTPUT.PUT_LINE('Tipo: ' || v_tipo);
    END LOOP;

    CLOSE c_platos;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--UPDATE

-- Crear procedimiento para actualizar un plato
CREATE OR REPLACE PROCEDURE sp_ActualizarPlato (
    plato_id IN NUMBER,
    nombre_plato IN VARCHAR2,
    precio IN NUMBER,
    tipo IN VARCHAR2
) AS
BEGIN
    UPDATE Menu
    SET nombre_plato = nombre_plato, precio = precio, tipo = tipo
    WHERE plato_id = plato_id;
END;
/

--DELETE
-- Crear procedimiento para eliminar un plato
CREATE OR REPLACE PROCEDURE sp_EliminarPlatos (
    plato_id IN NUMBER
) AS
BEGIN
    -- Actualizar los registros en la tabla Pedido para que plato_id sea NULL
    UPDATE Pedido
    SET plato_id = NULL
    WHERE plato_id = plato_id;

    -- Eliminar el plato de la tabla Menu
    DELETE FROM Menu
    WHERE plato_id = plato_id;
END;
/

/*TESTING

BEGIN
    sp_InsertarPlato('Spaghetti', 12.99, 'Pasta');
END;
/

BEGIN
    sp_ObtenerPlato(1);
END;
/

BEGIN
    sp_ObtenerTodosPlatos;
END;
/


BEGIN
    sp_ActualizarPlato(1, 'Spaghetti Carbonara', 15.99, 'Pasta');
END;
/

BEGIN
    sp_EliminarPlatos(1);
END;
/
*/



--SP INVENTARIO

--CREATE

CREATE OR REPLACE PROCEDURE sp_InsertarInventario (
    proveedor_id IN NUMBER,
    cant_producto IN NUMBER,
    nombre_producto IN VARCHAR2
) AS
BEGIN
    -- Insertar un nuevo registro en la tabla Inventario
    INSERT INTO Inventario (proveedor_id, cant_producto, nombre_producto)
    VALUES (proveedor_id, cant_producto, nombre_producto);
END;
/


--READ

CREATE OR REPLACE PROCEDURE sp_LeerInventario AS
    CURSOR c_inventario IS
        SELECT producto_id, proveedor_id, cant_producto, nombre_producto
        FROM Inventario;
    v_producto_id NUMBER;
    v_proveedor_id NUMBER;
    v_cant_producto NUMBER;
    v_nombre_producto VARCHAR2(100);
BEGIN
    OPEN c_inventario;

    LOOP
        FETCH c_inventario INTO v_producto_id, v_proveedor_id, v_cant_producto, v_nombre_producto;
        EXIT WHEN c_inventario%NOTFOUND;

        -- Mostrar los resultados usando DBMS_OUTPUT
        DBMS_OUTPUT.PUT_LINE('Producto ID: ' || v_producto_id);
        DBMS_OUTPUT.PUT_LINE('Proveedor ID: ' || v_proveedor_id);
        DBMS_OUTPUT.PUT_LINE('Cantidad Producto: ' || v_cant_producto);
        DBMS_OUTPUT.PUT_LINE('Nombre Producto: ' || v_nombre_producto);
    END LOOP;

    CLOSE c_inventario;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


--UPDATE

CREATE OR REPLACE PROCEDURE sp_ActualizarInventario (
    producto_id IN NUMBER,
    cant_producto IN NUMBER,
    nombre_producto IN VARCHAR2
) AS
BEGIN
    -- Actualizar el inventario con los nuevos valores
    UPDATE Inventario
    SET cant_producto = cant_producto,
        nombre_producto = nombre_producto
    WHERE producto_id = producto_id;
END;
/

--DELETE

CREATE OR REPLACE PROCEDURE sp_EliminarInventario (
    producto_id IN NUMBER
) AS
BEGIN
    -- Eliminar un registro de Inventario por producto_id
    DELETE FROM Inventario
    WHERE producto_id = producto_id;
END;
/


/*TESTING

EXEC sp_InsertarInventario(1, 100, 'Producto A');

EXEC sp_LeerInventario;

EXEC sp_ActualizarInventario(1, 150, 'Producto A Actualizado');

EXEC sp_EliminarInventario(2);

*/


--SP PROVEEDOR

--CREATE

CREATE OR REPLACE PROCEDURE sp_InsertarProveedor (
    nombre_proveedor IN VARCHAR2,
    contacto IN VARCHAR2
) AS
BEGIN
    INSERT INTO Proveedor (nombre_proveedor, contacto)
    VALUES (nombre_proveedor, contacto);
    COMMIT; -- Confirmar la transacci�n
END;
/


--READ

CREATE OR REPLACE PROCEDURE sp_LeerProveedorPorId (
    proveedor_id IN NUMBER
) AS
BEGIN
    FOR r IN (SELECT * FROM Proveedor WHERE proveedor_id = proveedor_id) LOOP
        -- Puedes usar DBMS_OUTPUT para mostrar los resultados
        DBMS_OUTPUT.PUT_LINE('Proveedor ID: ' || r.proveedor_id);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || r.nombre_proveedor);
        DBMS_OUTPUT.PUT_LINE('Contacto: ' || r.contacto);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontr� el proveedor con ID ' || proveedor_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--UPDATE

CREATE OR REPLACE PROCEDURE sp_ActualizarProveedor (
    proveedor_id IN NUMBER,
    nombre_proveedor IN VARCHAR2,
    contacto IN VARCHAR2
) AS
BEGIN
    UPDATE Proveedor
    SET nombre_proveedor = nombre_proveedor,
        contacto = contacto
    WHERE proveedor_id = proveedor_id;

    COMMIT; -- Confirmar la transacci�n
END;
/

--DELETE

CREATE OR REPLACE PROCEDURE sp_EliminarProveedores1 (
    proveedor_id IN NUMBER
) AS
BEGIN
    -- Eliminar registros en la tabla Inventario donde proveedor_id sea el proveedor a eliminar
    DELETE FROM Inventario
    WHERE proveedor_id = proveedor_id;

    -- Ahora eliminamos el proveedor
    DELETE FROM Proveedor WHERE proveedor_id = proveedor_id;

    COMMIT; -- Confirmar la transacci�n
END;
/

/*TESTING

EXEC sp_InsertarProveedor('Proveedor A', '123-456-789');

EXEC sp_LeerProveedorPorId(1); 

EXEC sp_ActualizarProveedor(1, 'Proveedor A Actualizado', '111-222-333');

EXEC sp_EliminarProveedores1(1); -- Elimina el proveedor con ID 1 y sus registros asociados en Inventario
*/


--SP REPORTE


--CREATE
CREATE OR REPLACE PROCEDURE sp_InsertarReporte (
    p_venta_id IN NUMBER,
    p_fecha_reporte IN DATE,
    p_inicio_reporte IN DATE,
    p_final_reporte IN DATE
) AS
BEGIN
    INSERT INTO Reporte (venta_id, fecha_reporte, inicio_reporte, final_reporte)
    VALUES (p_venta_id, p_fecha_reporte, p_inicio_reporte, p_final_reporte);

    COMMIT; -- Confirmar la transacci�n
END;
/


--READ

CREATE OR REPLACE PROCEDURE sp_ObtenerReportePorId (
    p_reporte_id IN NUMBER
) AS
BEGIN
    FOR r IN (SELECT reporte_id, venta_id, fecha_reporte, inicio_reporte, final_reporte
              FROM Reporte
              WHERE reporte_id = p_reporte_id) LOOP
        -- Mostrar los resultados
        DBMS_OUTPUT.PUT_LINE('Reporte ID: ' || r.reporte_id);
        DBMS_OUTPUT.PUT_LINE('Venta ID: ' || r.venta_id);
        DBMS_OUTPUT.PUT_LINE('Fecha Reporte: ' || TO_CHAR(r.fecha_reporte, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Inicio Reporte: ' || TO_CHAR(r.inicio_reporte, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Final Reporte: ' || TO_CHAR(r.final_reporte, 'DD-MON-YYYY'));
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontr� el reporte con ID ' || p_reporte_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE sp_ObtenerTodosReportes AS
BEGIN
    FOR r IN (SELECT reporte_id, venta_id, fecha_reporte, inicio_reporte, final_reporte
              FROM Reporte) LOOP
        -- Mostrar los resultados
        DBMS_OUTPUT.PUT_LINE('Reporte ID: ' || r.reporte_id);
        DBMS_OUTPUT.PUT_LINE('Venta ID: ' || r.venta_id);
        DBMS_OUTPUT.PUT_LINE('Fecha Reporte: ' || TO_CHAR(r.fecha_reporte, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Inicio Reporte: ' || TO_CHAR(r.inicio_reporte, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Final Reporte: ' || TO_CHAR(r.final_reporte, 'DD-MON-YYYY'));
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--UPDATE

CREATE OR REPLACE PROCEDURE sp_ActualizarReporte (
    p_reporte_id IN NUMBER,
    p_venta_id IN NUMBER,
    p_fecha_reporte IN DATE,
    p_inicio_reporte IN DATE,
    p_final_reporte IN DATE
) AS
BEGIN
    UPDATE Reporte
    SET venta_id = p_venta_id,
        fecha_reporte = p_fecha_reporte,
        inicio_reporte = p_inicio_reporte,
        final_reporte = p_final_reporte
    WHERE reporte_id = p_reporte_id;

    COMMIT; -- Confirmar la transacci�n
END;
/


--DELETE

CREATE OR REPLACE PROCEDURE sp_EliminarReporte (
    p_reporte_id IN NUMBER
) AS
BEGIN
    DELETE FROM Reporte
    WHERE reporte_id = p_reporte_id;

    COMMIT; -- Confirmar la transacci�n
END;
/


/*TESTING 

EXEC sp_InsertarReporte(1, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-02', 'YYYY-MM-DD'));

EXEC sp_ObtenerReportePorId(5); 

EXEC sp_ObtenerTodosReportes;

EXEC sp_ActualizarReporte(1, 2, TO_DATE('2024-11-03', 'YYYY-MM-DD'), TO_DATE('2024-11-03', 'YYYY-MM-DD'), TO_DATE('2024-11-04', 'YYYY-MM-DD'));

EXEC sp_EliminarReporte(5); -- Elimina el reporte con ID 1
*/


--VISTAS

-- USUARIO-PEDIDOS
CREATE OR REPLACE VIEW vw_UsuarioPedidos AS
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

--USUARIOS Y ROLES

CREATE OR REPLACE VIEW vw_UsuariosConRoles AS
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


--INVENTARIO
CREATE OR REPLACE VIEW vista_inventario_proveedor AS
SELECT i.producto_id, 
       i.nombre_producto, 
       i.cant_producto, 
       p.nombre_proveedor, 
       p.contacto
FROM Inventario i
JOIN Proveedor p ON i.proveedor_id = p.proveedor_id;



--VENTAS

CREATE OR REPLACE VIEW vw_VentasConDetalle AS
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

--REPORTES

CREATE OR REPLACE VIEW vw_ReportesResumen AS
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
    





















