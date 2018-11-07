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

--a)	Cho biết lượng nước tưới tiêu cần thiết (tính bằng m3) của mỗi loại đất
select MA,MUCDICH, VITRI.STArea()/10000 *MATDOLUONGNUOC as 'Lượng nước tưới' from THUADAT
--b)	Cho biết loại đất có diện tích bé nhất

select MA from THUADAT 
where VITRI.STArea() in(select Min(VITRI.STArea()) from THUADAT)
--c)	Giả sử ta cần đào 1 kênh nước để dẫn nước tưới tiêu. Kênh nước này được giới hạn bởi 2 đường thẳng song song với Oy và lần lượt qua điểm A(2, 4) và B(4,-2). Hãy cho biết diện tích bị mất sau ứng với mỗi loại sau khi xây dựng kênh nước này.
declare @tem geometry
set @tem = geometry::STGeomFromText('POLYGON((2 -2,2 4,4 4,4 -2,2 -2))',0)
select @tem
select MA,VITRI.STIntersection(@tem).STArea() as 'dien tich bị mất' from THUADAT
