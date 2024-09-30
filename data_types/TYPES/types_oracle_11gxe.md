
# Types en Oracle 11g XE

En **Oracle 11g XE**, los **`TYPES`** (tipos de datos definidos por el usuario) son estructuras de datos que te permiten crear tus propios tipos de datos personalizados, además de los tipos de datos predefinidos como **`NUMBER`**, **`VARCHAR2`**, **`DATE`**, etc. Estos **TYPES** son utilizados principalmente en **PL/SQL** para representar colecciones complejas y objetos, y son muy útiles cuando necesitas almacenar o procesar datos que no se ajustan perfectamente a los tipos de datos estándar de Oracle.

## Tipos de Types en Oracle

1. **Tipos escalares** (Scalars): Básicamente, estos son los tipos de datos predefinidos en Oracle, como **`NUMBER`**, **`VARCHAR2`**, **`DATE`**, pero pueden ser incluidos como parte de otros tipos definidos por el usuario.
2. **Tipos compuestos (Collections)**: Tipos como **tablas anidadas** y **varrays** (arrays de tamaño variable).
3. **Tipos de objeto (Object Types)**: Tipos complejos que representan entidades o "objetos" con atributos y métodos, similares a los objetos en lenguajes de programación orientados a objetos.

---

## 1. Tipos Compuestos (Collections)

Los **`TYPES`** compuestos te permiten crear colecciones de datos, como **arrays** o **tablas**. Los principales tipos de colecciones son:

- **Tablas anidadas (Nested Tables)**: Son colecciones que pueden contener un número indefinido de elementos, y estos elementos pueden estar dispersos en términos de su almacenamiento.
- **Varrays (Variable-size arrays)**: Son arrays con un tamaño máximo definido. A diferencia de las tablas anidadas, los varrays conservan el orden de los elementos y su límite está predefinido.

### Ejemplo de una tabla anidada:

```sql
-- Declaración de un tipo compuesto
CREATE OR REPLACE TYPE numeros_t AS TABLE OF NUMBER;
/

-- Uso del tipo en un bloque PL/SQL
DECLARE
    numeros numeros_t := numeros_t(1, 2, 3, 4, 5);
BEGIN
    FOR i IN 1..numeros.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(numeros(i));
    END LOOP;
END;
/
```

---

### Ejemplo de un Varray:

```sql
-- Crear un tipo VARRAY con tamaño máximo de 5
CREATE OR REPLACE TYPE nombres_t AS VARRAY(5) OF VARCHAR2(100);
/

-- Uso del tipo VARRAY en un bloque PL/SQL
DECLARE
    nombres nombres_t := nombres_t('Juan', 'Ana', 'Carlos');
BEGIN
    FOR i IN 1..nombres.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(nombres(i));
    END LOOP;
END;
/
```

---

## 2. Tipos de Objeto (Object Types)

Los **Tipos de Objeto** son una de las características más poderosas de Oracle. Te permiten definir un tipo que puede tener **atributos** (propiedades) y **métodos** (procedimientos y funciones), similar a la programación orientada a objetos.

### Ejemplo de Tipo de Objeto:

```sql
-- Crear un tipo de objeto 'Empleado'
CREATE OR REPLACE TYPE empleado_t AS OBJECT (
    emp_id    NUMBER,
    nombre    VARCHAR2(100),
    salario   NUMBER,
    PROCEDURE mostrar_info
);
/

-- Implementar el método 'mostrar_info'
CREATE OR REPLACE TYPE BODY empleado_t IS
    PROCEDURE mostrar_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ID: ' || emp_id || ', Nombre: ' || nombre || ', Salario: ' || salario);
    END;
END;
/

-- Usar el tipo de objeto
DECLARE
    emp empleado_t;
BEGIN
    emp := empleado_t(1, 'Juan Pérez', 5000);
    emp.mostrar_info;  -- Llamar al método del objeto
END;
/
```

---

## 3. Tipos en PL/SQL (Declaración dentro de PL/SQL)

También puedes definir **TYPES** directamente dentro de un bloque PL/SQL, lo que los convierte en tipos locales que solo se pueden usar dentro de ese bloque específico.

### Ejemplo de declaración de un tipo dentro de un bloque PL/SQL:

```sql
DECLARE
    TYPE numeros_t IS TABLE OF NUMBER;
    numeros numeros_t := numeros_t(10, 20, 30);
BEGIN
    FOR i IN 1..numeros.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(numeros(i));
    END LOOP;
END;
/
```

---

## 4. Tipos Escalares

Los tipos escalares son los tipos de datos básicos o atómicos que se utilizan en Oracle, como:

- **`NUMBER`**: Para almacenar números enteros y decimales.
- **`VARCHAR2`**: Para cadenas de texto.
- **`DATE`**: Para fechas y horas.
- **`BOOLEAN`**: Para valores booleanos (solo en PL/SQL).

Aunque los tipos escalares son tipos básicos, pueden ser utilizados dentro de otros **TYPES** para crear estructuras más complejas.

---

## 5. Tipos en Tablas

Además de ser utilizados en PL/SQL, los **TYPES** también pueden ser utilizados en el diseño de **tablas** en la base de datos. Esto es útil cuando quieres almacenar colecciones dentro de una tabla o crear una estructura similar a la de una tabla en la base de datos.

### Ejemplo de uso de tipos en una tabla:

```sql
-- Definir un tipo de objeto
CREATE OR REPLACE TYPE direccion_t AS OBJECT (
    calle VARCHAR2(100),
    ciudad VARCHAR2(100),
    codigo_postal VARCHAR2(10)
);
/

-- Crear una tabla usando el tipo de objeto
CREATE TABLE empleados (
    emp_id NUMBER,
    nombre VARCHAR2(100),
    direccion direccion_t  -- Usar el tipo de objeto como columna
);
```

---

## Resumen de los **TYPES** en Oracle 11g XE

1. **Tipos compuestos (Colecciones)**: Permiten almacenar conjuntos de datos, como tablas anidadas o varrays.
   - **Tablas anidadas**: Colecciones sin tamaño límite.
   - **Varrays**: Arrays con un tamaño máximo definido.
   
2. **Tipos de objeto (Object Types)**: Permiten crear estructuras de datos más complejas con atributos y métodos.
   
3. **Declaración de TYPES en PL/SQL**: Puedes declarar **TYPES** dentro de bloques PL/SQL para uso local.
   
4. **Uso de TYPES en Tablas**: Los **TYPES** también pueden ser utilizados para definir columnas en tablas.

Los **`TYPES`** en Oracle permiten una mayor flexibilidad y capacidad de manipulación de datos, dándote la posibilidad de estructurar mejor tus datos y de manejar colecciones y objetos dentro de PL/SQL de una manera más eficiente.
