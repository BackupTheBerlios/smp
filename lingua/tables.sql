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

INSERT INTO lingua_dictionary (en, de, fr) VALUES ('German', 'deutsch','allemand');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('English', 'englisch','anglais');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Username','Benutzername', 'Nom Utilisateur');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Password', 'Passwort','Mot de passe');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Languages','Sprachen', 'Langues');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Change', 'Wechseln','Changer');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Login', 'Anmelden','Entrer');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Points existence','Punkte vorhanden', 'Points existants');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Points in work','Punkte in arbeit', 'Points en travail');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Personal Page','Persönliche Seite', 'Page personnelle');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Logout', 'Abmelden','Sortir');
INSERT INTO lingua_dictionary (en, de, fr) VALUES 
	('Wrong username or password.', 'Falscher Benutzername oder Passwort.', 'Mot de passe ou Nom Utilisateur incorrect');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Put a text', 'Text rein stellen', 'Ecrire un Texte');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Category admin', 'Kategorien verwalten', 'Gestion de Categories');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Start', 'Start', 'Start');

INSERT INTO lingua_dictionary (en, de, fr) VALUES ('French', 'französisch', 'francais');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Swahili', 'swahili', 'swahili' );
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Lingala', 'lingala', 'lingala' );
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Arabic', 'arabisch', 'arabe' );
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Dutch', 'niederländisch', 'hollandais');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Spanish','spanisch', 'espagnol');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Polish','polnisch', 'polonais');

INSERT INTO lingua_dictionary (en, de) VALUES ('Register here', 'Hier Registrieren');

INSERT INTO lingua_dictionary (en, de) VALUES ('Title', 'Überschrift');
INSERT INTO lingua_dictionary (en, de) VALUES ('Description', 'Beschreibung');
INSERT INTO lingua_dictionary (en, de) VALUES ('Source language', 'Quellsprache');
INSERT INTO lingua_dictionary (en, de) VALUES ('Degree of interest', 'Interessengrad');

INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES (4001, 'History, Politics', 'Geschichte, Politik', 'Histoire et Politique');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Law', 'Jura', 'Droit');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Natural science', 'Naturwissenschaften', 'Sciences Naturelles');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Sports', 'Sport', 'Sport');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Technology', 'Technik', 'Technique');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Business administration', 'Wirtschaftswissenschaften', 'Sciences economiques');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Miscellaneous', 'Diverses', 'Divers');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Egyptology', 'Ägyptologie', 'Egyptoligie');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Archeology', 'Archäologie', 'Archeologie');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Cultural history', 'Kulturgeschichte', 'Histoires Culturelles');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Political science', 'Politikwissenschaft', 'Sciences Politiques');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Social science', 'Sozialwissenschaften', 'Sciences Sociales');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Theology', 'Theologie, Religion', 'Theologie, Religion');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Ethnology', 'Völkerkunde', 'Ethnologie');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Standards, Patents', 'Normen, Patente', 'Standardisation, Brevet');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Legal science', 'Rechtswissenschaft', 'Sciences du Droit');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Physics', 'Physik', 'Physique');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Biology', 'Biologie', 'Biologie');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Chemistry', 'Chemie', 'Chimie');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Medicine', 'Medizin', 'Medecine');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Pharmacy', 'Pharmazie', 'Pharmacie');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Electrical engineering', 'Elektrotechnik', 'Electrotechnique');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Energy engineering', 'Energietechnik', 'Technique energetique');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Computerscience and data processing', 'Informatik und Datenverarbeitung', 'Informatique et Traitement de Donnees');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Mechanical engineering', 'Maschinenbau','Construction Mecanique');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Mechanics', 'Mechanik', 'Mecanique');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Control engineering', 'Meß- und Regelungstechnik', 'Technique de Reglementation et de Mesure');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Telecommunications', 'Nachrichtentechnik', 'Technique de la Communication');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Traffic, Transport', 'Verkehrswesen', 'Transport, Circulation');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Surveying', 'Vermessungswesen', 'Mensuration, Topographie');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Hardware', 'Hardware', 'Hardware');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Software', 'Software', 'Software');

### home module
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6000', 'New', 'Neu');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6001', 'Change', 'Ändern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6002', 'Delete', 'Löschen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6003', 'Lock', 'Sperren');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6004', 'Unlock', 'Freigeben');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6005', 'Categoryname in the right language', 'Kategorienname in der entsprechenden Sprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('6006', 'Please fill all the language fields.', 'Bitte geben Sie den Namen in allen Sprachen an.');

### text module (new & change)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7000', 'Category', 'Kategorie');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7001', 'Back', 'Zurück');
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
                                                        'Bitte überprüfen Sie ihre Eingaben.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7011',
                                                        'You have not enough Points for this text:',
                                                        'Ihnen fehlen noch Punkte für diesen Text:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7012', 'Source language', 'Quellsprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7017', 'Destiny language', 'Zielsprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7018',
                                                        'Source language and destiny languagemay not be the same.',
                                                        'Quellsprache und Zielsprache dürfen nicht gleich sein.');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8000', 'Your browser does not support Unicode', 'Ihr Browser unterstützt leider nicht Unicode');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8001', 'Your file is not an Unicode-File', 'Ihre Datei ist nicht richtig kodiert(Unicode-utf8)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8002', 'Your data are not coded right', 'Ihre Daten sind nicht richtig kodiert(Unicode-utf8).');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8003', 'Enter new text', 'neuer Text eingeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8004', 'New Text upload', 'neuer Text uploaden');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8005', 'Text insert confirmation', 'Text speichern');


#TMPL-TEXT-TRANS
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8006', 'Text translation', 'Text');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8007', 'Original-Title', 'Originaler-Titel');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8008', 'Translation-Title', 'Übersetzer-Titel');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8009', 'Original-Description', 'Originale-Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8010', 'Translation-Description', 'Übersetze-Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8011', 'Original-Text', 'Originaler-Text');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8012', 'Translation-Text', 'Übersetzer-Text');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8013', 'Upload', 'Hochladen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8014', 'Save', 'Speichern');

### text to trans upload
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8015', 'Upload translation file', 'Übersetze Datei hochladen');

# TMPL TEXT-TRANS DOWNLOAD
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8018', 'Reserve language', 'Sprache reservieren');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8016', 'online translation', 'online Übersetzung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8017', 'Text downloaden', 'Text herunterladen');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8022', 'Date', 'Datum');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8019', 'Text', 'Text');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8020', 'Object', 'Betreff');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8021', 'User messages', 'Benutzermeldungen');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8023', 'No message for you', 'Keine Meldung');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8024', 'Text is already available in this language', 'Der Text ist schon in dieser Sprache vorhanden');

INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8025', 
                                                        'Please give a translation of the title.', 
                                                        'Bitte geben Sie eine Übersetzung des Titels an.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8026',
                                                        'Please give a translation of the description.',
                                                        'Bitte geben Sie eine Übersetzung der Beschreibung ein.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8027',
                                                        'Please give a translation of the text.',
                                                        'Bitte geben Sie eine Übersetzung des Textes.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8028',
                                                        'Please check your input.',
                                                        'Bitte überprüfen Sie ihre Eingaben.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8029','Code of file not OK','Kodierung der Datei nicht OK');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8030','Fileformat not OK','Dateiformat nicht OK');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8031','no file chooce','kein Datei gewählen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8032',
                                                        'Inserting of translation was sucsesfully finishted.',
                                                        'Speichern der Übersetzung war Erfolgreich.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8033','delete','löschen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8034','upload','hochladen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8035','release','freigeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8036','your text have been rated','Ihr Text wurde bewertet');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8037','your translation have been rated','Ihre Übersetzung wurde bewertet');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8038', 'Text is reserved for you. Translation language:','Text is für Sie reserviert. Übersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8039','Your text have been reserved. Translation language:', 'Ihr Text wurde reserviert. Übersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8040','Your text have been transled. Translation language:', 'Ihr Text wurde übersetzt. Übersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8041','Your reserved text have been released. Translation language:','Ihr reservierter Text wurde freigegeben. Übersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8042','Text have been reserved for you. Translation language:','Text wurde für Sie reserviert. Übersetzungssprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8043','This language is already reserved. Selected language:','Diese Sprache wurde schon reserviert. Gewählte Sprache:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8044','Please select a language','Bitte eine Sprache wählen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8045','Close window','Dieses Fenster schliessen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('8046','Select (file)-(Save As) or (Print) to save or to print this file.','Wählen Sie Bitte (Datei)-(Speichern unter) oder (ausdrücken), um den Inhalt dieses Festers auszudrücken oder zu speichern');




### text module (upload)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7016', 'File', 'Datei');

### text module (new_ok)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7013',
                                                        'Inserting finishted successfully.',
                                                        'Speichern des Textes war erfolgreich.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7014', 'Count words', 'Anzahl Wörter');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES ('7015', 'Point cost', 'Punktekosten');


### text module (text_show)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7100',
                                                           'Author','Autor','Autorfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7101',
                                                           'Text','Text','Textfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7102',
                                                           'Original-Language','Original-Sprache','OriginalSprachefr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7103',
                                                           'Text exist in','Text existiert in','Text existiert infr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7104',
                                                           'Text-Rating','Text-Bewertung','Bewertungfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7105',
                                                           'Number of ratings','Anzahl der Bewertungen','Anzahl der Bewertungenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7106',
                                                           'Translate Text','Text übersetzen','Text Übersetzenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7107',
                                                           'Very good', 'Sehr gut', 'sehr gut fr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7108',
                                                           'Good', 'Gut', 'Bien');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7109',
                                                           'is ok', 'geht so', 'acceptable');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7110',
                                                           'Bad', 'schlecht', 'mediocre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7111',
                                                           'Very bad', 'Sehr schlecht', 'Tres Mediocre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7112',
                                                           'Rating of content', 'Inhaltsbewertung', 'Valeur du contenue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7113',
                                                           'rate', 'bewerten', 'Evaluation');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7114',
                                                           'Delete text', 'Text löschen', 'Effacer le texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7115',
                                                           'Rating of translation', 'Übersetzungsbewertung', 'noter la traduction');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7116',
                                                           'Prepare date', 'Erstellungsdatum', 'Erstellungsdatumfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7117',
                                                           'You rated this text with', 'Sie haben diesen Text bewertet mit', 'Selon vous ,la valeur du text est de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7118',
                                                           'View', 'Anzeigen', 'Montrer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7119',
                                                           'Text-View', 'Text-Anzeige', 'Montrer le texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7120',
                                                           'Title', 'Titel', 'Titre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7121',
                                                           'Number of words', 'Wortanzahl', 'Wortanzahlfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7122',
                                                           'Description', 'Beschreibung', 'Beschreibungfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7123',
                                                           'Category', 'Kategorie', 'Kategoriefr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7124',
                                                           'Text-Language', 'Textsprache', 'Textsprachefr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7125',
                                                           'Total rating', 'Gesamtbewertung', 'Gesamtbewertungfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7126',
                                                           'Translation Request', 'Übersetzungswunsch', 'Übersetzungswunschfr');



### text module (text_delete)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7220',
                                                           'This is an original-text', 'Dies ist ein Originaltext, daher müssen auch die zugehörigen Übersetzungen mitgelöscht werden.', 'C est un text original, c est pourquoi il faut aussi effacer sa traduction');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7221',
                                                           'This is not an original-text', 'Dies ist kein Originaltext', 'C est pas un texte original');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7222',
                                                           'Delete', 'löschen', 'löschenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7223',
                                                           'Don\'t Delete', 'nicht löschen', 'Ne pas effacer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7224',
                                                           'Delete only this translation', 'Nur diese Übersetzung löschen', 'N effacer que cette traduction');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7225',
                                                           'Delete all translations and the original text', 'Alle Übersetzungen und den Originaltext löschen', 'Effacer le texte original et ses traductions');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7226',
                                                           'Delete translation', 'Übersetzung löschen', 'Effacer la traduction');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7227',
                                                           'Delete all', 'Alles löschen', 'Tout effacer');



### text module (text_delete_all_ok)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7300',
                                                           'Text was deleted succesful', 'Der Text wurde erfolgreich gelöscht', 'Der Text wurde erfolgreich gelöschtfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7301',
                                                           'categorie', 'Kategorie:', 'Categorie:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7302',
                                                           'Author','Autor','Autorfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7303',
                                                           'Description', 'Bescreibung:', 'Description:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7304',
                                                           'Text','Text','Textfr');


### text module (texts_own)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7400',
                                                           'Title', 'Titel', 'Titre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7401',
                                                           'Language', 'Sprache', 'Sprachefr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7402',
                                                           'Category','Kategorie','Kategoriefr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7403',
                                                           'Submit-Time', 'Erstellungsdatum', 'Erstellungsdatumfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7404',
                                                           'Original texts by', 'Original-Texte von', 'Original-Texte vonfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7405',
                                                           'Translations by', 'Übersetzungen von', 'Übersetzungen vonfr');


### text module (text_delete_trans_ok)



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
       ('1013', 'All fields must be filled out.', 'Alle Felder müssen ausgefüllt werden.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1014', 'You will receive your password by email.', 'Ihr Password erhalten Sie an Ihre mail-Adresse.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1015', 'Your Username must have 3 to 10 characters [a-z, A-Z, or numbers 0-9]; No special characters please',
                'Ihr Benutzername muss 3 bis 10 Buchstaben haben [a-z, A-Z oder Ziffern 0-9]; Bitte keine Sonderzeichen.');
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
       ('1026', 'this email address is not valid.', 'die Email-Adresse ist nicht gültig.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1027', 'you cannot use this username.', 'diesen Benutzernamen können Sie nicht benutzen.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1028', 'you did not fill out all input forms.', 'nicht alle Eingabefelder sind ausgefüllt.');

# registration page 2 (1031 - 1040)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1031', 'Registration', 'Registrierung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1032', 'Please verify that your input is correct.', 'Bitte überprüfen Sie kurz Ihre Eingaben!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1033', 'By pressing <next> you will become a registered member of LINGUA',
                'Drücken Sie <Weiter> um registriertes Mitglied von LINUGA zu werden!');
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
       ('1039', '(Please press this button only once.)', '(Bitte drücken Sie diesen Knopf nur einmal!)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1040', 'Next', 'Weiter');

# registration page 3 (1043 - 1048)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1043', 'Registration', 'Registrierung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1044', 'Congratulations!', 'Glückwunsch!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1045', 'You are now a member of LINGUA', 'Sie sind jetzt Mitglied bei LINGUA');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1046', 'You can log in as soon as you have your password in your mailbox.',
                'Sobald Sie Ihr Passwort per mail erhalten haben, können Sie sich einloggen.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1047', 'You can enter a personal description of yourself, as well as your spoken languages, on your Personal Page.',
                'Eine Persönliche Beschreibung sowie Ihre gesprochenen Sprachen können Sie auf Ihrer Persönlichen Seite eintragen.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1048', 'To do so, click on <Personal Page> when you are logged in.',
                'Klicken Sie dazu nach dem Einloggen auf den Link <Persönliche Seite>.');

# personal page (1051 - 1072)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1051', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1052', 'Name', 'Name', 'Nom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1053', 'E-mail', 'E-mail', 'E-mail');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1054', 'System Language', 'Systemsprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1055', 'Change', 'ändern');
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
       ('1063', 'Personal description', 'Persönliche Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1064', 'Edit this description', 'Diese Beschreibung bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1065', 'Edit', 'Bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1066', 'Submit this description in another language', 'Ihre Beschreibung in einer anderen Sprache eingeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1067', 'New', 'Neu');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1068', 'Submit a description', 'Eine Beschreibung eingeben:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1069', 'New', 'Neu');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1070', 'Texts', 'Texte');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1071', 'To your own texts', 'Ihre eigenen Texte finden Sie hier');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1072', 'To this user\'s texts', 'Texte dieses Benutzers finden Sie hier');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1073', 'To your translations', 'Ihre übersetzungen finden Sie hier');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1074', 'To this user\'s translations', 'übersetzungen dieses Benutzers finden Sie hier');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1075', 'No languages entered yet.', 'Keine Sprachen angegeben.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1076', 'Change', 'Wechseln');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1077', 'Password', 'Passwort');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1078', 'This user has not yet submitted a description', 'Bisher keine Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1079', 'This user has been blocked by an admin!', 'Dieser Benutzer ist von einem Admin gesperrt worden!');

# Sprachlevel (1080 - 1085)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1080', 'Mother tongue', 'Muttersprache', 'Langue maternelle');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1081', 'Fluent', 'Fließend', 'Couremment');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1082', 'Good', 'Gut', 'Bien');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1083', 'Mediocre', 'Mittelmäßig', 'Mediocre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1084', 'Base Knowledge', 'Grundkenntnisse', 'Connaissance de base');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1085', 'Not at all', 'überhaupt nicht');

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
       ('1094', 'Thanks for registering with LINGUA', 'Vielen Dank für Ihre Registrierung bei LINGUA');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1095', 'You can log in using the following', 'Ihre Zugangsdaten sind:');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1096', 'username', 'Benutzername');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1097', 'password', 'Passwort');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1098', 'Yours,', 'Mit freundlichem Gruß');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1099', 'The LINGUA Community', 'Ihre LINGUA-Community');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1100', 'Your LINGUA login data', 'Ihre LINGUA-Zugangs-Daten');

# system language update (1110 - 1112)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1110', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1111', 'Here, you can change your system language', 'ändern der Systemsprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1112', 'Change', 'ändern');

# language update (1115 - 1121)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1115', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1116', 'Here, you can edit the languages you speak', 'Hier können Sie Ihre Sprachen bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1117', 'Language', 'Sprache');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1118', 'Degree of knowledge', 'Kenntnisstand');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1119', 'Change', 'ändern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1120', 'Add a Language', 'Eine Sprache hinzufügen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1121', 'Add', 'Hinzufügen');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1122', 'Back', 'Zurück');

# password update (1125 - 1131)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1125', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1126', 'Here, you can change your password', 'ändern des Passworts');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1127', 'Your password must have 5 to 10 characters', 'Ihr Password muss 5 bis 10 Buchstaben haben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1128', '[a-z, A-z, or numbers 0-9]', '[a-z, A-Z, oder Ziffern 0-9]');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1129', 'Password', 'Passwort');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1130', 'Password (retype)', 'Passwort (bestätigen)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1131', 'Submit', 'ändern');

# password update errors (1134 - 1136)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1134', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1135', 'the words you entered do not match', 'Ihre eingegebenen Wörter stimmen nicht überein');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1136', 'this password is not valid', 'dies ist kein gültiges Passwort');

# password ok (1139 - 1141)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1139', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1140', 'Your password has been updated', 'Ihr Password wurde geändert');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1141', 'Back', 'Zurück');

# description-edit-page (1144 - 1149)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1144', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1145', 'Here, you can edit your personal description', 'Bearbeiten Ihrer Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1146', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1147', 'Change', 'Wechseln');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1148', 'Submit', 'ändern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1149', 'Back', 'Zurück');

# description-edit-page error (1152 - 1153)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1152', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1153', 'the description is too long.', 'die Beschreibung ist zu lang.');

# new-description-page (1156 - 1161)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1156', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1157', 'Here, you can submit a new personal description', 'Bearbeiten einer neuen Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1158', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1159', '1. Please select a language.', '1. Bitte wählen Sie eine Sprache!');
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
       ('1171', 'this is not a valid username.', 'dies ist kein gültiger Benutzername.');

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
       ('1178', 'More info', 'Weitere Infos');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1179', 'Promote this user', 'Diesen Benutzer befördern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1180', 'Promote to', 'Befördern zum');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1181', 'Submit', 'Befördern');
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
                'Vorsicht: Die Begründung für die Sperre wird gelöscht!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1187', 'Un-Block', 'Freigeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1188', 'Reason for the block', 'Grund für die Sperre');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1189', 'Change', 'Wechseln');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1190', 'Edit this reason', 'Diese Begründung bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1191', 'Edit', 'Bearbeiten');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1192', 'Submit this reason in another language', 'Begründung in anderer Sprache eingeben');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1193', 'New', 'Neu');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1194', 'Blocked by', 'Gesperrt von');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1195', 'Time of block', 'Zeit der Sperre');

# user status (1196 - 1198)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1196', 'Blocked', 'Gesperrt');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1197', 'OK', 'OK');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1198', 'Never logged in', 'Noch nie eingeloggt');

# link on left page (debug)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1200', 'User admin', 'Benutzer verwalten');

# blockreason-edit-page (1204 - 1209)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1204', 'User Administration', 'Benutzerverwaltung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1205', 'Edit block-reason', 'Bearbeiten der Sperre-Begründung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1206', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1207', 'Change', 'Wechseln');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1208', 'Submit', 'ändern');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1209', 'Back', 'Zurück');

# blockreason-edit-page error (1212 - 1213)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1212', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1213', 'the reason is too long.', 'die Begründung ist zu lang.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1214', 'no empty reason please.', 'bitte keine leere Begründung.');

# new-blockreason-page (1216 - 1221)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1216', 'User Administration', 'Benutzerverwaltung');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1217', 'New block reason', 'Neue Begründung für eine Sperre');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1218', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1219', '1. Please select a language.', '1. Bitte wählen Sie eine Sprache!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1220', '2. Please enter the reason.', '2. Bitte geben Sie die Begründung ein!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1221', 'Submit', 'Speichern');

# for blocked users (1224 - 1228)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1224', 'You\'re blocked!', 'Sie sind gesperrt!');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1225', 'You can\'t login while you are blocked.', 'Sie können sich nicht einloggen, solange Sie gesperrt sind');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1226', 'You have been blocked by', 'Sie wurden gesperrt von');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1227', 'Time of block', 'Gesperrt seit');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1228', 'Reason for the block', 'Begründung für die Sperre');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1229', 'Change', 'Wechseln');



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
('2', 'evil', '666', 'Beelzebub', 'Himself', 'sauron@morgul.mor', '1007057807', '1000', '0', '0', '1');

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
	parent_id   INT(10) UNSIGNED DEFAULT '0',
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













