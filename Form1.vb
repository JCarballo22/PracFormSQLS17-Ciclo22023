Imports System.Data.SqlClient

Public Class Form1
    Dim conexion As New SqlConnection("Server=LAPTOP-ENVY-PC\SQLSERVER; DataBase=BDEmpresa;Integrated Security=True")
    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        CargarProveedor()
        CargarCategoria()
        CargarUnidad()
        MostrarDatos()
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Guardar()
    End Sub

    Sub Guardar()
        Try
            Dim consulta As String = "Insert Into Producto(Producto,IdProveedor,IdCategoria,IdUnidad,Precio,InStock) 
                                    Values ('" & tbProducto.Text & "',
                                    " & cbProveedor.SelectedValue & ",
                                    " & cbCategoria.SelectedValue & ",
                                    " & cbUnidades.SelectedValue & ",
                                    " & tbPrecio.Text & "," & tbInStock.Text & ");"
            Dim comando As New SqlCommand(consulta, conexion)
            conexion.Open()
            comando.ExecuteNonQuery()
            MsgBox("Se guardo el producto")

        Catch ex As Exception
            MsgBox(ex.Message)
        Finally
            conexion.Close()
            MsgBox("Se cerro la coneccion")
            tbProducto.Text = ""
            cbProveedor.Text = ""
            cbCategoria.Text = ""
            cbUnidades.Text = ""
            tbPrecio.Text = ""
            tbInStock.Text = ""
        End Try
    End Sub
    Sub CargarProveedor()
        Try
            Dim consulta = "Select * From Proveedor"
            Dim da As New SqlDataAdapter(consulta, conexion)
            Dim ds As New DataSet
            da.Fill(ds, "Proveedor")
            With cbProveedor
                .DataSource = ds.Tables("Proveedor")
                .DisplayMember = "Proveedor"
                .ValueMember = "IdProveedor"
            End With

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Sub CargarCategoria()
        Try
            Dim consulta = "Select * From Categoria"
            Dim da As New SqlDataAdapter(consulta, conexion)
            Dim ds As New DataSet
            da.Fill(ds, "Categoria")
            With cbCategoria
                .DataSource = ds.Tables("Categoria")
                .DisplayMember = "Categoria"
                .ValueMember = "IdCategoria"
            End With

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Sub CargarUnidad()
        Try
            Dim consulta = "Select * From Unidad"
            Dim da As New SqlDataAdapter(consulta, conexion)
            Dim ds As New DataSet
            da.Fill(ds, "Unidad")
            With cbUnidades
                .DataSource = ds.Tables("Unidad")
                .DisplayMember = "UnidadDes"
                .ValueMember = "IdUnidad"
            End With

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Sub MostrarDatos()
        Try


            Dim consulta As String = "Select P.Producto,Pro.Proveedor,Cat.Categoria,U.UnidadDes,P.Precio,P.InStock
                                From Producto P
                                Join Proveedor Pro On Pro.IdProveedor = P.IdProveedor
                                Join Categoria Cat On Cat.IdCategoria = P.IdCategoria
                                Join Unidad U On U.IdUnidad = P.IdUnidad;"
            Dim da As New SqlDataAdapter(consulta, conexion)
            Dim ds As New DataSet
            da.Fill(ds, "Producto")
            dgDatos.DataSource = ds.Tables("Producto")
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

End Class
