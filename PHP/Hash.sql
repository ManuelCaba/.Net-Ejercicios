USE [azure-javier]
GO

--Funci�n que devuelve una cadena codificada a partor del correo y la contrase�a de un usuario
CREATE OR ALTER FUNCTION HashContrase�aUsuario (@Correo Varchar(60), @Password Varchar(15)) RETURNS Binary(16) AS
BEGIN
	DECLARE @PasswordCodificado Binary(16)

	SET @PasswordCodificado = HASHBYTES('MD5', @Correo+@Password)

	RETURN @PasswordCodificado
END
GO

--Funci�n que comprueba si existe un usuario con las credenciales pasadas por par�metros
CREATE OR ALTER FUNCTION LoginUsuario (@Correo Varchar(60), @Password Varchar(15)) RETURNS Bit AS
BEGIN
	DECLARE @PasswordCodificado Binary(16)
	DECLARE @Existe Bit = 0

	SET @PasswordCodificado = HASHBYTES('MD5', @Correo+@Password)

	IF EXISTS(SELECT * FROM Usuarios WHERE Correo = @Correo AND PasswordCodificada = @PasswordCodificado)
	BEGIN
		SET @Existe = 1
	END

	RETURN @Existe
END
GO

SELECT dbo.HashContrase�aUsuario('manuel.caballero@iesnervion.es', 'prueba')

SELECT HASHBYTES('MD5','emanenxd@gmail.com'+ 'prueba')

UPDATE Usuarios
SET PasswordCodificada = dbo.HashContrase�aUsuario(Correo, Password)

SELECT * FROM Usuarios
SELECT dbo.LoginUsuario ('rwightman0@linkedin.com', '86Km5Y')
SELECT dbo.LoginUsuario ('rwightman0@linkedin.com', '0x6D16CC755D84A1186CE54A62C39622AA')