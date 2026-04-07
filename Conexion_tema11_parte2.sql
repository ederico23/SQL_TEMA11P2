/*9. Conectarse como usuario SYSTEM a la base de datos de Oracle y crear un
usuario llamado “administrador” autentificado por la base de datos con
contraseña admin. Indicar como "tablespace" por defecto USERS y como
"tablespace" temporal TEMP; asignar una cuota de 500K en el "tablespace"
USERS.
*/

--EN CONEXIONSYSTEM
CREATE USER administrador IDENTIFIED BY admin
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 500K ON USERS;


SELECT * 
FROM ALL_USERS
ORDER BY USERNAME;


/*10.Consulta después la vista all_users e indica la información que aparece sobre él.
 Abrir una nueva conexión en sql developer e intentar conectarse como usuario
“administrador”, ¿qué sucede?, ¿por qué?*/


/*11. Averiguar qué privilegios de sistema, roles y privilegios sobre objetos tiene
concedidos el usuario “administrador” consultando las vistas dba_role_privs,
dba_tab_privs, dba_sys_privs (busca en Internet qué contienen cada una de
estas vistas).*/

    

/*12. Otorgar el privilegio “CREATE SESSION” al usuario “administrador” e intentar de
nuevo la conexión sqlplus o sqldeveloper*/


/*13. Modifica la contraseña del usuario administrador por admi y vuelve a acceder a
Oracle con el usuario administrador. Comprueba que se ha modificado la
contraseña.*/

-- ERROR
    --DESDE SYSTEM
    ALTER USER adminstrador IDENTIFIED BY admi;
    
    
/*14. Modifica el usuario administrador de forma que su cuenta esté bloqueada.
Accede de nuevo con este usuario y comprueba que efectivamente no puede
acceder a su cuenta.*/

    --DESDE SYSTEM
    ALTER USER administrador
    ACCOUNT LOCK;
    

/*15. Conectarse como usuario “administrador” y crear un usuario llamado
“prueba00” que tenga como "tablespace" por defecto USERS y como
"tablespace" temporal TEMP; asignar una cuota de 500K en el "tablespace"
USERS. ¿Es posible hacerlo?*/

    --SYSTEM
    ALTER USER administrador
    ACCOUNT UNLOCK;
    
    --ADMINISTRADOR
    CREATE USER prueba00 IDENTIFIED BY prueba00
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA 500K ON USER;


/*16. Conectado como usuario SYSTEM, otorgar el privilegio “create user” al usuario
“administrador” y repetir el ejercicio anterior.*/

    
    
    
    
/*17. Crea un nuevo usuario prueba1 con clave prueba1 y tablespace users.
Concédele el privilegio de connectarse a la BD. Trata de crear una tabla ¿Has
podido? ¿Por qué? Concédele el privilegio CREATE TABLE y trata de crear de
nuevo la tabla ¿Has podido?*/

    --ADMINISTRADOR
    CREATE USER prueba1 IDENTIFIED BY PRUEBA1
    DEFAULT TABLESPACE USERS;
    
GRANT CREATE SESSION TO prueba1;
--NO DEJA PQ NO TIENE PRIVILEGIOS
    
    --SYSTEM
    GRANT CREATE SESSION TO administrador WITH ADMIN OPTION;

    --PRUEBA1
    --(IDENTIFICADOR NUMBER,
    --NOMBRE VARCHAR2(50));

--ERROR. FALTAN PRIVILEGIOS

    --SYSTEM 
    --GRANT CREATE TABLE TO prueba1;


/*18. Asígnale una cuota de 500 K al usuario prueba1.*/

    ALTER USER prueba1
    QUOTA 500K ON USERS;
    

/*19. Como usuario prueba1, modifica su propia contraseña a pru1. ¿Puede
modificar el propio usuario prueba1 su espacio de tablas por defecto? ¿Qué
privilegio necesita? Asígnale dicho privilegio desde el usuario System y
comprueba que ahora el usuario prueba1 puede modificarse a sí mismo su
espacio de tabla o su cuota, por ejemplo.*/

    --PRUEBA1
    ALTER USER prueba1 IDENTIFIED BY pru1;

    ALTER USER prueba1
    QUOTA 500K ON USERS;

--ERROR FALTA PRIVILEGIOS

    --SYSTEM
    GRANT ALTER USER TO prueba1;
    
    --PRUEBA1
    ALTER USER prueba1
    QUOTA 500K ON USERS;
    
    
    
    
/*20. Como usuario administrador crea un nuevo usuario llamado ora1 con
contraseña ora1 cuota 500k y espacios users y temp. Este nuevo usuario
deberá poder conectarse a la BD y crear tablas. Crea una tabla para el usuario
ora1¿Puedes insertar datos o manipular la tabla ? ¿Puedes crear
procedimientos, triggers,… ? Indica qué privilegios necesitarías.*/ 

    --ADMINISTRADOR 
    CREATE USER ora1 IDENTIFIED BY ora1
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA 500K ON USERS;
    
    GRANT CREATE SESSION, CREATE TABLE TO ora1;
    
    --SYSTEM
    GRANT CREATE TABLE TO administrador WITH ADMIN OPTION;

    --ADMINISTRADOR
    GRANT CREATE TABLE TO ora1;
    
    --ORA1
    CREATE TABLE EJEMPLO
    (IDENTIFICADOR NUMBER,
    NOMBRE VARCHAR2(50));
    
    INSERT INTO EJEMPLO VALUES(2,'ANA');
    
    SELECT * 
    FROM EJEMPLO;
    
    UPDATE EJEMPLO
    SET IDENTIFICADOR = 1;
    
    DELETE EJEMPLO;
    
    
    
/*21. Como usuario administrador borra el usuario ora1. Indica los pasos que has
tenido que realizar para poder hacerlo.*/

    --SYSTEM
    GRANT DROP USER TO ADMINISTRADOR;

    --ADMINISTRADOR
    DROP USER ora1 CASCADE;
    
    
/*22. Averiguar qué usuarios de la base de datos tienen asignado el privilegio “create
user” de forma directa, ¿qué vista debe ser consultada? ¿Qué significa la
opción ADMIN OPTION?*/

    --SYSTEM
    SELECT * 
    FROM DBA_SYS_PRIVS
    WHERE PRIVILEGE =  'CREATE USER';
    
    
    
/*23. Hacer lo mismo para el privilegio “create session”.*/

    --SYSTEM
    SELECT * 
    FROM DBA_SYS_PRIVS
    WHERE PRIVILEGE =  'CREATE SESSION';
    

/*24. En caso de que esté bloqueado, desbloquea el usuario hr de la base de datos y
ponle como contraseña hr.
Consulta las tablas de las que dispone este usuario.*/

    --SYSTEM
    ALTER USER HR
    ACCOUNT UNLOCK;
    
    SELECT TABLE_NAMES
    FROM USER_TABLES;
    
    
/*25. Concede permisos al usuario oracle4 para ejecutar consultas sobre la tabla
employees del usuario hr (Crea previamente el usuario oracle4 con clave a 500k
y tablespace users y temp, concédele privilegios para conectarse y crear tablas,
crea una tabla en el usuario oracle4) Nota: previamente concede
definitivamente al administrador el rol dba.*/
    
    --SYSTEM
    GRANT DBA TO ADMINISTRADOR;
    
    --ADMINISTRADOR
    CREATE USER oracle4 IDENTIFIED BY oracle4
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP 
    QUOTA 500K ON USERS;
    
    GRANT CREATE SESSION, CREATE TABLE TO oracle4;
    
    --HR
    GRANT SELECT ON EMPLOYEES TO oracle4;
    
    --ORACLE4
    CREATE TABLE EJEMPLO
    (IDENTIFICADOR NUMBER,
    NOMBRE VARCHAR2(50));
    
    
    
/*26. Consulta los datos de la tabla employees (habiéndote conectado como usuario
oracle4). Crear la tabla empleados a partir de la consulta anterior.*/


    --ORACLE4
    SELECT * 
    FROM HR.EMPLOYEES;

    --SYSTEM
    GRANT CREATE SYNONYM TO oracle4;
    
    --ORACLE4    
    CREATE SYNONYM EMPLOYEES FOR HR.EMPLOYEES;

SELECT * 
FROM EMPLOYEES;

    
    CREATE TABLE EMPLEADOS AS 
    SELECT *
    FROM EMPLOYEES;
    

/*27. Consulta los datos de la tabla countries de hr ¿Has podido? ¿Por qué?*/

    --ORACLE4
    SELECT *
    FROM HR.COUNTRIES;
    
    --NO SE PUEDE PQ NO TIENE PERMISOS
    
/*28. Concede permisos a oracle4 para insertar registros en la tabla countries de hr*/

    --HR
    GRANT INSERT ON COUNTRIES TO oracle4;   
    

/*29. Inserta el país España con código ES de Europa en la tabla countries como
usuario oracle4*/

    --ORACLE4
    INSERT INTO HR.COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
    VALUES('ES', 'España', 1);
    
    SELECT * 
    FROM HR.COUNTRIES;
        
    
/*30. Trata de borrar como usuario oracle4 la fila que has insertado*/

