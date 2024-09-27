
# Queries Jerárquicas en Oracle XE 11g

Las **queries jerárquicas** en Oracle permiten trabajar con datos que tienen una relación de jerarquía o dependencia, como una estructura de árbol. Un ejemplo típico es una organización donde los empleados tienen jefes, y esos jefes tienen superiores, formando una estructura jerárquica.

En Oracle, las **queries jerárquicas** se logran utilizando la cláusula **CONNECT BY** en combinación con **START WITH**. Esto permite recuperar datos que tienen una relación jerárquica, y navegar a través de ellos, tanto desde los nodos superiores (padres) hacia los inferiores (hijos) como al revés.

## Componentes clave de una query jerárquica:

1. **START WITH**: Define el nodo raíz o punto de inicio de la jerarquía.
2. **CONNECT BY**: Especifica la relación jerárquica entre los nodos (padres e hijos).
3. **PRIOR**: Determina si la jerarquía debe navegar de padre a hijo o de hijo a padre.
4. **LEVEL**: Es una pseudo-columna que indica la profundidad de un nodo en la jerarquía. El nivel 1 es el nodo raíz.
5. **SYS_CONNECT_BY_PATH**: Devuelve una cadena que muestra la ruta completa desde el nodo raíz hasta el nodo actual.
6. **ORDER SIBLINGS BY**: Ordena los resultados de la query dentro de cada nivel jerárquico.

## Ejemplo de estructura jerárquica:

Imaginemos una tabla `empleados` que contiene empleados con una relación de jefe-subordinado. Cada empleado tiene un identificador único y un campo que indica su jefe.

```sql
CREATE TABLE empleados (
  emp_id NUMBER PRIMARY KEY,
  nombre VARCHAR2(100),
  jefe_id NUMBER
);

-- Insertar datos
INSERT INTO empleados (emp_id, nombre, jefe_id) VALUES (1, 'CEO', NULL);
INSERT INTO empleados (emp_id, nombre, jefe_id) VALUES (2, 'Gerente 1', 1);
INSERT INTO empleados (emp_id, nombre, jefe_id) VALUES (3, 'Gerente 2', 1);
INSERT INTO empleados (emp_id, nombre, jefe_id) VALUES (4, 'Empleado 1', 2);
INSERT INTO empleados (emp_id, nombre, jefe_id) VALUES (5, 'Empleado 2', 2);
INSERT INTO empleados (emp_id, nombre, jefe_id) VALUES (6, 'Empleado 3', 3);
```

Esta tabla describe una jerarquía donde el **CEO** es el jefe de los **gerentes**, y estos a su vez son jefes de **empleados**.

## Ejemplo de query jerárquica:

Supongamos que queremos recuperar la jerarquía completa de empleados, empezando por el CEO, y seguir bajando a través de sus subordinados. Para esto usamos **START WITH** y **CONNECT BY PRIOR**.

```sql
SELECT emp_id, nombre, LEVEL
FROM empleados
START WITH jefe_id IS NULL  -- Comienza con los empleados que no tienen jefe (CEO)
CONNECT BY PRIOR emp_id = jefe_id  -- Establece la relación jerárquica (de jefe a subordinado)
ORDER SIBLINGS BY nombre;  -- Ordena los hermanos por nombre
```

**Resultado:**

| EMP_ID | NOMBRE      | LEVEL |
|--------|-------------|-------|
| 1      | CEO         | 1     |
| 2      | Gerente 1   | 2     |
| 4      | Empleado 1  | 3     |
| 5      | Empleado 2  | 3     |
| 3      | Gerente 2   | 2     |
| 6      | Empleado 3  | 3     |

- **LEVEL**: Indica el nivel jerárquico en el que se encuentra cada empleado. El CEO está en el nivel 1, los gerentes en el nivel 2, y los empleados en el nivel 3.
- **CONNECT BY PRIOR emp_id = jefe_id**: Establece la relación jerárquica, donde el campo `jefe_id` indica el jefe del empleado.

## Explicación de la query:

- **START WITH jefe_id IS NULL**: Comienza la jerarquía desde el nodo raíz, que es el CEO (que no tiene jefe, por lo tanto `jefe_id` es NULL).
- **CONNECT BY PRIOR emp_id = jefe_id**: Establece la relación entre el `emp_id` del subordinado y el `jefe_id` de su jefe.
- **LEVEL**: Devuelve el nivel jerárquico de cada fila en la jerarquía, donde el valor 1 corresponde al nodo raíz.
- **ORDER SIBLINGS BY nombre**: Ordena a los empleados que están en el mismo nivel jerárquico (hermanos) por su nombre.

## Funciones avanzadas en queries jerárquicas:

### 1. **SYS_CONNECT_BY_PATH**

Devuelve la ruta jerárquica completa desde el nodo raíz hasta el nodo actual.

```sql
SELECT emp_id, nombre, SYS_CONNECT_BY_PATH(nombre, ' -> ') AS ruta
FROM empleados
START WITH jefe_id IS NULL
CONNECT BY PRIOR emp_id = jefe_id;
```

**Resultado:**

| EMP_ID | NOMBRE      | RUTA                         |
|--------|-------------|------------------------------|
| 1      | CEO         |  -> CEO                      |
| 2      | Gerente 1   |  -> CEO -> Gerente 1         |
| 4      | Empleado 1  |  -> CEO -> Gerente 1 -> Empleado 1 |
| 5      | Empleado 2  |  -> CEO -> Gerente 1 -> Empleado 2 |
| 3      | Gerente 2   |  -> CEO -> Gerente 2         |
| 6      | Empleado 3  |  -> CEO -> Gerente 2 -> Empleado 3 |

### 2. **NOCYCLE**

A veces, en estructuras más complejas, puedes encontrar ciclos en la jerarquía (por ejemplo, si un empleado es jefe de su propio jefe). La opción **NOCYCLE** se utiliza para evitar que la query entre en un bucle infinito en estos casos.

```sql
SELECT emp_id, nombre, LEVEL
FROM empleados
START WITH jefe_id IS NULL
CONNECT BY NOCYCLE PRIOR emp_id = jefe_id;
```

Aquí, **NOCYCLE** evita ciclos jerárquicos al detener la navegación una vez que se detecta un ciclo.

## Resumen

- **Queries jerárquicas** son útiles para representar y navegar por estructuras en forma de árbol, como organigramas o relaciones jefe-subordinado.
- **CONNECT BY** y **START WITH** son las claves para definir la relación entre nodos en una jerarquía.
- Funciones como **LEVEL** y **SYS_CONNECT_BY_PATH** ayudan a explorar la profundidad de la jerarquía y ver la ruta completa.
- **ORDER SIBLINGS BY** te permite controlar el orden dentro de un mismo nivel jerárquico.

Las queries jerárquicas son poderosas para consultas complejas donde los datos están organizados de forma jerárquica o recursiva, como categorías de productos, dependencias de proyectos, y más.
