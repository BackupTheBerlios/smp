DROP TABLE IF EXISTS lingua_languages;

CREATE TABLE lingua_languages (
        lang_id                     SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
        lang_name_id                INT(10)     UNSIGNED,
        system_lang  enum('0', '1') DEFAULT '0',
        PRIMARY KEY(lang_id)
);

INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('1','1');
INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('2','1');
INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('16','1');
INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('17','0');
INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('18','0');
INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('19','0');
INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('20','0');
INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('21','0');
INSERT INTO lingua_languages (lang_name_id, system_lang) VALUES ('22','0');


DROP TABLE IF EXISTS lingua_dictionary;

CREATE TABLE lingua_dictionary (
        dict_id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        en      TEXT,
        de      TEXT,
        fr      TEXT,
        PRIMARY KEY (dict_id)
);

INSERT INTO lingua_dictionary (en, de, fr) VALUES ('german', 'deutsch','allemand');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('english', 'englisch','anglais');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Username','Benutzername', 'Nom Utilisateur');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Password', 'Passwort','Mot de passe');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Languages','Sprachen', 'Langues');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Change', 'Wechseln','Changer');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Login', 'Anmelden','Entrer');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Points existence','Punkte vorhanden', 'Points existants');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Points in work','Punkte in arbeit', 'Points en travail');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('personal page','pers�nliche Seite', 'Page personnelle');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Logout', 'Abmelden','Sortir');
INSERT INTO lingua_dictionary (en, de, fr) VALUES 
	('Wrong username or password.', 'Falscher Benutzername oder Passwort.', 'Mot de passe ou Nom Utilisateur incorrect');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Put a text', 'Text rein stellen', 'Ecrire un Texte');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Category admin', 'Kategorien verwalten', 'Gestion de Categories');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Start', 'Start', 'Start');

INSERT INTO lingua_dictionary (en, de, fr) VALUES ('french', 'franz�sich', 'francais');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('swahili', 'swahili', 'swahili' );
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('lingala', 'lingala', 'lingala' );
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('arabisch', 'arabisch', 'arabe' );
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('neederland', 'holland', 'hollandais');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('spain','spanisch', 'espagnol');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('polnich','polnich', 'polonais');

INSERT INTO lingua_dictionary (en, de) VALUES ('Register here', 'Hier Registrieren');

INSERT INTO lingua_dictionary (en, de) VALUES ('Title', '�berschrift');
INSERT INTO lingua_dictionary (en, de) VALUES ('Description', 'Beschreibung');
INSERT INTO lingua_dictionary (en, de) VALUES ('Languages', 'Sprachen');
INSERT INTO lingua_dictionary (en, de) VALUES ('Amount of intresting', 'Interessengrad');

INSERT INTO lingua_dictionary (dict_id, de, fr) VALUES (4001,'Geschichte, Politik', 'Histoire et Politique');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Jura', 'Droit');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Naturwissenschaften', 'Sciences Naturelles');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Sport', 'Sport');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Technik', 'Technique');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Wirtschaftswissenschaften', 'Sciences economiques');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Diverses', 'Divers');
INSERT INTO lingua_dictionary (de, fr) VALUES ('�gyptologie', 'Egyptoligie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Arch�ologie', 'Archeologie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Kulturgeschichte', 'Histoires Culturelles');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Politikwissenschaft', 'Sciences Politiques');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Sozialwissenschaften', 'Sciences Sociales');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Theologie, Religion', 'Theologie, Religion');
INSERT INTO lingua_dictionary (de, fr) VALUES ('V�lkerkunde', 'Ethnologie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Normen, Patente', 'Standardisation, Brevet');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Rechtswissenschaft', 'Sciences du Droit');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Physik', 'Physique');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Biologie', 'Biologie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Chemie', 'Chimie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Medizin', 'Medecine');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Pharmazie', 'Pharmacie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Elektrotechnik', 'Electrotechnique');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Energietechnik', 'Technique energetique');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Informatik und Datenverarbeitung', 'Informatique et Traitement de Donnees');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Maschinenbau','Construction Mecanique');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Mechanik', 'Mecanique');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Me�- und Regelungstechnik', 'Technique de Reglementation et de Mesure');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Nachrichtentechnik', 'Technique de la Communication');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Verkehrswesen', 'Transport, Circulation');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Vermessungswesen', 'Mensuration, Topographie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Hardware', 'Hardware');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Software', 'Software');

### home module
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6000', 'New', 'Neu');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6001', 'Change', '�ndern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6002', 'Delete', 'L�schen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6003', 'Lock', 'Sperren');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6004', 'Unlock', 'Freigeben');

### text module (new & change)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7000', 'Category', 'Kategorie');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7001', 'Back', 'Zur�ck');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7002', 'Title', 'Titel');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7003', 'Description', 'Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7004', 'Content', 'Inhalt');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7005', 'Save', 'Speichern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7006', 'Upload', 'Hochladen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7007', 
                                                        'Please enter a title.', 
                                                        'Bitte geben Sie einen Titel an.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7008',
                                                        'Please enter a description.',
                                                        'Bitte geben Sie eine Beschreibung ein.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7009',
                                                        'Please enter a text or upload one.',
                                                        'Bitte geben Sie einen Text ein oder laden einen hoch.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7010',
                                                        'Please check your input.',
                                                        'Bitte �berpr�fen Sie ihre Eingaben.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7011',
                                                        'You have not enough Points for this text:',
                                                        'Ihnen fehlen noch Punkte f�r diesen Text:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7012', 'Source language', 'Quellsprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7017', 'Destiny language', 'Zielsprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7018',
                                                        'Source language and destiny languagemay not be the same.',
                                                        'Quellsprache und Zielsprache d�rfen nicht gleich sein.');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8000', 'Your browser does not support Unicode', 'Ihr Browser unterst�tzt leider nicht Unicode');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8001', 'Your file is not an Unicode-File', 'Ihre Datei ist nicht richtig kodiert(Unicode-utf8)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8002', 'Your data are not right Coded', 'Ihre Daten sind nicht richtig kodiert(Unicode-utf8).');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8003', 'Enter new text', 'neuer Text eingeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8004', 'New Text upload', 'neuer Text uploaden');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8005', 'Text insert confirmation', 'Text speichern');


#TMPL-TEXT-TRANS
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8006', 'Text translation', 'Text');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8007', 'Original-Title', 'Originaler-Titel');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8008', 'Translation-Title', '�bersetzer-Titel');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8009', 'Original-Description', 'Originale-Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8010', 'Translation-Description', '�bersetze-Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8011', 'Original-Text', 'Originaler-Text');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8012', 'Translation-Text', '�bersetzer-Text');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8013', 'Upload', 'Hochladen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8014', 'Save', 'Speichern');

### text to trans upload
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8015', 'Upload translation file', '�bersetze Datei hochladen');

# TMPL TEXT-TRANS DOWNLOAD
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8018', 'Reserve language', 'Sprache reservieren');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8016', 'online translation', 'online �bersetzung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8017', 'Text downloaden', 'Text herunterladen');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8022', 'Date', 'Datum');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8019', 'Text', 'Text');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8020', 'Object', 'Betreff');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8021', 'User messages', 'Benutzermeldungen');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8023', 'No message for you', 'Keine Meldung');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8024', 'Text is already available in this language', 'Der Text ist schon in dieser Sprache vorhanden');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8025', 
                                                        'Please give a translation of the title.', 
                                                        'Bitte geben Sie eine �bersetzung des Titels an.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8026',
                                                        'Please give a translation of the description.',
                                                        'Bitte geben Sie eine �bersetzung der Beschreibung ein.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8027',
                                                        'Please give a translation of the text.',
                                                        'Bitte geben Sie eine �bersetzung des Textes.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8028',
                                                        'Please check your input.',
                                                        'Bitte �berpr�fen Sie ihre Eingaben.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8029','Code of file not OK','Kodierung der Datei nicht OK');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8030','Fileformat not OK','Dateiformat nicht OK');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8031','no file chooce','kein Datei gew�hlen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8032',
                                                        'Inserting of translation was sucsesfully finishted.',
                                                        'Speichern der �bersetzung war Erfolgreich.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8033','delete','l�schen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8034','upload','hochladen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8035','release','freigeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8036','your text have been rated','Ihr Text wurde bewertet');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8037','your translation have been rated','Ihre �bersetzung wurde bewertet');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8038', 'Text is reserved for you. Translation language:','Text is f�r Sie reserviert. �bersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8039','Your text have been reserved. Translation language:', 'Ihr Text wurde reserviert. �bersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8040','Your text have been transled. Translation language:', 'Ihr Text wurde �bersetzt. �bersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8041','Your reserved text have been released. Translation language:','Ihr reservierter Text wurde freigegeben. �bersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8042','Text have been reserved for you. Translation language:','Text wurde f�r Sie reserviert. �bersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8043','This language is already reserved. Selected language:','Diese Sprache wurde schon reserviert. Gew�hlte Sprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8044','Please select a language','Bitte eine Sprache w�hlen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8045','Close fenster','Dieses Fenster schliessen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8046','Select (file)-(Save As) or (Print) to save or to print this file.','W�hlen Sie Bitte (Datei)-(Speichern unter) oder (ausdr�cken), um den Inhalt dieses Festers auszudr�cken oder zu speichern');




### text module (upload)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7016', 'File', 'Datei');

### text module (new_ok)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7013',
                                                        'Inserting was sucsesfully finishted.',
                                                        'Speichern des Textes war Erfolgreich.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7014', 'Count words', 'Anzahl W�rter');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7015', 'Point cost', 'Punktekosten');

#
# user module
#

# registration page 1 (1010 - 1020)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1010', 'Registration', 'Registrierung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1011', 'Thru this form you become a member of LINGUA.', 'Hier werden Sie Mitglied bei LINGUA.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1012', 'Please enter your name, email etc.', 'Bitte geben Sie Ihren Namen, E-mail-Adresse usw. ein!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1013', 'All fields must be filled out.', 'Alle Felder m&uuml;ssen ausgef&uuml;llt werden.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1014', 'You will receive your password by email.', 'Ihr Password erhalten Sie an Ihre mail-Adresse.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1015', 'Your Username must have 3 to 10 characters<br>[a-z, A-Z, or numbers 0-9]; No special characters please',
                'Ihr Benutzername muss 3 bis 10 Buchstaben haben<br>[a-z, A-Z oder Ziffern 0-9]; Bitte keine Sonderzeichen.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1016', 'Username', 'Benutzername');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1017', 'First Name', 'Vorname', 'Prenom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1018', 'Last Name', 'Nachname', 'Nom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1019', 'Email Address', 'Email-Adresse', 'Email-Adresse');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1020', 'System Language (Preferred Language on this site)',
                'Systemsprache (Bevorzugte Sprache auf dieser Seite)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1021', 'Next', 'Weiter');

# errors on registration page 1 (1023 - 1028)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1023', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1024', 'there is already a user with that username.',
                'dieser Benutzername wird schon von jemand anderes benutzt.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1025', 'there is already a user with that email address.',
                'diese Email-Adresse  wird schon von jemand anderes benutzt.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1026', 'this email address is not valid.', 'die Email-Adresse ist nicht g&uuml;ltig.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1027', 'you cannot use this username.', 'diesen Benutzernamen k&ouml;nnen Sie nicht benutzen.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1028', 'you did not fill out all input forms.', 'nicht alle Eingabefelder sind ausgef&uuml;llt.');

# registration page 2 (1031 - 1040)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1031', 'Registration', 'Registrierung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1032', 'Please verify that your input is correct.', 'Bitte &uuml;berpr&uuml;fen Sie kurz Ihre Eingaben!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1033', 'By pressing &lt;next&gt; you will become a registered member of LINGUA',
                'Dr&uuml;cken Sie &lt;Weiter&gt; um registriertes Mitglied von LINUGA zu werden!');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1034', 'Username', 'Benutzername', 'Nom Utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1035', 'First Name', 'Vorname', 'Prenom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1036', 'Last Name', 'Nachname', 'Nom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1037', 'Email Address', 'Email-Adresse', 'Email-Adresse');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1038', 'System Language', 'Systemsprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1039', '(Please press this button only once.)', '(Bitte dr&uuml;cken Sie diesen Knopf nur einmal!)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1040', 'Next', 'Weiter');

# registration page 3 (1043 - 1048)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1043', 'Registration', 'Registrierung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1044', 'Congratulations!', 'Gl&uuml;ckwunsch!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1045', 'You are now a member of LINGUA', 'Sie sind jetzt Mitglied bei LINGUA');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1046', 'You can log in as soon as you have your password in your mailbox.',
                'Sobald Sie Ihr Passwort per mail erhalten haben, k&ouml;nnen Sie sich einloggen.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1047', 'You can enter a <b>personal description</b> of yourself, as well as your spoken languages, on your <b>Personal Page.</b>',
                'Eine <b>Pers&ouml;nliche Beschreibung</b> sowie Ihre gesprochenen Sprachen k&ouml;nnen Sie auf Ihrer <b>Pers&ouml;nlichen Seite</b> eintragen.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1048', 'To do so, click on &lt;Personal Page&gt; when you are logged in.',
                'Klicken Sie dazu nach dem Einloggen auf den Link &lt;Pers&ouml;nliche Seite&gt;.');

# personal page (1051 - 1072)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1051', 'Personal Page of', 'Pers&ouml;nliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1052', 'Name', 'Name', 'Nom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1053', 'E-mail', 'E-mail', 'E-mail');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1054', 'System Language', 'Systemsprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1055', 'Change', '&Auml;ndern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1056', 'User level', 'Benutzer-Level');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1057', 'Last login', 'Letzter Login am');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1058', 'Registered since', 'Registriert seit dem');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1059', 'My Languages', 'Meine Sprachen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1060', 'This user speaks the following languages', 'Dieser Benutzer spricht folgende Sprachen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1061', 'Edit', 'Bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1062', 'Description of myself', 'Beschreibung meiner Person');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1063', 'Personal description', 'Pers&ouml;nliche Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1064', 'Edit this description', 'Diese Beschreibung bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1065', 'Edit', 'Bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1066', 'Submit this description in another language', 'Ihre Beschreibung in einer anderen Sprache eingeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1067', 'New', 'Neu');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1068', 'Submit a description:&nbsp;', 'Eine Beschreibung eingeben:&nbsp');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1069', 'New', 'Neu');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1070', 'Texts', 'Texte');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1071', 'To your own texts', 'Ihre eigenen Texte finden Sie hier');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1072', 'To this user\'s texts', 'Texte dieses Benutzers finden Sie hier');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1073', 'To your translations', 'Ihre &Uuml;bersetzungen finden Sie hier');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1074', 'To this user\'s translations', '&Uuml;bersetzungen dieses Benutzers finden Sie hier');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1075', 'No languages entered yet.', 'Keine Sprachen angegeben.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1076', 'Change', 'Wechseln');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1077', 'Password', 'Passwort');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1078', 'This user has not yet submitted a description', 'Bisher keine Beschreibung');

# Sprachlevel (1080 - 1085)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1080', 'Mother tongue', 'Muttersprache', 'Langue maternelle');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1081', 'Fluent', 'Flie&szlig;end', 'Couremment');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1082', 'Good', 'Gut', 'Bien');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1083', 'Mediocre', 'Mittelm&auml;&szlig;ig', 'Mediocre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1084', 'Base Knowledge', 'Grundkenntnisse', 'Connaissance de base');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1085', 'Not at all', '&Uuml;berhaupt nicht');

# User Level (1088 - 1090)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1088', 'Registered user', 'Registrierter Benutzer');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1089', 'Category admin', 'Kategorienleiter');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1090', 'Administrator', 'Administrator');

# password-mail to user (1093 - 1100)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1093', 'Hello', 'Hallo');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1094', 'Thanks for registering with LINGUA', 'Vielen Dank f��r Ihre Registrierung bei LINGUA');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1095', 'You can log in using the following', 'Ihre Zugangsdaten sind:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1096', 'username', 'Benutzername');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1097', 'password', 'Passwort');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1098', 'Yours,', 'Mit freundlichem Gru��');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1099', 'The LINGUA Community', 'Ihre LINGUA-Community');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1100', 'Your LINGUA login data', 'Ihre LINGUA-Zugangs-Daten');

# system language update (1110 - 1112)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1110', 'Personal Page of', 'Pers&ouml;nliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1111', 'Here, you can change your system language', '&Auml;ndern der Systemsprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1112', 'Change', '&Auml;ndern');

# language update (1115 - 1121)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1115', 'Personal Page of', 'Pers&ouml;nliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1116', 'Here, you can edit the languages you speak', 'Hier k&ouml;nnen Sie Ihre Sprachen bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1117', 'Language', 'Sprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1118', 'Degree of knowledge', 'Kenntnisstand');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1119', 'Change', '&Auml;ndern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1120', 'Add a Language', 'Eine Sprache hinzuf&uuml;gen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1121', 'Add', 'Hinzuf&uuml;gen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1122', 'Back', 'Zur&uuml;ck');

# password update (1125 - 1131)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1125', 'Personal Page of', 'Pers&ouml;nliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1126', 'Here, you can change your password', '&Auml;ndern des Passworts');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1127', 'Your password must have 5 to 10 characters', 'Ihr Password muss 5 bis 10 Buchstaben haben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1128', '[a-z, A-z, or numbers 0-9]', '[a-z, A-Z, oder Ziffern 0-9]');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1129', 'Password', 'Passwort');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1130', 'Password (retype)', 'Passwort (best&auml;tigen)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1131', 'Submit', '&Auml;ndern');

# password update errors (1134 - 1136)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1134', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1135', 'the words you entered do not match', 'Ihre eingegebenen W&ouml;rter stimmen nicht &uuml;berein');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1136', 'this password is not valid', 'dies ist kein g&uuml;ltiges Passwort');

# password ok (1139 - 1141)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1139', 'Personal Page of', 'Pers&ouml;nliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1140', 'Your password has been updated', 'Ihr Password wurde ge�ndert');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1141', 'Back', 'Zur�ck');

# description-edit-page (1144 - 1149)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1144', 'Personal Page of', 'Pers&ouml;nliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1145', 'Here, you can edit your personal description', 'Bearbeiten Ihrer Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1146', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1147', 'Change', 'Wechseln');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1148', 'Submit', '&Auml;ndern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1149', 'Back', 'Zur&uuml;ck');

# description-edit-page error (1152 - 1153)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1152', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1153', 'the description is too long.', 'die Beschreibung ist zu lang.');

# new-description-page (1156 - 1161)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1156', 'Personal Page of', 'Pers&ouml;nliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1157', 'Here, you can submit a new personal description', 'Bearbeiten einer neuen Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1158', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1159', '1. Please select a language.', '1. Bitte w&auml;hlen Sie eine Sprache!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1160', '2. Please enter your description.', '2. Bitte geben Sie Ihre Beschreibung ein!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1161', 'Submit', 'Speichern');

# admin user search (1164 - 1166)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1164', 'User Administration', 'Benutzerverwaltung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1165', 'Select user (by his username)', 'Geben Sie einen Benutzernamen ein');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1166', 'Go', 'Weiter');

# user search errors (1169 - 1171)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1169', 'Sorry, but...', 'Sorry, aber...');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1170', 'there is no user with that username.', 'diesen Benutzernamen gibt es nicht.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1171', 'this is not a valid username.', 'dies ist kein g&uuml;ltiger Benutzername.');

# user admin page (1174 - 1184)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1174', 'User Administration', 'Benutzerverwaltung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1175', 'Username', 'Benutzername');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1176', 'Level', 'Level');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1177', 'Status', 'Status');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1178', 'More info', 'Weiter Infos');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1179', 'Promote this user', 'Diesen Benutzer bef&ouml;rdern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1180', 'Promote to', 'Bef&ouml;rdern zum');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1181', 'Submit', 'Bef&ouml;rdern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1182', 'Block this user', 'Diesen Benutzer sperren');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1183', 'Block', 'Sperren');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1184', 'Other user', 'Anderer Benutzer');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1185', 'Un-Block this user', 'Diesen Benutzer wieder freigeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1186', 'Attention: The reasons for blocking will be lost!', 
                'Vorsicht: Die Begr&uuml;ndung f&uuml;r die Sperre wird gel&ouml;scht!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1187', 'Un-Block', 'Freigeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1188', 'Reason for the block', 'Grund f&uuml;r die Sperre');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1189', 'Change', 'Wechseln');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1190', 'Edit this reason', 'Diese Begr&uuml;ndung bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1191', 'Edit', 'Bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1192', 'Submit this reason in another language', 'Begr&uuml;ndung in anderer Sprache eingeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1193', 'New', 'Neu');

# user status (1196 - 1198)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1196', 'OK', 'OK');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1197', 'Never logged in', 'Noch nie eingeloggt');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1198', 'Blocked', 'Gesperrt');

# link on left page (debug)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1200', 'User admin', 'Benutzer verwalten');

# blockreason-edit-page (1204 - 1209)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1204', 'User Administration', 'Benutzerverwaltung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1205', 'Edit block-reason', 'Bearbeiten der Sperre-Begr&uuml;ndung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1206', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1207', 'Change', 'Wechseln');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1208', 'Submit', '&Auml;ndern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1209', 'Back', 'Zur&uuml;ck');

# blockreason-edit-page error (1212 - 1213)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1212', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1213', 'the reason is too long.', 'die Begr&uuml;ndung ist zu lang.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1214', 'no empty reason please.', 'bitte keine leere Begr&uuml;ndung.');


# new-blockreason-page (1216 - 1221)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1216', 'User Administration', 'Benutzerverwaltung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1217', 'New block reason', 'Neue Begr&uuml;ndung f&uuml;r eine Sperre');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1218', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1219', '1. Please select a language.', '1. Bitte w&auml;hlen Sie eine Sprache!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1220', '2. Please enter the reason.', '2. Bitte geben Sie die Begr&uuml;ndung ein!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1221', 'Submit', 'Speichern');



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
        points      VARCHAR(10)          DEFAULT '0',
        status      ENUM('0','1','2')    DEFAULT '0',
        level       ENUM('0','1','2')    DEFAULT '0',
        system_lang SMALLINT(3) UNSIGNED DEFAULT '0',
        PRIMARY KEY(user_id),
        UNIQUE(username, email)
);

INSERT INTO lingua_user (username, password, lastname, firstname, email, reg_time, points, status, level, system_lang) VALUES ('admin', 'test', 'Test', 'Testie', 'test@test.de', '1007057807', '1000', '1', '2', '1');
INSERT INTO lingua_user (user_id, username, password, lastname, firstname, email, reg_time, points, status, level, system_lang) VALUES ('3','gio', 'gio', 'Test', 'Testie', 'test@test.de', '1007057807', '1000', '1', '2', '1');


INSERT INTO lingua_user 
(user_id, username, password, lastname, firstname, email, reg_time, points, status, level, system_lang) VALUES 
('2', 'evil', '666', 'Beelzebub', 'Himself', 'sauron@morgul.mor', '1007057807', '1000', '2', '0', '1');

DROP TABLE IF EXISTS lingua_user_desc;

CREATE TABLE lingua_user_desc (
        desc_id   SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
        user_id   INT(10)     UNSIGNED NOT NULL,
        lang_id   SMALLINT(3) UNSIGNED NOT NULL,
        desc_text TEXT                 NOT NULL,
        PRIMARY KEY(desc_id)
);

INSERT INTO lingua_user_desc (desc_id, user_id, lang_id, desc_text) VALUES
       ('1', '1', '1', 'Morgen ist Donnerstag [Deutsch]');
INSERT INTO lingua_user_desc (desc_id, user_id, lang_id, desc_text) VALUES
       ('2', '1', '2', 'Tomorry is Thursday [English]');
INSERT INTO lingua_user_desc (desc_id, user_id, lang_id, desc_text) VALUES
       ('3', '1', '3', '[Francais]');
INSERT INTO lingua_user_desc (desc_id, user_id, lang_id, desc_text) VALUES
       ('4', '1', '4', '[Swahili]');


DROP TABLE IF EXISTS lingua_user_blocked;

CREATE TABLE lingua_user_blocked (
        user_id      INT(10)     UNSIGNED NOT NULL AUTO_INCREMENT,
        blocked_by   INT(10)     UNSIGNED NOT NULL,
        block_time   CHAR(10)             NOT NULL,
        PRIMARY KEY(user_id)
);

INSERT INTO lingua_user_blocked (user_id, blocked_by, block_time) VALUES
       ('2', '1', '1007057807');


DROP TABLE IF EXISTS lingua_user_reason;

CREATE TABLE lingua_user_reason (
        user_id     INT(10)     UNSIGNED NOT NULL,
        block_reason TEXT,
        lang_id      SMALLINT(3) UNSIGNED NOT NULL
);	

INSERT INTO lingua_user_reason (user_id, block_reason, lang_id) VALUES
       ('2', 'user screwed up big time!!!', '2');
INSERT INTO lingua_user_reason (user_id, block_reason, lang_id) VALUES
       ('2', 'Benutzer hat kein Benehmen!!!', '1');


DROP TABLE IF EXISTS lingua_user_lang;

CREATE TABLE lingua_user_lang (
        id      INT(10)     UNSIGNED      NOT NULL AUTO_INCREMENT,
        user_id INT(10)     UNSIGNED      NOT NULL,
        lang_id SMALLINT(3) UNSIGNED      NOT NULL,
        level   ENUM('0','1','2','3','4') NOT NULL,
        PRIMARY KEY (id)
);

INSERT INTO lingua_user_lang (user_id, lang_id, level) VALUES ('1', '1', '0');
INSERT INTO lingua_user_lang (user_id, lang_id, level) VALUES ('1', '2', '2');


DROP TABLE IF EXISTS lingua_categories;

CREATE TABLE lingua_categories (
        cat_id     INT(10)        UNSIGNED NOT NULL               AUTO_INCREMENT,
        parent_id  INT(10)        UNSIGNED           DEFAULT '0',
        lang_id    INT(10)        UNSIGNED NOT NULL,
        depth      INT(10)        UNSIGNED           DEFAULT '0',
        cat_count  INT(10)        UNSIGNED           DEFAULT '0',
        text_count INT(10)        UNSIGNED           DEFAULT '0',
	status     ENUM('0', '1')                    DEFAULT '0',
        PRIMARY KEY(cat_id)
);

# Categories level: 1.
INSERT INTO lingua_categories (lang_id, cat_count, status) VALUES ('4001', '7', '1');
INSERT INTO lingua_categories (lang_id, cat_count, status) VALUES ('4002', '2', '1');
INSERT INTO lingua_categories (lang_id, cat_count, status) VALUES ('4003', '5', '1');
INSERT INTO lingua_categories (lang_id, cat_count, status) VALUES ('4004', '0', '1');
INSERT INTO lingua_categories (lang_id, cat_count, status) VALUES ('4005', '9', '1');
INSERT INTO lingua_categories (lang_id, cat_count, status) VALUES ('4006', '0', '1');
INSERT INTO lingua_categories (lang_id, cat_count, status) VALUES ('4007', '0', '1');

# Categories level: 2
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4008', '1', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4009', '1', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4010', '1', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4011', '1', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4012', '1', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4013', '1', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4014', '1', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4015', '2', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4016', '2', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4017', '3', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4018', '3', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4019', '3', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4020', '3', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4021', '3', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4022', '5', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4023', '5', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, cat_count, depth, status) VALUES ('4024', '5', '2', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4025', '5', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4026', '5', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4027', '5', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4028', '5', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4029', '5', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4030', '5', '1', '1');

# Categories level: 3
INSERT INTO lingua_categories (lang_id, parent_id, cat_count, depth, status) VALUES ('4031', '24', '0', '2', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth, status) VALUES ('4032', '24', '2', '1');

DROP TABLE IF EXISTS lingua_text;

CREATE TABLE lingua_text (
        text_id         INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	parent_id       INT(10) DEFAULT '0',
        text_header     MEDIUMTEXT NOT NULL,
	text_desc       MEDIUMTEXT NOT NULL,
	text_content    MEDIUMTEXT NOT NULL,
        num_words       INT(10) UNSIGNED DEFAULT '0',
        lang_id         INT(10) UNSIGNED NOT NULL,
	lang_trans_id   INT(10) UNSIGNED DEFAULT '0',
        submit_time     TIMESTAMP,
        user_id         INT(10) UNSIGNED DEFAULT '0',
        category_id     INT(10) UNSIGNED DEFAULT '0',
        status          INT(10) UNSIGNED DEFAULT '1',
        avg_rating      DOUBLE DEFAULT '0',
        num_ratings     INT(10) UNSIGNED DEFAULT '0',
        PRIMARY KEY(text_id)
);

DROP TABLE IF EXISTS lingua_text_rating;

CREATE TABLE lingua_text_rating (
        rating_id   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        user_id     INT(10) UNSIGNED DEFAULT '0',
        text_id     INT(10) UNSIGNED DEFAULT '0',
	text_rating INT(10) UNSIGNED DEFAULT '0',
        PRIMARY KEY(rating_id)
);

#
# library: Points
#

DROP TABLE IF EXISTS lingua_inactiv_points;

CREATE TABLE lingua_inactiv_points (
  id               INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  userid           INT(10) UNSIGNED DEFAULT '0',
  insert_date      DATETIME DEFAULT '0',
  translation_id   INT(10) UNSIGNED DEFAULT '0',
  points           INT(10) UNSIGNED DEFAULT '0',
  PRIMARY KEY(id)
);

INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (4,1,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (3,2,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (2,3,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (1,4,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (2,5,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (2,6,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (2,7,25);


DROP TABLE IF EXISTS lingua_text_reserve;

CREATE TABLE lingua_text_reserve (
        res_id          INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	text_id         INT(10) UNSIGNED DEFAULT '0',	
	lang_trans_id   INT(10) UNSIGNED DEFAULT '0',
        submit_time     TIMESTAMP,
        user_id         INT(10) UNSIGNED NOT NULL,
        art             ENUM('0','1','2','3', '4', '5') NOT NULL,
        PRIMARY KEY(res_id)
);













