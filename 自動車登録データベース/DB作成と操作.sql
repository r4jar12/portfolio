CREATE DATABASE regist;

USE regist;

CREATE TABLE 表_自動車種別(
  CD INT PRIMARY KEY,
  名称 VARCHAR(10),
  税額 INT
);

INSERT INTO 表_自動車種別 VALUES(1,'普通車',37000);
INSERT INTO 表_自動車種別 VALUES(2,'軽自動車',15000);
INSERT INTO 表_自動車種別 VALUES(3,'中型二輪',10000);

SELECT * FROM 表_自動車種別;

SELECT * FROM 表_自動車種別
  WHERE 税額 >= 10000 AND 税額 <= 20000
  ORDER BY 税額 DESC;

SELECT * FROM 表_自動車種別
  WHERE 名称 LIKE '%車%';

CREATE TABLE 表_世帯(
  CD INT PRIMARY KEY,
  電話 VARCHAR(20),
  住所 VARCHAR(50)
);

INSERT INTO 表_世帯(CD,住所) VALUES(1,'泉区～～～');
INSERT INTO 表_世帯(CD,電話,住所) VALUES(2,'297-3981','青葉区～～～');
INSERT INTO 表_世帯(CD,電話,住所) VALUES(3,'221-3478','宮城野区～～～');
INSERT INTO 表_世帯(CD,住所) VALUES(4,'太白区～～～');
INSERT INTO 表_世帯(CD,電話,住所) VALUES(5,'743-1234','若林区～～～');

SELECT * FROM 表_世帯;

SELECT * FROM 表_世帯 WHERE 電話 IS NULL;

CREATE TABLE 表_個人(
  CD INT PRIMARY KEY,
  氏名 VARCHAR(20),
  携帯 VARCHAR(20),
  世帯CD INT REFERENCES 表_世帯(CD)
);

INSERT INTO 表_個人(CD,氏名,携帯,世帯CD) VALUES(1,'相田 聡','090-8737-5883',1);
INSERT INTO 表_個人(CD,氏名,携帯,世帯CD) VALUES(2,'伊藤 望','090-3482-3248',2);
INSERT INTO 表_個人(CD,氏名,携帯,世帯CD) VALUES(3,'伊藤 正','090-2341-9311',2);
INSERT INTO 表_個人(CD,氏名,世帯CD) VALUES(4,'宇部 徹',3);
INSERT INTO 表_個人(CD,氏名,携帯,世帯CD) VALUES(5,'江木 孝','090-1095-1843',4);
INSERT INTO 表_個人(CD,氏名,世帯CD) VALUES(6,'織田 亨',5);
INSERT INTO 表_個人(CD,氏名,携帯,世帯CD) VALUES(7,'宇部 徹','070-5802-1039',5);

SELECT * FROM 表_個人;

SELECT 表_世帯.CD AS 世帯CD,電話,住所,表_個人.CD AS 個人CD,氏名,携帯
  FROM 表_世帯 INNER JOIN 表_個人
  ON 表_世帯.CD = 表_個人.世帯CD
  ORDER BY 表_世帯.CD, 表_個人.CD;

CREATE TABLE 表_登録(
  CD INT PRIMARY KEY,
  個人CD INT REFERENCES 表_個人(CD),
  種別CD INT REFERENCES 表_自動車種別(CD)
);

INSERT INTO 表_登録 VALUES(1,1,1);
INSERT INTO 表_登録 VALUES(2,2,3);
INSERT INTO 表_登録 VALUES(3,3,2);
INSERT INTO 表_登録 VALUES(4,2,1);
INSERT INTO 表_登録 VALUES(5,4,1);
INSERT INTO 表_登録 VALUES(6,5,2);
INSERT INTO 表_登録 VALUES(7,6,3);
INSERT INTO 表_登録 VALUES(8,7,2);

SELECT * FROM 表_登録;

SELECT 表_登録.CD AS 登録番号,表_世帯.CD AS 世帯番号,電話,住所,表_個人.CD AS 個人番号,氏名,携帯,表_自動車種別.CD AS 種別番号,名称,税額
  FROM 表_登録 INNER JOIN 表_個人
       ON 表_登録.個人CD = 表_個人.CD
       INNER JOIN 表_自動車種別
       ON 表_登録.種別CD = 表_自動車種別.CD
       INNER JOIN 表_世帯
       ON 表_個人.世帯CD = 表_世帯.CD
  ORDER BY 登録番号;

SELECT 氏名 FROM 表_個人
  GROUP BY 氏名
  HAVING COUNT(氏名) > 1;

SELECT 表_世帯.CD AS 世帯番号,電話,住所,COUNT(表_自動車種別.CD) AS 登録数,SUM(税額) AS 税額合計
  FROM 表_登録 INNER JOIN 表_個人
       ON 表_登録.個人CD = 表_個人.CD
       INNER JOIN 表_自動車種別
       ON 表_登録.種別CD = 表_自動車種別.CD
       INNER JOIN 表_世帯
       ON 表_個人.世帯CD = 表_世帯.CD
  GROUP BY 世帯番号;
