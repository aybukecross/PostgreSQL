SELECT * 
FROM calisanlar
WHERE maas=7000

SELECT * 
FROM calisanlar
WHERE maas=(
		SELECT MAX(maas) 
		FROM calisanlar)
		
SELECT * 
FROM calisanlar
WHERE maas=(
		SELECT MIN(maas) 
		FROM calisanlar)
		
SELECT * 
FROM calisanlar
WHERE maas=(
	SELECT MAX(maas) 
	FROM calisanlar
	WHERE maas < (
		SELECT MAX(maas)
		FROM calisanlar
		WHERE maas < (
			SELECT MAX(maas)
			FROM calisanlar)))
			
SELECT * 
FROM calisanlar
WHERE maas=(
		SELECT MAX(maas) 
		FROM calisanlar)
		OR
		maas=(
		SELECT MIN(maas) 
		FROM calisanlar)
					
SELECT * 
FROM calisanlar
WHERE maas IN (
		(
			SELECT MAX(maas) 
			FROM calisanlar
		),
		(
			SELECT MIN(maas) 
			FROM calisanlar
		)
)

SELECT marka_id,calisan_sayisi
FROM markalar
WHERE marka_isim IN('Vakko','Adidas','Pierre Cardin')

SELECT * FROM markalar
SELECT * FROM calisanlar

SELECT marka_id,calisan_sayisi
FROM markalar
WHERE marka_isim IN(SELECT isyeri FROM calisanlar WHERE sehir='Ankara')

SELECT isim,maas,sehir
FROM calisanlar
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101)

SELECT isim,maas,sehir
FROM calisanlar
WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000)

SELECT isim,maas,sehir
FROM calisanlar
WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE marka_id>101)

SELECT isim,maas,sehir
FROM calisanlar
WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000)

SELECT marka_id,marka_isim,(
	SELECT COUNT(sehir) FROM calisanlar 
	WHERE isyeri=marka_isim
)
FROM markalar

SELECT * FROM markalar
SELECT * FROM calisanlar

--DISTICT komutu sadece farklı olan değerleri gösterir.
SELECT DISTINCT sehir FROM calisanlar
SELECT DISTINCT (sehir) FROM calisanlar

SELECT COUNT(DISTINCT (sehir)) FROM calisanlar

SELECT marka_id,marka_isim,(
	SELECT COUNT(DISTINCT sehir) FROM calisanlar
	WHERE isyeri=marka_isim) AS sehir_sayısı
FROM markalar

--VIEW oluşturma
CREATE VIEW sehir_sayisi AS
SELECT marka_id,marka_isim,(
	SELECT COUNT(DISTINCT sehir) FROM calisanlar
	WHERE isyeri=marka_isim) AS sehir_sayısı
FROM markalar

--TABLE oluşturma
CREATE TABLE sehirsayisi AS
SELECT marka_id,marka_isim,(
	SELECT COUNT(DISTINCT sehir) FROM calisanlar
	WHERE isyeri=marka_isim) AS sehir_sayısı
FROM markalar

SELECT marka_isim, calisan_sayisi,(
	SELECT MIN(maas) FROM calisanlar
	WHERE isyeri=marka_isim
)
FROM markalar

SELECT marka_isim, calisan_sayisi,(
	SELECT MAX(maas) FROM calisanlar
	WHERE isyeri=marka_isim
)
FROM markalar

SELECT marka_isim, calisan_sayisi,
(
	SELECT MAX(maas)
	FROM calisanlar
	WHERE isyeri=marka_isim
) AS max_maas,
(
	SELECT MIN(maas)
	FROM calisanlar
	WHERE isyeri=marka_isim
) AS min_maas
FROM markalar

--EXISTS
--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.

CREATE TABLE mart
(	
urun_id int,	
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(	
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;

--Mart ayında 'Toyota' satışı yapılmışsa Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.

SELECT * 
FROM nisan
WHERE EXISTS (SELECT urun_isim FROM mart WHERE urun_isim='Toyota'); 

--EXISTS false olursa
--Mart ayında 'Volvo' satışı yapılmışsa Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.

SELECT * 
FROM nisan
WHERE EXISTS (SELECT urun_isim FROM mart WHERE urun_isim='Volvo');

--Mart ayında satılan ürünün urun_id ve musteri_isim'lerini, eğer Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız. 

SELECT urun_id,musteri_isim
FROM mart 
WHERE EXISTS (SELECT urun_isim FROM nisan WHERE nisan.urun_isim=mart.urun_isim )

SELECT urun_id,musteri_isim,urun_isim
FROM mart AS m
WHERE EXISTS (SELECT urun_isim FROM nisan AS n WHERE n.urun_isim=m.urun_isim )--correlated subquery