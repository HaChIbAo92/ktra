create database QLHANG
GO
USE [QLHANG]
GO
CREATE TABLE VATTU
(
MAVAT char(4) primary key,
TENVT nvarchar (20) not null,
DVTINH nvarchar(10) not null,
SLCON int not null,
)
create table HDBAN
(
MAHD char(4) primary key,
NGAYXUAT datetime,
HOTENKH nvarchar(40) not null,
)
create table HANGXUAT
(
MAHD char(4) not null,
MAVT char(4) not null,
DONGIA money not null,
SLBAN int not null,
constraint pk_hangxuat primary key(MAHD,MAVT)
)

--THÊM DỮ LIỆU cho bảng vạt tư
insert into VATTU values ('VT01','Xi măng' ,'bao', 10)
insert into VATTU values ('VT02','Xẻng, cuốc','Cái', 20)

--THÊM DỮ LIỆU CHO BẢNG HDBAN
insert into HDBAN values ('HD01','1/1/2022','Trần Ngọc Cường')
insert into HDBAN values ('HD02','1/2/2022','Trần Ngọc Bảo')
--THÊM DỮ LIỆU CHO BẢNG HANGXUAT
insert into HANGXUAT values ('HD01','VT01',420000, 5)
insert into HANGXUAT values ('HD01','VT02',375000, 5)
insert into HANGXUAT values ('HD02','VT02',588000, 7)
insert into HANGXUAT values ('HD02','VT01',675000, 9)

--Câu 2:
select Top 1 MAHD, SUM(DONGIA) as TONGTIEN
from HANGXUAT
group by MAHD, DONGIA
Order by DONGIA desc

--Câu 4:
CREATE PROCEDURE p4  @thang int, @nam int 
AS
SELECT SUM(SLBAN * DONGIA)
FROM HANGXUAT HX
INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
where MONTH(HD.NGAYXUAT) = @THANG AND YEAR(HD.NGAYXUAT) = @NAM;
select * from  dbo.p4

--Câu 3:
create function getThu(@ngay DATETIME)
	returns nvarchar(100)
as
begin
	declare @songaytrongtuan int;
	set @songaytrongtuan = datepart(weekday, @ngay);
	declare @thu nvarchar (100);

	if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu hai';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu ba';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu tu';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu nam';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu sau';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'thu bay';
	end
		if (@songaytrongtuan = 0)
	begin
		set @thu = 'Chu nhat';
	end 
go
create function cau3(@mahd int)
returns table
as
	return
		select dbo.HDBAN.MAHD, NgayXuat, MaVT, DonGia, SLBan, getThu(NGAYXUAT) as 'NgayThu'
		from dbo.HANGXUAT, dbo.HDBAN
		where dbo.HDBAN.MAHD = dbo.HANGXUAT.MAHD And dbo.HANGXUAT.MAHD = @mahd

go 
select * from dbo.cau3(2)