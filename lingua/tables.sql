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

INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Register here', 'Hier Registrieren','Enregistrement ici');

INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Title', 'Überschrift', 'Titre');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Description', 'Beschreibung','Description');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Languages', 'Sprachen', 'Langue');
INSERT INTO lingua_dictionary (en, de, fr) VALUES ('Degree of interest', 'Interessengrad', 'Degre d interet');

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
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('6000', 'New', 'Neu', 'Nouveau');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('6001', 'Change', 'Ändern', 'Changer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('6002', 'Delete', 'Löschen', 'Effacer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('6003', 'Lock', 'Sperren', 'Bloquer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('6004', 'Unlock', 'Freigeben', 'Debloquer');

### text module (new & change)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7000', 'Category', 'Kategorie', 'Categorie');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7001', 'Back', 'Zurück', 'Retour');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7002', 'Title', 'Titel', 'Titre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7003', 'Description', 'Beschreibung', 'Description');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7004', 'Content', 'Inhalt', 'Contenu');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7005', 'Save', 'Speichern', 'Sauvegarder');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7006', 'Upload', 'Hochladen', 'Charger');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7007', 
                                                        'Please enter a title.', 
                                                        'Bitte geben Sie einen Titel an.',
							'Donner un titre s il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7008',
                                                        'Please enter a description.',
                                                        'Bitte geben Sie eine Beschreibung ein.',
							'Donner une description s il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7009',
                                                        'Please enter a text or upload one.',
                                                        'Bitte geben Sie einen Text ein oder laden einen hoch.',
							'Donner un text ou charger en un s il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7010',
                                                        'Please check your input.',
                                                        'Bitte überprüfen Sie ihre Eingaben.',
							'Verifier vos entrees s il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7011',
                                                        'You have not enough Points for this text:',
                                                        'Ihnen fehlen noch Punkte für diesen Text:',
							'Vous n avez suffisament pas de points pour ce text');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7012', 'Source language', 'Quellsprache', 'Langue de  source');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7017', 'Destiny language', 'Zielsprache', 'Langue destinee');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7018',
                                                        'Source language and destiny language may not be the same.',
                                                        'Quellsprache und Zielsprache dürfen nicht gleich sein.',
							'Langue de source et la langue destinee doivent etre differents.');

INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8000', 'Your browser does not support Unicode', 'Ihr Browser unterstützt leider nicht Unicode', 'Votre browser n assiste pas Unicode');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8001', 'Your file is not an Unicode-File', 'Ihre Datei ist nicht richtig kodiert(Unicode-utf8)', 'Votre fichier n´est pas Unicode-code');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8002', 'Your data are not coded right', 'Ihre Daten sind nicht richtig kodiert(Unicode-utf8).', 'Vos donnees ne sont pas convenablement codees');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8003', 'Enter new text', 'Neuer Text eingeben', 'Introduire un nouveau text');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8004', 'New Text upload', 'Neuer Text uploaden', 'Charger un nouveau text');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8005', 'Text insert confirmation', 'Text speichern', 'Sauvegarder le text');


#TMPL-TEXT-TRANS
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8006', 'Text translation', 'Text Uebersetzt', 'Text traduit');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8007', 'Original-Title', 'Originaler-Titel', 'Titre original');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8008', 'Translation-Title', 'Übersetzer-Titel', 'Titre traduit');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8009', 'Original-Description', 'Originale-Beschreibung', 'Description originale');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8010', 'Translation-Description', 'Übersetze-Beschreibung', 'Description traduite');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8011', 'Original-Text', 'Originaler-Text', 'Text original');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8012', 'Translation-Text', 'Übersetzer-Text', 'Text-Traduit');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8013', 'Upload', 'Hochladen', 'Appeler  le text');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8014', 'Save', 'Speichern', 'Sauvegarder le text');

### text to trans upload
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8015', 'Upload translation file', 'Übersetze Datei hochladen', 'Appeler le text a traduire');

# TMPL TEXT-TRANS DOWNLOAD
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8018', 'Reserve language', 'Sprache reservieren', 'Reserver une langue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8016', 'online translation', 'online Übersetzung', 'Traduction Online');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8017', 'Text downloaden', 'Text herunterladen', 'Charger le texte');

INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8022', 'Date', 'Datum', 'date');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8019', 'Text', 'Text', 'Texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8020', 'Object', 'Betreff', 'Sujet');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8021', 'User messages', 'Benutzermeldungen', 'Messages de l utilisateur');

INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8023', 'No message for you', 'Keine Meldung', 'Aucun message pour vous');

INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8024', 'Text is already available in this language', 'Der Text ist schon in dieser Sprache vorhanden', 'Le texte existe deja en cette langue');

INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8025', 
                                                        'Please give a translation of the title.', 
                                                        'Bitte geben Sie eine Übersetzung des Titels an.',
							'Donnez une traduction au titre s´il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8026',
                                                        'Please give a translation of the description.',
                                                        'Bitte geben Sie eine Übersetzung der Beschreibung ein.',
							'Donnez une traduction a la description s´il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8027',
                                                        'Please give a translation of the text.',
                                                        'Bitte geben Sie eine Übersetzung des Textes.',
							'Traduire le texte s´il vous plait.');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8028',
                                                        'Please check your input.',
                                                        'Bitte überprüfen Sie ihre Eingaben.',
							'verifiez vos entrees s´il vous plait.');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8029','Code of file not OK','Kodierung der Datei nicht OK', 'Mauvais codage du fichier.');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8030','Fileformat not OK','Dateiformat nicht OK', 'Format du fichier pas OK.');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8031','no file chooce','kein Datei gewählt', 'Aucun fichier choisi');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8032',
                                                        'Inserting of translation was sucsesfully finishted.',
                                                        'Speichern der Übersetzung war Erfolgreich.',
							'Sauvegarde de la traduction reussie');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8033','delete','löschen', 'Effacer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8034','upload','hochladen', 'Appeler le text');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8035','release','freigeben', 'Liberer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8036','your text have been rated','Ihr Text wurde bewertet', 'Votre texte a ete evalue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8037','your translation have been rated','Ihre Übersetzung wurde bewertet', 'Votre traduction a ete evaluee');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8038', 'Text is reserved for you. Translation language:','Text is für Sie reserviert. Übersetzungssprache:', 'Le texte vous est reserve. Langue de traduction :');
INSERT INTO lingua_dictionary (dict_id, en, de,fr) VALUES ('8039','Your text have been reserved. Translation language:', 'Ihr Text wurde reserviert. Übersetzungssprache:', 'Votre texte a ete reserve. Langue de traduction :');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8040','Your text have been transled. Translation language:', 'Ihr Text wurde übersetzt. Übersetzungssprache:', 'Votre texte a ete traduit. Langue de traduction :');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8041','Your reserved text have been released. Translation language:','Ihr reservierter Text wurde freigegeben. Übersetzungssprache:', 'Votre reservation faite a ete annulee. Langue de Traduction');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8042','Text have been reserved for you. Translation language:','Text wurde für Sie reserviert. Übersetzungssprache:', 'Le texte a ete reserve pour vous. Langue de traduction:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8043','This language is already reserved. Selected language:','Diese Sprache wurde schon reserviert. Gewählte Sprache:', 'Cette langue a deja ete prise. Langue choisie :');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8044','Please select a language','Bitte eine Sprache wählen', 'Selectionnez une langue s´il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8045','Close window','Dieses Fenster schliessen', 'Fermer la fenetre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8046','Select (file)-(Save As) or (Print) to save or to print this file.','Wählen Sie Bitte (Datei)-(Speichern unter) oder (ausdrücken), um den Inhalt dieses Festers auszudrücken oder zu speichern',
'Choisissez sauvegarder(Fichier)-(Sauvegarder sous) ou (imprimer), pour pouvoir sauvergarder ou imprimer le contenu de cette fenetre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('8047','NewPoints','Punktguthaben', 'Nouveaux Points');



### text module (upload)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7016', 'File', 'Datei', 'Fichier');

### text module (new_ok)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7013',
                                                        'Inserting finishted successfully.',
                                                        'Speichern des Textes war erfolgreich.',
							'Sauvegarde du Fichier reussie');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7014', 'Count words', 'Anzahl Wörter', 'Nombre de mots');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES ('7015', 'Point cost', 'Punktekosten', 'Cout des mots');



### text module (text_show)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7100',
                                                           'Author','Autor','Auteur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7101',
                                                           'Text','Text','Texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7102',
                                                           'Original-Language','Original-Sprache','Laongue originale');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7103',
                                                           'Text exist in','Text existiert in','Texte existe en');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7104',
                                                           'Text-Rating','Text-Bewertung','Evaluation du texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7105',
                                                           'Number of ratings','Anzahl der Bewertungen','Nombre d evaluations');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7106',
                                                           'Translate Text','Text übersetzen','Texte traduit');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7107',
                                                           'Very good', 'Sehr gut', 'Tres bien');
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
                                                           'Rating of translation', 'Übersetzungsbewertung', 'Noter la traduction');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7116',
                                                           'Prepare date', 'Erstellungsdatum', 'Date d apparition');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7117',
                                                           'You rated this text with', 'Sie haben diesen Text bewertet mit', 'Selon vous ,la valeur du text est de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7118',
                                                           'View', 'Anzeigen', 'Montrer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7119',
                                                           'Text-View', 'Text-Anzeige', 'Montrer le texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7120',
                                                           'Title', 'Titel', 'Titre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7121',
                                                           'Number of words', 'Wortanzahl', 'Nombre de mots');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7122',
                                                           'Description', 'Beschreibung', 'Description');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7123',
                                                           'Category', 'Kategorie', 'Categorie');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7124',
                                                           'Text-Language', 'Textsprache', 'Langue-Text');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7125',
                                                           'Total rating', 'Gesamtbewertung', 'Note');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7126',
                                                           'Translation Request', 'Übersetzungswunsch', 'Traduction souhaitee');



### text module (text_delete)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7220',
                                                           'This is an original-text', 'Dies ist ein Originaltext, daher müssen auch die zugehörigen Übersetzungen mitgelöscht werden.', 'C est un text original, c est pourquoi il faut aussi effacer sa traduction');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7221',
                                                           'This is not an original-text', 'Dies ist kein Originaltext', 'C est pas un texte original');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7222',
                                                           'Delete', 'löschen', 'Effacer');
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
                                                           'Author','Autor','Auteur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7303',
                                                           'Description', 'Bescreibung:', 'Description:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7304',
                                                           'Text','Text','Texte');


### text module (texts_own)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7400',
                                                           'Title', 'Titel', 'Titre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7401',
                                                           'Language', 'Sprache', 'Langue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7402',
                                                           'Category','Kategorie','categorie');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7403',
                                                           'Submit-Time', 'Erstellungsdatum', 'Date d apparition');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7404',
                                                           'Original texts by', 'Original-Texte von', 'Texte original du');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES('7405',
                                                           'Translations by', 'Übersetzungen von', 'Traduit par');








#
# user module
#

# registration page 1 (1010 - 1020)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
       ('1010', 'Registration', 'Registrierung', 'Enregistrement');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
       ('1011', 'Through this form you become a member of LINGUA.', 'Hier werden Sie Mitglied bei LINGUA.', 'D ici vous pourrez etre membre de LINGUA.');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
       ('1012', 'Please enter your name, email etc.', 'Bitte geben Sie Ihren Namen, E-mail-Adresse usw. ein!' ,'Votre nom ,adresse-email, etc.. sil vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
       ('1013', 'All fields must be filled out.', 'Alle Felder müssen ausgefüllt werden.', 'Tout espace doit etre rempli');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES 
       ('1014', 'You will receive your password by email.', 'Ihr Password erhalten Sie an Ihre mail-Adresse.', ' Vous recevrez votre mot de passe par email');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1015', 'Your Username must have 3 to 10 characters [a-z, A-Z, or numbers 0-9]; No special characters please',
                'Ihr Benutzername muss 3 bis 10 Buchstaben haben [a-z, A-Z oder Ziffern 0-9]; Bitte keine Sonderzeichen.',
		'Votre nom d utilisateur doit avoir etre 3 et 10 characteres[a-z, A-Z ou chiffre 0-9]; pas de characteres speciaux s.v.p ');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1016', 'Username', 'Benutzername', 'Nom de l utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1017', 'First Name', 'Vorname', 'Prenom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1018', 'Last Name', 'Nachname', 'Nom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1019', 'Email Address', 'Email-Adresse', 'Email-Adresse');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1020', 'System Language (Preferred Language on this site)',
                'Systemsprache (Bevorzugte Sprache auf dieser Seite)',
		'Langue du system (Langue preferee a cette page)');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1021', 'Next', 'Weiter', 'Poursuivre');

# errors on registration page 1 (1023 - 1028)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1023', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...', 'Desole,  mais ..');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1024', 'there is already a user with that username.',
                'dieser Benutzername wird schon von jemand anderes benutzt.',
		'Nous avons deja un utilisateur sous ce mon');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1025', 'there is already a user with that email address.',
                'diese Email-Adresse  wird schon von jemand anderes benutzt.',
		'Cette Adresse electronique est deja utilisee par quelqu un d´autre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1026', 'this email address is not valid.', 'die Email-Adresse ist nicht gültig.', 'Adresse electronique pas valable');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1027', 'you cannot use this username.', 'diesen Benutzernamen können Sie nicht benutzen.', 'Vous ne pouvez utiliser ce nom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1028', 'you did not fill out all input forms.', 'nicht alle Eingabefelder sind ausgefüllt.', 'Veillez remplir tous les espaces s´il vous plait');

# registration page 2 (1031 - 1040)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1031', 'Registration', 'Registrierung', 'Enregistrement');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1032', 'Please verify that your input is correct.', 'Bitte überprüfen Sie kurz Ihre Eingaben!', 'Verifiez que vos donnees sont exactes, s´il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1033', 'By pressing <next> you will become a registered member of LINGUA',
                'Drücken Sie <Weiter> um registriertes Mitglied von LINUGA zu werden!',
		'Appuyez sur <Poursuivre> , afin de devenir membre de LINGUA!');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1034', 'Username', 'Benutzername', 'Nom Utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1035', 'First Name', 'Vorname', 'Prenom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1036', 'Last Name', 'Nachname', 'Nom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1037', 'Email Address', 'Email-Adresse', 'Email-Adresse');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1038', 'System Language', 'Systemsprache', 'Langue du system');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1039', '(Please press this button only once.)', '(Bitte drücken Sie diesen Knopf nur einmal!)', 'Pressez ce button une seule fois s´il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1040', 'Next', 'Weiter', 'Poursuivre');

# registration page 3 (1043 - 1048)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1043', 'Registration', 'Registrierung', 'Enregistrement');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1044', 'Congratulations!', 'Glückwunsch!', 'Felicitations');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1045', 'You are now a member of LINGUA', 'Sie sind jetzt Mitglied bei LINGUA', 'Vous etes a compte de maintenant un menbre de LINGUA');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1046', 'You can log in as soon as you have your password in your mailbox.',
                'Sobald Sie Ihr Passwort per mail erhalten haben, können Sie sich einloggen.',
		' Des obtention de votre mot de passe (par mail), vous pourrez penetrer le system');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1047', 'You can enter a personal description of yourself, as well as your spoken languages, on your Personal Page.',
                'Eine Persönliche Beschreibung sowie Ihre gesprochenen Sprachen können Sie auf Ihrer Persönlichen Seite eintragen.',
		'Vous pouvez vous decrire, et enummerer les langues que vous parler, sur votre page (personnelle)' );
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1048', 'To do so, click on <Personal Page> when you are logged in.',
                'Klicken Sie dazu nach dem Einloggen auf den Link <Persönliche Seite>.',
		'Appuyez sur <Page Personnelle>, des que vous vous annoncez.');

# personal page (1051 - 1072)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1051', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1052', 'Name', 'Name', 'Nom');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1053', 'E-mail', 'E-mail', 'E-mail');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1054', 'System Language', 'Systemsprache', 'Langue du system');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1055', 'Change', 'Ändern', 'Changer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1056', 'User level', 'Benutzer-Level', 'Niveau de l´utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1057', 'Last login', 'Letzter Login am', 'Derniere entree date de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1058', 'Registered since', 'Registriert seit dem', 'Enregistre depuis le');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1059', 'My Languages', 'Meine Sprachen', 'Mes langues');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1060', 'This user speaks the following languages:', 'Dieser Benutzer spricht folgende Sprachen:', 'C est utilisateur parle les langues suivantes:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1061', 'Edit', 'Bearbeiten', 'Rediger');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1062', 'Description of myself', 'Beschreibung meiner Person', 'Ma description');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1063', 'Personal description', 'Persönliche Beschreibung', 'Description personnelle');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1064', 'Edit this description', 'Diese Beschreibung bearbeiten', 'Rediger ma description');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1065', 'Edit', 'Bearbeiten', 'Rediger');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1066', 'Submit this description in another language', 'Ihre Beschreibung in einer anderen Sprache eingeben', 'Decrire en une autre langue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1067', 'New', 'Neu', 'Nouveau');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1068', 'Submit a description', 'Eine Beschreibung eingeben:', 'Donnez une Description');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1069', 'New', 'Neu', 'Nouveau');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1070', 'Texts','Text', 'Texte');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1071', 'To your own texts', 'Ihre eigenen Texte finden Sie hier', 'Vos textes a vos sont ici');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1072', 'To this user\'s texts', 'Texte dieses Benutzers finden Sie hier', 'Les textes de cet utilisateur sont ici');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1073', 'To your translations', 'Ihre übersetzungen finden Sie hier', 'Vos Traductions sont ici');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1074', 'To this user\'s translations', 'übersetzungen dieses Benutzers finden Sie hier', 'Les traductions de cet utilisateur sont ici' );
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1075', 'No languages entered yet.', 'Keine Sprachen angegeben.', 'Pour le moment, pas de language selectionne');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1076', 'Change', 'Wechseln', 'Changer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1077', 'Password', 'Passwort', ' Mot de passe');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1078', 'This user has not yet submitted a description', 'Bisher keine Beschreibung', 'Pas de description, jusqu´a present');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1079', 'This user has been blocked by an admin!', 'Dieser Benutzer ist von einem Admin gesperrt worden!', 'Cet utilisateur a ete bloque par l un des administrateurs du system');

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
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1085', 'Not at all', 'Überhaupt nicht', 'Aucunement');

# User Level (1088 - 1090)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1088', 'Registered user', 'Registrierter Benutzer', 'Utilisateur enregistre');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1089', 'Category admin', 'Kategorienleiter', 'Categorie des Admin´s');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1090', 'Administrator', 'Administrator', 'Administrateur');

# password-mail to user (1093 - 1100)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1093', 'Hello', 'Hallo', 'Salut');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1094', 'Thanks for registering with LINGUA', 'Vielen Dank für Ihre Registrierung bei LINGUA', 'Merci de vous etre fait enregistre chez LINGUA');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1095', 'You can log in using the following', 'Ihre Zugangsdaten sind:', 'Vos donnees d´access au system sont:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1096', 'username', 'Benutzername', 'Nom d utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1097', 'password', 'Passwort', 'Mot de passe');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1098', 'Yours,', 'Mit freundlichem Gruß', 'Amicalement');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1099', 'The LINGUA Community', 'Ihre LINGUA-Community', 'Le comite de LINGUA');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1100', 'Your LINGUA login data', 'Ihre LINGUA-Zugangs-Daten', 'Vos donnees-LINGUA');

# system language update (1110 - 1112)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1110', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1111', 'Here, you can change your system language', 'Ändern der Systemsprache', 'Pour changer la langue du system');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1112', 'Change', 'Ändern', 'Changer');

# language update (1115 - 1121)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1115', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1116', 'Here, you can edit the languages you speak', 'Hier können Sie Ihre Sprachen bearbeiten', 'Vous pouvez rediger la langue que vous parler ici');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1117', 'Language', 'Sprache', 'Langue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1118', 'Degree of knowledge', 'Kenntnisstand', 'Niveau de connaissances');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1119', 'Change', 'Ändern', 'Changer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1120', 'Add a Language', 'Eine Sprache hinzufügen', 'Augmenter une langue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1121', 'Add', 'Hinzufügen', 'Ajouter');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1122', 'Back', 'Zurück', 'Retour');

# password update (1125 - 1131)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1125', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1126', 'Here, you can change your password', 'Ändern des Passworts', 'Changer le mot de passe');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1127', 'Your password must have 5 to 10 characters', 'Ihr Password muss 5 bis 10 Buchstaben haben', 'Votre mot de passe doit aoir 3 a 10 characteres');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1128', '[a-z, A-z, or numbers 0-9]', '[a-z, A-Z, oder Ziffern 0-9]', '[a-z, A-Z, et ou chiffre 0-9]');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1129', 'Password', 'Passwort', 'Mot de passe');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1130', 'Password (retype)', 'Passwort (bestätigen)', 'Mot de passe (Valider)');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1131', 'Submit', 'Ändern', 'Envoyer');

# password update errors (1134 - 1136)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1134', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...', 'Desole, mais ..');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1135', 'the words you entered do not match', 'Ihre eingegebenen Wörter stimmen nicht überein', 'Les mots que vous utilises, ne sont pas corrects');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1136', 'this password is not valid', 'dies ist kein gültiges Passwort', 'Ce mot de passe n est pas valable');

# password ok (1139 - 1141)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1139', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1140', 'Your password has been updated', 'Ihr Password wurde geändert', 'Votre mot de passe a ete change');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1141', 'Back', 'Zurück', 'Retour');

# description-edit-page (1144 - 1149)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1144', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('1145', 'Here, you can edit your personal description', 'Bearbeiten Ihrer Beschreibung');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1146', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)', '(Maximun 400 characteres)');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1147', 'Change', 'Wechseln', 'Changer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1148', 'Submit', 'Ändern', 'Changer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1149', 'Back', 'Zurück', 'Retour');

# description-edit-page error (1152 - 1153)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1152', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...', 'Desole, mais ...');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1153', 'The description is too long.', 'Die Beschreibung ist zu lang.', 'La description est trop longue');

# new-description-page (1156 - 1161)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1156', 'Personal Page of', 'Persönliche Seite von', 'Page personnelle de');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1157', 'Here, you can submit a new personal description', 'Bearbeiten einer neuen (persoenliche) Beschreibung', 'Ici, vous pouvez rediger une nouvelle description (personnelle)');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1158', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)', '(Maximum 400 characteres)');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1159', '1. Please select a language.', '1. Bitte wählen Sie eine Sprache!', '1. Selectionnez une langue s´il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1160', '2. Please enter your description.', '2. Bitte geben Sie Ihre Beschreibung ein!', '2. S´il vous plait  une description');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1161', 'Submit', 'Speichern', 'Sauvegarder');

# admin user search (1164 - 1166)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1164', 'User Administration', 'Benutzerverwaltung', 'Administration de l utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1165', 'Select user (by his username)', 'Geben Sie einen Benutzernamen ein', 'Le nom d un utilisateur, s´il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1166', 'Go', 'Weiter', 'Poursuivre');

# user search errors (1169 - 1171)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1169', 'Sorry, but...', 'Schade, aber...', 'Desole, mais ...');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1170', 'there is no user with that username.', 'diesen Benutzernamen gibt es nicht.', 'Cet utilisateur n existe pas');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1171', 'this is not a valid username.', 'dies ist kein gültiger Benutzername.', 'Ce nom n est pas valable');

# user admin page (1174 - 1184)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1174', 'User Administration', 'Benutzerverwaltung', 'Administration de l utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1175', 'Username', 'Benutzername', 'Nom de l utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1176', 'Level', 'Level', 'Niveau');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1177', 'Status', 'Status', 'Status');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1178', 'More info', 'Weitere Infos', 'Plus d info´s');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1179', 'Promote this user', 'Diesen Benutzer befördern', 'Promouvoir cet Utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1180', 'Promote to', 'Befördern zum', 'Admis au niveau suivant:');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1181', 'Submit', 'Befördern', 'Grade');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1182', 'Block this user', 'Diesen Benutzer sperren', 'Bloquer cet utilisateur' );
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1183', 'Block', 'Sperren', 'Bloquer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1184', 'Other user', 'Anderer Benutzer', 'Autres utilisateurs');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1185', 'Un-Block this user', 'Diesen Benutzer wieder freigeben', 'Debloquer cet utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1186', 'Attention: The reasons for blocking will be lost!', 
                'Vorsicht: Die Begründungen für die Sperre werden gelöscht!',
		'Attention:Les raisons du blocages seront effacees');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1187', 'Un-Block', 'Freigeben', 'Debloquer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1188', 'Reason for the block', 'Grund für die Sperre', 'Raison du blocage');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1189', 'Change', 'Wechseln', 'Changer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1190', 'Edit this reason', 'Diese Begründung bearbeiten', 'Rediger les raisons');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1191', 'Edit', 'Bearbeiten', 'Rediger');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1192', 'Submit this reason in another language', 'Begründung in anderer Sprache eingeben', 'Traduire ces raisons');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1193', 'New', 'Neu', 'Nouveau');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1194', 'Blocked by', 'Gesperrt von', 'Bloque par');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1195', 'Time of block', 'Zeit der Sperre', 'Temps de Blocage');

# user status (1196 - 1198)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1196', 'Blocked', 'Gesperrt', 'Bloque');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1197', 'OK', 'OK', 'OK');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1198', 'Never logged in', 'Noch nie eingeloggt', 'Jamais annonce');

# link on left page (debug)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1200', 'User admin', 'Benutzer verwalten', 'Admin de l utilisateur');

# blockreason-edit-page (1204 - 1209)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1204', 'User Administration', 'Benutzerverwaltung', 'Administration de l utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1205', 'Edit block-reason', 'Bearbeiten der Sperre-Begründung', 'Rediger la reason du blocage');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1206', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)', '(Maximum 400 characteres)');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1207', 'Change', 'Wechseln', 'Changer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1208', 'Submit', 'Ändern', 'Changer');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1209', 'Back', 'Zurück', 'Retour');

# blockreason-edit-page error (1212 - 1213)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1212', 'Sorry, but...', 'Entschuldigen Sie die Unannehmlichkeit, aber...', 'Desole, mais...');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1213', 'the reason is too long.', 'die Begründung ist zu lang.', 'La raison est trop longue');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1214', 'no empty reason please.', 'bitte keine leere Begründung.', 'Pas de raison vide s´il vous plait');

# new-blockreason-page (1216 - 1221)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1216', 'User Administration', 'Benutzerverwaltung', 'Administration de l utilisateur');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1217', 'New block reason', 'Neue Begründung für eine Sperre', 'Nouveau raison pour le blocage');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1218', '(Maximum 400 characters)', '(Maximal 400 Buchstaben)', '(Maximum 400 characteres)');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1219', '1. Please select a language.', '1. Bitte wählen Sie eine Sprache!', '1. Choisissez un message s´il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1220', '2. Please enter the reason.', '2. Bitte geben Sie die Begründung ein!', '2. Donnez une raison s´il vous plait');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1221', 'Submit', 'Speichern', 'Sauvegarder');

# for blocked users (1224 - 1228)
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1224', 'You\'re blocked!', 'Sie sind gesperrt!', 'Vous etes bloques');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1225', 'You can\'t login while you are blocked.', 'Sie können sich nicht einloggen, solange Sie gesperrt sind', 'Vous n aurez pas access au sytsem aussi longtemps que vous etes bloques');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1226', 'You have been blocked by', 'Sie wurden gesperrt von', 'Vous avez ete bloques par');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1227', 'Time of block', 'Gesperrt seit', 'Duree du blocage');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1228', 'Reason for the block', 'Begründung für die Sperre', 'Reason du blocage');
INSERT INTO lingua_dictionary (dict_id, en, de, fr) VALUES
       ('1229', 'Change', 'Wechseln', 'Changer');


#
# Help pages
#

# link on left page
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('2001', 'Info/Help', 'Info/Hilfe');
# page title
INSERT INTO lingua_dictionary (dict_id, en, de) VALUES
       ('2002', 'LINGUA - Info and Help', 'Lingua - Info und Hilfe');



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
       ('1', '1', '1', '[Deutsch] Ich bin Student der Informatik.\nIch übersetze gerne wissenschaftliche Texte, und bin auch sonst ein dufter Typ.');
INSERT INTO lingua_user_desc (desc_id, user_id, lang_id, desc_text) VALUES
       ('2', '1', '2', '[English] Hi, I\'m a computer science student.\nIn my spare time, I like to translate scientific texts, an moreover, my friends call me \"the King\"');
INSERT INTO lingua_user_desc (desc_id, user_id, lang_id, desc_text) VALUES
       ('3', '1', '3', '[Francais] Je suis un estudiant de Informatique. Bonjour, et au revoir');
INSERT INTO lingua_user_desc (desc_id, user_id, lang_id, desc_text) VALUES
       ('4', '1', '4', '[Swahili] Well... looks like I\'ve forgotten all about my Swahili.\nMaybe next time...');




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














