
# Multiset Operators en Oracle 11g XE

En **Oracle 11g XE**, los **Multiset Operators** son operadores utilizados para realizar operaciones sobre conjuntos de datos en formato **colecciones** (como tablas anidadas o arrays). Estos operadores son útiles cuando trabajas con **colecciones** en **PL/SQL** y necesitas realizar comparaciones, uniones, intersecciones, o diferencias entre dos colecciones de datos.

## Tipos de Multiset Operators en Oracle

1. **MULTISET UNION**: Combina dos conjuntos de datos en una colección.
2. **MULTISET INTERSECT**: Devuelve los elementos que están presentes en ambas colecciones.
3. **MULTISET EXCEPT**: Devuelve los elementos de una colección que no están presentes en otra.
4. **IS A SET**: Verifica si la colección no tiene elementos duplicados.

---

## 1. MULTISET UNION

El operador **`MULTISET UNION`** combina dos colecciones en una sola. Puede eliminar o incluir duplicados dependiendo del tipo de unión que uses.

### Sintaxis:
```sql
collection1 MULTISET UNION [ALL | DISTINCT] collection2
```

- **`ALL`**: Incluye duplicados en la colección resultante.
- **`DISTINCT`**: Elimina duplicados en la colección resultante.

### Ejemplo:
```sql
DECLARE
    TYPE num_table IS TABLE OF NUMBER;
    collection1 num_table := num_table(1, 2, 3);
    collection2 num_table := num_table(3, 4, 5);
    result_collection num_table;
BEGIN
    -- Usando MULTISET UNION ALL (incluye duplicados)
    result_collection := collection1 MULTISET UNION ALL collection2;
    DBMS_OUTPUT.PUT_LINE('Result with ALL: ' || result_collection.COUNT);

    -- Usando MULTISET UNION DISTINCT (sin duplicados)
    result_collection := collection1 MULTISET UNION DISTINCT collection2;
    DBMS_OUTPUT.PUT_LINE('Result with DISTINCT: ' || result_collection.COUNT);
END;
/
```

---

## 2. MULTISET INTERSECT

El operador **`MULTISET INTERSECT`** devuelve los elementos que están presentes en ambas colecciones.

### Sintaxis:
```sql
collection1 MULTISET INTERSECT collection2
```

### Ejemplo:
```sql
DECLARE
    TYPE num_table IS TABLE OF NUMBER;
    collection1 num_table := num_table(1, 2, 3);
    collection2 num_table := num_table(2, 3, 4);
    result_collection num_table;
BEGIN
    -- Elementos que están en ambas colecciones
    result_collection := collection1 MULTISET INTERSECT collection2;
    DBMS_OUTPUT.PUT_LINE('Intersect result: ' || result_collection.COUNT);
END;
/
```

---

## 3. MULTISET EXCEPT

El operador **`MULTISET EXCEPT`** devuelve los elementos que están en la primera colección pero no en la segunda.

### Sintaxis:
```sql
collection1 MULTISET EXCEPT collection2
```

### Ejemplo:
```sql
DECLARE
    TYPE num_table IS TABLE OF NUMBER;
    collection1 num_table := num_table(1, 2, 3);
    collection2 num_table := num_table(2, 3, 4);
    result_collection num_table;
BEGIN
    -- Elementos que están en collection1 pero no en collection2
    result_collection := collection1 MULTISET EXCEPT collection2;
    DBMS_OUTPUT.PUT_LINE('Except result: ' || result_collection.COUNT);
END;
/
```

---

## 4. IS A SET

El operador **`IS A SET`** verifica si una colección es un **conjunto** (es decir, si no contiene elementos duplicados).

### Sintaxis:
```sql
collection IS A SET
```

### Ejemplo:
```sql
DECLARE
    TYPE num_table IS TABLE OF NUMBER;
    collection num_table := num_table(1, 2, 3, 3);
BEGIN
    IF collection IS A SET THEN
        DBMS_OUTPUT.PUT_LINE('Collection is a set (no duplicates).');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Collection is not a set (contains duplicates).');
    END IF;
END;
/
```

---

## Ejemplo Completo Usando Multiset Operators

Aquí te muestro un ejemplo más complejo que usa **`MULTISET UNION DISTINCT`**, **`MULTISET INTERSECT`**, y **`MULTISET EXCEPT`** en un solo bloque PL/SQL para ilustrar su uso en un caso realista:

```sql
DECLARE
    TYPE emp_table IS TABLE OF VARCHAR2(100);
    team_a emp_table := emp_table('Juan', 'Ana', 'Carlos');
    team_b emp_table := emp_table('Ana', 'Luis', 'Carlos');
    result_collection emp_table;
BEGIN
    -- UNION DISTINCT: combinar ambos equipos sin duplicados
    result_collection := team_a MULTISET UNION DISTINCT team_b;
    DBMS_OUTPUT.PUT_LINE('Union result (distinct): ' || result_collection.COUNT);

    -- INTERSECT: miembros que están en ambos equipos
    result_collection := team_a MULTISET INTERSECT team_b;
    DBMS_OUTPUT.PUT_LINE('Intersect result: ' || result_collection.COUNT);

    -- EXCEPT: miembros que están en team_a pero no en team_b
    result_collection := team_a MULTISET EXCEPT team_b;
    DBMS_OUTPUT.PUT_LINE('Except result (team_a - team_b): ' || result_collection.COUNT);
END;
/
```

---

## Resumen

- **MULTISET UNION [ALL | DISTINCT]**: Combina dos colecciones en una sola.
- **MULTISET INTERSECT**: Devuelve los elementos comunes en ambas colecciones.
- **MULTISET EXCEPT**: Devuelve los elementos que están en la primera colección pero no en la segunda.
- **IS A SET**: Verifica si una colección no tiene duplicados.

Estos operadores son útiles para manipular colecciones y realizar operaciones similares a las que harías en **SQL** con conjuntos de filas, pero aplicadas a colecciones dentro de **PL/SQL**.
