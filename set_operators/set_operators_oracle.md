
# Set Operators en Oracle XE 11g con Ejemplos Prácticos

Los **set operators** (operadores de conjuntos) en Oracle se utilizan para combinar los resultados de dos o más consultas en una única salida. A continuación, exploramos cada uno de los operadores de conjuntos en Oracle con ejemplos prácticos. Utilizaremos un modelo de datos para que puedas practicar estas operaciones.

## Set Operators en Oracle:

1. **UNION**
2. **UNION ALL**
3. **INTERSECT**
4. **MINUS**

## Modelo de Datos

Crearemos dos tablas, `clientes` y `clientes_antiguos`, para almacenar datos de clientes actuales y antiguos respectivamente. Luego, utilizaremos los operadores de conjuntos para trabajar con estas tablas.

```sql
-- Crear tabla 'clientes'
CREATE TABLE clientes (
  cliente_id NUMBER PRIMARY KEY,
  nombre VARCHAR2(100),
  ciudad VARCHAR2(100)
);

-- Crear tabla 'clientes_antiguos'
CREATE TABLE clientes_antiguos (
  cliente_id NUMBER PRIMARY KEY,
  nombre VARCHAR2(100),
  ciudad VARCHAR2(100)
);

-- Insertar datos en 'clientes'
INSERT INTO clientes (cliente_id, nombre, ciudad) VALUES (1, 'Juan', 'Madrid');
INSERT INTO clientes (cliente_id, nombre, ciudad) VALUES (2, 'Ana', 'Barcelona');
INSERT INTO clientes (cliente_id, nombre, ciudad) VALUES (3, 'Pedro', 'Sevilla');
INSERT INTO clientes (cliente_id, nombre, ciudad) VALUES (4, 'Luis', 'Madrid');

-- Insertar datos en 'clientes_antiguos'
INSERT INTO clientes_antiguos (cliente_id, nombre, ciudad) VALUES (5, 'Maria', 'Valencia');
INSERT INTO clientes_antiguos (cliente_id, nombre, ciudad) VALUES (6, 'Pedro', 'Sevilla');
INSERT INTO clientes_antiguos (cliente_id, nombre, ciudad) VALUES (7, 'Ana', 'Barcelona');
```

En este modelo:
- La tabla **clientes** contiene los clientes actuales.
- La tabla **clientes_antiguos** contiene los clientes que alguna vez lo fueron.

---

## 1. UNION

El operador **UNION** combina los resultados de dos o más consultas y elimina los duplicados.

#### Ejemplo:

Queremos obtener una lista de **todos** los clientes, tanto actuales como antiguos, sin duplicar los nombres.

```sql
SELECT nombre, ciudad
FROM clientes
UNION
SELECT nombre, ciudad
FROM clientes_antiguos;
```

**Resultado:**

| NOMBRE | CIUDAD    |
|--------|-----------|
| Juan   | Madrid    |
| Ana    | Barcelona |
| Pedro  | Sevilla   |
| Luis   | Madrid    |
| Maria  | Valencia  |

- **Explicación**: `Pedro` y `Ana` aparecen en ambas tablas, pero con `UNION` solo se muestran una vez.

---

## 2. UNION ALL

El operador **UNION ALL** combina los resultados de dos o más consultas sin eliminar duplicados.

#### Ejemplo:

Queremos obtener una lista de todos los clientes, incluidos aquellos que han sido tanto actuales como antiguos.

```sql
SELECT nombre, ciudad
FROM clientes
UNION ALL
SELECT nombre, ciudad
FROM clientes_antiguos;
```

**Resultado:**

| NOMBRE | CIUDAD    |
|--------|-----------|
| Juan   | Madrid    |
| Ana    | Barcelona |
| Pedro  | Sevilla   |
| Luis   | Madrid    |
| Maria  | Valencia  |
| Pedro  | Sevilla   |
| Ana    | Barcelona |

- **Explicación**: `Pedro` y `Ana` aparecen dos veces, ya que están en ambas tablas y **UNION ALL** no elimina duplicados.

---

## 3. INTERSECT

El operador **INTERSECT** devuelve solo las filas que están presentes en ambos conjuntos de resultados.

#### Ejemplo:

Queremos saber qué clientes **actuales** también aparecen en la lista de clientes antiguos.

```sql
SELECT nombre, ciudad
FROM clientes
INTERSECT
SELECT nombre, ciudad
FROM clientes_antiguos;
```

**Resultado:**

| NOMBRE | CIUDAD    |
|--------|-----------|
| Ana    | Barcelona |
| Pedro  | Sevilla   |

- **Explicación**: `Ana` y `Pedro` son los únicos clientes que aparecen en ambas tablas.

---

## 4. MINUS

El operador **MINUS** devuelve las filas que están en la primera consulta pero **no** en la segunda.

#### Ejemplo:

Queremos ver qué clientes actuales **no** están en la lista de clientes antiguos.

```sql
SELECT nombre, ciudad
FROM clientes
MINUS
SELECT nombre, ciudad
FROM clientes_antiguos;
```

**Resultado:**

| NOMBRE | CIUDAD    |
|--------|-----------|
| Juan   | Madrid    |
| Luis   | Madrid    |

- **Explicación**: `Juan` y `Luis` están en la tabla de clientes actuales pero no en la tabla de clientes antiguos.

---

## Reglas para usar los operadores de conjuntos:

1. El número de columnas en todas las consultas debe ser el mismo.
2. Los tipos de datos de las columnas correspondientes en ambas consultas deben ser compatibles.
3. El orden de las columnas debe ser el mismo en ambas consultas.
4. Solo puedes usar `ORDER BY` después de aplicar el operador de conjuntos.

```sql
SELECT nombre, ciudad
FROM clientes
UNION
SELECT nombre, ciudad
FROM clientes_antiguos
ORDER BY nombre;
```

---

## Conclusión

Los **set operators** son herramientas útiles para combinar conjuntos de datos de manera eficiente. En este documento, exploramos cómo utilizar **UNION**, **UNION ALL**, **INTERSECT**, y **MINUS** en Oracle, con un modelo de datos simple para poner en práctica los conceptos. Practicar estos operadores en escenarios reales te permitirá mejorar tus habilidades en la manipulación de datos en SQL.
