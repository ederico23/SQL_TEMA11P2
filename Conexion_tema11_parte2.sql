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

