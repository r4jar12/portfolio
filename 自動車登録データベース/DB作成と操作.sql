CREATE DATABASE regist;

USE regist;

CREATE TABLE \_©®ÔíÊ(
  CD INT PRIMARY KEY,
  ¼Ì VARCHAR(10),
  Åz INT
);

INSERT INTO \_©®ÔíÊ VALUES(1,'ÊÔ',37000);
INSERT INTO \_©®ÔíÊ VALUES(2,'y©®Ô',15000);
INSERT INTO \_©®ÔíÊ VALUES(3,'^ñÖ',10000);

SELECT * FROM \_©®ÔíÊ;

SELECT * FROM \_©®ÔíÊ
  WHERE Åz >= 10000 AND Åz <= 20000
  ORDER BY Åz DESC;

SELECT * FROM \_©®ÔíÊ
  WHERE ¼Ì LIKE '%Ô%';

CREATE TABLE \_¢Ñ(
  CD INT PRIMARY KEY,
  db VARCHAR(20),
  Z VARCHAR(50)
);

INSERT INTO \_¢Ñ(CD,Z) VALUES(1,'òæ```');
INSERT INTO \_¢Ñ(CD,db,Z) VALUES(2,'297-3981','Âtæ```');
INSERT INTO \_¢Ñ(CD,db,Z) VALUES(3,'221-3478','{éìæ```');
INSERT INTO \_¢Ñ(CD,Z) VALUES(4,'¾æ```');
INSERT INTO \_¢Ñ(CD,db,Z) VALUES(5,'743-1234','áÑæ```');

SELECT * FROM \_¢Ñ;

SELECT * FROM \_¢Ñ WHERE db IS NULL;

CREATE TABLE \_Âl(
  CD INT PRIMARY KEY,
  ¼ VARCHAR(20),
  gÑ VARCHAR(20),
  ¢ÑCD INT REFERENCES \_¢Ñ(CD)
);

INSERT INTO \_Âl(CD,¼,gÑ,¢ÑCD) VALUES(1,'c ','090-8737-5883',1);
INSERT INTO \_Âl(CD,¼,gÑ,¢ÑCD) VALUES(2,'É¡ ]','090-3482-3248',2);
INSERT INTO \_Âl(CD,¼,gÑ,¢ÑCD) VALUES(3,'É¡ ³','090-2341-9311',2);
INSERT INTO \_Âl(CD,¼,¢ÑCD) VALUES(4,'F O',3);
INSERT INTO \_Âl(CD,¼,gÑ,¢ÑCD) VALUES(5,']Ø F','090-1095-1843',4);
INSERT INTO \_Âl(CD,¼,¢ÑCD) VALUES(6,'Dc ',5);
INSERT INTO \_Âl(CD,¼,gÑ,¢ÑCD) VALUES(7,'F O','070-5802-1039',5);

SELECT * FROM \_Âl;

SELECT \_¢Ñ.CD AS ¢ÑCD,db,Z,\_Âl.CD AS ÂlCD,¼,gÑ
  FROM \_¢Ñ INNER JOIN \_Âl
  ON \_¢Ñ.CD = \_Âl.¢ÑCD
  ORDER BY \_¢Ñ.CD, \_Âl.CD;

CREATE TABLE \_o^(
  CD INT PRIMARY KEY,
  ÂlCD INT REFERENCES \_Âl(CD),
  íÊCD INT REFERENCES \_©®ÔíÊ(CD)
);

INSERT INTO \_o^ VALUES(1,1,1);
INSERT INTO \_o^ VALUES(2,2,3);
INSERT INTO \_o^ VALUES(3,3,2);
INSERT INTO \_o^ VALUES(4,2,1);
INSERT INTO \_o^ VALUES(5,4,1);
INSERT INTO \_o^ VALUES(6,5,2);
INSERT INTO \_o^ VALUES(7,6,3);
INSERT INTO \_o^ VALUES(8,7,2);

SELECT * FROM \_o^;

SELECT \_o^.CD AS o^Ô,\_¢Ñ.CD AS ¢ÑÔ,db,Z,\_Âl.CD AS ÂlÔ,¼,gÑ,\_©®ÔíÊ.CD AS íÊÔ,¼Ì,Åz
  FROM \_o^ INNER JOIN \_Âl
       ON \_o^.ÂlCD = \_Âl.CD
       INNER JOIN \_©®ÔíÊ
       ON \_o^.íÊCD = \_©®ÔíÊ.CD
       INNER JOIN \_¢Ñ
       ON \_Âl.¢ÑCD = \_¢Ñ.CD
  ORDER BY o^Ô;

SELECT ¼ FROM \_Âl
  GROUP BY ¼
  HAVING COUNT(¼) > 1;

SELECT \_¢Ñ.CD AS ¢ÑÔ,db,Z,COUNT(\_©®ÔíÊ.CD) AS o^,SUM(Åz) AS Åzv
  FROM \_o^ INNER JOIN \_Âl
       ON \_o^.ÂlCD = \_Âl.CD
       INNER JOIN \_©®ÔíÊ
       ON \_o^.íÊCD = \_©®ÔíÊ.CD
       INNER JOIN \_¢Ñ
       ON \_Âl.¢ÑCD = \_¢Ñ.CD
  GROUP BY ¢ÑÔ;
