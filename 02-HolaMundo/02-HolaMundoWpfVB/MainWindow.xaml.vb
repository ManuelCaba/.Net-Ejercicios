Imports _02_HolaMundoWpfCSharp

Class MainWindow

    ''' <summary>
    ''' Función que al pulsar el botón saluda según el nombre que se haya indicado
    ''' en el text box asignado para éste. En caso de no haber indicado ningún 
    ''' nombre mandará un mensaje de error.
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Private Sub Button_Click(sender As Object, e As RoutedEventArgs)
        Dim persona As clsPersona

        persona.Nombre = txbNombre.Text

        If (Not String.IsNullOrEmpty(persona.Nombre)) Then
            lblErrorNombre.Content = ""
            MessageBox.Show($"Hola {persona.Nombre}")
        Else
            lblErrorNombre.Content = "El nombre no puede estar vacío"
        End If

    End Sub
End Class
