USE LeoMasters
GO
--6.- Comprueba que un tenista sólo juegue como máximo en una modalidad doble y otra simple
--en cada edición del torneo cuando se inserte un nuevo contrincante (requisito 4).
DECLARE @Contrincantes Table
(
	Tenista Char(3) NOT NULL,
	Modalidad Char(2) NOT NULL,
	Edicion SmallInt NOT NULL,
	Ronda TinyInt NOT NULL
)

INSERT @Contrincantes	
SELECT Tenista1, Modalidad, Edicion, Ronda FROM 
(
	SELECT C.*, P.Ronda FROM LM_Partidos AS P
	INNER JOIN LM_Contrincantes AS C 
	ON (P.Contrincante1 = C.ID OR P.Contrincante2 = C.ID) AND P.Edicion = C.Edicion AND P.Modalidad = C.Modalidad
) AS C

INSERT @Contrincantes
SELECT Tenista2, Modalidad, Edicion, Ronda FROM (
	SELECT C.*, P.Ronda FROM LM_Partidos AS P --TODO
	INNER JOIN LM_Contrincantes AS C 
	ON (P.Contrincante1 = C.ID OR P.Contrincante2 = C.ID) AND P.Edicion = C.Edicion AND P.Modalidad = C.Modalidad
) AS C
WHERE Tenista2 IS NOT NULL

SELECT C.Tenista, C.Edicion, C.Ronda, M.Simple FROM @Contrincantes AS C
INNER JOIN LM_Modalidades AS M ON C.Modalidad = M.ID


SELECT C1.*, COUNT(*) AS Veces FROM @Contrincantes AS C1
GROUP BY C1.Tenista, C1.Edicion, C1.Modalidad, C1.Ronda
HAVING COUNT(*) > 1


--Prueba

SELECT C.*, P.Ronda FROM LM_Contrincantes AS C
INNER JOIN LM_Partidos AS P ON C.ID = P.Contrincante1 OR C.ID = P.Contrincante2
INNER JOIN LM_Modalidades AS M ON C.Modalidad = M.ID
WHERE (C.Tenista1 = 'ACH' OR C.Tenista2 = 'ACH') AND C.Edicion = 2000 AND M.Simple = 0

SELECT * FROM LM_Contrincantes
SELECT * FROM LM_Partidos
WHERE Edicion = 2000 AND Modalidad = 'SF'

--7.- Haz un trigger que al insertar un partido, compruebe que el tanteo de todos los sets es
--correcto y en caso contrario anule la operación. El tanteo es correcto en los siguientes casos: Si
--el número mayor es 6, el menor ha de estar comprendido entre 0 y 4. Si el número mayor es
--siete, el menor puede ser 5 o 6.
--Pista: Haz una función que compruebe si el tanteo de un solo set es correcto.
--Avanzado:
--Se incluye la posibilidad de que se modifiquen varias filas y de que haya
--que consultar otras tablas.
GO
CREATE OR ALTER TRIGGER ComprobarTantero ON LM_Partidos AFTER INSERT
AS
	BEGIN
		
		DECLARE CPartidos CURSOR FOR Select Edicion, Numero From inserted
		DECLARE @Edicion SmallInt, @Numero SmallInt
		DECLARE @SetMinimo TinyInt, @SetMaximo TinyInt

		OPEN CPartidos

		FETCH NEXT FROM CPartidos INTO @Edicion, @Numero

		WHILE @@FETCH_STATUS = 0
			BEGIN
				
				SELECT @SetMaximo =
				  (SELECT MAX(v) 
				   FROM (VALUES (Set11), (Set12), (Set21), (Set22), (Set31), (Set32), (Set41), (Set42), (Set51), (Set52)) AS Value(v))
				FROM inserted WHERE Edicion = @Edicion AND Numero = @Numero

				SELECT @SetMinimo =
				  (SELECT MIN(v) 
				   FROM (VALUES (Set11), (Set12), (Set21), (Set22), (Set31), (Set32), (Set41), (Set42), (Set51), (Set52)) AS Value(v))
				FROM inserted WHERE Edicion = @Edicion AND Numero = @Numero

				IF(@SetMaximo = 6)
				BEGIN
					IF(NOT @SetMinimo BETWEEN 0 AND 4)
					BEGIN
						ROLLBACK
					END
				END
				ELSE IF(@SetMaximo = 7)
				BEGIN
					IF(NOT @SetMinimo BETWEEN 5 AND 6)
					BEGIN
						ROLLBACK
					END
				END
				ELSE
				BEGIN
					ROLLBACK
				END

				FETCH NEXT FROM CPartidos INTO @Edicion, @Numero

			END -- While

		CLOSE CPartidos
		DEALLOCATE CPartidos

	END
GO


--8.- Queremos evitar que se introduzcan palabras que terminen en “azo”
--Sobre LeoMasters
--9.- Cuando se inserte un nuevo partido hemos de comprobar que su fecha está comprendida
--entre el inicio y el final de esa edición.
--10 .- Cuando se inserte un nuevo partido, hemos de comprobar que los contrincantes son los
--vencedores de los partidos de la ronda anterior o es el primer partido que juegan.







