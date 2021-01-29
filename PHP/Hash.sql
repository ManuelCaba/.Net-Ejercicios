USE [azure-javier]
GO

--Función que devuelve una cadena codificada a partor del correo y la contraseña de un usuario
CREATE OR ALTER FUNCTION HashContraseñaUsuario (@Correo Varchar(60), @Password Varchar(15)) RETURNS Binary(20) AS
BEGIN
	DECLARE @PasswordCodificado Binary(20)

	SET @PasswordCodificado = HASHBYTES('SHA1', @Correo+@Password)

	RETURN @PasswordCodificado
END
GO

--Función que comprueba si existe un usuario con las credenciales pasadas por parámetros
CREATE OR ALTER FUNCTION LoginUsuario (@Correo Varchar(60), @Password Varchar(15)) RETURNS Bit AS
BEGIN
	DECLARE @PasswordCodificado Binary(20)
	DECLARE @Existe Bit = 0

	SET @PasswordCodificado = HASHBYTES('SHA1', @Correo+@Password)

	IF EXISTS(SELECT * FROM Usuarios WHERE Correo = @Correo AND PasswordCodificada = @PasswordCodificado)
	BEGIN
		SET @Existe = 1
	END

	RETURN @Existe
END
GO

SELECT dbo.HashContraseñaUsuario('manuel.caballero@iesnervion.es', 'prueba')

SELECT HASHBYTES('MD5','emanenxd@gmail.com'+ 'prueba')

UPDATE Usuarios
SET PasswordCodificada = dbo.HashContraseñaUsuario(Correo, Password)

SELECT * FROM Usuarios
SELECT dbo.LoginUsuario ('rwightman0@linkedin.com', '86Km5Y')
SELECT dbo.LoginUsuario ('rwightman0@linkedin.com', '0x42C130BA29BBC6424A8FEADFEA18338911993ADC')