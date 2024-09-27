
# Operadores en Oracle XE 11g

En **Oracle XE 11g**, los **operadores** son símbolos que se utilizan para realizar diversas operaciones sobre uno o más operandos, que pueden ser columnas, constantes, literales o valores de variables. Oracle ofrece una amplia gama de operadores que permiten realizar operaciones aritméticas, lógicas, de comparación, concatenación y más.

## Clasificación de los operadores en Oracle

1. **Operadores aritméticos**
2. **Operadores de comparación**
3. **Operadores lógicos**
4. **Operadores de concatenación**
5. **Operadores de negación**

### 1. Operadores aritméticos

Los operadores aritméticos se utilizan para realizar operaciones matemáticas básicas como suma, resta, multiplicación y división.

| Operador | Descripción                 | Ejemplo                          |
|----------|-----------------------------|-----------------------------------|
| `+`      | Suma                        | `SELECT 5 + 3 FROM DUAL;`         |
| `-`      | Resta                       | `SELECT 5 - 3 FROM DUAL;`         |
| `*`      | Multiplicación              | `SELECT 5 * 3 FROM DUAL;`         |
| `/`      | División                    | `SELECT 6 / 3 FROM DUAL;`         |
| `-`      | Cambio de signo (negativo)  | `SELECT -5 FROM DUAL;`            |

#### Ejemplo de uso:

```sql
SELECT emp_id, salario + comision AS salario_total
FROM empleados
WHERE dept_id = 10;
```

---

### 2. Operadores de comparación

Estos operadores se utilizan para comparar dos valores o expresiones. Los resultados de estas comparaciones son booleanos (`TRUE`, `FALSE` o `NULL`).

| Operador | Descripción                 | Ejemplo                          |
|----------|-----------------------------|-----------------------------------|
| `=`      | Igual a                     | `SELECT * FROM empleados WHERE salario = 3000;` |
| `!=`     | No igual a                  | `SELECT * FROM empleados WHERE salario != 3000;` |
| `<>`     | Diferente de                | `SELECT * FROM empleados WHERE salario <> 3000;` |
| `>`      | Mayor que                   | `SELECT * FROM empleados WHERE salario > 3000;` |
| `<`      | Menor que                   | `SELECT * FROM empleados WHERE salario < 3000;` |
| `>=`     | Mayor o igual que           | `SELECT * FROM empleados WHERE salario >= 3000;` |
| `<=`     | Menor o igual que           | `SELECT * FROM empleados WHERE salario <= 3000;` |

#### Ejemplo de uso:

```sql
SELECT emp_id, nombre, salario
FROM empleados
WHERE salario > 3000;
```

---

### 3. Operadores lógicos

Los operadores lógicos se utilizan para combinar varias condiciones de manera lógica en una sola consulta.

| Operador | Descripción                 | Ejemplo                          |
|----------|-----------------------------|-----------------------------------|
| `AND`    | Verdadero si todas las condiciones son verdaderas | `SELECT * FROM empleados WHERE salario > 3000 AND dept_id = 10;` |
| `OR`     | Verdadero si al menos una condición es verdadera | `SELECT * FROM empleados WHERE salario > 3000 OR dept_id = 20;` |
| `NOT`    | Invierte el valor lógico    | `SELECT * FROM empleados WHERE NOT (salario > 3000);` |

#### Ejemplo de uso:

```sql
SELECT emp_id, nombre, salario
FROM empleados
WHERE salario > 3000 AND dept_id = 10;
```

---

### 4. Operador de concatenación

El operador de concatenación se utiliza para unir cadenas de texto.

| Operador | Descripción | Ejemplo                          |
|----------|-------------|-----------------------------------|
| `||`     | Concatena dos o más cadenas | `SELECT 'Nombre: ' || nombre FROM empleados;` |

#### Ejemplo de uso:

```sql
SELECT nombre || ' trabaja en el departamento ' || dept_id AS informacion
FROM empleados;
```

---

### 5. Operador de negación

El operador de negación (`IS NULL` y `IS NOT NULL`) se utiliza para verificar si un valor es nulo o no.

| Operador     | Descripción              | Ejemplo                          |
|--------------|--------------------------|-----------------------------------|
| `IS NULL`    | Verifica si es nulo       | `SELECT * FROM empleados WHERE comision IS NULL;` |
| `IS NOT NULL`| Verifica si no es nulo    | `SELECT * FROM empleados WHERE comision IS NOT NULL;` |

#### Ejemplo de uso:

```sql
SELECT emp_id, nombre, comision
FROM empleados
WHERE comision IS NOT NULL;
```

---

### Operadores adicionales

#### 1. **IN**
El operador `IN` se utiliza para verificar si un valor coincide con alguno de los valores de una lista.

```sql
SELECT * FROM empleados WHERE dept_id IN (10, 20, 30);
```

#### 2. **BETWEEN**
El operador `BETWEEN` se usa para verificar si un valor está dentro de un rango.

```sql
SELECT * FROM empleados WHERE salario BETWEEN 3000 AND 5000;
```

#### 3. **LIKE**
El operador `LIKE` se utiliza para realizar búsquedas con patrones.

```sql
SELECT * FROM empleados WHERE nombre LIKE 'J%';
```

#### 4. **EXISTS**
El operador `EXISTS` se utiliza para verificar la existencia de filas que cumplan con una condición.

```sql
SELECT dept_id FROM departamentos WHERE EXISTS (SELECT * FROM empleados WHERE dept_id = departamentos.dept_id);
```

---

### Conclusión

Los operadores en Oracle XE 11g son fundamentales para la manipulación de datos en SQL. Comprender cómo funcionan estos operadores es esencial para escribir consultas eficientes y optimizar el rendimiento de las bases de datos.
