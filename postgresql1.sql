create table tedarikciler(
	tedarikci_id CHAR(4),
	tedarikci_ismi VARCHAR(50),
	tedarikci_adres VARCHAR(2500),
	ulasim_tarihi DATE
)

select * from tedarikciler

CREATE TABLE tedarikci_info AS 
	SELECT tedarikci_ismi, ulasim_tarihi 
FROM tedarikciler;

select * from tedarikci_info

create table ogretmenler(
	kimlik_no CHAR(11),
	isim VARCHAR(50),
	brans VARCHAR(50),
	cinsiyet VARCHAR(50)
)

select * from ogretmenler

INSERT INTO ogretmenler VALUES(
	'234431223',
	'Ayse Guler',
	'Matematik',
	'kadin'
);

INSERT INTO ogretmenler VALUES(
	'234431224',
	'Ali Guler',
	'Fizik',
	'erkek'
);

select * from ogretmenler

INSERT INTO ogretmenler VALUES(
	'',
	'Muzaffer Guler'
	'',
	'erkek'
);

select * from ogretmenler