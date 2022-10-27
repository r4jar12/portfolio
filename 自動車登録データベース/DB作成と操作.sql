CREATE DATABASE regist;

USE regist;

CREATE TABLE �\_�����Ԏ��(
  CD INT PRIMARY KEY,
  ���� VARCHAR(10),
  �Ŋz INT
);

INSERT INTO �\_�����Ԏ�� VALUES(1,'���ʎ�',37000);
INSERT INTO �\_�����Ԏ�� VALUES(2,'�y������',15000);
INSERT INTO �\_�����Ԏ�� VALUES(3,'���^���',10000);

SELECT * FROM �\_�����Ԏ��;

SELECT * FROM �\_�����Ԏ��
  WHERE �Ŋz >= 10000 AND �Ŋz <= 20000
  ORDER BY �Ŋz DESC;

SELECT * FROM �\_�����Ԏ��
  WHERE ���� LIKE '%��%';

CREATE TABLE �\_����(
  CD INT PRIMARY KEY,
  �d�b VARCHAR(20),
  �Z�� VARCHAR(50)
);

INSERT INTO �\_����(CD,�Z��) VALUES(1,'���`�`�`');
INSERT INTO �\_����(CD,�d�b,�Z��) VALUES(2,'297-3981','�t��`�`�`');
INSERT INTO �\_����(CD,�d�b,�Z��) VALUES(3,'221-3478','�{����`�`�`');
INSERT INTO �\_����(CD,�Z��) VALUES(4,'������`�`�`');
INSERT INTO �\_����(CD,�d�b,�Z��) VALUES(5,'743-1234','��ы�`�`�`');

SELECT * FROM �\_����;

SELECT * FROM �\_���� WHERE �d�b IS NULL;

CREATE TABLE �\_�l(
  CD INT PRIMARY KEY,
  ���� VARCHAR(20),
  �g�� VARCHAR(20),
  ����CD INT REFERENCES �\_����(CD)
);

INSERT INTO �\_�l(CD,����,�g��,����CD) VALUES(1,'���c ��','090-8737-5883',1);
INSERT INTO �\_�l(CD,����,�g��,����CD) VALUES(2,'�ɓ� �]','090-3482-3248',2);
INSERT INTO �\_�l(CD,����,�g��,����CD) VALUES(3,'�ɓ� ��','090-2341-9311',2);
INSERT INTO �\_�l(CD,����,����CD) VALUES(4,'�F�� �O',3);
INSERT INTO �\_�l(CD,����,�g��,����CD) VALUES(5,'�]�� �F','090-1095-1843',4);
INSERT INTO �\_�l(CD,����,����CD) VALUES(6,'�D�c ��',5);
INSERT INTO �\_�l(CD,����,�g��,����CD) VALUES(7,'�F�� �O','070-5802-1039',5);

SELECT * FROM �\_�l;

SELECT �\_����.CD AS ����CD,�d�b,�Z��,�\_�l.CD AS �lCD,����,�g��
  FROM �\_���� INNER JOIN �\_�l
  ON �\_����.CD = �\_�l.����CD
  ORDER BY �\_����.CD, �\_�l.CD;

CREATE TABLE �\_�o�^(
  CD INT PRIMARY KEY,
  �lCD INT REFERENCES �\_�l(CD),
  ���CD INT REFERENCES �\_�����Ԏ��(CD)
);

INSERT INTO �\_�o�^ VALUES(1,1,1);
INSERT INTO �\_�o�^ VALUES(2,2,3);
INSERT INTO �\_�o�^ VALUES(3,3,2);
INSERT INTO �\_�o�^ VALUES(4,2,1);
INSERT INTO �\_�o�^ VALUES(5,4,1);
INSERT INTO �\_�o�^ VALUES(6,5,2);
INSERT INTO �\_�o�^ VALUES(7,6,3);
INSERT INTO �\_�o�^ VALUES(8,7,2);

SELECT * FROM �\_�o�^;

SELECT �\_�o�^.CD AS �o�^�ԍ�,�\_����.CD AS ���єԍ�,�d�b,�Z��,�\_�l.CD AS �l�ԍ�,����,�g��,�\_�����Ԏ��.CD AS ��ʔԍ�,����,�Ŋz
  FROM �\_�o�^ INNER JOIN �\_�l
       ON �\_�o�^.�lCD = �\_�l.CD
       INNER JOIN �\_�����Ԏ��
       ON �\_�o�^.���CD = �\_�����Ԏ��.CD
       INNER JOIN �\_����
       ON �\_�l.����CD = �\_����.CD
  ORDER BY �o�^�ԍ�;

SELECT ���� FROM �\_�l
  GROUP BY ����
  HAVING COUNT(����) > 1;

SELECT �\_����.CD AS ���єԍ�,�d�b,�Z��,COUNT(�\_�����Ԏ��.CD) AS �o�^��,SUM(�Ŋz) AS �Ŋz���v
  FROM �\_�o�^ INNER JOIN �\_�l
       ON �\_�o�^.�lCD = �\_�l.CD
       INNER JOIN �\_�����Ԏ��
       ON �\_�o�^.���CD = �\_�����Ԏ��.CD
       INNER JOIN �\_����
       ON �\_�l.����CD = �\_����.CD
  GROUP BY ���єԍ�;
