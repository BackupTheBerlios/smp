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
        en      BLOB,
        de      BLOB,
        fr      BLOB,
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
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('personal page','persönliche Seite', 'Page personnelle');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Logout', 'Abmelden','Sortir');
INSERT INTO lingua_dictionary (en, de, fr) VALUES 
	('Wrong username or password.', 'Falscher Benutzername oder Passwort.', 'Mot de passe ou Nom Utilisateur incorrect');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Put a text', 'Text rein stellen', 'Ecrire un Texte');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Category admin', 'Kategorien verwalten', 'Gestion de Categories');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Start', 'Start', 'Start');

INSERT INTO lingua_dictionary (en, de, fr) VALUES ('french', 'französich', 'francais');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('swahili', 'swahili', 'swahili' );
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('lingala', 'lingala', 'lingala' );
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('arabisch', 'arabisch', 'arabe' );
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('holland', 'neederland', 'hollandais');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('spain','spanisch', 'espagnol');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('polnich','polnich', 'polonais');

INSERT INTO lingua_dictionary (en, de) VALUES ('Register here', 'Hier Registrieren');

INSERT INTO lingua_dictionary (en, de) VALUES ('Title', 'Überschrift');
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
INSERT INTO lingua_dictionary (de, fr) VALUES ('Ägyptologie', 'Egyptoligie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Archäologie', 'Archeologie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Kulturgeschichte', 'Histoires Culturelles');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Politikwissenschaft', 'Sciences Politiques');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Sozialwissenschaften', 'Sciences Sociales');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Theologie, Religion', 'Theologie, Religion');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Völkerkunde', 'Ethnologie');
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
INSERT INTO lingua_dictionary (de, fr) VALUES ('Meß- und Regelungstechnik', 'Technique de Reglementation et de Mesure');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Nachrichtentechnik', 'Technique de la Communication');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Verkehrswesen', 'Transport, Circulation');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Vermessungswesen', 'Mensuration, Topographie');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Hardware', 'Hardware');
INSERT INTO lingua_dictionary (de, fr) VALUES ('Software', 'Software');

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
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
       ('1015', 'Username (min. 3 characters [a-z, A-Z] or numbers [0-9]; No special characters please)', 'Benutzername (mind. 3 Buchstaben [a-z, A-Z] oder Ziffern [0-9]; Bitte keine Sonderzeichen)', 'Nom Utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
       ('1016', 'First Name', 'Vorname', 'Prenom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
       ('1017', 'Last Name', 'Nachname', 'Nom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
       ('1018', 'Email Address', 'Email-Adresse', 'Email-Adresse');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1019', 'System Language (Preferred Language on this site)', 'Systemsprache (Bevorzugte Sprache auf dieser Seite)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1020', 'Next', 'Weiter');

# errors on registration page 1 (1023 - 1028)
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1023', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1024', 'there is already a user with that username.', 'dieser Benutzername wird schon von jemand anderes benutzt.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1025', 'there is already a user with that email address.', 'diese Email-Adresse  wird schon von jemand anderes benutzt.');
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
       ('1033', 'By pressing &lt;next&gt; you will become a registered member of LINGUA', 'Dr&uuml;cken Sie &lt;Weiter&gt; um registriertes Mitglied von LINUGA zu werden!');
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
       ('1046', 'You can log in as soon as you have your password in your mailbox.', 'Sobald Sie Ihr Passwort per mail erhalten haben, k&ouml;nnen Sie sich einloggen.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1047', 'You can enter a <b>personal description</b> of yourself, as well as your spoken languages, on your <b>Personal Page.</b>', 'Eine <b>Pers&ouml;nliche Beschreibung</b> sowie Ihre gesprochenen Sprachen k&ouml;nnen Sie auf Ihrer <b>Pers&ouml;nlichen Seite</b> eintragen.');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1048', 'To do so, click on &lt;Personal Page&gt; when you are logged in.', 'Klicken Sie dazu nach dem Einloggen auf den Link &lt;Pers&ouml;nliche Seite&gt;.');

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
       ('1068', 'Submit a description', 'Eine Beschreibung eingeben');
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
       ('1075', '(No languages entered yet.)', '(Keine Sprachen angegeben.)');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
       ('1076', 'Change', 'Wechseln');


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


# Gesperrt ...

# (1084 - ...)

#INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
#       ('1054', '', '');
#INSERT INTO lingua_dictionary (dict_id, en, de) VALUES 
#       ('1054', '', '');
#INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
#       ('1031', 'Points', 'Punkte', 'Points');
#INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
#       ('1032', 'Spoken Language', 'Beherrschte Sprache', 'Langues maitrisees');
#INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
#       ('1034', 'Add Language', 'Sprache hinzuf&uuml;gen', 'Inserer une langue');
#INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
#       ('1035', 'Your personal description', 'Ihre pers&ouml;liche Beschreibung', 'Description personnelle');
#INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
#       ('1036', 'Add description in new Language', 'Beschreibung in neuer Sprache hinzuf&uuml;gen', 'Inserer description dans une nouvelle langue');
#INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
#       ('1037', 'Update!', '&Auml;ndern', 'changer');


##############################################
# Text Module				     #
##############################################

##### Text_upload.tmpl (2000 -> 2016) ######################################
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2000 ,'You have not choose a file!','Sie haben keine Datei gewählt!', 'Vous navez pas choisi de fichier!');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2001 , 'Only Unicode-file (.txt) admit!','Nur
Unicode-Textdateiein (txt) sind zugelasen!', 'Seuls les fichiers Unicode (.txt) sont autorises!');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2002 , 'Actual Type: ', 'Aktueller Dateitype: ', 'Type actuel: ');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2003 , 'file location:', 'Datei:', 'Source du fichier:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2004 , 'Send file', 'Datei Senden', 'Envoyer le fichier');

##### Text_message.tmpl (2005 -> 2007)######################################
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2005, 'New Text', 'Neuer Text', 'Nouveau texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2006, 'See text', 'Text ansehen', 'Voir le Text');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2007, 'Description in another language', 'Beschreibung in andere Sprache', 'Description dans une autre langue');


##### Text_description.tmpl ((2008 -> 2016) + 2026 + 2027)######################################

INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2008, 'Text language:', 'Text Sprache:', 'Langue du texte:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2009, 'Please select a language', 'Bitte Sprache wählen','veiller choisir une langue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2010, 'Title:', 'Title:', 'Titre:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2011, 'Please enter title', 'Bitte Title eingeben', 'Veiller donner un titre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2012, 'Description', 'Bescreibung:', 'Description:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2013, 'Please enter a description', 'Bitte Beschreibung eingeben', 'Veiller donner une description');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2014, 'Send Description', 'Beschreibung senden', 'Envoyer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2015, 'Your description have been successfull save.!', 'Ihre Beschreibung wurde erfolgreich gespeichert.!', 'Votre description a ete enregistree avec succes.!');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2016, 'for another description in another language or new Text use follow buttons', 
		'für weitere Beschreibung in andere Sprache oder neuer Text benutzen Sie die unteren Buttons.', 
		'Pour autre description en autres langues ou nouveaux textes utiliser les boutons ci-dessous');

##### Text_New.tmpl (2017 -> 2036) ### (2026 & 2027 werden auch von Text_beschreibung.tmpl benutzt.) ######################################
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2017, 'You can not give more than:', 'Es dürfen nicht mehr als', 'Vous ne pouvez donner plus de:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2018, 'symbols!', 'Zeichen eingegeben werden!', 'symboles!');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2019, 'categorie', 'Kategorie:', 'Categorie:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2020, 'Please select a categorie', 'Bitte wählen Sie eine Kategorie aus', 'Veillez choisir une categorie');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2021, 'Text language', 'Text Sprache:', 'Langue du texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2022, 'Please select a language', 'Bitte wählen Sie eine Sprache aus', 'Veillez choisir une Langue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2023, 'Title:', 'Title:', 'Titre:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2024, 'Please give a title', 'Bitte Title eingeben', 'Veillez donner un titre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2025, 'Description:', 'Beschreibung:', 'Description:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2026, '(max', '(max', '(max');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2027, 'symbols)', 'Zeichen)', 'Symboles)');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2028, 'Put-Text:', 'Text-eingeben:', 'Inserer texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2029, 'or', 'Oder', 'ou');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2030, 'Text-Upload', 'Text-Uploaden', 'Charger le text');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2031, ' Please give a text', 'Bitte Text eingeben', 'Veillez inserer votre texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2032, 'free:', 'noch frei:', 'possible:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2033, 'Text length:', 'Textlänge:', 'Longueur du Text:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2034, 'Text send', 'Text senden', 'expedier le Texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2035, 'Your Text have been successfull save.!', 'Ihr Text wurde erfolgreich gespeichert.!', 'Votre Texte a ete enregistrer avec succes.!
'); 
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2036, 'for another description of the text in another language use follow buttons',
		'für neue Beschreibung des Textes in andere Sprache benutzen Sie die unteren Buttons.', 
		'Pour autre description du texte dans une nouvelle langue utiliser les boutons ci-dessous');


##### Text_Confirm_Save.tmpl (2037 -> 20)######################################
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
	(2037, 'Confirm Save','Text Speichern','Enregistrer le Texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
	(2038, 'Change Something','Änderungen vornehmen','Changer le Texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2039, 'Title:','Überschrift:','Titre:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2040, 'Code:','Codierung:','Code:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2041, 'Length of Text:','Wortanzahl:','Punktekosten:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2042, 'Text-Punct:','Punktekosten:','Points en moins:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2043, 'Actual Punkt:','Aktuelle Punkte:','Points actuels:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
	(2044, 'Punct after Save:','neuer Punktestand:','Points apres enregistrement:');


##### Text_description.tmpl ((2008 -> 2016) + 2026 + 2027)######################################



##### Text_Show.tmpl (2100 -> 2200)######################################
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
	(2100, 'Author','Autor','Autorfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
	(2101, 'Text','Text','Textfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
	(2102, 'Original-Language','Original-Sprache','OriginalSprachefr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
	(2103, 'Text exist in','Text existiert in','Text existiert infr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
	(2104, 'Text-Rating','Text-Bewertung','Bewertungfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
	(2105, 'Number of ratings','Anzahl der Bewertungen','Anzahl der Bewertungenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
	(2106, 'Translate Text','Text übersetzen','Text Übersetzenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2107', 'Very good', 'Sehr gut', 'sehr gut fr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2108', 'Good', 'Gut', 'Bien');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2109', 'is ok', 'geht so', 'geht sofr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2110', 'Bad', 'schlecht', 'schlechtfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2111', 'Very bad', 'Sehr schlecht', 'Sehr schlecht');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2112', 'Rating of content', 'Inhaltsbewertung', 'Inhaltsbewertungfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2113', 'rate', 'bewerten', 'bewerternfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2114', 'Delete text', 'Text löschen', 'Text löschenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2115', 'Rating of translation', 'Übersetzungsbewertung', 'Übersetzungsbewertungfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2116', 'Prepare date', 'Erstellungsdatum', 'Erstellungsdatumfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2117', 'You rated this text with', 'Sie haben diesen Text bewertet mit', 'Sie haben diesen Text bewertet mitfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2118', 'View', 'Anzeigen', 'Anzeigenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2119', 'Text-View', 'Text-Anzeige', 'Text-Anzeigefr');

##### Text_Delete.tmpl (2120 -> 2200)######################################
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2120', 'This is an original-text', 'Dies ist ein Originaltext, daher müssen auch die zugehörigen Übersetzungen mitgelöscht werden.', 'Dies ist ein Originaltextfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2121', 'This is not an original-text', 'Dies ist kein Originaltext', 'Dies ist kein Originaltextfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2122', 'Delete', 'löschen', 'löschenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2123', 'Don\'t Delete', 'nicht löschen', 'nicht löschenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2124', 'Delete only this translation', 'Nur diese Übersetzung löschen', 'Nur diese Übersetzung löschenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2125', 'Delete all translations and the original text', 'Alle Übersetzungen und den Originaltext löschen', 'Alle Übersetzungen und den Originaltext löschenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2126', 'Delete translation', 'Übersetzung löschen', 'Übersetzung löschenfr');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2127', 'Delete all', 'Alles löschen', 'Alles löschenfr');


##### Text_Delete_ok.tmpl (2128 -> 2200)######################################
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('2128', 'Text was deleted succesful', 'Der Text wurde erfolgreich gelöscht', 'Der Text wurde erfolgreich gelöschtfr');

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

INSERT INTO lingua_user (username, password, lastname, firstname, email, reg_time, status, level, system_lang) VALUES ('admin', 'test', 'Test', 'Testie', 'test@test.de', '1007057807', '1', '2', '1');

DROP TABLE IF EXISTS lingua_user_desc;

CREATE TABLE lingua_user_desc (
        desc_id   SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
        user_id   INT(10)     UNSIGNED NOT NULL,
        lang_id   SMALLINT(3) UNSIGNED NOT NULL,
        desc_text BLOB                 NOT NULL,
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
        block_reason BLOB,
        lang_id      SMALLINT(3) UNSIGNED NOT NULL,
        PRIMARY KEY(user_id)
);

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
        cat_id     INT(10) UNSIGNED NOT NULL               AUTO_INCREMENT,
        parent_id  INT(10) UNSIGNED           DEFAULT '0',
        lang_id    INT(10) UNSIGNED NOT NULL,
        depth      INT(10) UNSIGNED           DEFAULT '0',
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
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4008', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4009', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4010', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4011', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4012', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4013', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4014', '1', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4015', '2', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4016', '2', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4017', '3', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4018', '3', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4019', '3', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4020', '3', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4021', '3', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4022', '5', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4023', '5', '1');
INSERT INTO lingua_categories (lang_id, parent_id, cat_count, depth) VALUES ('4024', '5', '2', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4025', '5', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4026', '5', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4027', '5', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4028', '5', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4029', '5', '1');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4030', '5', '1');

# Categories level: 3
INSERT INTO lingua_categories (lang_id, parent_id, cat_count, depth) VALUES ('4031', '24', '1', '2');
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4032', '24', '2');

# Categories level: 4 (for testing only)
INSERT INTO lingua_categories (lang_id, parent_id, depth) VALUES ('4001', '31', '3');

DROP TABLE IF EXISTS lingua_original_text;

CREATE TABLE lingua_original_text (
        original_id     INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
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
        trans_id        INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
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
        desc_id         INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        desc_text       MEDIUMBLOB   DEFAULT '',
        lang_id         INT(10) UNSIGNED NOT NULL,
        text_id         INT(10) UNSIGNED DEFAULT '0',
	trans_id         INT(10) UNSIGNED DEFAULT '0',
        user_id         INT(10) UNSIGNED DEFAULT '0',
        submit_time     TIMESTAMP,
        PRIMARY KEY(desc_id)
);

DROP TABLE IF EXISTS lingua_text_header;

CREATE TABLE lingua_text_header (
        header_id       INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        header_text     MEDIUMBLOB   DEFAULT '',
        lang_id         INT(10) UNSIGNED NOT NULL,
        text_id         INT(10) UNSIGNED DEFAULT '0',
	trans_id         INT(10) UNSIGNED DEFAULT '0',
        user_id         INT(10) UNSIGNED DEFAULT '0',
        submit_time     TIMESTAMP,
        PRIMARY KEY(header_id)
);

DROP TABLE IF EXISTS lingua_text_rating;

CREATE TABLE lingua_text_rating (
        rating_id        INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
        user_id          INT(10) UNSIGNED DEFAULT '0',
        text_original_id INT(10) UNSIGNED DEFAULT '0',
	text_trans_id    INT(10) UNSIGNED DEFAULT '0',
	text_rating      INT(10) UNSIGNED DEFAULT '0',
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

INSERT INTO lingua_user (user_id,username,lastname,firstname,email,points) VALUES
  (2,"testuser2","nachname2","vorname2","email@email.de",26);

INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (4,1,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (3,2,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (2,3,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (1,4,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (2,5,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (2,6,25);
INSERT INTO lingua_inactiv_points (userid,translation_id,points) VALUES (2,7,25);














