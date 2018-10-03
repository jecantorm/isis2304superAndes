--- Sentencias SQL para la creación del esquema de superAndes
--- Las tablas tienen prefijo A_ para facilitar su acceso desde SQL Developer

-- Creación restricciones de la tabla A_PRODUCTO
ALTER TABLE A_PRODUCTO
ADD CONSTRAINT PK_A_PRODUCTO
PRIMARY KEY(CODIGO_DE_BARRAS)
;
ALTER TABLE A_PRODUCTO
ADD CONSTRAINT UN_NOMBRE
UNIQUE (NOMBRE)
;
ALTER TABLE A_PRODUCTO
ADD CONSTRAINT CK_UNIDAD_DE_MEDIDA
CHECK ( UNIDAD_DE_MEDIDA IN ('ml','cm3'))
;


-- Creación restricciones de la tabla A_PROMOCION
ALTER TABLE A_PROMOCION
ADD CONSTRAINT PK_A_PROMOCION
PRIMARY KEY(ID_PROMOCION)
;
ALTER TABLE A_PROMOCION
ADD CONSTRAINT CK_CANTIDAD_PRODUCTOS_P
CHECK (CANTIDAD_PRODUCTOS >=0)
;

-- Creación referencia FK de A_PROMOCION a A_PRODUCTO

ALTER TABLE A_PRODUCTO
ADD CONSTRAINT FK_A_PROMOCION
    FOREIGN KEY (ID_PROMOCION)
    REFERENCES A_PROMOCION (ID_PROMOCION)
;

-- Creación restricciones de la tabla A_PROVEEDOR
ALTER TABLE A_PROVEEDOR
ADD CONSTRAINT CK_CALIFICACION
CHECK(CALIFICACION <= 10 AND CALIFICACION >= 0)
;

ALTER TABLE A_PROVEEDOR
ADD CONSTRAINT PK_PROVEEDOR
PRIMARY KEY (NIT)
;

ALTER TABLE A_PROVEEDOR
ADD CONSTRAINT CK_NIT_PROVEEDOR
CHECK (NIT>=100000000 AND NIT <=999999999)
;

ALTER TABLE A_PROVEEDOR
ADD CONSTRAINT UN_NOMBRE_P
UNIQUE (NOMBRE)
;

ALTER TABLE A_PROVEEDOR
ADD CONSTRAINT CK_TIPOPROVEEDOR
CHECK (TIPOPROVEEDOR IN ('Especifico','General'))
;

-- Creación referencia FK de A_PRODUCTO a A_PROVEEDOR

ALTER TABLE A_PRODUCTO
ADD CONSTRAINT FK_A_PROVEEDOR_P
FOREIGN KEY (NIT_PROVEEDOR)
REFERENCES A_PROVEEDOR(NIT)
;

-- Creación referencia FK de A_PROMOCION a A_PROVEEDOR

ALTER TABLE A_PROMOCION
ADD CONSTRAINT FK_A_PROVEEDOR_PR
FOREIGN KEY (NIT_PROVEEDOR)
REFERENCES A_PROVEEDOR(NIT)
;

-- Creación restricciones de la tabla A_PEDIDO
ALTER TABLE A_PEDIDO
ADD CONSTRAINT CK_CALIFICACION_P
CHECK (CALIFICACION >= 0 AND CALIFICACION <=10)
;
ALTER TABLE A_PEDIDO
ADD CONSTRAINT PK_A_PEDIDO
PRIMARY KEY (NUMERO_PEDIDO)
;

-- Creación referencia FK de A_PEDIDO a A_PROVEEDOR
ALTER TABLE A_PEDIDO
ADD CONSTRAINT FK_A_PROVEEDOR_PE
FOREIGN KEY (NIT_PROVEEDOR)
REFERENCES A_PROVEEDOR(NIT)
;

-- Creación restricciones de la tabla A_SUCURSAL
ALTER TABLE A_SUCURSAL
ADD CONSTRAINT PK_A_SUCURSAL
PRIMARY KEY (NOMBRE,DIRECCION,CIUDAD)
;

-- Creación referencia FK de A_PEDIDO a A_SUCURSAL
ALTER TABLE A_PEDIDO
ADD CONSTRAINT FK_A_SUCURSAL
FOREIGN KEY (NOMBRE_SUCURSAL,DIRECCION_SUCURSAL,CIUDAD_SUCURSAL)
REFERENCES A_SUCURSAL(NOMBRE,DIRECCION,CIUDAD)
;

-- Creación restricciones de la tabla A_LOCAL_VENTAS
ALTER TABLE A_LOCAL_VENTAS
ADD CONSTRAINT PK_A_LOCAL_VENTAS
PRIMARY KEY (ID_LOCALVENTAS)
;

-- Creación referencia FK de A_SUCURSAL a A_LOCAL_VENTAS
ALTER TABLE A_SUCURSAL
ADD CONSTRAINT FK_A_LOCAL_VENTAS
FOREIGN KEY (ID_LOCALVENTAS)
REFERENCES A_LOCAL_VENTAS(ID_LOCALVENTAS)
;

-- Creación restricciones de la tabla A_ALMACENAMIENTO
ALTER TABLE A_ALMACENAMIENTO
ADD CONSTRAINT PK_A_ALMACENAMIENTO
PRIMARY KEY (ID_ALMACENAMIENTO)
;
ALTER TABLE A_ALMACENAMIENTO
ADD CONSTRAINT CK_CANTIDAD_PRODUCTOS_A
CHECK (CANTIDAD_PRODUCTOS >=0)
;
-- Creación restricciones de la tabla A_BODEGA
ALTER TABLE A_BODEGA
ADD CONSTRAINT PK_A_BODEGA
PRIMARY KEY (NOMBRE_BODEGA)
;
-- Creación referencia FK de A_BODEGA a A_ALMACENAMIENTO
ALTER TABLE A_BODEGA
ADD CONSTRAINT FK_A_ALMACENAMIENTO_B
FOREIGN KEY (ID_ALMACENAMIENTO)
REFERENCES A_ALMACENAMIENTO (ID_ALMACENAMIENTO)
;

-- Creación restricciones de la tabla A_BODEGA
ALTER TABLE A_ESTANTE
ADD CONSTRAINT PK_A_ESTANTE
PRIMARY KEY (NOMBRE_ESTANTE)
;

-- Creación referencia FK de A_BODEGA a A_ALMACENAMIENTO
ALTER TABLE A_ESTANTE
ADD CONSTRAINT FK_A_ALMACENAMIENTO_E
FOREIGN KEY (ID_ALMACENAMIENTO)
REFERENCES A_ALMACENAMIENTO (ID_ALMACENAMIENTO)
;

-- Creación restricciones de la tabla A_FACTURA
ALTER TABLE A_FACTURA
ADD CONSTRAINT PK_A_FACTURA
PRIMARY KEY(NUMERO_FACTURA)
;
ALTER TABLE A_FACTURA
ADD CONSTRAINT CK_VALOR_BASE
CHECK (VALOR_BASE>=0)
;
ALTER TABLE A_FACTURA
ADD CONSTRAINT CK_VALOR_TOTAL
CHECK (VALOR_TOTAL>=0)
;

-- Creación referencia FK de A_FACTURA a A_SUCURSAL
ALTER TABLE A_FACTURA
ADD CONSTRAINT FK_A_SUCURSAL_F
FOREIGN KEY (SUCURSAL_NOMBRE,SUCURSAL_DIRECCION,SUCURSAL_CIUDAD)
REFERENCES A_SUCURSAL(NOMBRE,DIRECCION,CIUDAD)
;


-- Creación restricciones de la tabla A_CLIENTE
ALTER TABLE A_CLIENTE
ADD CONSTRAINT PK_CLIENTE
PRIMARY KEY(CORREO)
;

ALTER TABLE A_CLIENTE
ADD CONSTRAINT CK_CORREO_CLIENTE
CHECK (CORREO LIKE '%___@___%.__%')
;

-- Creación referencia FK de A_FACTURA a A_CLIENTE

ALTER TABLE A_FACTURA
ADD CONSTRAINT FK_CLIENTE_F
FOREIGN KEY(CORREO_CLIENTE)
REFERENCES A_CLIENTE(CORREO)
;

-- Creación restricciones de la tabla A_EMPRESA
ALTER TABLE A_EMPRESA
ADD CONSTRAINT PK_A_EMPRESA
PRIMARY KEY (NIT)
;

ALTER TABLE A_EMPRESA
ADD CONSTRAINT CK_NIT_EMPRESA
CHECK (NIT>=100000000 AND NIT <=999999999)
;
-- Creación referencia FK de A_EMPRESA a A_CLIENTE
ALTER TABLE A_EMPRESA
ADD CONSTRAINT FK_CLIENTE_E
FOREIGN KEY (CORREO_CLIENTE)
REFERENCES A_CLIENTE (CORREO)
;


-- Creación restricciones de la tabla A_PERSONANATURAL
ALTER TABLE A_PERSONANATURAL
ADD CONSTRAINT PK_A_PERSONANATURAL
PRIMARY KEY (TIPO_DOCUMENTO,NUMERO_IDENTIFICACION)
;

ALTER TABLE A_PERSONANATURAL
ADD CONSTRAINT CK_TIPO_DOCUMENTO
CHECK (TIPO_DOCUMENTO IN ('CC','TI','TP','CE','RC'))
;
-- Creación referencia FK de A_PERSONANATURAL a A_CLIENTE

ALTER TABLE A_PERSONANATURAL
ADD CONSTRAINT FK_CLIENTE_N
FOREIGN KEY (CORREO_CLIENTE)
REFERENCES A_CLIENTE (CORREO)
;
