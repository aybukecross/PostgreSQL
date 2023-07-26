--29-GROUP BY clause:

CREATE TABLE manav
(
	isim varchar(50),
	urun_adi varchar(50),
	urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);  
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);  
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);


SELECT * FROM manav;

--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
SELECT * FROM manav

SELECT isim, SUM(urun_miktar)
FROM manav
GROUP BY isim

SELECT isim, SUM(urun_miktar) toplam_kg
FROM manav
GROUP BY isim
ORDER BY toplam_kg DESC;

--Her bir ismin aldığı her bir ürünün toplam miktarını isme göre sıralı görüntüleyiniz.
SELECT isim, SUM(urun_miktar) toplam_kg
FROM manav
GROUP BY isim
ORDER BY isim;

--NOT:GROUP BY ile gruplama yapıldığında SELECT den sonra sadece gruplama yapılan sütunu 
--veya herhangi bir sütunun aggregate fonk ile kullanımı mümkündür. Aksi halde
--diğer sütunlar kullanılamaz.

--NOT 2: GROUP BY dan sonraki sütun sırası önemli, öncelikle ilk sütundan başlayarak gruplar.
SELECT isim, urun_adi, SUM(urun_miktar) toplam_kg
FROM manav
GROUP BY isim,urun_adi
ORDER BY isim;


SELECT isim, SUM(urun_miktar) toplam_kg
FROM manav
GROUP BY isim
ORDER BY isim;

--ürün ismine göre her bir ürünü alan toplam kişi sayısı gösteriniz.
SELECT urun_adi, COUNT(DISTINCT isim) kisi_sayisi
FROM manav
GROUP BY urun_adi

--Isme göre alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz
SELECT isim, SUM(urun_miktar) AS toplam_urun_miktari, COUNT(DISTINCT urun_adi) AS cesit_sayisi
FROM manav
GROUP BY isim

SELECT * FROM manav

--Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sıralayınız.
SELECT urun_miktar, COUNT(DISTINCT isim) kisi_sayisi
FROM manav
GROUP BY urun_miktar
ORDER BY kisi_sayisi

--2. yol
SELECT urun_miktar, COUNT(DISTINCT isim) kisi_sayisi
FROM manav
GROUP BY urun_miktar
ORDER BY COUNT(DISTINCT isim)

SELECT urun_adi, SUM(urun_miktar) Toplam_Urun
FROM manav
GROUP BY urun_adi

SELECT * FROM manav

-- Kim Toplam kaç kg ürün aldı
SELECT isim, SUM(urun_miktar) Toplam_Urun
FROM manav
GROUP BY isim

-- Hangi üründen Toplam kaç kg alındı
SELECT urun_adi, SUM(urun_miktar) Toplam_Urun
FROM manav
GROUP BY urun_adi

-- Kim Hangi üründen Toplam kaç kg aldı
SELECT isim,urun_adi, SUM(urun_miktar) Toplam_Urun
FROM manav
GROUP BY isim,urun_adi

SELECT isim,urun_miktar
FROM manav
GROUP BY isim,urun_miktar
ORDER BY urun_miktar

--30-HAVING clause:group by komutundan sonra filtreleme yapmak için
--aggregate fonks. birlikte kullanılır.

CREATE TABLE personel(
	id int,
	isim varchar(50),
	sehir varchar(50), 
	maas int,  
	sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(678901245, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');


SELECT * FROM personel;

--Her bir şirketin MIN maas bilgisini eğer 4000den fazla ise görüntüleyiniz.
SELECT sirket, MIN(maas) min_maas
FROM personel
GROUP BY sirket
HAVING MIN(maas)>4000

SELECT sirket, MIN(maas)
FROM personel where maas>4000
GROUP BY sirket

--Maaşı 4000 den fazla olan çalışanlardan, her bir şirketin MIN maas bilgisini görüntüleyiniz.
SELECT sirket, MIN(maas) min_maas
FROM personel
WHERE maas>4000
GROUP BY sirket

--Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa sehir ismini ve personel sayısını veren sorgu yazınız
SELECT sehir, COUNT(DISTINCT id) kisi_sayisi
FROM personel
GROUP BY sehir
HAVING COUNT(DISTINCT id)>1;

SELECT * FROM personel

SELECT sirket, MIN(maas) as Min_Maas
FROM personel
GROUP BY sirket
HAVING MIN(maas)>4000

SELECT sirket, MIN(maas) as Min_Maas
FROM personel
WHERE maas>4000
GROUP BY sirket

SELECT isim, SUM(maas) AS toplam_gelir
FROM personel
GROUP BY isim
HAVING SUM(maas)>10000

--31-UNION:iki farklı sorgunun sonucunu birleştirerek görüntülememizi sağlar.
          --tekrarlı değerleri göstermez.
--UNION ALL operator:UNION ile aynı işlevi görür ancak tekrarlı verileri de gösterir

CREATE TABLE developers(
	id SERIAL PRIMARY KEY,
	name varchar(50),
	email varchar(50) UNIQUE,
	salary real,
	prog_lang varchar(20),
	city varchar(50),
	age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Bey','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Bey','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Hanım ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Hanım','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Bey','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Bey','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Bey','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Tansu Hanım','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Said Bey','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mustafa Bey','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hakan Bey','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Deniz Bey','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ummu Hanım','ummu@mail.com',4000,'C#','Bursa',29);


CREATE TABLE contact_info(
	address_id int,
	street varchar(30),
	number int,	
	city varchar(30),
	FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');

SELECT * FROM developers;
SELECT * FROM contact_info;

--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini
--tekrarsız gösteren sorguyu yaziniz

SELECT name FROM developers WHERE age>25--12
UNION
SELECT prog_lang FROM developers WHERE age<30--5

--NOT:UNION/UNION ALL birleştirdiğimiz sorgular aynı sayıda sütunu göstermeli ve alt alta gelecek olan sütunun 
--data tipi aynı olmalı

--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini
--tekrarlı gösteren sorguyu yaziniz
SELECT name FROM developers WHERE age>25
UNION ALL
SELECT prog_lang FROM developers WHERE age<30

--Java kullananların maaşını ve prog. dilini ve 
--JavaScript kullananların yaşını ve prog. dilini
--tekrarsız gösteren sorguyu yaziniz

SELECT salary maas_yas, prog_lang FROM developers WHERE prog_lang='Java'
UNION
SELECT age maas_yas, prog_lang FROM developers WHERE prog_lang='JavaScript'

--id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.
SELECT city, salary maas_kapino FROM developers WHERE id=8
UNION
SELECT city, number maas_kapino FROM contact_info WHERE address_id=8

--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--tümünü tekrarsız olarak listeleyiniz

--32-INTERSECT : iki farklı sorgunun sonuçlarından ortak olanları kesişimi gösterir.
--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--aynı olanlarını tekrarsız olarak listeleyiniz

SELECT city FROM developers
INTERSECT
SELECT sehir FROM calisanlar3

--33-EXCEPT :bir sorgunun sonuçlarından diğer sorgunun sonuçları hariç 
--olanları gösterir.

--developers tablosundaki şehirleri
--calisanlar tablosunda sehirler hariç olarak listeleyiniz
SELECT city FROM developers
EXCEPT
SELECT sehir FROM calisanlar

--calisanlar3 tablosundaki şehirleri
--developers tablosunda sehirler hariç olarak listeleyiniz

SELECT sehir FROM calisanlar3
EXCEPT
SELECT city FROM developers

 --ÖDEV:mart ve nisan tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz.  
 --ÖDEV:mart ve nisan tablolarındaki ortak ürünlerin isimlerini listeleyiniz.
 --ÖDEV:mart ayında satılıp nisan ayında satılmayan ürünlerin isimlerini listeleyiniz. 