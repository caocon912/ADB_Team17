CREATE DATABASE ADBTeam17SpatialDB
 USE ADBTeam17SpatialDB
 GO

 CREATE TABLE THUADAT
 (
	MA NVARCHAR(10) PRIMARY KEY,
	MUCDICH NVARCHAR(50) ,
	MATDOLUONGNUOC REAL,
	MATDODOANHTHU REAL,
	VITRI geometry

 )
 
 insert into THUADAT values
('M7',N'Trồng lúa',75000,250.6,geometry:: STGeomFromText('MULTIPOLYGON (((0 -2,0 2,1 3,3 3,3 -1,0 -2)),((5 0,8 1,7 3,9 3,9 -2,7 -2,5 0)))',0)),
('M8',N'Trồng cây ăn quả',45000,350.4,geometry:: STGeomFromText('POLYGON ((0 -2,3 -1,3 0,5 0,5 -2,0 -2))',0)),
('M9',N'Trồng rau',35000,450.5,geometry:: STGeomFromText('POLYGON ((3 0,3 3,5 4,7 3,7 1,5 0,3 0))',0))
select VITRI from THUADAT

--b)	Cho biết loại đất có diện tích bé nhất
select MA
 from THUADAT 
 where VITRI.STArea() in(select Min(VITRI.STArea()) from THUADAT)