SELECT * FROM calisanlar WHERE maas = 
	(
		SELECT MAX(maas) FROM calisanlar WHERE maas <
		(
			SELECT MAX(maas) FROM calisanlar
		)
	)
	
SELECT * FROM calisanlar WHERE maas =
	(
		SELECT MAX(maas) FROM calisanlar
	)
	
--Mart ve Nisan ayında satılan ürünlerin ürün isimlerini ve Nisan ayında satın alan müşteri isimlerini listeleyen sorguyu yazınız.
SELECT urun_isim, musteri_isim
FROM nisan AS n
WHERE EXISTS (SELECT urun_isim FROM mart AS m WHERE m.urun_isim=n.urun_isim)

--Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
SELECT urun_isim, musteri_isim
FROM nisan AS n
WHERE NOT EXISTS (SELECT urun_isim FROM mart AS m WHERE m.urun_isim=n.urun_isim)

--CREATE:INSERT
--  READ:SELECT
-- UPDATE:?
--DELETE:DELETE,TRUNCATE

--26-UPDATE komutu:tablodaki veriyi günceller
--syntax: UPDATE table_name
--        SET column_name=yeni değer, column_name2=yeni değer 2
--        WHERE condition

--idsi 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz.
UPDATE calisanlar set isyeri='Trendyol'
SELECT * FROM calisanlar

--idsi 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz.
UPDATE calisanlar
SET isyeri='Trendyol'
WHERE id=123456789;

SELECT * FROM calisanlar

--id'si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve 
--sehirini 'Bursa' olarak güncelleyiniz.
UPDATE calisanlar
SET isim='Veli Yıldırım'
WHERE id=567890123;

SELECT * FROM calisanlar

--id'si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve 
--sehirini 'Bursa' olarak güncelleyiniz.
UPDATE calisanlar
SET sehir='Bursa', isim='Veli Yıldırım'
WHERE id=567890123;

SELECT * FROM calisanlar

--markalar tablosundaki marka_id değeri 102 ye eşit veya büyük olanların marka_id'sini 2 ile çarparak değiştirin.
UPDATE markalar
SET marka_id=marka_id*2
WHERE marka_id>=102;

SELECT * FROM markalar

--markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.
UPDATE markalar
SET calisan_sayisi=calisan_sayisi+marka_id

SELECT * FROM markalar

--calisanlar tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.
UPDATE calisanlar
set sehir=
	(SELECT sehir FROM calisanlar WHERE isim='Veli Yıldırım')
WHERE isim='Ali Seker'

SELECT * FROM calisanlar

--calisanlar tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.

UPDATE calisanlar
SET isyeri = (SELECT marka_isim FROM markalar WHERE calisan_sayisi>20000)
WHERE maas=1500

SELECT * FROM markalar
SELECT * FROM calisanlar

--calisanlar tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
UPDATE calisanlar
SET sehir=CONCAT(sehir, ' Subesi')
WHERE isyeri='Trendyol'

SELECT * FROM calisanlar

--2. Yol
UPDATE calisanlar
SET sehir=sehir || ' Dukkani'
WHERE isyeri = 'LCWaikiki'

SELECT * FROM calisanlar

--people tablosundaki name sütununda NULL olan değerleri listleyiniz.
SELECT name FROM people 
WHERE name IS NULL

--people tablosundaki name sütununda NULL olmayan değerleri listleyiniz.
SELECT name FROM people 
WHERE name IS NOT NULL

--people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..
UPDATE people
SET name='MISSING ...'
WHERE name IS NULL

SELECT * FROM people;

--people tablosundaki name sütununda NULL olan değerleri listleyiniz.
SELECT *
FROM people
WHERE name IS NULL;

--people tablosundaki adres sütununda NULL olmayan değerleri listleyiniz.
SELECT *
FROM people
WHERE address IS NOT NULL;

CREATE TABLE person
(
	ssn char(9),
	isim varchar(50),
	soyisim varchar(50),  
	adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 

SELECT * FROM person;

--person tablosundaki tüm kayıtları adrese göre (artan) sıralayarak listeleyiniz.

SELECT *
FROM person
ORDER BY adres ASC;--defaultta da ASC

--person tablosundaki tüm kayıtları soyisime göre (azalan) sıralayarak listeleyiniz.
SELECT * 
FROM person
ORDER BY soyisim DESC;--DESC(ENDING):azalan sıralı

--person tablosundaki soyismi Bulut olanları isime göre (azalan) sıralayarak listeleyiniz.
SELECT * FROM person
WHERE soyisim='Bulut'
ORDER BY isim DESC

--person tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayiniz
SELECT * FROM person
ORDER BY ssn DESC

--person tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyiniz
SELECT * FROM person
ORDER BY isim,soyisim DESC

INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa');

SELECT * FROM person

--İsim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.
SELECT isim,soyisim FROM person
ORDER BY LENGTH(soyisim)

--Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.

SELECT CONCAT(isim, ' ', soyisim) AS tam_isim, LENGTH(CONCAT(isim, ' ', soyisim)) AS toplam_uzunluk
FROM person
ORDER BY toplam_uzunluk;

--Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.

SELECT isim ||' '||soyisim AS tam_isim, LENGTH(isim || soyisim) AS karakter_sayisi
FROM person
ORDER BY LENGTH(isim || soyisim)

SELECT CONCAT(isim,' ',soyisim) AS tam_isim
FROM person
ORDER BY LENGTH(isim)+LENGTH(soyisim)

--calisanlar tablosunda maaşı ortalama maaştan yüksek olan çalışanların
--isim,şehir ve maaşlarını maaşa göre artan sıralayarak listeleyiniz.

SELECT isim,sehir,maas
FROM calisanlar
WHERE maas>(SELECT AVG(maas) FROM calisanlar)
ORDER BY maas;