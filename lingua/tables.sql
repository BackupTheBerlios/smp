DROP TABLE IF EXISTS lingua_languages;

CREATE TABLE lingua_languages (
	lang_id                     SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
	lang_name_id                INT(10)     UNSIGNED,
	system_lang  enum('0', '1') DEFAULT '0',
	PRIMARY KEY(lang_id)
);

INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('1', '1');
INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('2', '1');

DROP TABLE IF EXISTS lingua_dictionary;

CREATE TABLE lingua_dictionary (
	dict_id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	en	BLOB, 
	de	BLOB,
	fr	BLOB,
	PRIMARY KEY (dict_id)
);

INSERT INTO lingua_dictionary (en, de) VALUES ('german', 'deutsch');
INSERT INTO lingua_dictionary (en, de) VALUES ('english', 'englisch');
INSERT INTO lingua_dictionary (en, de) VALUES ('Username', 'Benutzername');
INSERT INTO lingua_dictionary (en, de) VALUES ('Password', 'Passwort');
INSERT INTO lingua_dictionary (en, de) VALUES ('Languages', 'Sprachen');
INSERT INTO lingua_dictionary (en, de) VALUES ('Change', 'Wechseln');
INSERT INTO lingua_dictionary (en, de) VALUES ('Login', 'Anmelden');
INSERT INTO lingua_dictionary (en, de) VALUES ('Points existence', 'Punkte vorhanden');
INSERT INTO lingua_dictionary (en, de) VALUES ('Points in work', 'Punkte in arbeit');
INSERT INTO lingua_dictionary (en, de) VALUES ('personal page', 'persöhnliche Seite');
INSERT INTO lingua_dictionary (en, de) VALUES ('Logout', 'Abmelden');
INSERT INTO lingua_dictionary (en, de) VALUES 
	('Wrong username or password.', 'Falscher Benutzername oder Passwort.');
INSERT INTO lingua_dictionary (en, de) VALUES ('Put in a text', 'Text rein stellen');
INSERT INTO lingua_dictionary (en, de) VALUES ('Category admin', 'Kategorien verwalten');

INSERT INTO lingua_dictionary (dict_id, de) VALUES (4001,'Geschichte, Politik');
INSERT INTO lingua_dictionary (de) VALUES ('Jura');
INSERT INTO lingua_dictionary (de) VALUES ('Naturwissenschaften');
INSERT INTO lingua_dictionary (de) VALUES ('Sport');
INSERT INTO lingua_dictionary (de) VALUES ('Technik');
INSERT INTO lingua_dictionary (de) VALUES ('Wirtschaftswissenschaften');
INSERT INTO lingua_dictionary (de) VALUES ('Diverses');
INSERT INTO lingua_dictionary (de) VALUES ('Ägyptologie');
INSERT INTO lingua_dictionary (de) VALUES ('Archäologie');
INSERT INTO lingua_dictionary (de) VALUES ('Kulturgeschichte');
INSERT INTO lingua_dictionary (de) VALUES ('Politikwissenschaft');
INSERT INTO lingua_dictionary (de) VALUES ('Sozialwissenschaften');
INSERT INTO lingua_dictionary (de) VALUES ('Theologie, Religion');
INSERT INTO lingua_dictionary (de) VALUES ('Völkerkunde');
INSERT INTO lingua_dictionary (de) VALUES ('Normen, Patente');
INSERT INTO lingua_dictionary (de) VALUES ('Rechtswissenschaft');
INSERT INTO lingua_dictionary (de) VALUES ('Physik');
INSERT INTO lingua_dictionary (de) VALUES ('Biologie');
INSERT INTO lingua_dictionary (de) VALUES ('Chemie');
INSERT INTO lingua_dictionary (de) VALUES ('Medizin');
INSERT INTO lingua_dictionary (de) VALUES ('Pharmazie');
INSERT INTO lingua_dictionary (de) VALUES ('Elektrotechnik');
INSERT INTO lingua_dictionary (de) VALUES ('Energietechnik');
INSERT INTO lingua_dictionary (de) VALUES ('Informatik und Datenverarbeitung');
INSERT INTO lingua_dictionary (de) VALUES ('Maschinenbau');
INSERT INTO lingua_dictionary (de) VALUES ('Mechanik');
INSERT INTO lingua_dictionary (de) VALUES ('Meß- und Regelungstechnik');
INSERT INTO lingua_dictionary (de) VALUES ('Nachrichtentechnik');
INSERT INTO lingua_dictionary (de) VALUES ('Verkehrswesen');
INSERT INTO lingua_dictionary (de) VALUES ('Vermessungswesen');
INSERT INTO lingua_dictionary (de) VALUES ('Hardware');
INSERT INTO lingua_dictionary (de) VALUES ('Software');

INSERT INTO lingua_dictionary (en, de) VALUES ('Logout', 'Abmelden');
INSERT INTO lingua_dictionary (en, de) VALUES 
	('Wrong username or password.', 'Falscher Benutzername oder Passwort.');
#
# user module
#
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1001', 'Personal Page', 'Pers&ouml;liche Seite');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1002', 'This is not a valid email address', 'Das ist keine korrekte email-Adresse');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1003', 'Username', 'Benutzername');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1004', 'First Name', 'Vorname');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1005', 'Last Name', 'Nachname');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1006', 'Email Address', 'Email-Adresse');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1007', 'Points', 'Punkte');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1008', 'Spoken Language', 'Beherrschte Sprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1009', 'Preferred Language on LINGUA', 'Bevorzugte Sprache in LINGUA');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1010', 'Add Language', 'Sprache hinzuf&uuml;gen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1011', 'Your personal description', 'Ihre pers&ouml;liche Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1012', 'Add description in new Language', 'Beschreibung in neuer Sprache hinzuf&uuml;gen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1013', 'Update!', '&Auml;ndern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1014', 'Mother tongue', 'Muttersprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1015', 'Fluent', 'Flie&szlig;end');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1016', 'Good', 'Gut');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1017', 'Mediocre', 'Mittelm&auml;&szlig;ig');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1018', 'Base Knowledge', 'Grundkenntnisse');

DROP TABLE IF EXISTS lingua_user;

CREATE TABLE lingua_user (
	user_id     INT(10)     UNSIGNED NOT NULL AUTO_INCREMENT,
	username    VARCHAR(10)          NOT NULL,
	password    VARCHAR(10)          NOT NULL,
	lastname    VARCHAR(50),
	firstname   VARCHAR(50),
	email       VARCHAR(200)         NOT NULL,
	reg_time    CHAR(10),
	last_login  CHAR(10),
	points      VARCHAR(10),
	status      ENUM('0','1','2')    DEFAULT '0',
	level       ENUM('0','1','2')    DEFAULT '0',
	system_lang SMALLINT(3) UNSIGNED DEFAULT '0',
	PRIMARY KEY(user_id),
	UNIQUE(username, email)
);

INSERT INTO lingua_user (username, password, lastname, firstname, email, reg_time,
			 status, level, system_lang) VALUES ('admin', 'test', 
			 'Test', 'Testie', 'test@test.de', '1007057807', '1', '2', '1');

DROP TABLE IF EXISTS lingua_user_desc;

CREATE TABLE lingua_user_desc (
	desc_id   SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id   INT(10)     UNSIGNED NOT NULL,
	lang_id   SMALLINT(3) UNSIGNED NOT NULL,
	desc_text BLOB                 NOT NULL,
	PRIMARY KEY(desc_id)
);

DROP TABLE IF EXISTS lingua_user_blocked;

CREATE TABLE lingua_user_blocked (
	user_id      INT(10)     UNSIGNED NOT NULL AUTO_INCREMENT,
	blocked_by   INT(10)     UNSIGNED NOT NULL,
	block_time   CHAR(10)             NOT NULL,
	block_reason BLOB,
	lang_id      SMALLINT(3) UNSIGNED NOT NULL,
	PRIMARY KEY(user_id)
);

DROP TABLE IF EXISTS lingua_user_lang;

CREATE TABLE lingua_user_lang (
	user_id INT(10)     UNSIGNED      NOT NULL,
	lang_id SMALLINT(3) UNSIGNED      NOT NULL,
	level   ENUM('0','1','2','3','4') NOT NULL,
);

INSERT INTO lingua_user_lang (user_id, lang_id, level) VALUES ('1', '1', '0');
INSERT INTO lingua_user_lang (user_id, lang_id, level) VALUES ('1', '2', '2');


DROP TABLE IF EXISTS lingua_categories;

CREATE TABLE lingua_categories (
	cat_id     INT(10) UNSIGNED NOT NULL               AUTO_INCREMENT,
	parent_id  INT(10) UNSIGNED           DEFAULT '0',
	lang_id    INT(10) UNSIGNED NOT NULL,
	cat_count  INT(10) UNSIGNED           DEFAULT '0',
	text_count INT(10) UNSIGNED           DEFAULT '0',
	PRIMARY KEY(cat_id)
);

# Categories level: 1.
INSERT INTO lingua_categories (lang_id, cat_count) VALUES ('4001', '7');
INSERT INTO lingua_categories (lang_id, cat_count) VALUES ('4002', '2');
INSERT INTO lingua_categories (lang_id, cat_count) VALUES ('4003', '5');
INSERT INTO lingua_categories (lang_id, cat_count) VALUES ('4004', '0');
INSERT INTO lingua_categories (lang_id, cat_count) VALUES ('4005', '9');
INSERT INTO lingua_categories (lang_id, cat_count) VALUES ('4006', '0');
INSERT INTO lingua_categories (lang_id, cat_count) VALUES ('4007', '0');

# Categories level: 2
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4008', '1');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4009', '1');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4010', '1');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4011', '1');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4012', '1');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4013', '1');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4014', '1');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4015', '2');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4016', '2');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4017', '3');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4018', '3');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4019', '3');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4020', '3');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4021', '3');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4022', '5');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4023', '5');
INSERT INTO lingua_categories (lang_id, parent_id, cat_count) VALUES ('4024', '5', '2');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4025', '5');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4026', '5');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4027', '5');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4028', '5');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4029', '5');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4030', '5');

# Categories level: 3
<<<<<<< tables.sql
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4031', '24');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('4032', '24');

=======
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('41', '24');
INSERT INTO lingua_categories (lang_id, parent_id) VALUES ('42', '24');

DROP TABLE IF EXISTS lingua_original_text;


CREATE TABLE lingua_original_text (
	original_id     INT(10) UNSIGNED NOT NULL               AUTO_INCREMENT,
	original_text   MEDIUMBLOB   DEFAULT '',
	num_words       INT(10) UNSIGNED DEFAULT '0',
	lang_id         INT(10) UNSIGNED NOT NULL,
	submit_time     TIMESTAMP,
	user_id         INT(10) UNSIGNED DEFAULT '0',
	category_id     INT(10) UNSIGNED DEFAULT '0',
	status          INT(10) UNSIGNED DEFAULT '0',
	avg_rating      DOUBLE,
	num_ratings     INT(10) UNSIGNED DEFAULT '0',
	PRIMARY KEY(original_id)
);



DROP TABLE IF EXISTS lingua_translation_text;

CREATE TABLE lingua_translation_text (
	trans_id        INT(10) UNSIGNED NOT NULL               AUTO_INCREMENT,
	trans_text      MEDIUMBLOB   DEFAULT '',
	num_words       INT(10) UNSIGNED DEFAULT '0',
	lang_id         INT(10) UNSIGNED NOT NULL,
	submit_time     TIMESTAMP,
	user_id         INT(10) UNSIGNED DEFAULT '0',
	category_id     INT(10) UNSIGNED DEFAULT '0',
	status          INT(10) UNSIGNED DEFAULT '0',
	original_id     INT(10) UNSIGNED DEFAULT '0',
	trans_base_id   INT(10) UNSIGNED DEFAULT '0',
	avg_rating      DOUBLE,
	num_ratings     INT(10) UNSIGNED DEFAULT '0',
	PRIMARY KEY(trans_id)
);


DROP TABLE IF EXISTS lingua_text_description;

CREATE TABLE lingua_text_description (
	desc_id         INT(10) UNSIGNED NOT NULL               AUTO_INCREMENT,
	desc_text       MEDIUMBLOB   DEFAULT '',
	lang_id         INT(10) UNSIGNED NOT NULL,
	text_id         INT(10) UNSIGNED DEFAULT '0',
	user_id         INT(10) UNSIGNED DEFAULT '0',
	submit_time     TIMESTAMP,
	PRIMARY KEY(desc_id)
);

DROP TABLE IF EXISTS lingua_text_header;

CREATE TABLE lingua_text_header (
	header_id       INT(10) UNSIGNED NOT NULL               AUTO_INCREMENT,
	header_text     MEDIUMBLOB   DEFAULT '',
	lang_id         INT(10) UNSIGNED NOT NULL,
	text_id         INT(10) UNSIGNED DEFAULT '0',
	user_id         INT(10) UNSIGNED DEFAULT '0',
	submit_time     TIMESTAMP,
	PRIMARY KEY(header_id)
);
>>>>>>> 1.3
