#DATA MODEL IS COMPRISED OF: PRODUCT, TICKET & PAYMENT DATA MODELS

#CREATING PRODUCT DATA MODEL

CREATE TABLE PRODUCT(
   PRODUCT_ID BIGINT NOT NULL,
   TYPE_ID BIGINT NOT NULL,
   SIZE_CODE CHAR(2),
   COLOR_CODE CHAR (6),
   PRODUCT_NAME VARCHAR(40) NOT NULL,
   BRAND_ID BIGINT NOT NULL, 
   GENDER_ID BIGINT NOT NULL,
   DESCRIPTION VARCHAR(100) NOT NULL,
   PRIMARY KEY (PRODUCT_ID)
);

CREATE TABLE BRAND(
   BRAND_ID BIGINT NOT NULL,
   BRAND_NAME VARCHAR(40) NOT NULL,
   EMAIL VARCHAR(40),
   PRIMARY KEY (BRAND_ID)
);

CREATE TABLE COLOR(
   COLOR_CODE CHAR(6) NOT NULL,
   COLOR_NAME VARCHAR(20) NOT NULL,
   PRIMARY KEY (COLOR_CODE)
);

CREATE TABLE CATEGORY(
   CATEGORY_ID BIGINT NOT NULL,
   CATEGORY_NAME VARCHAR(40) NOT NULL,
   PRIMARY KEY (CATEGORY_ID)
);

CREATE TABLE SIZE(
   SIZE_CODE CHAR(2) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (SIZE_CODE)
);

CREATE TABLE TYPE(
   TYPE_ID BIGINT NOT NULL,
   TYPE_NAME VARCHAR(40) NOT NULL,
   CATEGORY_ID BIGINT,
   PRIMARY KEY (TYPE_ID)
);

CREATE TABLE GENDER(
   GENDER_ID BIGINT NOT NULL,
   GENDER_NAME VARCHAR(40) NOT NULL,
   PRIMARY KEY (GENDER_ID)
);

#CREATING TICKET DATA MODEL

CREATE TABLE TICKET_ITEM(
   TICKET_ID BIGINT NOT NULL,
   NUMSEQ SMALLINT NOT NULL,
   PRODUCT_ID BIGINT NOT NULL,
   QUANTITY SMALLINT NOT NULL,
   PRICE DECIMAL(20,5) NOT NULL,
   TAX_AMOUNT DECIMAL(20,5) NOT NULL,
   PRODUCT_AMOUNT DECIMAL(20,5) NOT NULL,
   PRIMARY KEY (TICKET_ID, NUMSEQ)
);

CREATE TABLE TICKET(
   TICKET_ID BIGINT NOT NULL AUTO_INCREMENT,
   TIMEPLACED TIMESTAMP NOT NULL,
   EMPLOYEE_ID INTEGER NOT NULL,
   CUSTOMER_ID INTEGER NOT NULL,
   TOTAL_PRODUCT DECIMAL(20,5) NOT NULL,
   TOTAL_TAX DECIMAL(20,5) NOT NULL,
   TOTAL_ORDER DECIMAL(20,5) NOT NULL,
   CCPAYMENT_ID BIGINT NOT NULL,
   PRIMARY KEY (TICKET_ID)
);

CREATE TABLE EMPLOYEE(
   EMPLOYEE_ID INT NOT NULL,
   FIRSTNAME VARCHAR(40) NOT NULL,
   LASTNAME VARCHAR(40) NOT NULL,
   DOB DATE,
   EMAIL VARCHAR(40),
   PHONENO VARCHAR(20),
   PRIMARY KEY (EMPLOYEE_ID)
);

CREATE TABLE CUSTOMER(
   CUSTOMER_ID INT NOT NULL,
   FIRSTNAME VARCHAR(40) NOT NULL,
   LASTNAME VARCHAR(40) NOT NULL,
   DOB DATE,
   EMAIL VARCHAR(40),
   PHONENO VARCHAR(20),
   PRIMARY KEY (CUSTOMER_ID)
);

#CREATING PAYMENT DATA MODEL

CREATE TABLE CCPAYMENT (
   CCPAYMENT_ID BIGINT NOT NULL AUTO_INCREMENT,
   CCPAYTRAN_ID BIGINT,
   EXPECTED_AMOUNT DECIMAL(20,5) NOT NULL,
   APPROVING_AMOUNT	DECIMAL(20,5),
   APPROVED_AMOUNT DECIMAL(20,5),
   CCPAYMENT_STATE CHAR(1) NOT NULL,
   TIMECREATED TIMESTAMP NOT NULL,
   TIMEUPDATED TIMESTAMP,
   TIMEEXPIRED TIMESTAMP,
   PRIMARY KEY (CCPAYMENT_ID)
);

CREATE TABLE CCPAYMENT_CARD (
   CCPAYMENT_ID BIGINT NOT NULL,
   PAYMENT_TYPE CHAR(2) NOT NULL,
   IS_ENCRYPT CHAR(1) NOT NULL,
   CARD_NUMBER VARCHAR(64) NOT NULL,
   BANKNAME VARCHAR(64) NOT NULL,
   CCEXPDATE CHAR(6) NOT NULL,
   CCENTRY_METHOD VARCHAR(20) NOT NULL,
   PRIMARY KEY (CCPAYMENT_ID)
);

CREATE TABLE CCPAYMENT_TYPE (
   CCTYPE CHAR(2) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (CCTYPE)
);

CREATE TABLE CCPAYMENT_STATE (
   CCSTATE CHAR(1) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (CCSTATE)
);

CREATE TABLE CCENTRY_METHOD (
   CCMETHOD CHAR(1) NOT NULL,
   DESCRIPTION VARCHAR(40) NOT NULL,
   PRIMARY KEY (CCMETHOD)
);

#CREATING RELAITONSHIPS BETWEEN TABLES

#ALTERING PRODUCT TABLE
ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (TYPE_ID) REFERENCES TYPE(TYPE_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (COLOR_CODE) REFERENCES COLOR(COLOR_CODE)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (GENDER_ID) REFERENCES GENDER(GENDER_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (SIZE_CODE) REFERENCES SIZE(SIZE_CODE)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
ALTER TABLE PRODUCT 
   ADD FOREIGN KEY (BRAND_ID) REFERENCES BRAND(BRAND_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
#ALTERING TYPE TABLE
ALTER TABLE TYPE 
   ADD FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
#ALTER TICKET_ITEM TABLE
ALTER TABLE TICKET_ITEM 
   ADD FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE TICKET_ITEM 
   ADD FOREIGN KEY (TICKET_ID) REFERENCES TICKET(TICKET_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
#ALTER TICKET TABLE
ALTER TABLE TICKET
   ADD FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE TICKET
   ADD FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE TICKET
   ADD FOREIGN KEY (CCPAYMENT_ID) REFERENCES CCPAYMENT(CCPAYMENT_ID)
   ON UPDATE CASCADE ON DELETE RESTRICT;
   
#ALTER CCPAYMENT TABLE
ALTER TABLE CCPAYMENT 
   ADD FOREIGN KEY (CCPAYMENT_STATE)
   REFERENCES CCPAYMENT_STATE (CCSTATE);
   
#ALTER CCPAYMENT_CARD TABLE
ALTER TABLE CCPAYMENT_CARD 
   ADD FOREIGN KEY (CCENTRY_METHOD)
   REFERENCES CCENTRY_METHOD (CCMETHOD);

ALTER TABLE CCPAYMENT_CARD 
   ADD FOREIGN KEY (PAYMENT_TYPE)
   REFERENCES CCPAYMENT_TYPE (CCTYPE);
   
ALTER TABLE CCPAYMENT_CARD 
   ADD FOREIGN KEY (CCPAYMENT_ID)
   REFERENCES CCPAYMENT (CCPAYMENT_ID);

#INSERTING DATA INTO MODEL
INSERT INTO CATEGORY VALUES
(67010300,'Lower Body Wear/Bottoms'),
(67010800,'Upper Body Wear/Tops');

INSERT INTO TYPE VALUES
(100001350,'Jackets/Blazers/Cardigans/Waistcoats',67010800),
(10001352,'Shirts/Blouses/Polo Shirts/T-shirts',67010800),
(10001353,'Sweaters/Pullovers',67010800),
(10001334,'Skirts',67010300),
(10001335,'Trousers/Shorts',67010300);

INSERT INTO BRAND VALUES 
(86010100,'GAP','contact@gap.com'),
(86010200,'American Eagle','contact@ae.com'),
(86010300,'HM','contact@hm.com'),
(86010400,'ZARA','contact@zara.com'),
(86010500,'Calvin Klein','contact@ck.com'),
(86010600,'Vera Moda','contact@vm.com'),
(86010700,"Levi's",'contact@levis.com'),
(86010800,'Gant','contact@gant.com'),
(86010900,'Nautica','contact@nautica.com');

INSERT INTO SIZE VALUES
('S','Small'),
('M','Medium'),
('L','Large');

INSERT INTO GENDER VALUES 
(30003891,'FEMALE'),
(30004039,'MALE'),
(30004340,'UNISEX');

INSERT INTO COLOR VALUES 
('ffcccc','Pink'),
('ff0000','Red'),
('000000','Black'),
('ffffff','White'),
('0000b3','Blue'),
('ffff00','Yellow'),
('009933','Green'),
('ff6600','Orange');

INSERT INTO EMPLOYEE VALUES 
(1,'Carlos','Lopez','1992-01-01','c.lopez@store.com','34615824328'),
(2,'Maria','Salim','1989-03-29','m.salim@store.com','34670561337'),
(3,'Sami','Omari','1970-02-23','s.omari@store.com','34655870193'),
(4,'Pablo','Reberto','1982-11-17','p.reberto@store.com','34697557362'),
(5,'Alex','Smith','1991-09-07','a.smith@store.com',34670881472);

INSERT INTO CUSTOMER VALUES 
(1,'Emilia','Kenny','1995-05-02','e.kenny@gmail.com','34615824324'),
(2,'Ivanna','Ovens','1982-05-19','ivanna.o@hotmail.com','34673561237'),
(3,'Mariana','Rea','1979-01-11','m.rea79@gmail.com','34653870093'),
(4,'Anthony','Ekerot','1983-10-17','a.ekerot@hotmail.com','34692357092'),
(5,'Dylan','Moncure','1992-07-20','dylan.moncure@gmail.com',34648631472);

INSERT INTO CCPAYMENT_STATE VALUES
('0', 'new'),
('1', 'approving'),
('2', 'approved'),
('3', 'failed'),
('4', 'canceled'),
('5', 'expired');

INSERT INTO CCENTRY_METHOD VALUES
('0', 'Swiping'),
('1', 'Dipping'),
('2', 'Contactless');

INSERT INTO CCPAYMENT_TYPE VALUES
('MC', 'MasterCard'),
('VS', 'Visa'),
('AM', 'American Express'),
('BK', 'Other bank card');

INSERT INTO  PRODUCT VALUES 
(645158, 10001335,'S','ffcccc','Trousers',86010100,30003891,'Beautiful Trousers'),
(202412,100001350,'M','ff0000','Cardigan',86010200,30004039,'Beautiful Cardigans'),
(9850,100001350,'L','000000','Waistcoat',86010500,30003891,'Made with love'),
(656897,100001350,'L','ffffff','Jacket',86010500,30004039,'sustainable'),
(432766,10001334,'M','0000b3','Skirt',86010600,30004340,'Made with love'),
(739557,100001350,'L','ffcccc','Blazer',86010700,30004340,'sustainable'),
(755767,10001353,'L','ff0000','Sweater',86010100,30003891,'sustainable'),
(226664,10001335,'S','0000b3','Trousers',86010800,30004340,'sustainable'),
(440491,100001350,'L','ffffff','Jacket',86010200,30004039,'Hand made'),
(979687,10001352,'L','ffcccc','T-shirt',86010800,30003891,'Hand made'),
(181304,10001353,'L','ff0000','Sweater',86010900,30003891,'Made with love'),
(335234,10001352,'M','ffff00','T-shirt',86010900,30003891,'Made with love'),
(958854,10001335,'L','009933','Trousers',86010100,30003891,'sustainable'),
(35987,10001352,'L','ff6600','T-shirt',86010500,30003891,'sustainable'),
(908915,10001352,'M','ff6600','Blouse',86010600,30004039,'Hand made'),
(749703,100001350,'S','ff0000','Jacket',86010200,30004039,'Hand made'),
(8500,10001334,'L','ffff00','Skirt',86010700,30004039,'Made with love'),
(958254,10001335,'S','ff6600','Shorts',86010800,30003891,'Made with love'),
(2039,10001335,'M','009933','Trousers',86010900,30003891,'sustainable'),
(459184,10001352,'M','000000','Blouse',86010900,30004340,'sustainable'),
(260403,10001334,'M','ff0000','Skirt',86010500,30003891,'sustainable');

INSERT INTO CCPAYMENT VALUES
(146844777230, 748810042110, 163.56, 163.56, 163.56, 2, '2022-01-09 11:00:18', '2022-01-09 11:01:21', '2022-01-09 11:03:21'),
(72857319254, 670510789132, 87.058, 87.058, 87.058, 2, '2022-04-02 17:01:15', '2022-04-02 17:01:45', '2022-04-02 17:02:55'),
(367547658124, 350502963347, 269.004, 269.004, 269.004, 2, '2022-05-22 14:02:34', '2022-05-22 14:03:31', '2022-05-22 14:05:11'),
(8305929187, 330749321073, 1782.3168, 1782.3168, 1782.3168, 2, '2022-03-18 15:03:23', '2022-03-18 15:03:59', '2022-03-18 15:05:15'),
(86106526762, 154900366708, 185.6, 185.6, 185.6, 2, '2022-09-02 13:04:24', '2022-09-02 13:04:54', '2022-09-02 13:07:04'),
(431217944350, 862357391456, 435, 435, 435, 2, '2022-01-11 12:05:25', '2022-01-11 12:06:10', '2022-01-11 12:06:10'),
(182243448139, 455469124028, 504.6, 504.6, 504.6, 2, '2022-07-12 10:15:27', '2022-07-12 10:16:37', '2022-07-12 10:18:17'),
(84849632857, 525734851076, 104.3884, 104.3884, 104.3884, 2, '2022-03-08 13:25:58', '2022-03-08 13:27:18', '2022-03-08 13:29:18'),
(315302452748, 334261020925, 737.76, 737.76, 737.76, 2, '2022-04-10 11:26:54', '2022-04-10 11:28:12', '2022-04-10 11:30:22'),
(24420215195, 213095869570, 556.8, 556.8, 556.8, 2, '2022-02-15 10:27:46', '2022-02-15 10:29:26', '2022-02-15 10:32:26'),
(23671563807, 127187561115, 154.28, 154.28, 154.28, 2, '2022-01-27 12:30:49', '2022-01-27 12:32:21', '2022-01-27 12:33:11'),
(438969340853, 798802892200, 324.8, 324.8, 324.8, 2, '2022-01-16 11:32:45', '2022-01-16 11:33:45', '2022-01-16 11:35:25'),
(16837199743, 277654323148, 662.36, 662.36, 662.36, 2, '2022-05-20 10:33:32', '2022-05-20 10:34:31', '2022-05-20 10:36:21'),
(385553270550, 253759462170, 1033.5252, 1033.5252, 1033.5252, 2, '2022-01-06 15:37:34', '2022-01-06 15:37:55', '2022-01-06 15:39:13'),
(272217526993, 843678545557, 81.78, 81.78, 81.78, 2, '2022-05-09 17:45:35', '2022-05-09 17:46:12', '2022-05-09 17:48:32'),
(56193830205, 528034220251, 87.058, 87.058, 87.058, 2, '2022-03-01 17:58:46', '2022-03-01 17:59:46', '2022-03-01 18:01:26'),
(89816679233, 995912964004, 134.502, 134.502, 134.502, 2, '2022-07-24 14:21:31', '2022-07-24 14:22:21', '2022-07-24 14:23:51'),
(184400307427, 477785386104, 115.9884, 115.9884, 115.9884, 2, '2022-05-13 16:04:12', '2022-05-13 16:05:16', '2022-05-13 16:07:46'),
(30601529446, 789872294047, 199.288, 199.288, 199.288, 2, '2022-06-04 11:05:20', '2022-06-04 11:05:57', '2022-06-04 11:07:17'),
(368847419483, 827266494167, 827266494167, 827266494167, 827266494167, 2, '2022-02-05 13:00:03', '2022-02-05 13:01:23', '2022-02-05 13:02:53'),
(247939218073, 774539706657, 302.064, 302.064, 302.064, 2, '2022-07-23 16:01:04', '2022-07-23 16:02:04', '2022-07-23 16:03:54'),
(451307014518, 114724954416, 603.316, 603.316, 603.316, 2, '2022-08-22 10:02:06', '2022-08-22 10:02:43', '2022-08-22 10:03:23'),
(326874418172, 604892328351, 145, 145, 145, 2, '2022-07-25 12:03:02', '2022-07-25 12:04:12', '2022-07-25 12:06:32'),
(83903386428, 922938878431, 504.6, 504.6, 504.6, 2, '2022-09-21 16:04:06', '2022-09-21 16:05:16', '2022-09-21 16:07:46'),
(342706237599, 107066899681, 104.3884, 104.3884, 104.3884, 2, '2022-09-19 15:05:55', '2022-09-19 15:07:15', '2022-09-19 15:08:45'),
(277212338225, 309745923550, 184.44, 184.44, 184.44, 2, '2022-03-17 14:15:49', '2022-03-17 14:16:49', '2022-03-17 14:18:49'),
(290299154239, 89938730604, 185.6, 185.6, 185.6, 2, '2022-04-28 15:25:45', '2022-04-28 15:26:25', '2022-04-28 15:27:55'),
(250984580036, 910135446758, 308.56, 308.56, 308.56, 2, '2022-01-26 12:26:32', '2022-01-26 12:27:34', '2022-01-26 12:28:54'),
(178691081716, 681644541144, 487.2, 487.2, 487.2, 2, '2022-06-14 12:27:34', '2022-06-14 12:28:54', '2022-06-14 12:30:02'),
(348987895716, 422955200736, 561.44, 561.44, 561.44, 2, '2022-05-06 17:30:35', '2022-05-06 17:32:35', '2022-05-06 17:34:31'),
(424522890979, 853958799667, 174, 174, 174, 2, '2022-07-08 14:32:46', '2022-07-08 14:34:16', '2022-07-08 14:35:26'),
(109588876497, 584420088118, 894.3368, 894.3368, 894.3368, 2, '2022-08-01 13:33:31', '2022-08-01 13:34:33', '2022-08-01 13:36:13'),
(463093417760, 987277450018, 371.2, 371.2, 371.2, 2, '2022-09-12 16:37:12', '2022-09-12 16:38:32', '2022-09-12 16:39:52'),
(355501500143, 638478414809, 145, 145, 145, 2, '2022-03-04 10:45:02', '2022-03-04 10:46:12', '2022-03-04 10:47:42'),
(360745157781, 883163958825, 996.4284, 996.4284, 996.4284, 2, '2022-01-07 13:58:30', '2022-01-07 13:59:30', '2022-01-07 14:02:10'),
(126199252772, 988370301243, 597.4, 597.4, 597.4, 2, '2022-04-03 11:21:04', '2022-04-03 11:22:54', '2022-04-03 11:24:24');

INSERT INTO CCPAYMENT_CARD VALUES
(355501500143, 'AM', 'N', 372774671064608, 'Abanca', 26-06-01, 2),
(178691081716, 'AM', 'Y', 344640226961991, 'Caixabank', 28-04-01, 2),
(72857319254, 'VS', 'Y', 4532609192410055, 'Bankinter', 26-09-01, 1),
(247939218073, 'MC', 'N', 5513366760288401, 'Abanca', 24-06-01, 2),
(277212338225, 'BK', 'N', 6011394717375464, 'Santander', 26-05-01, 1),
(431217944350, 'AM', 'N', 342984992552465, 'BBVA', 27-04-01, 0),
(250984580036, 'AM', 'Y', 345957680469660, 'BBVA', 27-03-01, 2),
(290299154239, 'VS', 'Y', 4532946401669307, 'Bankinter', 26-05-01, 2),
(385553270550, 'MC', 'Y', 5339887826540628, 'Santander', 23-04-01, 1),
(89816679233, 'BK', 'N', 6011897603860936, 'Santander', 25-05-01, 2),
(424522890979, 'MC', 'Y', 5384629164619133, 'Bankinter', 28-08-01, 2),
(146844777230, 'MC', 'Y', 5330979738242572, 'Santander', 22-04-01, 2),
(24420215195, 'VS', 'N', 4485200478971866, 'Abanca', 24-04-01, 0),
(184400307427, 'VS', 'N', 4539189830503812, 'Caixabank', 26-04-01, 0),
(182243448139, 'BK', 'N', 6011426006404439, 'Santander', 23-07-01, 2),
(342706237599, 'BK', 'N', 6011000191497688, 'Bankinter', 24-04-01, 2),
(16837199743, 'MC', 'Y', 5500380688224633, 'Caixabank', 23-03-01, 2),
(126199252772, 'AM', 'Y', 375357965579338, 'BBVA', 24-07-01, 2),
(368847419483, 'BK', 'N', 6011383467257394, 'Santander', 25-04-01, 2),
(438969340853, 'BK', 'N', 6011400826372472, 'Bankinter', 23-07-01, 1),
(30601529446, 'AM', 'Y', 349887415651991, 'BBVA', 27-03-01, 0),
(315302452748, 'VS', 'Y', 4916779413088968, 'Caixabank', 24-05-01, 2),
(23671563807, 'VS', 'Y', 4539110207988444, 'Santander', 25-03-01, 0),
(109588876497, 'VS', 'N', 4485314468975389, 'Santander', 27-05-01, 1),
(348987895716, 'BK', 'Y', 6011869361865456, 'Bankinter', 27-05-01, 2),
(360745157781, 'AM', 'Y', 373784974906065, 'BBVA', 24-09-01, 1),
(451307014518, 'VS', 'N', 4532967395023152, 'Santander', 24-06-01, 2),
(326874418172, 'MC', 'N', 5578296537154556, 'Bankinter', 27-07-01, 2),
(83903386428, 'BK', 'Y', 6011074817724437, 'Abanca', 25-06-01, 2),
(86106526762, 'AM', 'Y', 348075118577678, 'Bankinter', 27-02-01, 2),
(463093417760, 'VS', 'Y', 4556870133856183, 'Santander', 28-04-01, 2),
(272217526993, 'BK', 'Y', 6011048379905212, 'Caixabank', 26-08-01, 0),
(84849632857, 'MC', 'N', 5497128554475093, 'Santander', 23-02-01, 0),
(56193830205, 'BK', 'Y', 6011908151370416, 'Santander', 27-06-01, 0),
(8305929187, 'AM', 'Y', 344491990131977, 'Santander', 25-03-01, 2),
(367547658124, 'VS', 'Y', 4243327127791313, 'Bankinter', 26-07-01, 0);

INSERT INTO TICKET VALUES
(36701285, '2022-01-9 11:00:18', 3, 1, 4, 22.56, 163.56, 355501500143),
(48937606, '2022-04-02 17:01:15', 3, 2, 3, 12.008, 87.058, 178691081716),
(53957703, '2022-05-22 14:02:34', 4, 3, 1, 37.104, 269.004, 72857319254),
(56714845, '2022-03-18 15:03:23', 2, 1, 9, 245.8368, 1782.3168, 247939218073),
(60188437, '2022-09-02 13:04:24', 5, 2, 1, 25.6, 185.6, 277212338225),
(67620743, '2022-01-11 12:05:25', 5, 3, 2, 60, 435, 431217944350),
(84048495, '2022-07-12 10:15:27', 2, 1, 3, 69.6, 504.6, 250984580036),
(102459992, '2022-03-08 13:25:58', 3, 2, 1, 14.3984, 104.3884, 290299154239),
(120080542, '2022-04-10 11:26:54', 1, 3, 1, 101.76, 737.76, 385553270550),
(147515781, '2022-02-15 10:27:46', 1, 2, 1, 76.8, 556.8, 89816679233),
(156508130, '2022-01-27 12:30:49', 1, 5, 2, 21.28, 154.28, 424522890979),
(159687857, '2022-01-16 11:32:45', 2, 2, 2, 44.8, 324.8, 146844777230),
(162158408, '2022-05-20 10:33:32', 2, 2, 4, 91.36, 662.36, 24420215195),
(205520764, '2022-01-06 15:37:34', 4, 5, 3, 142.5552, 1033.5252, 184400307427),
(219973888, '2022-05-09 17:45:35', 5, 2, 2, 11.28, 81.78, 182243448139),
(224410475, '2022-03-01 17:58:46', 2, 5, 6, 12.008, 87.058, 342706237599),
(238204511, '2022-07-24 14:21:31', 5, 5, 2, 18.552, 134.502, 16837199743),
(255660742, '2022-05-13 16:04:12', 3, 5, 1, 15.9984, 115.9884, 126199252772),
(262984448, '2022-06-04 11:05:20', 1, 4, 3, 27.488, 199.288, 368847419483),
(263890764, '2022-02-05 13:00:03', 4, 4, 2, 72.16, 1033.5252, 438969340853),
(264933961, '2022-07-23 16:01:04', 1, 1, 3, 41.664, 302.064, 30601529446),
(270540857, '2022-08-22 10:02:06', 3, 2, 2, 83.216, 603.316, 315302452748),
(272388740, '2022-07-25 12:03:02', 2, 1, 1, 20, 145, 23671563807),
(283859458, '2022-09-21 16:04:06', 1, 2, 1, 69.6, 504.6, 109588876497),
(287933691, '2022-09-19 15:05:55', 4, 1, 1, 14.3984, 104.3884, 348987895716),
(288009088, '2022-03-17 14:15:49', 2, 5, 3, 25.44, 184.44, 360745157781),
(301839262, '2022-04-28 15:25:45', 2, 1, 4, 25.6, 185.6, 451307014518),
(317433510, '2022-01-26 12:26:32', 5, 1, 2, 42.56, 308.56, 326874418172),
(404910302, '2022-06-14 12:27:34', 1, 3, 3, 67.2, 487.2, 83903386428),
(407459794, '2022-05-06 17:30:35', 3, 2, 2, 77.44, 561.44, 86106526762),
(407744780, '2022-07-08 14:32:46', 2, 3, 1, 24, 174, 463093417760),
(412367561, '2022-08-01 13:33:31', 5, 4, 1, 123.3568, 894.3368, 272217526993),
(421843710, '2022-09-12 16:37:12', 2, 4, 2, 51.2, 371.2, 84849632857),
(458286378, '2022-03-04 10:45:02', 2, 3, 3, 20, 145, 56193830205),
(489537837, '2022-01-07 13:58:30', 3, 2, 2, 137.4384, 996.4284, 8305929187),
(491842836, '2022-04-03 11:21:04', 1, 3, 1, 82.4, 597.4, 367547658124);

INSERT INTO TICKET_ITEM VALUES
(36701285,1,645158,2,70.5,11.28,141),
(48937606,2,202412,1,75.05,12.008,75.05),
(53957703,3,9850,2,115.95,18.552,231.9),
(56714845,4,656897,1,99.99,15.9984,99.99),
(56714845,5,432766,1,85.9,13.744,85.9),
(56714845,6,2039,2,150,24,300),
(56714845,7,459184,1,119.99,19.1984,119.99),
(56714845,8,226664,1,130.2,20.832,130.2),
(56714845,9,440491,4,200.1,32.016,800.4),
(60188437,10,979687,1,160,25.6,160),
(67620743,11,181304,3,125,20,375),
(84048495,12,335234,3,145,23.2,435),
(102459992,13,958854,1,89.99,14.3984,89.99),
(120080542,14,35987,4,159,25.44,636),
(147515781,15,908915,3,160,25.6,480),
(156508130,16,749703,1,133,21.28,133),
(159687857,17,8500,2,140,22.4,280),
(162158408,18,958254,1,121,19.36,121),
(162158408,19,2039,3,150,24,450),
(205520764,20,459184,3,119.99,19.1984,359.97),
(205520764,21,260403,3,177,28.32,531),
(219973888,22,645158,1,70.5,11.28,70.5),
(224410475,23,202412,1,75.05,12.008,75.05),
(238204511,24,9850,1,115.95,18.552,115.95),
(255660742,25,656897,1,99.99,15.9984,99.99),
(262984448,26,432766,2,85.9,13.744,171.8),
(263890764,27,739557,1,230,36.8,230),
(263890764,28,755767,1,221,35.36,221),
(264933961,29,226664,2,130.2,20.832,260.4),
(270540857,30,440491,1,200.1,32.016,200.1),
(270540857,31,979687,2,160,25.6,320),
(272388740,32,181304,1,125,20,125),
(283859458,33,335234,3,145,23.2,435),
(287933691,34,958854,1,89.99,14.3984,89.99),
(288009088,35,35987,1,159,25.44,159),
(301839262,36,908915,1,160,25.6,160),
(317433510,37,749703,2,133,21.28,266),
(404910302,38,8500,3,140,22.4,420),
(407459794,39,958254,4,121,19.36,484),
(407744780,40,2039,1,150,24,150),
(412367561,41,459184,2,119.99,19.1984,239.98),
(412367561,42,260403,3,177,28.32,531),
(421843710,43,979687,2,160,25.6,320),
(458286378,44,181304,1,125,20,125),
(489537837,45,335234,2,145,23.2,290),
(489537837,46,958854,1,89.99,14.3984,89.99),
(489537837,47,35987,1,159,25.44,159),
(489537837,48,908915,2,160,25.6,320),
(491842836,49,749703,1,133,21.28,133),
(491842836,50,8500,1,140,22.4,140),
(491842836,51,958254,2,121,19.36,242);

#USING MODEL TO ANSWER BUSINESS QUESTIONS

#Q1 - Which are the top 3 colors sold last season (summer 2022)?
SELECT A.COLOR_NAME COLOR, COUNT(A.COLOR_NAME) NUMBER_ITEMS_SOLD
FROM COLOR A 
JOIN PRODUCT B ON (A.COLOR_CODE = B.COLOR_CODE)
JOIN TICKET_ITEM C ON (B.PRODUCT_ID = C.PRODUCT_ID)
JOIN TICKET D ON (C.TICKET_ID = D.TICKET_ID)
WHERE DATE(D.TIMEPLACED) BETWEEN '2022-06-21' AND '2022-09-23'
GROUP BY A.COLOR_NAME
ORDER BY 2 DESC
LIMIT 3;

#Q2 - Show the amount spent per credit card type.
SELECT A.DESCRIPTION CREDIT_CARD_TYPE, ROUND(SUM(D.TOTAL_ORDER),2) AMOUNT_SPENT
FROM CCPAYMENT_TYPE A
JOIN CCPAYMENT_CARD B ON (A.CCTYPE = B.PAYMENT_TYPE)
JOIN CCPAYMENT C ON (B.CCPAYMENT_ID = C.CCPAYMENT_ID)
JOIN TICKET D ON (C.CCPAYMENT_ID = D.CCPAYMENT_ID)
GROUP BY A.DESCRIPTION;

#Q3 - What is the average amount spent per type of clothes?
SELECT D.TYPE_NAME TYPE_OF_CLOTHES, ROUND(AVG(A.TOTAL_ORDER),2) AVG_AMOUNT_SPENT
FROM TICKET A 
JOIN TICKET_ITEM B ON (A.TICKET_ID = B.TICKET_ID)
JOIN PRODUCT C ON (B.PRODUCT_ID = C.PRODUCT_ID)
JOIN TYPE D ON (C.TYPE_ID = D.TYPE_ID)
GROUP BY D.TYPE_NAME;

#Q4 - Which brand results in the most profit?
SELECT A.BRAND_NAME, ROUND(SUM(C.PRODUCT_AMOUNT),2) PROFIT
FROM BRAND A
JOIN PRODUCT B ON (A.BRAND_ID = B.BRAND_ID)
JOIN TICKET_ITEM C ON (B.PRODUCT_ID = C.PRODUCT_ID)
GROUP BY A.BRAND_NAME
ORDER BY 2 DESC
LIMIT 1;

#Q5 - Which customer bought the largest number of female clothes? 
SELECT CONCAT(A.FIRSTNAME,' ',A.LASTNAME) CUSTOMER_NAME, SUM(C.QUANTITY) FEMALE_ITEMS_PURCHASED
FROM CUSTOMER A
JOIN TICKET B ON (A.CUSTOMER_ID = B.CUSTOMER_ID)
JOIN TICKET_ITEM C ON (B.TICKET_ID = C.TICKET_ID)
JOIN PRODUCT D ON (C.PRODUCT_ID = D.PRODUCT_ID)
JOIN GENDER E ON (D.GENDER_ID = E.GENDER_ID)
WHERE E.GENDER_NAME = 'FEMALE'
GROUP BY A.CUSTOMER_ID
ORDER BY 2 DESC
LIMIT 1;