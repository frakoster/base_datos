CREATE TABLE departamentos (
  dept_id NUMBER PRIMARY KEY,
  nombre_departamento VARCHAR2(100)
);

CREATE TABLE empleados (
  emp_id NUMBER PRIMARY KEY,
  nombre VARCHAR2(100),
  dept_id NUMBER,
  FOREIGN KEY (dept_id) REFERENCES departamentos(dept_id)
);

-- Insertar datos en la tabla 'departamentos'
INSERT INTO departamentos (dept_id, nombre_departamento)
VALUES (10, 'Ventas');
INSERT INTO departamentos (dept_id, nombre_departamento)
VALUES (20, 'Marketing');
INSERT INTO departamentos (dept_id, nombre_departamento)
VALUES (30, 'Recursos Humanos');

-- Insertar datos en la tabla 'empleados'
INSERT INTO empleados (emp_id, nombre, dept_id)
VALUES (1, 'Juan', 10);
INSERT INTO empleados (emp_id, nombre, dept_id)
VALUES (2, 'Ana', 20);
INSERT INTO empleados (emp_id, nombre, dept_id)
VALUES (3, 'Pedro', 10);
INSERT INTO empleados (emp_id, nombre, dept_id)
VALUES (4, 'Luis', 30);
INSERT INTO empleados (emp_id, nombre, dept_id)
VALUES (5, 'Maria', 30);

-- Crear índice en la columna 'dept_id' de la tabla 'empleados'
CREATE INDEX idx_emp_dept ON empleados(dept_id);
