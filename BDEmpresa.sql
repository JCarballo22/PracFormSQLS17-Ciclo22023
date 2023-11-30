create database BDEmpresa;
Use BDEmpresa;

Create Table Sexo(
	IdSexo Int Not Null Primary Key Identity(1,1),
	Genero Char(1)
);

Insert Into Sexo Values('M');
Insert Into Sexo Values('F');

Select * From Sexo;

Create Table Cargo(
	IdCargo Int Not Null Primary Key Identity(1,1),
	Nombre Varchar(15) Not Null
);

Insert Into Cargo Values('Gerente');
Insert Into Cargo Values('Supervisor');
Insert Into Cargo Values('Vendedor');
Insert Into Cargo Values('Bodeguero');
Insert Into Cargo Values('Operador');

Select * From Cargo;

--Drop Table Empleado;

Create Table Empleado(
IdCodigo Int Primary Key Identity(1,1),
Nombre Varchar(30) Not Null,
Apellido Varchar(25) Not Null,
Sexo Int Not Null Foreign Key References Sexo(IdSexo), 
Cargo Int Not Null Foreign Key References Cargo(IdCargo), 
Estado Bit default(1),
Creado Datetime default(getdate())
);

Insert Into Empleado(Nombre,Apellido,Sexo,Cargo) 
values('Mario','Mendoza',1,3);

select * from Empleado;

Select E.IdCodigo, E.Nombre, E.Apellido,  S.Genero, C.Cargo
From Empleado E
Join Sexo S On S.IdSexo = E.Sexo
Join Cargo C On C.IdCargo = E.Cargo Where IdCodigo = 5;

Exec sp_rename 'Cargo.Nombre', 'Cargo','Column'

--Practica 16/11/2023
drop table Imagen;
Create Table Imagen(
IdImagen Int Primary Key Identity(1,1),
--NomImagen Varchar(20) Not Null,
Imagen Image Not Null,
Estado bit default (1),
Creado Datetime default(getdate())
);

select * From Imagen;

Create Table Departamento(
IdDepartamento Int Not Null Primary Key Identity(1,1),
NomDepartamento Varchar(25) Not Null
);

Create Table Municipio(
IdMunicipio Int Not Null Primary Key Identity(1,1),
IdDep Int Not Null Foreign Key References Departamento(IdDepartamento),
NomMunicipio Varchar(25) Not Null
);

Insert Into Departamento(NomDepartamento)
Values ('Chalatenango');
Insert Into Departamento(NomDepartamento)
Values ('San Salvador');
Insert Into Departamento(NomDepartamento)
Values ('San Miguel');
Insert Into Departamento(NomDepartamento)
Values ('Sonsonate');

Select * From Departamento;

Insert Into Municipio (IdDep,NomMunicipio)
Values (1,'Chalatenango');
Insert Into Municipio (IdDep,NomMunicipio)
Values (2,'San Salvador');
Insert Into Municipio (IdDep,NomMunicipio)
Values (3,'San Miguiel');
Insert Into Municipio (IdDep,NomMunicipio)
Values (4,'Sonsonate');

Insert Into Municipio (IdDep,NomMunicipio)
Values (1,'La Palma');
Insert Into Municipio (IdDep,NomMunicipio)
Values (2,'Aguilares');
Insert Into Municipio (IdDep,NomMunicipio)
Values (3,'San Antorio');
Insert Into Municipio (IdDep,NomMunicipio)
Values (4,'Izalco');

Select * From Municipio;

Create Table Proveedor(
IdProveedor Int Not Null Primary Key Identity(1,1),
Proveedor Varchar(35) Not Null Unique,
NomRepresentante varchar(50) Not Null,
Telefono Int Not Null,
IdDep Int Not Null Foreign Key References Departamento(IdDepartamento),
IdMun Int Not Null Foreign Key References Municipio(IdMunicipio),
Estado Bit default(1),
Creado Datetime default(getdate())
);

Insert Into Proveedor(Proveedor,NomRepresentante,Telefono,IdDep,IdMun) 
values('Tecnológia Max','Jose Mendoza',87946841,2,6);

Insert Into Proveedor(Proveedor,NomRepresentante,Telefono,IdDep,IdMun) 
values('San Juan Lacteos','Juan Peréz',87749871,1,1);

select * from Proveedor;

select P.Proveedor,P.NomRepresentante,P.Telefono,D.NomDepartamento,M.NomMunicipio
from Proveedor P
Join Departamento D On D.IdDepartamento = P.IdDep
Join Municipio M On M.IdMunicipio = P.IdMun

Create Table Categoria(
	IdCategoria Int Not Null Primary Key Identity(1,1),
	Categoria Varchar(50) Not Null Unique,
);

Insert Into Categoria 
Values ('Tecnologia'),
	   ('Abarroteria'),
	   ('Lacteos'),
	   ('Bebidas'),
	   ('Hogar');

Create Table Unidad(
	IdUnidad Int Not Null Primary Key Identity(1,1),
	UnidadDes Varchar(25) Not Null
);

Insert Into Unidad 
Values ('12 - 550ml botella'),
		('5 - 1 lb bolsa'),
		('10 - 8 oz Paquete'),
		('3 pack');


Create Table Producto(
	IdProducto Int Primary Key Identity(1,1),
	Producto Varchar(50) not Null Unique,
	IdProveedor Int Foreign Key References Proveedor(IdProveedor),
	IdCategoria Int Foreign Key References Categoria(IdCategoria),
	IdUnidad Int Foreign key References Unidad(IdUnidad),
	Precio Real Not Null,
	InStock Int Not Null,
	Estado bit default (1),
	Creado Datetime default(getdate())
);

Insert Into Producto(Producto,IdProveedor,IdCategoria,IdUnidad,Precio,InStock) 
Values ('Teclado',1,1,4,15,5);

Insert Into Producto(Producto,Precio,InStock) 
Values ('Pantalla',125,3);

select * from Producto;

Select P.Producto,Pro.Proveedor,Cat.Categoria,U.UnidadDes,P.Precio,P.InStock
From Producto P
Join Proveedor Pro On Pro.IdProveedor = P.IdProveedor
Join Categoria Cat On Cat.IdCategoria = P.IdCategoria
Join Unidad U On U.IdUnidad = P.IdUnidad