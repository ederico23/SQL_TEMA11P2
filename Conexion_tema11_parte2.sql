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



















/*35. Comprueba que desde oracle 4 puedes borrar la tabla countries.*/

    --ORACLE4
    DROP TABLE HR.COUNTRIES CASCADE CONSTRAINT;


/*36. Concede permisos al usuario oracle4 para que a su vez pueda crear usuarios así
como darles cualquier privilegio.*/

    --SYSTEM
    GRANT CREATE USER TO ORACLE4;
    GRANT GRANT ANY OBJECT PRIVILEGE, GRANT ANY PRIVILEGE TO ORACLE4;


/*37. Conéctate como usuario oracle4 y crea el usuario oracle4a con contraseña
oracle4a espacio de tablas usuario y sin límite de cuota. Asígnale permisos de
ejecución de consultas sobre la tabla jobs del usuario hr. Concede ahora
privilegio de modificación sobre la columna coutry_name de la tabla countries
a todos los usuarios*/

    --ORACLE4
    CREATE USER ORACLE4A
    IDENTIFIED BY ORACLE4A
    DEFAULT TABLESPACE USERS
    QUOTA UNLIMITED ON USERS;
    
    GRANT SELECT ON HR.JOBS TO ORACLE4A;
    GRANT CREATE SESSION TO ORACLE4A;
    GRANT UPDATE(COUNTY_NAME) ON HR.COUNTRIES TO PUBLICm
    
    
/*38. Comprueba desde el usuario hr qué permisos ha concedido sobre sus tablas a
los demás usuarios. Comprueba desde el usuario oracle4 qué permisos ha
recibido sobre las tablas de otros usuarios (usa la vista user_tab_privs).*/


    --HR
    SELECT *
    FROM USER_TAB_PRIVIS;
    
    --ORACLE4
    SELECT *
    FROM USER_TAB_PRIVIS;
    
    
/*39. Consulta los privilegios de sistema asignados a oracle4a ( usa la vista
dba_sys_privs).*/

    --SYSTEM
    SELECT * 
    FROM DBA_SYS_PRIVIS
    WHERE GARANTEE ='ORACLE4A';
    
    

/*40. Estando conectado como usuario “administrador” probar a crear un rol llamado
“administrador”, ¿qué ocurre?*/
    

    --ADMINISTRADOR
    CREATE ROLE ADMINISTRADOR;
    --ERROR CONFLICTO DE NOMBRE
    
    
/*41. Idem estando conectado como usuario SYSTEM, ¿qué sucede?, ¿por qué?*/
    
    --SYSTEM
    CREATE ROLE ADMINISTRADOR;
    --ERROR CONFLICTO NOMBRE
    

/*42. Comprobar en el diccionario de datos los usuarios o roles que poseen el
privilegio “CREATE ROLE”. (Utiliza la vista dba_sys_privs)*/


    --SYSTEM 
    SELECT * 
    FROM DBA_SYS_PRIVS
    WHERE PRIVILEGE = 'CREATE ROLE';
    
    
    
/*43. Crear un rol llamado “ADMIN”, asignarle los privilegios “create session”,
“create user” y “CREATE ROLE”. Asignarlo al usuario administrador.*/


    --SYSTEM
    CREATE ROLE ADMIN;
    GRANT CREATE SESSION, CREATE USER, CREATE ROLE TO ADMIN;
    GRANT ADMIN TO ADMINISTRADOR;
    
    
/*44. Consultar los privilegios de sistema que tiene asignados de forma directa el
usuario “administrador”, revocarlos y asignarle el rol “admin.”.*/

    --SYSTEM
    SELECT * 
    FROM DBA_SYS_PRIVS
    WHERE GARANTEE = 'ADMINISTRADOR';
    
    
    REVOKE UNLIMITED TABLESPACE, CREATE SESSION, CREATE USER, DROP USER FROM ADMINISTRADOR;
    REVOKE CREATE TABLE FROM ADMINISTRADOR;
    
    GRANT ADMIN TO ADMINISTRADOR;
    
    SELECT *
    FROM DBA_ROLE_PRIVS
    WHERE GARANTEE = 'ADMINISTRADOR';
    
    
/*45. Crea el usuario usuario1 y asígnale el role connect y resource. Comprueba
después en la vista correspondiente que efectivamente tiene esos roles.
Comprueba también desde el EM que el usuario tiene marcados esos roles.*/


    --ADMINISTRADOR
    CREATE USER USUARIO1
    IDENTIFIED BY USUARIO1
    DEFAULT TABLESPACE USERS
    QUOTA 500K ON USERS;
    
    GRANT CONNECT, RESOURCE TO USUARIO1;
    
    
    SELECT * 
    FROM DBA_ROLE_PRIVS
    WHERE GARANTEE = 'USUARIO1';
    
    --USUARIO1
    SELECT * 
    FROM USER_ROLE_PRIVS;
    
    
/*46. Crea el rol opera_jobs de modo que este rol adjudique permisos de selección,
inserción y borrado sobre la tabla jobs del usuario HR. Y además tenga
permisos para crear usuarios en la base de datos*/
    
    --ADMINISTRADOR
    CREATE ROLE OPERA_JOBS;
    GRANT SELECT, INSERT, DELETE ON HR.JOBS TO OPERA_JOBS;
    GRANT CREATE USER TO OPERA_JOBS;
    
    
/*47. Comprueba en las correspondientes vistas los permisos que tiene asociados el
rol opera_jobs.*/

    --ADMINISTRADOR
    SELECT * 
    FROM ROLE_SYS_PRIVS
    WHERE ROLE = 'OPERA_JOBS';
    
    SELECT *
    FROM ROLE_TAB_PRIVS
    WHERE ROLE = 'OPERA_JOBS';
    
    
/*48. Crea un usuario oracle5 con contraseña oracle5, espacio de tablas usuarios y
sin límite de cuota. Asígnale a oracle5 y oracle4 el rol opera jobs(en una sola
sentencia). Accede con el usuario oracle5 y comprueba que puedes insertar la
fila ('SA_TA', 'XXXXX', 200,9000) en la tabla jobs de hr.*/

    
    --SYSTEM
    CREATE USER ORACLE5
    IDENTIFIED BY ORACLE5
    DEFAULT TABLESPACE USERS
    QUOTA UNLIMITED ON USERS;
    
    GRANT OPERA_JOBS TO ORACLE4,ORACLE5;
    GRANT CREATE SESSION TO ORACLE5;
    
    
    --ORACLE5
    INSERT INTO HR.JOBS VALUES ('SA_TA', 'XXXXX', 200, 9000);
    COMMIT;
    
    SELECT * 
    FROM HR.JOBS
    WHERE JOB_ID LIKE 'S%';

    
/*49. Retira el privilegio create user del role opera_jobs.*/

    --SYSTEM 
    REVOKE CREATE USER FROM OPERA_JOBS;
    
    
/*50. Retira al usuario oracle5 el rol opera_jobs*/

    --SYSTEM
    REVOKE OPERA_JOBS FROM ORACLE5;
    
/*51. Borra el rol opera_jobs*/

    --SYSTEM
    DROP ROLE OPERA_JOBS;
    

/*52. Si cuando creamos un usuario no le asignamos ningún perfil, ¿qué perfil le
adjudica ORACLE?Entra en la vista dba_profiles y comprueba los valores de los
campos asociados al perfil DEFAULT.
a. ¿Cuántas sesiones concurrentes por usuario permite ?
b.¿Cuál es el límite de tiempo de inactividad?
c. ¿Cuál es el máximo tiempo que una sesión puede permanecer inactiva?
d.¿Cuántos intentos consecutivos fallidos permite antes de bloquear la cuenta?
FAILED_LOGIN_ATTEMPTS.*/

    --DEFAULT
    --SYSTEM
    SELECT *
    FROM DBA_PROFILES
    WHERE PROFILE = 'DEFAULT';
    
    
    --A SESSIONS_PER_USER UNLIMITED
    --B IDLE_TIME UNLIMITED
    --C CONNECT_TIME UNLIMITED
    --D FAILED_LOGIN_ATTEMPTS 10
    
    
/*53. Crea el perfil pruebas1 (desde el usuario administrador) de modo que solo
pueda haber 2 sesiones concurrentes por usuario, el tiempo de inactividad será
un máximo de 2’ y el nº de intentos fallidos antes de bloquear la cuenta 2.
Indica los pasos realizados.*/

    --ADMINISTRADOR
    CREATE PROFILE PRUEBAS1
    LIMIT SESSIONS_PER_USER 2
    IDLE_TIME 2
    FAILED_LOGIN_ATTEMPTS 2;
    
    --SYSTEM/ADMINISTRADOR
    SELECT * 
    FROM DBA_PROFILES
    WHERE PROFILE = 'PRUEBAS1';
    
        
    
/*54. Modifica el usuario oracle4 de modo que su perfil sea pruebas1 y comprueba
que se cumplen las condiciones del perfil.*/
    
    
    --ADMINISTRADOR
    ALTER USER ORACLE4 PROFILE PRUEBAS1;
    
    SELECT *
    FROM DBA_USERS
    WHERE USERNAME = 'ORACLE4';
    
    
/*55. Modifica el perfil pruebas1 cambiando el tiempo de inactividad a 3’ y el tiempo
de sesión a 400’.*/
    
    
    --ADMINISTRADOR
    ALTER PROFILE PRUEBAS1
    LIMIT IDLE_TIME 3
    CONNECT_TIME 400;
    
    
/*56. Comprueba a través de la vista de perfiles cuales son los nuevos valores
asignados.*/
    
    
    --ADMINISTRADOR/SYSTEM
    SELECT *
    FROM DBA_PROFILES
    WHERE PROFILE = 'PRUEBAS1';
        
    
/*57. Borra el perfil pruebas1.*/
    
    
    --SYSTEM
    DROP PROFILE PRUEBAS1 CASCADE;
    
    