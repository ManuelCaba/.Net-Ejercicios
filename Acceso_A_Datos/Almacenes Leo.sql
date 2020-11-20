SELECT * FROM Envios AS E
INNER JOIN
(
	SELECT A.ID, A.Capacidad - Sum(E.NumeroContenedores) AS disponible From Almacenes AS A 
	Inner Join Asignaciones As Ag ON A.ID = Ag.IDAlmacen
	Inner Join Envios AS E ON Ag.IDEnvio = E.ID
	Group By A.ID, A.Capacidad
) AS D ON E.AlmacenPreferido = D.ID
WHERE E.FechaAsignacion IS NULL AND E.ID = 5


