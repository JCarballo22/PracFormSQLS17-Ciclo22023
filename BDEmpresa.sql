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

select * from Proveedor;

select P.Proveedor,P.NomRepresentante,P.Telefono,D.NomDepartamento,M.NomMunicipio
from Proveedor P
Join Departamento D On D.IdDepartamento = P.IdDep
Join Municipio M On M.IdMunicipio = P.IdMun



