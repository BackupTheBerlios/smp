#################################################################
#NAME: package modules::Text.					#
#
#DESC: 								#
#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)		#
#	 Hendrik ...     (erler@cs.tu-berlin.de)		#
#        Guy Nokam       (floreguy@cs.tu-berlin.de)		#
#################################################################

package modules::Text;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use Unicode::String qw(latin1 utf8 utf16);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.15 $ =~ /(\d+)\.(\d+)/;

#################################################################
#NAME: parameter($mgr).						#
#
#DESC: Check wich method have to be executed			#
#
#NOTE: This function is calling by main.cgi			#
#
#SEE:  see main.cgi - sub handler() 				#
#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)		#
#	 Hendrik ...     (erler@cs.tu-berlin.de)		#
#        Guy Nokam       (floreguy@cs.tu-berlin.de)		#
#################################################################

sub parameter {
  my ($self, $mgr) = @_;

  $mgr->{Page}->fill_main_part($mgr);
  $mgr->{Page}->fill_user_part($mgr);
  $mgr->{Page}->fill_lang_part($mgr);

my $method = $mgr->{CGI}->param('text_method') || 'text_new';

if ($method eq 'text_new'){ $self->show_text_new($mgr);}

elsif ($method eq 'text_direction'){ $self->check_text_direction($mgr);}

elsif ($method eq 'text_upload'){ $self->show_text_upload($mgr);}

elsif ($method eq 'text_description'){ $self->show_text_description($mgr);}

elsif ($method eq 'text_message'){ $self->show_text_message($mgr);}

elsif ($method eq 'text_message_way'){ $self->show_way($mgr);}

elsif ($method eq 'text_confirm_save'){ $self->show_text_confirm_save($mgr);}

elsif ($method eq 'create_text'){ $self->show_text_new($mgr);}

elsif ( ($method eq 'trans_desc') || ($method eq 'text_trans') ){ $self->show_trans_desc($mgr);}

elsif ($method eq 'text_trans_contents'){ $self->show_trans_contents($mgr);}

elsif ($method eq 'text_show'){ $self->show_text_see($mgr);}

elsif ($method eq 'delete_text'){ $self->delete_text($mgr);}

elsif ($method eq 'text_unicode_info'){ $self->text_unicode_info($mgr);}

return 1;
}



sub text_unicode_info{
my ($self, $mgr)=@_;

$mgr->{Template} = $mgr->{TmplFiles}->{Text_Unicode_Info};

$mgr->{TmplData}{PAGE_LANG_003004} = $mgr->{Func}->get_text($mgr, 3004);
$mgr->{TmplData}{PAGE_LANG_003005} = $mgr->{Func}->get_text($mgr, 3005);
$mgr->{TmplData}{PAGE_LANG_003006} = $mgr->{Func}->get_text($mgr, 3006);
$mgr->{TmplData}{PAGE_LANG_003007} = $mgr->{Func}->get_text($mgr, 3007);
$mgr->{TmplData}{PAGE_LANG_003008} = $mgr->{Func}->get_text($mgr, 3008);
$mgr->{TmplData}{PAGE_LANG_003009} = $mgr->{Func}->get_text($mgr, 3009);
$mgr->{TmplData}{PAGE_LANG_003010} = $mgr->{Func}->get_text($mgr, 3010);
$mgr->{TmplData}{PAGE_LANG_003011} = $mgr->{Func}->get_text($mgr, 3011);
$mgr->{TmplData}{PAGE_LANG_003012} = $mgr->{Func}->get_text($mgr, 3012);
$mgr->{TmplData}{PAGE_LANG_003013} = $mgr->{Func}->get_text($mgr, 3013);
$mgr->{TmplData}{PAGE_LANG_003014} = $mgr->{Func}->get_text($mgr, 3014);
}



#########################################################################################################################
#CALL: $self->show_text_new($mgr).											#
#
#DESC: page have been submit:												#
#	  with ('save' & 'param missing')	-> 	send Template with data & message over missing param (red). 				#
#	  with ('save' & 'param ok')		-> 	save all input & Show a Confirmation (Template_Text_Message)	#
#	  with ('Change language')	 	->	change language & send Template with actual input		#
#	  with ('Text Upload')			->	Conserve input & show Template_Text_Upload			#
#	  else  show Template_Text_New (empty)												#
#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)									#
#########################################################################################################################

sub show_text_new {
my ($self, $mgr,$cat_mes, $lang_mes, $title_mes, $text_mes, $trans_mes, $same_mes, $text_from_file , $text_length ) = @_;

my $title = $mgr->{CGI}->param('title') || "";
my $text_desc = $mgr->{CGI}->param('text_desc') || "";

my $text_cat_id = $mgr->{CGI}->param('text_cat_id') || undef;
my $text_lang_id = $mgr->{CGI}->param('text_desc_lang_id') || undef;
my $trans_lang_id = $mgr->{CGI}->param('trans_lang_id') || undef;
my $mytext = $mgr->{CGI}->param('mytext') || undef;
my $submit = $mgr->{CGI}->param('send') || undef;

$mgr->{Template} = $mgr->{TmplFiles}->{Text_New};

if (defined $submit){
	if ((defined $cat_mes) and ($cat_mes==1)){
		$mgr->{TmplData}{TEXT_CAT_MES_002020}= $mgr->{Func}->get_text($mgr, 2020);}
	if ((defined $lang_mes) and ($lang_mes==1)){
		$mgr->{TmplData}{TEXT_LANG_MES_002022}= $mgr->{Func}->get_text($mgr, 2022);}
	if ((defined $title_mes) and ($title_mes==1)){
		$mgr->{TmplData}{TEXT_TITLE_MES_002024}= $mgr->{Func}->get_text($mgr, 2024);}
	if ((defined $text_mes) and ($text_mes==1)){
		$mgr->{TmplData}{TEXT_MES_002031}=$mgr->{Func}->get_text($mgr, 2031);}
	if ((defined $trans_mes) and ($trans_mes==1)){
		$mgr->{TmplData}{TEXT_TRANS_MES_003500}=$mgr->{Func}->get_text($mgr, 3500);}
	if ((defined $same_mes) and ($same_mes==1)){
		$mgr->{TmplData}{TEXT_TRANS_MES_003502}=$mgr->{Func}->get_text($mgr, 3502);}
}

$mgr->{TmplData}{TEXT_TITLE}=$title;
$mgr->{TmplData}{TEXT_DESCRIPTION}=$text_desc;

$mgr->{TmplData}{PAGE_LANG_002017} = $mgr->{Func}->get_text($mgr, 2017);
$mgr->{TmplData}{PAGE_LANG_002018} = $mgr->{Func}->get_text($mgr, 2018);
$mgr->{TmplData}{PAGE_LANG_002019} = $mgr->{Func}->get_text($mgr, 2019); 
$mgr->{TmplData}{PAGE_LANG_002021} = $mgr->{Func}->get_text($mgr, 2021); 
$mgr->{TmplData}{PAGE_LANG_002023} = $mgr->{Func}->get_text($mgr, 2023); 
$mgr->{TmplData}{PAGE_LANG_002025} = $mgr->{Func}->get_text($mgr, 2025); 
$mgr->{TmplData}{PAGE_LANG_002026} = $mgr->{Func}->get_text($mgr, 2026); 
$mgr->{TmplData}{PAGE_LANG_002027} = $mgr->{Func}->get_text($mgr, 2027); 
$mgr->{TmplData}{PAGE_LANG_002028} = $mgr->{Func}->get_text($mgr, 2028); 
$mgr->{TmplData}{PAGE_LANG_002029} = $mgr->{Func}->get_text($mgr, 2029); 
$mgr->{TmplData}{PAGE_LANG_002030} = $mgr->{Func}->get_text($mgr, 2030); 
#$mgr->{TmplData}{PAGE_LANG_002032} = $mgr->{Func}->get_text($mgr, 2032); 
$mgr->{TmplData}{PAGE_LANG_002033} = $mgr->{Func}->get_text($mgr, 2033); 
$mgr->{TmplData}{PAGE_LANG_002034} = $mgr->{Func}->get_text($mgr, 2034); 
$mgr->{TmplData}{PAGE_LANG_003501} = $mgr->{Func}->get_text($mgr, 3501); 
$mgr->{TmplData}{PAGE_LANG_003503} = $mgr->{Func}->get_text($mgr, 3503);

###################### Category #######################################
if (defined $text_cat_id){
	$mgr->{TmplData}{TEXT_CAT_ID_SELECT}=$text_cat_id;

my $table_cats = $mgr->{Tables}->{CATS};
my $dbh = $mgr->connect();
my $sth = $dbh->prepare(<<SQL);

SELECT lang_id FROM $table_cats WHERE cat_id= $text_cat_id

SQL

$sth->execute();
my @cat_ray =  $sth->fetchrow_array();

$sth->finish();

	my $cat_name = $mgr->{Func}->get_text($mgr,$cat_ray[0]);
	$mgr->{TmplData}{TEXT_CAT_NAME_SELECT}= $cat_name; }

else{	$mgr->{TmplData}{TEXT_CAT_NAME_SELECT}= '-----------'; }

my @cat_loop_data = $self->get_below_cats($mgr) ;

@cat_loop_data = sort {$a->{TEXT_CAT_NAME} cmp $b->{TEXT_CAT_NAME}} @cat_loop_data;#added by Hendrik, sort categories

$mgr->{TmplData}{TEXT_LOOP_CAT}=\@cat_loop_data;


################ Language #####################################
 

if (defined $text_lang_id){
	$mgr->{TmplData}{TEXT_LANG_ID_SELECT}=$text_lang_id;
	my $nr = $self->get_lang_name_id($mgr,$text_lang_id);
	my $lang_name = $mgr->{Func}->get_text($mgr, $nr);
	$mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= $lang_name ; }

else{ $mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= '-----------'; }

my @lang_loop_data=();
my @ray = $mgr->{Func}->get_langs($mgr,'all');
my $elem;
foreach $elem (@ray){
my %data;
$data{TEXT_LANG_ID}= $$elem[0];
$data{TEXT_LANG_NAME}= $$elem[1];
push(@lang_loop_data,\%data);
}
@lang_loop_data = sort {$a->{TEXT_LANG_NAME} cmp $b->{TEXT_LANG_NAME}} @lang_loop_data;#added by Hendrik, sort languages

$mgr->{TmplData}{TEXT_LOOP_LANG}=\@lang_loop_data;


################ TRANS Language #####################################
 

if (defined $trans_lang_id){
	$mgr->{TmplData}{TEXT_TRANS_LANG_ID_SELECT}=$trans_lang_id ;
	my $trans_nr = $self->get_lang_name_id($mgr,$trans_lang_id );
	my $trans_lang_name = $mgr->{Func}->get_text($mgr, $trans_nr);
	$mgr->{TmplData}{TEXT_TRANS_LANG_NAME_SELECT}= $trans_lang_name ; }

else{ $mgr->{TmplData}{TEXT_TRANS_LANG_NAME_SELECT}= '-----------'; }

my @trans_lang_loop_data=();
my @trans_ray = $mgr->{Func}->get_langs($mgr,'all');
my $trans_elem;
foreach $trans_elem (@trans_ray){
my %trans_data;
$trans_data{TEXT_TRANS_LANG_ID}= $$trans_elem[0];
$trans_data{TEXT_TRANS_LANG_NAME}= $$trans_elem[1];
push(@trans_lang_loop_data,\%trans_data);
}
@trans_lang_loop_data = sort {$a->{TEXT_TRANS_LANG_NAME} cmp $b->{TEXT_TRANS_LANG_NAME}} @trans_lang_loop_data;#added by Hendrik, sort languages

$mgr->{TmplData}{TEXT_LOOP_TRANS_LANG}=\@trans_lang_loop_data;



###################### PUNKTE #######################################
my $user_id = $mgr->{UserData}{UserId};
my $punkt =$mgr->{Points}->get_activ_points($mgr, $user_id);
$mgr->{TmplData}{TEXT_MAX_VAL}= $punkt;

if (!defined $text_from_file) { 
	if (defined $mytext) { 
		$text_from_file=$mytext;
	}else { 
		$text_from_file=''; 
	}
}

$text_length = $self->get_words($text_from_file); #longueuer du texte
my $punktekosten = $self->get_punktkosten($mgr,$text_length);

$mgr->{TmplData}{TEXT}=  $text_from_file;
$mgr->{TmplData}{TEXT_LENG}= $text_length;  #zur Zeit $punktekosten=$text_length

}


#################################################################################
#CALL: $self->check_text_direction($mgr).					#						
#
#DESC: method use by lingua_text_new.tmpl					#						
#      Check if the User want:  						#
#	  to upload a text 	-> 	$self->show_text_upload($mgr)		#
#	  to save a text	->	$self->text_save($mgr) 			#
#	  else			->	$self->show_text_new($mgr)		#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)				#
#################################################################################

sub check_text_direction{
my ($self, $mgr) = @_;

my $title = $mgr->{CGI}->param('title') || undef;
my $text_cat_id = $mgr->{CGI}->param('text_cat_id') || undef;
my $text_lang_id = $mgr->{CGI}->param('text_desc_lang_id') || undef;
my $trans_lang_id = $mgr->{CGI}->param('trans_lang_id') || undef;
my $text = $mgr->{CGI}->param('mytext') || undef;

my $upload = $mgr->{CGI}->param('upload') || undef;
my $text_send = $mgr->{CGI}->param('send') || undef;

my $cat_mes=0;
my $lang_mes=0;
my $title_mes=0;
my $text_mes=0;
my $trans_mes=0;
my $same_mes=0;

if (defined $upload) { $self->show_text_upload($mgr); }

elsif(defined $text_send ) {

	if (!$title){$title_mes=1;}
	if (!$text_cat_id){$cat_mes=1;}
	if (!$text_lang_id){$lang_mes=1;}
	if (!$text){$text_mes=1;}
	if (!$trans_lang_id){$trans_mes=1;}
	if ((($trans_lang_id) and ($text_lang_id)) and ($trans_lang_id eq $text_lang_id)){$same_mes=1;}

	if ( ( (((($cat_mes==1) or ($lang_mes==1)) or ($title_mes==1)) or ($text_mes==1)) or ($trans_mes==1)) or ($same_mes==1)){

		#Hidden-Var des 2. Formular setzen.  
		$mgr->{TmplData}{PAGE_ACTION}=$mgr->{Action};
		$mgr->{TmplData}{PAGE_SID}= $mgr->{SessionId};
		my $lang = $mgr->{Language};
		$mgr->{TmplData}{PAGE_LANG}= $mgr->{SystemLangs}->{$lang};

		 $self->show_text_new($mgr, $cat_mes, $lang_mes, $title_mes, $text_mes, $trans_mes, $same_mes);


	} else { 
		### check_length & Kodierung erden in confirm_save gepr�ft.



#---------------------------Kodierung pr�fen----

	my @bytes    = split //, $text;
			my $lentgh   = @bytes;

			my $index=0;
			my $follower=0;
			my $bstring;

	#Kodierung pr�fen		
	while (($index < $lentgh) && ($follower<3)) {

		$bstring = sprintf "%08b", ord($bytes[$index]);

		if ($bstring =~ /^0/) {$follower = 0; }
		elsif ($bstring =~ /^110/) {$follower = 1; }
		elsif ($bstring =~ /^1110/){$follower = 2; }
		else {$follower = 3;}
	
		if ($follower == 0){$index = $index +1;}
		elsif ($follower == 1){
			if ($index+1 < $lentgh){			
				$index=$index+1;			
				$bstring = sprintf "%08b", ord($bytes[$index]);

				if ($bstring =~ /^10/ ){ $index = $index +1;}
				else {$follower=3;}
			}else {$follower=3;}
		}
					
		elsif ($follower == 2){
			if ($index+2 < $lentgh){
				$index=$index+1;
				$bstring = sprintf "%08b", ord($bytes[$index]);

				if ($bstring =~ /^10/){
					$index=$index+1;
					$bstring = sprintf "%08b", ord($bytes[$index]);
					
					if ($bstring =~ /^10/){$index = $index +1;}
					else {$follower=3;}
				}else{ $follower=3;}
		    	}else {$follower=3;}
		}
		

	} #end while

	my $meldung=0;
	if ($follower==3) {$meldung =1;}
	
#--------------------------------------------------
		$self->show_text_confirm_save($mgr, $meldung);




	 }
	
     }	
else { 
	#Hidden-Var des 2. Formular setzen.  
	$mgr->{TmplData}{PAGE_ACTION}=$mgr->{Action};
	$mgr->{TmplData}{PAGE_SID}= $mgr->{SessionId};
	my $lang = $mgr->{Language};
	$mgr->{TmplData}{PAGE_LANG}= $mgr->{SystemLangs}->{$lang};

	$self->show_text_new($mgr);
      }



}

#################################################################################
#CALL: $self->text_save($mgr).							#						
#
#DESC: save a text 								#
#										#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)				#
#################################################################################
sub text_save {
my ($self, $mgr) = @_;

my $original_text = $mgr->{CGI}->param('mytext') || undef;
my $lang_id = $mgr->{CGI}->param('text_desc_lang_id') || undef;
my $user_id =$mgr->{Session}->get("UserId");
my $text_cat_id = $mgr->{CGI}->param('text_cat_id') || undef;
my $trans_lang_id = $mgr->{CGI}->param('trans_lang_id') || undef;

my $num_words = $self->get_words($original_text);
my $utf_text = utf8($original_text);

#Punktzahl des Benutzers aktualisieren.
#my $punktcost = $mgr->{Points}->receive_text($mgr, $user_id, $num_words);



my $text_desc = $mgr->{CGI}->param('text_desc') || undef;

my $table = $mgr->{Tables}->{TEXT_ORIG};
my $dbh   = $mgr->connect(); 
my $sth;

$dbh->do("LOCK TABLES $table WRITE");
$sth = $dbh->prepare(<<SQL);

INSERT INTO $table (original_text, num_words, lang_id, trans_lang_id, user_id, category_id )
VALUES (?, ?, ?, ?, ?, ?)

SQL

unless ($sth->execute($utf_text, $num_words, $lang_id, $trans_lang_id, $user_id, $text_cat_id ))
    {
	warn sprintf("[Error:] Trouble adding user to %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
   }

$dbh->do("UNLOCK TABLES");
$sth->finish();

 
# get text_id
my $text_id = $sth->{mysql_insertid};


$self->title_save($mgr, $text_id, $lang_id);
if (defined $text_desc) {$self->description_save($mgr, $text_id, $lang_id);}

return $text_id;
}


#################################################################################################
#CALL: $self->title_save($mgr, $text_id, $lang_id).									#
#
#DESC:  Save a title of a text, a translation or a description								#
#      												#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)						#
#################################################################################################

sub title_save{
my ($self, $mgr, $text_id, $lang_id) = @_;

my $header_text = $mgr->{CGI}->param('title') || undef;
my $user_id =$mgr->{Session}->get("UserId");

my $utf_header_text = utf8($header_text);

my $table = $mgr->{Tables}->{TEXT_TITLE};
my $dbh   = $mgr->connect(); 
my $sth;

$dbh->do("LOCK TABLES $table WRITE");
$sth = $dbh->prepare(<<SQL);

INSERT INTO $table (header_text, lang_id, text_id, user_id)
VALUES (?, ?, ?, ?)

SQL

unless ($sth->execute($utf_header_text, $lang_id, $text_id, $user_id )) 
    {
	warn sprintf("[Error:] Trouble adding user to %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

$dbh->do("UNLOCK TABLES");   
 $sth->finish();

}



#################################################################################################
#CALL: $self->description_save($mgr, $text_id, $lang_id).							#						
#
#DESC: Save a Description of a text, a translation or a description				#
#      												#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)						#
#################################################################################################

sub description_save{
my ($self, $mgr, $text_id, $lang_id) = @_;

my $desc_text = $mgr->{CGI}->param('text_desc') || undef;
my $user_id =$mgr->{Session}->get("UserId");

my $utf_desc_text = utf8($desc_text);
my $table = $mgr->{Tables}->{TEXT_DESC};
my $dbh   = $mgr->connect(); 
my $sth;

$dbh->do("LOCK TABLES $table WRITE");
$sth = $dbh->prepare(<<SQL);

INSERT INTO $table (desc_text, lang_id, text_id, user_id)
VALUES (?, ?, ?, ?)

SQL

unless ($sth->execute($utf_desc_text, $lang_id, $text_id, $user_id )) 
    {
	warn sprintf("[Error:] Trouble adding user to %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

$dbh->do("UNLOCK TABLES");   
 $sth->finish();

}

#################################################################################################
#CALL: $self->get_punktkosten($mgr,$words).								
#
#RETURN:  $counter
#											
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)					
#################################################################################################
sub get_punktkosten{
my ($self, $mgr, $words) = @_;  

my $pointscost = ($mgr->{TextPoints}) * $words;

return $pointscost;

}







#################################################################################################
#CALL: $self->get_words($text).								
#
#RETURN:  $counter
#
#utilisation du tabulateur et leerZeichen avant le mot -> probleme
#											
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)					
#################################################################################################
sub get_words{
   my ($self,$text) = @_;

my @zeiles = split(/\n/, $text);
my $counter = 0;
my @words;

	foreach my $zeile (@zeiles){
		if (length($zeile)==1) {
			my $bstring = sprintf "%08b", ord($zeile);
			if (!($bstring eq '00001101')){
				@words= split(/ +/,$zeile);
				$counter = $counter + @words;
			}

		}else{ 
			@words= split(/ +/,$zeile);	
			$counter = $counter + @words;
		}
	}	
return $counter;
}



#################################################################################################
#CALL: $self->show_text_upload($mgr).								#						
#
#DESC: show lingua_text_upload.tmpl  & note actual input of Template_Text_New			#
#												#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)						#
#################################################################################################
sub show_text_upload{
  my ($self, $mgr) = @_;

my $title = $mgr->{CGI}->param('title') || "";
my $textcat = $mgr->{CGI}->param('text_cat_id') || "";
my $textlang = $mgr->{CGI}->param('text_desc_lang_id') || "";
my $trans_lang = $mgr->{CGI}->param('trans_lang_id') || "";

my $description = $mgr->{CGI}->param('text_desc') || "";
my $submit = $mgr->{CGI}->param('sendup') || undef;
my $filename = $mgr->{CGI}->param('file') || undef;


my $text_from_file;
my $text_length;

my $buff;
my $size=1000001; #File max size

if (defined $submit){
	
	if (defined $filename){
#------------------------------------------------------------------------			
		#Datei lesen
		while (my $bytes_read = read($filename, my $buff, 2048)) {
                	$text_length += $bytes_read;
			$text_from_file .= $buff;
	       	}
	#size pr�fen
	if ($text_length < $size){
#check points
			my @bytes    = split //, $text_from_file;
			my $lentgh   = @bytes;

			my $index=0;
			my $follower=0;
			my $bstring;

	#Kodierung pr�fen		
	while (($index < $lentgh) && ($follower<3)) {

		$bstring = sprintf "%08b", ord($bytes[$index]);

		if ($bstring =~ /^0/) {$follower = 0; }
		elsif ($bstring =~ /^110/) {$follower = 1; }
		elsif ($bstring =~ /^1110/){$follower = 2; }
		else {$follower = 3;}
	
		if ($follower == 0){$index = $index +1;}
		elsif ($follower == 1){
			if ($index+1 < $lentgh){			
				$index=$index+1;			
				$bstring = sprintf "%08b", ord($bytes[$index]);

				if ($bstring =~ /^10/ ){ $index = $index +1;}
				else {$follower=3;}
			}else {$follower=3;}
		}
					
		elsif ($follower == 2){
			if ($index+2 < $lentgh){
				$index=$index+1;
				$bstring = sprintf "%08b", ord($bytes[$index]);

				if ($bstring =~ /^10/){
					$index=$index+1;
					$bstring = sprintf "%08b", ord($bytes[$index]);
					
					if ($bstring =~ /^10/){$index = $index +1;}
					else {$follower=3;}
				}else{ $follower=3;}
		    	}else {$follower=3;}
		}
		

	} #end while

		
		if ($follower==3) {
			#Falsche Kodierung
			#*** fell-upload-tmpl with ERROR1 *************************************
			$mgr->{TmplData}{PAGE_LANG_002003} = $mgr->{Func}->get_text($mgr, 2003);
			$mgr->{TmplData}{PAGE_LANG_002004} = $mgr->{Func}->get_text($mgr, 2004);
	
			$mgr->{Template} = $mgr->{TmplFiles}->{Text_Upload};

			$mgr->{TmplData}{TEXT_TITLE}=$title;
			$mgr->{TmplData}{TEXT_DESCRIPTION}=$description;
			$mgr->{TmplData}{TEXT_LANG}=$textlang;
			$mgr->{TmplData}{TEXT_CAT}=$textcat;
			$mgr->{TmplData}{TEXT_TRANS_LANG}=$trans_lang;


			#Hidden-Var des 2. Formular setzen.  
			$mgr->{TmplData}{PAGE_ACTION}=$mgr->{Action};
			$mgr->{TmplData}{PAGE_SID}= $mgr->{SessionId};
			my $lang = $mgr->{Language};
			$mgr->{TmplData}{PAGE_LANG}= $mgr->{SystemLangs}->{$lang};

			$mgr->{TmplData}{ERROR_MESS}=$mgr->{Func}->get_text($mgr, 3000);
			$index=$index +1;
			my $error_mess=$mgr->{Func}->get_text($mgr, 3001);
			$mgr->{TmplData}{ERROR_INDEX}=  "$error_mess"." $index";
			#****************************************

		}

		else{ 
			#Kodierung OK 
# +++++++++++++++++++++ Wird sp�ter gel�scht.+++++++++++++++++++++
	#------------------------ Datei up.html erstellen und Text in DB speichern -----------------------------------------
open(MY, '>up.html');
print MY "<html> <head>\n";
print MY "<meta http-equiv='content-type' content='text/html; charset=utf-8'>\n";
print MY "</head> <body>\n";
print MY "<p> Upload OK\n";
print MY "<p>Size: $text_length Byte\n";

print MY "<br><font color
='blue' size=4>Datei richtig Kodiert:</font><br>\n";
print MY "$text_from_file <form>\n";
print MY "<br>";
print MY "<TEXTAREA NAME='mytext'rows=20 cols='80'>$text_from_file</TEXTAREA> \n";
print MY "<br>\n";			
print MY "</form>\n";
close MY;


my $T_num_words=10;
my $T_lang_id=1;
my $T_user_id=1;
my $T_text_cat_id=12;

my $T_table = $mgr->{Tables}->{TEXT_ORIG};
my $T_dbh   = $mgr->connect(); 
my $T_sth;

$T_dbh->do("LOCK TABLES $T_table WRITE");
$T_sth = $T_dbh->prepare(<<SQL);

INSERT INTO $T_table (original_text, num_words, lang_id, user_id, category_id )
VALUES (?, ?, ?, ?, ?)

SQL

unless ($T_sth->execute($text_from_file, $T_num_words, $T_lang_id, $T_user_id, $T_text_cat_id ))
    {
	warn sprintf("[Error:] Trouble adding user to %s. " .
		     "Reason: [%s].", $T_table, $T_dbh->errstr());
	$T_dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

my $original_id_T= $T_sth->{mysql_insertid};

$T_dbh->do("UNLOCK TABLES");
 $T_sth->finish();

	#-------------------- Text vom DB lesen -----------------------------------------

my $table_T = $mgr->{Tables}->{TEXT_ORIG};


  my $dbh_T = $mgr->connect();
  my $sth_T = $dbh_T->prepare(<<SQL);

SELECT original_text
FROM   $table_T
WHERE  original_id = ?

SQL

  unless ($sth_T->execute($original_id_T)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table_T, $dbh_T->errstr());
    $mgr->fatal_error("Database error.");
  }

  my $T_text = $sth_T->fetchrow_array();

  $sth_T->finish();
	#------------------------------ upDB.html erstellen ---------------------------------------

open(TMY, '>upDB.html');
print TMY "<html> <head>\n";
print TMY "<meta http-equiv='content-type' content='text/html; charset=utf-8'>\n";
print TMY "</head> <body>\n";
print TMY "<p> Speicherung OK\n";
print TMY "<p>Size: $text_length Byte\n";

print TMY "<br><font color='blue' size=4>Lese Ergebniss:</font><br>\n";
print TMY "$T_text <form>\n";
print TMY "<br>";
print TMY "<TEXTAREA NAME='mytext'rows=20 cols='80'>$T_text</TEXTAREA> \n";
print TMY "<br>\n";			
print TMY "</form>\n";
close TMY;

#+++++++++++++++++++++++++++++++++++++++ Bis hier +++++++++++++++++++++++++++++++++++++++++++++


			$self->show_text_new($mgr, 0, 0, 0, 0, 0, 0, $text_from_file,$text_length);
		}
	 }else{
		#$text_length >= $size (Datei zu gro�)

		#*** fell-upload-tmpl with Error *************************************
		$mgr->{TmplData}{PAGE_LANG_002003} = $mgr->{Func}->get_text($mgr, 2003);
		$mgr->{TmplData}{PAGE_LANG_002004} = $mgr->{Func}->get_text($mgr, 2004);

		$mgr->{Template} = $mgr->{TmplFiles}->{Text_Upload};

		$mgr->{TmplData}{TEXT_TITLE}=$title;
		$mgr->{TmplData}{TEXT_DESCRIPTION}=$description;
		$mgr->{TmplData}{TEXT_LANG}=$textlang;
		$mgr->{TmplData}{TEXT_CAT}=$textcat;
		$mgr->{TmplData}{TEXT_TRANS_LANG}=$trans_lang;

		#Hidden-Var des 2. Formular setzen.  
		$mgr->{TmplData}{PAGE_ACTION}=$mgr->{Action};
		$mgr->{TmplData}{PAGE_SID}= $mgr->{SessionId};
		my $lang = $mgr->{Language};
		$mgr->{TmplData}{PAGE_LANG}= $mgr->{SystemLangs}->{$lang};
	
		$mgr->{TmplData}{ERROR_MESS}=$mgr->{Func}->get_text($mgr, 3002); 
		my $error_mess1=$mgr->{Func}->get_text($mgr, 3003); 
		$mgr->{TmplData}{ERROR_INDEX}="$error_mess1"." $text_length Byt";
		#************************************************************************

	}

	}else{
		#submit defined & filename not defined -> return to text_new
		$self->show_text_new($mgr);}
	

}else{
	#submit not defined
	#*** fell-upload-tmpl *************************************
	$mgr->{TmplData}{PAGE_LANG_002003} = $mgr->{Func}->get_text($mgr, 2003);
	$mgr->{TmplData}{PAGE_LANG_002004} = $mgr->{Func}->get_text($mgr, 2004);
	
	$mgr->{Template} = $mgr->{TmplFiles}->{Text_Upload};

	$mgr->{TmplData}{TEXT_TITLE}=$title;
	$mgr->{TmplData}{TEXT_DESCRIPTION}=$description;
	$mgr->{TmplData}{TEXT_LANG}=$textlang;
	$mgr->{TmplData}{TEXT_CAT}=$textcat;
	$mgr->{TmplData}{TEXT_TRANS_LANG}=$trans_lang;

	#Hidden-Var des 2. Formular setzen.  
	$mgr->{TmplData}{PAGE_ACTION}=$mgr->{Action};
	$mgr->{TmplData}{PAGE_SID}= $mgr->{SessionId};
	my $lang = $mgr->{Language};
	$mgr->{TmplData}{PAGE_LANG}= $mgr->{SystemLangs}->{$lang};
	#****************************************
}
	

}

#########################################################################################################################################
#CALL: $self->show_text_description($mgr).													#						
#
#DESC: show the Template_Text_Description   ~~~~> (for new description[empty] or if param are missing[with message over missing param])	#
#      			or														#
#	Call  $self->description_save($mgr,$text_id)  ~~~~> (Template_Text_Description have been submit & all param are defined)			#																#
#	      $self->title_save($mgr,$text_id)
#	
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)									#
#########################################################################################################################################

sub show_text_description {
  my ($self, $mgr) = @_;

my $title = $mgr->{CGI}->param('title') || undef;
my $desc = $mgr->{CGI}->param('text_desc') || undef;
my $desc_lang_id = $mgr->{CGI}->param('text_desc_lang_id') || undef;
my $submit = $mgr->{CGI}->param('send_desc') || undef;
my $text_id = $mgr->{CGI}->param('text_id') || undef;

if ( (((defined $title) && (defined $desc))  && (defined $desc_lang_id)) && (defined $submit) ) {

	if ($text_id){
	# chech if text_id are in the template
		my $check_lang_id = $self->get_text_desc_langs($mgr, $text_id, $desc_lang_id);
		
		if (!$check_lang_id){
		# chech if the actual text_desc are in the DB
	
			$self->description_save($mgr, $text_id, $desc_lang_id);
			$self->title_save($mgr, $text_id, $desc_lang_id);

			##### Confirmation###########
			my $mes1_002015= $mgr->{Func}->get_text($mgr, 2015); 
			my $mes2_002016= $mgr->{Func}->get_text($mgr, 2016); 
		
			$mgr->{TmplData}{TEXT_ID} = $text_id;
			$mgr->{TmplData}{TEXT_MES1_DICO} = 2015;
			$mgr->{TmplData}{TEXT_MES2_DICO} = 2016;

			$self->show_text_message($mgr, $mes1_002015, $mes2_002016);
		}else { 
		

			if (defined $desc_lang_id ){
				$mgr->{TmplData}{TEXT_LANG_ID_SELECT} = $desc_lang_id;
				my $nr = $self->get_lang_name_id($mgr,$desc_lang_id);
				my $lang_name = $mgr->{Func}->get_text($mgr, $nr);
			
				$mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= $lang_name ; }

			else{ $mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= '-----------'; }
	
				$mgr->{TmplData}{TEXT_TITLE} = $title; 
				$mgr->{TmplData}{TEXT_DESC} = $desc; 
				$mgr->{TmplData}{TEXT_ID} = $text_id;
	
				#setze le loop_lang
				my @lang_loop_data=();
				my @ray = $mgr->{Func}->get_langs($mgr,'all');
				my $elem;
	
				foreach $elem (@ray){
					my %data;
					$data{TEXT_LANG_ID}= $$elem[0];
					$data{TEXT_LANG_NAME}= $$elem[1];
	
					push(@lang_loop_data,\%data); 
				}
 
				$mgr->{TmplData}{TEXT_LOOP_LANG}=\@lang_loop_data;
	
				$mgr->{TmplData}{PAGE_LANG_002008} = $mgr->{Func}->get_text($mgr, 2008);
    				$mgr->{TmplData}{PAGE_LANG_002010} = $mgr->{Func}->get_text($mgr, 2010);
				$mgr->{TmplData}{PAGE_LANG_002012} = $mgr->{Func}->get_text($mgr, 2012);
				$mgr->{TmplData}{PAGE_LANG_002014} = $mgr->{Func}->get_text($mgr, 2014);	
				$mgr->{TmplData}{PAGE_LANG_002026} = $mgr->{Func}->get_text($mgr, 2026);
				$mgr->{TmplData}{PAGE_LANG_002027} = $mgr->{Func}->get_text($mgr, 2027);
		
				$mgr->{TmplData}{TEXT_LANG_MES_002045} = $mgr->{Func}->get_text($mgr, 2045);

				$mgr->{Template} = $mgr->{TmplFiles}->{Text_Description};

		}
	
	}else{
	#### Error tmpl. ####
	## Text_id is not in the template. The teyt can not be save
	}
}else{
	

	if (defined $desc_lang_id ){
		$mgr->{TmplData}{TEXT_LANG_ID_SELECT} = $desc_lang_id;
		my $nr = $self->get_lang_name_id($mgr,$desc_lang_id);
		my $lang_name = $mgr->{Func}->get_text($mgr, $nr);
		
		$mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= $lang_name ; }

	else{ $mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= '-----------'; }

	$mgr->{TmplData}{TEXT_TITLE} = $title; 
	$mgr->{TmplData}{TEXT_DESC} = $desc; 
	$mgr->{TmplData}{TEXT_ID} = $text_id;

	#setze le loop_lang
	my @lang_loop_data=();
	my @ray = $mgr->{Func}->get_langs($mgr,'all');
	my $elem;

	foreach $elem (@ray){
		my %data;
		$data{TEXT_LANG_ID}= $$elem[0];
		$data{TEXT_LANG_NAME}= $$elem[1];

		push(@lang_loop_data,\%data); }
 
	$mgr->{TmplData}{TEXT_LOOP_LANG}=\@lang_loop_data;
	
	$mgr->{TmplData}{PAGE_LANG_002008} = $mgr->{Func}->get_text($mgr, 2008);
    	$mgr->{TmplData}{PAGE_LANG_002010} = $mgr->{Func}->get_text($mgr, 2010);
	$mgr->{TmplData}{PAGE_LANG_002012} = $mgr->{Func}->get_text($mgr, 2012);
	$mgr->{TmplData}{PAGE_LANG_002014} = $mgr->{Func}->get_text($mgr, 2014);	
	$mgr->{TmplData}{PAGE_LANG_002026} = $mgr->{Func}->get_text($mgr, 2026);
	$mgr->{TmplData}{PAGE_LANG_002027} = $mgr->{Func}->get_text($mgr, 2027);

	$mgr->{Template} = $mgr->{TmplFiles}->{Text_Description};

	if (defined $submit) {
		if (!$title){$mgr->{TmplData}{TEXT_TITLE_MES_002011}= $mgr->{Func}->get_text($mgr, 2011);}
		if (!$desc){ $mgr->{TmplData}{TEXT_DESC_MES_002013}= $mgr->{Func}->get_text($mgr, 2013);}
		if (!$desc_lang_id){$mgr->{TmplData}{TEXT_LANG_MES_002009}= $mgr->{Func}->get_text($mgr, 2009);}
     		}

}


}

#########################################################################################################
#CALL: $self->show_text_message($mgr,$mes1, $mes2).							#
#	$mes1 = first message.										#
#	$mes2 = second message.										#
#													#
#DESC: Send any message to the user & note the Dict_ID of the message(hidden param)			#
#      if user change the language, the 'hidden' Dict_ID will be use to search the message in DB	#
#
#NOTE:  bevor call this function you have to save the Messsage_Dict_ID in:     				#
#	$mgr->{TmplData}{TEXT_MES1_DICO} = Dict_id of $mes1							#
#	$mgr->{TmplData}{TEXT_MES2_DICO} = Dict_id of $mes2							#
#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)							#
#########################################################################################################

sub show_text_message{
  my ($self, $mgr, $mes1, $mes2) = @_;

if (defined $mes1){ $mgr->{TmplData}{TEXT_MESSAGE_1}= $mes1; }
if (defined $mes2){ $mgr->{TmplData}{TEXT_MESSAGE_2}= $mes2; }

$mgr->{TmplData}{PAGE_LANG_002005} = $mgr->{Func}->get_text($mgr, 2005);
$mgr->{TmplData}{PAGE_LANG_002006} = $mgr->{Func}->get_text($mgr, 2006);
#$mgr->{TmplData}{PAGE_LANG_002007} = $mgr->{Func}->get_text($mgr, 2007);


$mgr->{Template} = $mgr->{TmplFiles}->{Text_Message};

}




#########################################################################################################
#CALL: $self->show_way($mgr).										#
#													#
#DESC: show Template_Text_New		~~~> 	if 'New Text' have been clicked				#
#      show Template_Text_Description   ~~~>    if 'New Description' have been clicked			#
#      show  ????????			~~~>    if 'See Text' have been click ed				#
#      change langue & show Template_Text_Meassage  ~~~>  if user want to change the Language 		#
#													#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)							#
#########################################################################################################

sub show_way{
  my ($self, $mgr) = @_;

my $new_text = $mgr->{CGI}->param('new_text') || undef;
my $see_text = $mgr->{CGI}->param('see_text') || undef;
my $new_desc = $mgr->{CGI}->param('new_desc') || undef;
my $mes1_dico = $mgr->{CGI}->param('mes1_dico') || undef;
my $mes2_dico = $mgr->{CGI}->param('mes2_dico') || undef;
my $text_trans_contents = $mgr->{CGI}->param('text_trans_contents') || undef; #added by Hendrik
my $delete_text = $mgr->{CGI}->param('delete_text') || undef; #added by Hendrik
my $show_text = $mgr->{CGI}->param('show_text') || undef; #added by Hendrik

if (defined $new_text){ $self->show_text_new($mgr); }
elsif (defined $see_text){ $self->show_text_see($mgr); }
elsif (defined $new_desc){ $self->show_text_description($mgr); }
elsif (defined $text_trans_contents){ $self->show_trans_desc($mgr); } #added by Hendrik
elsif (defined $delete_text){ $self->delete_text($mgr); } #added by Hendrik
elsif (defined $show_text){ $self->show_text_see($mgr); } #added by Hendrik
elsif ((defined $mes1_dico) && (defined $mes2_dico) ) {



my $mes1 = $mgr->{Func}->get_text($mgr, $mes1_dico); 
my $mes2 = $mgr->{Func}->get_text($mgr, $mes2_dico); 
$mgr->{TmplData}{TEXT_MES1_DICO} = $mes1_dico;
$mgr->{TmplData}{TEXT_MES2_DICO} = $mes2_dico;
	
$self->show_text_message($mgr, $mes1, $mes2);

	   }



}

#########################################################################################################################################
#CALL: $self->show_text_confirm_save($mgr, $message).													#
#																	#
#														#
#DESC:  														#
#																	#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)											#
#########################################################################################################################################

sub show_text_confirm_save{

	my ($self, $mgr, $message) = @_;

my $title = $mgr->{CGI}->param('title') || undef;
my $text_cat_id = $mgr->{CGI}->param('text_cat_id') || undef;
my $text_lang_id = $mgr->{CGI}->param('text_desc_lang_id') || undef;
my $trans_lang_id = $mgr->{CGI}->param('trans_lang_id') || undef;
my $text = $mgr->{CGI}->param('mytext') || undef;
my $text_desc = $mgr->{CGI}->param('text_desc') || undef;

my $text_change = $mgr->{CGI}->param('text_change') || undef;
my $text_save = $mgr->{CGI}->param('text_save') || undef;

my $text_id;

if (defined $text_change){
	#�nderungen vornehmen
	$self->show_text_new($mgr);}

elsif (defined $text_save){
		#Text wird in DB gespeichert		
		$text_id = $self->text_save($mgr);

		##### Confirmation###########
		my $mes1_002035= $mgr->{Func}->get_text($mgr, 2035); 
		my $mes2_002036= $mgr->{Func}->get_text($mgr, 2036); 

		$mgr->{TmplData}{TEXT_MES1_DICO} = 2035;
		$mgr->{TmplData}{TEXT_MES2_DICO} = 2036;
		$mgr->{TmplData}{TEXT_ID} = $text_id;
		$self->show_text_message($mgr, $mes1_002035, $mes2_002036);
 
}else{
		#Text_Confirm_Save anzeigen
		my $title_mess_002039 	= $mgr->{Func}->get_text($mgr, 2039);
		my $Code_mess2_002040 	= $mgr->{Func}->get_text($mgr, 2040); 
		my $length_mess2_002041 = $mgr->{Func}->get_text($mgr, 2041); 
		my $punct_tomove_mess2_002042 = $mgr->{Func}->get_text($mgr, 2042); 
		my $act_punct_mess2_002043 = $mgr->{Func}->get_text($mgr, 2043); 
		my $new_punct_mess2_002044 = $mgr->{Func}->get_text($mgr, 2044); 

############ Provisoire
my $user_id = $mgr->{UserData}{UserId};
my $punkt =$mgr->{Points}->get_activ_points($mgr, $user_id);
my $text_length = $self->get_words($text); #longueuer du texte
my $punktekosten = $self->get_punktkosten($mgr,$text_length);
my $new_punktstand= $punkt -$punktekosten;
my $unicode_mess='Unicode utf8';

if ((defined $message) and ($message==1)){ 
	$unicode_mess='????'; 
	$mgr->{TmplData}{PAGE_LANG_002037} ='';
	$mgr->{TmplData}{INPUT_TYPE}='hidden';
	$mgr->{TmplData}{PAGE_LANG_003505} = $mgr->{Func}->get_text($mgr, 3505);

}


		my @array_data = (
				{ TEXT_MESS  => $title_mess_002039 ,       TEXT_MESS_VAL  => $title} ,
				{ TEXT_MESS  => $Code_mess2_002040 ,       TEXT_MESS_VAL  => $unicode_mess} ,
				{ TEXT_MESS  => $length_mess2_002041 ,     TEXT_MESS_VAL  => $text_length } ,
				{ TEXT_MESS  => $punct_tomove_mess2_002042,TEXT_MESS_VAL  => $punktekosten } ,
				{ TEXT_MESS  => $act_punct_mess2_002043  ,  TEXT_MESS_VAL => $punkt},
				{ TEXT_MESS  => $new_punct_mess2_002044 ,  TEXT_MESS_VAL  =>  $new_punktstand}
			      );
		
		$mgr->{TmplData}{TEXT_LOOP_MES}=\@array_data;			

		if ($new_punktstand<0){
			$mgr->{TmplData}{PAGE_LANG_002037} ='';
			$mgr->{TmplData}{INPUT_TYPE}='hidden';
			$mgr->{TmplData}{PAGE_LANG_003504} = $mgr->{Func}->get_text($mgr, 3504);
		}else{
			if ($message==1){
			}else{
				$mgr->{TmplData}{PAGE_LANG_002037} = $mgr->{Func}->get_text($mgr, 2037);
				$mgr->{TmplData}{INPUT_TYPE}='submit';
			}
		}


		$mgr->{TmplData}{PAGE_LANG_002038} = $mgr->{Func}->get_text($mgr, 2038);
		$mgr->{TmplData}{TEXT_TITLE} = $title ;
		$mgr->{TmplData}{TEXT_DESCRIPTION}= $text_desc;
		$mgr->{TmplData}{TEXT_LANG}=$text_lang_id;
		$mgr->{TmplData}{TEXT_TRANS_LANG}=$trans_lang_id;
		$mgr->{TmplData}{TEXT_CAT}=$text_cat_id;
		$mgr->{TmplData}{TEXT}=$text;

		#$mgr->{TmplData}{TEXT_COUNTER}=$textcounter;
		#$mgr->{TmplData}{FREI_COUNTER}=$freicounter;

		$mgr->{Template} = $mgr->{TmplFiles}->{Text_Conf_Save};



     }
}






#########################################################################################################################################
#CALL: $self->get_below_cats($mgr).													#
#																	#
#RETURN: @array of {Cat_id & Cat_name in the actual language} of the below Categories (no parent <=> cat_count=0)			#
#	 (Ex. lang=de  ({CAT_ID => 8, CAT_NAME =>'�gyptologie'}, {CAT_ID => 14, CAT_NAME =>'V�lkerkunde'} )   				#													#
#																	#
#DESC: See SQL Statement. 														#
#																	#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)											#
#########################################################################################################################################

sub get_below_cats {
  my ($self, $mgr) = @_;

  # Language table name from the current system language.
  my $lang  = $mgr->{SystemLangs}->{$mgr->{Language}};

  # Names for the categories and dictionary table.
  my $table_cats = $mgr->{Tables}->{CATS};
  my $table_dict = $mgr->{Tables}->{DICT};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT c.cat_id, d.$lang FROM $table_cats c, $table_dict d
WHERE c.cat_count=0 AND d.dict_id = c.lang_id 

SQL

  unless ($sth->execute()) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
                 "Reason: [%s].", $table_cats, $table_dict, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

my @cats;

  # Push all the selected values into an array.
 
 while (my $ref = $sth->fetchrow_hashref() ){
my %data;
$data{TEXT_CAT_ID} = $ref->{'cat_id'};
$data{TEXT_CAT_NAME} = $ref->{"$lang"};
    push (@cats,\%data);

  }

  $sth->finish();

  return @cats;

}

#################################################################
#CALL: $self->get_below_cats($mgr, $lang_id).			#
#								#
#RETURN: $lang_name in the actual language			#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)		#
#################################################################

sub get_lang_name_id {
  my ($self, $mgr, $lang_id) = @_;

  my $table = $mgr->{Tables}->{LANG};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT lang_name_id
FROM   $table
WHERE  lang_id = ?

SQL

  unless ($sth->execute($lang_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my $lang_name = $sth->fetchrow_array();

  $sth->finish();

  return $lang_name;
}


#################################################################
#CALL: $self->get_text_desc_langs($mgr, $text_id, $lang_id).	#
#								#
#RETURN: @langs_id all languages of the present descriptions of the text
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)		#
#################################################################

sub get_text_desc_langs {
  my ($self, $mgr, $text_id, $lang_id) = @_;

  my $table = $mgr->{Tables}->{TEXT_DESC};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT lang_id
FROM   $table
WHERE  text_id = ? AND lang_id = ?

SQL

  unless ($sth->execute($text_id, $lang_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my $langs_id = $sth->fetchrow_array();

  $sth->finish();

  return $langs_id;
}




#########################################################################################################################################
#CALL: $self->get_text_title_desc($mgr, $text_id).													#
#																	#
#RETURN: 
#																#
#DESC: See SQL Statement. 														#
#																	#
#Author: Guy Nokam (floreguy@cs.tu-berlin.de)
#########################################################################################################################################

sub get_text_title_desc {
  my ($self, $mgr, $text_id) = @_;


  # Names for the categories and dictionary table.
  my $table_text = $mgr->{Tables}->{TEXT_ORIG};
  my $table_desc = $mgr->{Tables}->{TEXT_DESC};
  my $table_header = $mgr->{Tables}->{TEXT_TITLE};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT t.original_text, d.desc_text, h.header_text 
FROM $table_text t, $table_desc d, $table_header h
WHERE t.original_id = ? AND d.text_id = t.original_id AND h.text_id = t.original_id AND d.user_id = t.user_id AND h.user_id = t.user_id 

SQL

  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
                 "Reason: [%s].", $table_text, $table_desc, $table_header, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

my %data;

  # Push all the selected values into an array.
 
 while (my $ref = $sth->fetchrow_hashref() ){
$data{TEXT} = $ref->{'original_text'};
$data{TITLE} = $ref->{'header_text'};
$data{DESC} = $ref->{'desc_text'};
  }

  $sth->finish();

  return %data;

}






#########################################################################################################################################
#CALL: $self->show_trans_desc($mgr).													#
#																	#
#RETURN:
#																	#
#DESC:  														#
#																	#
#Author: # Guy Nokam
#########################################################################################################################################

sub show_trans_desc{
  my ($self, $mgr) = @_;


my $text_id = $mgr->{CGI}->param('text_id') || undef;

my $send_desc = $mgr->{CGI}->param('send_desc') || undef;
my $trans_desc_lang_id = $mgr->{CGI}->param('text_desc_lang_id') || undef;
my $trans_title = $mgr->{CGI}->param('trans_title') || undef;
my $trans_desc = $mgr->{CGI}->param('trans_desc') || undef;

###Schnitstelle avec hendrick von text_ansehen 
#my $new_trans = $mgr->{CGI}->param('text_id') || undef;
# et nom de son button

my %select_data = $self->get_text_title_desc($mgr, $text_id);


if (defined $send_desc){

	if ((defined $trans_desc_lang_id ) && (defined  $trans_title)) {

		### Speichern Text_id trans_title trans_desc dans text_trans_contenns
		$mgr->{TmplData}{TITLE} = $trans_title;
		$mgr->{TmplData}{DESC} = $trans_desc;
		$mgr->{TmplData}{TEXT_ID} = $text_id;
		
		$self->show_trans_contents($mgr, 1);
	}else{		
	
		if (defined $trans_desc_lang_id){
			$mgr->{TmplData}{TEXT_LANG_ID_SELECT}=$trans_desc_lang_id;
			my $nr = $self->get_lang_name_id($mgr,$trans_desc_lang_id);
			my $lang_name = $mgr->{Func}->get_text($mgr, $nr);
			$mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= $lang_name ; }

		else{ 
			$mgr->{TmplData}{PAGE_LANG_002511} = $mgr->{Func}->get_text($mgr, 2511);
			$mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= '-----------'; }

			my @lang_loop_data=();
			my @ray = $mgr->{Func}->get_langs($mgr,'all');
			my $elem;

			foreach $elem (@ray){
				my %data;
				$data{TEXT_LANG_ID}= $$elem[0];
				$data{TEXT_LANG_NAME}= $$elem[1];

				push(@lang_loop_data,\%data);

				}

			$mgr->{TmplData}{TEXT_LOOP_LANG}=\@lang_loop_data;

		if (!$trans_title){ $mgr->{TmplData}{PAGE_LANG_002514} = $mgr->{Func}->get_text($mgr, 2514);}

		#if (!$trans_desc ){ $mgr->{TmplData}{PAGE_LANG_002518} = $mgr->{Func}->get_text($mgr, 2518);}

		######SETZEN LE CONTENU
		$mgr->{TmplData}{TEXT_TITLE} = $select_data{TITLE};
		$mgr->{TmplData}{TEXT_DESC} = $select_data{DESC};
		$mgr->{TmplData}{TRANS_TITLE} = $trans_title;
		$mgr->{TmplData}{TRANS_DESC} =$trans_desc;
		$mgr->{TmplData}{TEXT_ID}=$text_id;
		
		$mgr->{TmplData}{PAGE_LANG_002510} = $mgr->{Func}->get_text($mgr, 2510);
		$mgr->{TmplData}{PAGE_LANG_002512} = $mgr->{Func}->get_text($mgr, 2512);
		$mgr->{TmplData}{PAGE_LANG_002513} = $mgr->{Func}->get_text($mgr, 2513);
		$mgr->{TmplData}{PAGE_LANG_002516} = $mgr->{Func}->get_text($mgr, 2516);
		$mgr->{TmplData}{PAGE_LANG_002517} = $mgr->{Func}->get_text($mgr, 2517);
		$mgr->{TmplData}{PAGE_LANG_002520} = $mgr->{Func}->get_text($mgr, 2520);	

		$mgr->{Template} = $mgr->{TmplFiles}->{Text_Trans_Desc};
		}
}else{
	##########Language##################################
	if (defined $trans_desc_lang_id){
			$mgr->{TmplData}{TEXT_LANG_ID_SELECT}=$trans_desc_lang_id;
			my $nr = $self->get_lang_name_id($mgr,$trans_desc_lang_id);
			my $lang_name = $mgr->{Func}->get_text($mgr, $nr);
			$mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= $lang_name ; }

		else{ 
			$mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= '-----------'; }

			my @lang_loop_data=();
			my @ray = $mgr->{Func}->get_langs($mgr,'all');
			my $elem;

			foreach $elem (@ray){
				my %data;
				$data{TEXT_LANG_ID}= $$elem[0];
				$data{TEXT_LANG_NAME}= $$elem[1];

				push(@lang_loop_data,\%data);

				}

			$mgr->{TmplData}{TEXT_LOOP_LANG}=\@lang_loop_data;
		
		###### LAS PAGES VARIABLES
		$mgr->{TmplData}{PAGE_LANG_002510} = $mgr->{Func}->get_text($mgr, 2510);
		$mgr->{TmplData}{PAGE_LANG_002512} = $mgr->{Func}->get_text($mgr, 2512);
		$mgr->{TmplData}{PAGE_LANG_002513} = $mgr->{Func}->get_text($mgr, 2513);
		$mgr->{TmplData}{PAGE_LANG_002516} = $mgr->{Func}->get_text($mgr, 2516);
		$mgr->{TmplData}{PAGE_LANG_002517} = $mgr->{Func}->get_text($mgr, 2517);
		$mgr->{TmplData}{PAGE_LANG_002520} = $mgr->{Func}->get_text($mgr, 2520);

		
		######SETZEN LE CONTENU
		$mgr->{TmplData}{TEXT_TITLE} = $select_data{TITLE};
		$mgr->{TmplData}{TEXT_DESC} = $select_data{DESC};
		$mgr->{TmplData}{TRANS_TITLE} = $trans_title;
		$mgr->{TmplData}{TRANS_DESC} =$trans_desc;
		$mgr->{TmplData}{TEXT_ID}=$text_id;

			$mgr->{Template} = $mgr->{TmplFiles}->{Text_Trans_Desc};
 

}


}

########################################################################################################################################
#CALL: $self->show_trans_contents($mgr).													#
#																	#
#RETURN:
#																	#
#DESC:  														#
#																	#
#Author: # Guy Nokam
#########################################################################################################################################

sub show_trans_contents{
  my ($self, $mgr, $rel) = @_;

#my $trans_desc_change = $mgr->{CGI}->param('trans_desc_change') || undef;
my $trans_send = $mgr->{CGI}->param('trans_send') || undef;
my $mytext = $mgr->{CGI}->param('mytext') || undef;
my $text_id = $mgr->{CGI}->param('text_id') || undef;
my $trans_title = $mgr->{CGI}->param('title') || undef;
my $trans_desc = $mgr->{CGI}->param('text_desc') || undef;

my %select_data = $self->get_text_title_desc($mgr, $text_id);

if(defined  $trans_send){
	
	if(!(defined  $mytext)){
		$mgr->{Template} = $mgr->{TmplFiles}->{Text_Trans_contents};
		$mgr->{TmplData}{PAGE_LANG_002502} = $mgr->{Func}->get_text($mgr, 2502);

		$mgr->{TmplData}{PAGE_LANG_002500} = $mgr->{Func}->get_text($mgr, 2500);
		$mgr->{TmplData}{PAGE_LANG_002501} = $mgr->{Func}->get_text($mgr, 2501);
		$mgr->{TmplData}{PAGE_LANG_002505} = $mgr->{Func}->get_text($mgr, 2505);

		$mgr->{TmplData}{TITLE} = $trans_title;
		$mgr->{TmplData}{DESC} = $trans_desc;
		$mgr->{TmplData}{TEXT_ID} = $text_id;

		$mgr->{TmplData}{OLD_TEXT} = $select_data{TEXT};

	}else{
		my $mes1_2521 = $mgr->{Func}->get_text($mgr, 2521);
		my $mes2_2522 = $mgr->{Func}->get_text($mgr, 2522);
		$self->show_text_message($mgr,$mes1_2521, $mes2_2522);
	}

}else{

	$mgr->{Template} = $mgr->{TmplFiles}->{Text_Trans_contents};

	$mgr->{TmplData}{PAGE_LANG_002500} = $mgr->{Func}->get_text($mgr, 2500);
	$mgr->{TmplData}{PAGE_LANG_002501} = $mgr->{Func}->get_text($mgr, 2501);
	$mgr->{TmplData}{PAGE_LANG_002505} = $mgr->{Func}->get_text($mgr, 2505);

	if (!defined $rel){
		$mgr->{TmplData}{TITLE} = $trans_title;
		$mgr->{TmplData}{DESC} = $trans_desc;
		$mgr->{TmplData}{TEXT_ID} = $text_id;
	}

	$mgr->{TmplData}{TEXT} = $mytext;
	$mgr->{TmplData}{OLD_TEXT} = $select_data{TEXT};
}

}


################# AB HIER ERLER############################



#################################################################
#CALL: $self->show_text($mgr).					#
#								#
#RETURN: 							#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################

sub show_text_see {
  my ($self, $mgr) = @_;
  my $text_id = $mgr->{CGI}->param('text_id') || undef;
  my $trans_text_id = $mgr->{CGI}->param('trans_text_id') || undef;
  my $text_rating = $mgr->{CGI}->param('text_rating') || undef;
  my $view_trans = $mgr->{CGI}->param('view_trans') || undef;

  $mgr->{Template} = $mgr->{TmplFiles}->{Text_Show};
  $mgr->{TmplData}{TRANS_TEXT_ID} = $trans_text_id;
  $mgr->{TmplData}{TEXT_ID} = $text_id;

  if (defined $text_rating && defined $text_id){ $self->text_original_rating($mgr); }
  elsif (defined $view_trans){ $self->view_trans($mgr); }
  elsif (defined $text_rating && defined $trans_text_id){ $self->text_trans_rating($mgr);}
  elsif ($trans_text_id ne undef){ $self->show_text_translation($mgr);}
  elsif ($text_id ne undef && $trans_text_id eq undef){ $self->show_text_original($mgr);}
}


#################################################################
#CALL: $self->show_text_translation($mgr).			#
#								#
#RETURN: 							#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################
sub show_text_translation {
my ($self, $mgr) = @_;
  my $given_text_id = $mgr->{CGI}->param('text_id') || undef;
  my $trans_text_id = $mgr->{CGI}->param('trans_text_id') || undef;
  my $current_user_id =$mgr->{Session}->get("UserId");
  my $current_user_level = $mgr->{Session}->get("UserLevel");


#text wether current user rates this text#############
  my $table = $mgr->{Tables}->{TEXT_RATING};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT  user_id, text_trans_id, text_rating
FROM   $table
WHERE  user_id = ? AND text_trans_id = ?

SQL

  unless ($sth->execute($current_user_id, $given_text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @row = $sth->fetchrow_array();
  my $text_trans_id = @row[1];
  my $text_rating   = @row[2];

  $sth->finish();



#Values of this Translation#############
  my $table = $mgr->{Tables}->{TEXT_TRANS};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT  trans_id, trans_text, num_words, lang_id, submit_time, user_id, category_id, status, avg_rating, num_ratings, original_id
FROM   $table
WHERE  trans_id = ?

SQL

  unless ($sth->execute($trans_text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @row = $sth->fetchrow_array();
  my $trans_id      = @row[0];
  my $trans_text    = @row[1];
  my $num_words     = @row[2];
  my $lang_id       = @row[3];
  my $submit_time   = @row[4];
  my $user_id       = @row[5];
  my $category_id   = @row[6];
  my $status        = @row[7];
  my $avg_rating    = @row[8];
  my $num_ratings   = @row[9];
  my $original_id   = @row[10];

  $sth->finish();

  $mgr->{TmplData}{PAGE_LANG_002104} = $mgr->{Func}->get_text($mgr, 2115);#TEXT_RATING Average
  $mgr->{TmplData}{PAGE_LANG_002112} = $mgr->{Func}->get_text($mgr, 2115);#TEXT_RATING
  $self->show_text_rest($mgr, $trans_text_id, $text_rating, $given_text_id, $trans_id, $trans_text, $num_words, $lang_id, $submit_time, $user_id, $category_id, $status, $avg_rating, $num_ratings, $current_user_id, $current_user_level);


#Text-Title################################
  my $table = $mgr->{Tables}->{TEXT_TITLE};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT  header_id, header_text, lang_id, text_id, user_id, submit_time, trans_id
FROM   $table
WHERE  text_id = ? AND trans_id = ?

SQL
  unless ($sth->execute($original_id,$trans_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $header_id   = @row[0];
  my $header_text = @row[1];
  my $lang_id     = @row[2];
  my $text_id     = @row[3];
  my $user_id     = @row[4];
  my $submit_time = @row[5];
  $sth->finish();
  $mgr->{TmplData}{TEXT_TITLE} = $header_text;



#Text-Description#####################
  my $table = $mgr->{Tables}->{TEXT_DESC};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT desc_id, desc_text, lang_id, text_id, user_id, submit_time
FROM   $table
WHERE  text_id = ? AND trans_id = ?

SQL
  unless ($sth->execute($original_id,$trans_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $desc_id     = @row[0];
  my $desc_text   = @row[1];
  my $lang_id     = @row[2];
  my $text_id     = @row[3];
  my $user_id     = @row[4];
  my $submit_time = @row[5];
  $sth->finish();
  $mgr->{TmplData}{TEXT_DESCRIPTION} = $desc_text;

}#end show_text_translation


#################################################################
#CALL: $self->show_text_original($mgr)				#
#								#
#RETURN: 							#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################
sub show_text_original {
  my ($self, $mgr) = @_;
  my $given_text_id = $mgr->{CGI}->param('text_id') || undef;
  my $trans_text_id = $mgr->{CGI}->param('trans_text_id') || undef;
  my $current_user_id = $mgr->{Session}->get('UserId');
  my $current_user_level = $mgr->{Session}->get('UserLevel');



#get Textvalues from original_text - Table#############
  my $table = $mgr->{Tables}->{TEXT_ORIG};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT  original_id, original_text, num_words, lang_id, submit_time, user_id, category_id, status, avg_rating, num_ratings
FROM   $table
WHERE  original_id = ?

SQL

  unless ($sth->execute($given_text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @row = $sth->fetchrow_array();
  my $original_id   = @row[0];
  my $original_text = @row[1];
  my $num_words     = @row[2];
  my $lang_id       = @row[3];
  my $submit_time   = @row[4];
  my $user_id       = @row[5];
  my $category_id   = @row[6];
  my $status        = @row[7];
  my $avg_rating    = @row[8];
  my $num_ratings   = @row[9];

  $sth->finish();


#test wether current user rated this text#############
  my $table = $mgr->{Tables}->{TEXT_RATING};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT  user_id, text_original_id, text_rating, text_trans_id
FROM   $table
WHERE  user_id = ? AND text_original_id = ? AND text_trans_id = ?

SQL

  unless ($sth->execute($current_user_id, $given_text_id, 0)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @row = $sth->fetchrow_array();
  my $text_original_id = @row[1];
  my $text_rating      = @row[2];

  $sth->finish();

  $mgr->{TmplData}{PAGE_LANG_002104} = $mgr->{Func}->get_text($mgr, 2112);#TEXT_RATING Average
  $mgr->{TmplData}{PAGE_LANG_002112} = $mgr->{Func}->get_text($mgr, 2112);#TEXT_RATING
  $self->show_text_rest($mgr, $text_original_id, $text_rating, $given_text_id, $original_id, $original_text, $num_words, $lang_id, $submit_time, $user_id, $category_id, $status, $avg_rating, $num_ratings, $current_user_id, $current_user_level);

#Text-Title################################
  my $table = $mgr->{Tables}->{TEXT_TITLE};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT  header_id, header_text, lang_id, text_id, user_id, submit_time
FROM   $table
WHERE  text_id = ? AND trans_id = ?

SQL
  unless ($sth->execute($original_id,0)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $header_id   = @row[0];
  my $header_text = @row[1];
  my $lang_id     = @row[2];
  my $text_id     = @row[3];
  my $user_id     = @row[4];
  my $submit_time = @row[5];
  $sth->finish();
  $mgr->{TmplData}{TEXT_TITLE} = $header_text;



#Text-Description#####################
  my $table = $mgr->{Tables}->{TEXT_DESC};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT desc_id, desc_text, lang_id, text_id, user_id, submit_time
FROM   $table
WHERE  text_id = ? AND trans_id = ?

SQL
  unless ($sth->execute($original_id,0)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $desc_id     = @row[0];
  my $desc_text   = @row[1];
  my $lang_id     = @row[2];
  my $text_id     = @row[3];
  my $user_id     = @row[4];
  my $submit_time = @row[5];
  $sth->finish();
  $mgr->{TmplData}{TEXT_DESCRIPTION} = $desc_text;


}#end show_text_original




#################################################################
#CALL: $self->show_text_rest					#
#								#
#RETURN: 							#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################
sub show_text_rest{
  my ($self, $mgr, $text_rating_id, $text_rating, $given_text_id, $text_id, $text, $num_words, $text_lang_id, $submit_time, $user_id, $category_id, $status, $avg_rating, $num_ratings, $current_user_id, $current_user_level) = @_;


  $mgr->{TmplData}{TEXT_LENGTH} = $num_words;
  $mgr->{TmplData}{TEXT} = $text;

  if($avg_rating < 1.5 && $avg_rating != 0){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 2111); }
  elsif($avg_rating < 2.5 && $avg_rating >= 1.5){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 2110); }
  elsif($avg_rating < 3.5 && $avg_rating >= 2.5){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 2109); }
  elsif($avg_rating < 4.5 && $avg_rating >= 3.5){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 2108); }
  elsif($avg_rating >= 4.5){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 2107); }

  $mgr->{TmplData}{TEXT_RATING_NUMBER} = $num_ratings;
  $mgr->{TmplData}{TEXT_SUBMIT_TIME} = substr($submit_time,6, 2) . "." . substr($submit_time,4, 2) . "." .substr($submit_time,0, 4);


#show text-rating-radio-buttons or not
  if($text_rating_id == $given_text_id){
    $mgr->{TmplData}{RADIO_TYPE} = 'hidden';
    $mgr->{TmplData}{SUBMIT_TYPE} = 'hidden';
    if($text_rating == 1 ){$mgr->{TmplData}{PAGE_LANG_002112} = $mgr->{Func}->get_text($mgr, 2117) . " " . $mgr->{Func}->get_text($mgr, 2111); }
    elsif($text_rating == 2){$mgr->{TmplData}{PAGE_LANG_002112} = $mgr->{Func}->get_text($mgr, 2117) . " " . $mgr->{Func}->get_text($mgr, 2110);}
    elsif($text_rating == 3){$mgr->{TmplData}{PAGE_LANG_002112} = $mgr->{Func}->get_text($mgr, 2117) . " " . $mgr->{Func}->get_text($mgr, 2109);}
    elsif($text_rating == 4){$mgr->{TmplData}{PAGE_LANG_002112} = $mgr->{Func}->get_text($mgr, 2117) . " " . $mgr->{Func}->get_text($mgr, 2108); }
    elsif($text_rating == 5){ $mgr->{TmplData}{PAGE_LANG_002112} = $mgr->{Func}->get_text($mgr, 2117) . " " . $mgr->{Func}->get_text($mgr, 2107);}
  }
  else{
    $mgr->{TmplData}{PAGE_LANG_002107} = $mgr->{Func}->get_text($mgr, 2107);
    $mgr->{TmplData}{PAGE_LANG_002108} = $mgr->{Func}->get_text($mgr, 2108);
    $mgr->{TmplData}{PAGE_LANG_002109} = $mgr->{Func}->get_text($mgr, 2109);
    $mgr->{TmplData}{PAGE_LANG_002110} = $mgr->{Func}->get_text($mgr, 2110);
    $mgr->{TmplData}{PAGE_LANG_002111} = $mgr->{Func}->get_text($mgr, 2111);
    $mgr->{TmplData}{PAGE_LANG_002113} = $mgr->{Func}->get_text($mgr, 2113);
    $mgr->{TmplData}{RADIO_TYPE} = 'radio';
    $mgr->{TmplData}{SUBMIT_TYPE} = 'submit';
  }


#User-handlig
  if($current_user_level == 0){$mgr->{TmplData}{SUBMIT_DELETE_TYPE} = 'hidden'; $mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'hidden';}
  elsif($current_user_level == 1){$mgr->{TmplData}{SUBMIT_DELETE_TYPE} = 'hidden'; $mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'submit';}
  elsif($current_user_level == 2){$mgr->{TmplData}{SUBMIT_DELETE_TYPE} = 'submit'; $mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'submit';}


  $mgr->{TmplData}{PAGE_LANG_002023} = $mgr->{Func}->get_text($mgr, 2023);#Title
  $mgr->{TmplData}{PAGE_LANG_002100} = $mgr->{Func}->get_text($mgr, 2100);#Author
  $mgr->{TmplData}{PAGE_LANG_002012} = $mgr->{Func}->get_text($mgr, 2012);#Text-Description
  $mgr->{TmplData}{PAGE_LANG_002033} = $mgr->{Func}->get_text($mgr, 2033);#Text_Length
  $mgr->{TmplData}{PAGE_LANG_002102} = $mgr->{Func}->get_text($mgr, 2102);#TEXT_ORIG_LANG
  $mgr->{TmplData}{PAGE_LANG_002103} = $mgr->{Func}->get_text($mgr, 2103);#TEXT_TRANS_LANGUAGES
  $mgr->{TmplData}{PAGE_LANG_002105} = $mgr->{Func}->get_text($mgr, 2105);#TEXT_RATING_NUMBE
  $mgr->{TmplData}{PAGE_LANG_002101} = $mgr->{Func}->get_text($mgr, 2101);#TEXT
  $mgr->{TmplData}{PAGE_LANG_002106} = $mgr->{Func}->get_text($mgr, 2106);#text_trans_buuton
  $mgr->{TmplData}{PAGE_LANG_002114} = $mgr->{Func}->get_text($mgr, 2114);#delete_text_button
  $mgr->{TmplData}{PAGE_LANG_002116} = $mgr->{Func}->get_text($mgr, 2116);#TEXT_SUBMIT_TIME
  $mgr->{TmplData}{PAGE_LANG_002019} = $mgr->{Func}->get_text($mgr, 2019);#TEXT_CAT
  $mgr->{TmplData}{PAGE_LANG_002118} = $mgr->{Func}->get_text($mgr, 2118);#View_Translation_Button
  $mgr->{TmplData}{PAGE_LANG_002119} = $mgr->{Func}->get_text($mgr, 2119);#Titel of Page




#Author of this Text#####################
  my $table = $mgr->{Tables}->{USER};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT user_id, username, lastname, firstname, email
FROM   $table
WHERE  user_id = ?

SQL
  unless ($sth->execute($user_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $username  = @row[1];
  my $lastname  = @row[2];
  my $firstname = @row[3];
  my $email     = @row[4];
  $sth->finish();
  $mgr->{TmplData}{AUTHOR_LINK} = $mgr->my_url(ACTION => "user", METHOD => "mypage");
  $mgr->{TmplData}{TEXT_AUTOR} = $firstname . " " . $lastname;
  $mgr->{TmplData}{AUTHOR_ID} =$user_id ;


#Original Language of this Text##################
  my $table = $mgr->{Tables}->{LANG};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT lang_id, lang_name_id, system_lang
FROM   $table
WHERE  lang_id = ?

SQL
  unless ($sth->execute($text_lang_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  #my $lang_id      = @row[0];
  my $lang_name_id = @row[1];
  my $system_lang  = @row[2];
  $sth->finish();
  $mgr->{TmplData}{TEXT_ORIG_LANG} = $mgr->{Func}->get_text($mgr, $lang_name_id);


#Translated Languages of this Text##################
  my $table = $mgr->{Tables}->{TEXT_TRANS};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT original_id, lang_id
FROM   $table
WHERE  original_id = ?

SQL
  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my $table = $sth->fetchall_arrayref();
  my @lang_loop_data;
  my $row;
  my %data;
  $data{TEXT_TRANS_LANG_ID}= $text_lang_id;
  $data{TEXT_TRANS_LANG_NAME}= $mgr->{Func}->get_text($mgr, $lang_name_id);
  push(@lang_loop_data,\%data);
  foreach $row (@$table){
    my %data;
    $data{TEXT_TRANS_LANG_ID}= $row[0];
    $data{TEXT_TRANS_LANG_NAME}= $row[1];
    push(@lang_loop_data,\%data);
  }
  @lang_loop_data = sort {$a->{TEXT_TRANS_LANG_NAME} cmp $b->{TEXT_TRANS_LANG_NAME}} @lang_loop_data;
  $mgr->{TmplData}{TEXT_LOOP_TRANS_LANG}=\@lang_loop_data;
  $mgr->{TmplData}{SUBMIT_VIEW_TRANS_TYPE}='submit';
  $sth->finish();

#Category-Name of this Text##################
  my $table = $mgr->{Tables}->{CATS};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT cat_id, lang_id
FROM   $table
WHERE  cat_id = ?

SQL
  unless ($sth->execute($category_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $cat_lang_id  = @row[1];
  $sth->finish();

  $mgr->{TmplData}{CAT_LINk} = $mgr->my_url(ACTION => "home", METHOD => "show_cat");
  $mgr->{TmplData}{TEXT_CAT} = $mgr->{Func}->get_text($mgr, $cat_lang_id);
  $mgr->{TmplData}{CAT_LANG_ID} = $cat_lang_id;

}#end show_text_rest




#################################################################
#CALL: $self->show_original_rating($mgr)			#
#								#
#RETURN: 							#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################
sub text_original_rating {
  my ($self, $mgr) = @_;
  my $rating = $mgr->{CGI}->param('rating') || undef;
  my $user_id =$mgr->{Session}->get("UserId");
  my $text_id = $mgr->{CGI}->param('text_id') || undef;

  #test wether current user rated this text#############
  my $table = $mgr->{Tables}->{TEXT_RATING};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT  user_id, text_original_id, text_rating
FROM   $table
WHERE  user_id = ? AND text_original_id = ?

SQL

  unless ($sth->execute($user_id, $text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @row = $sth->fetchrow_array();
  my $user_id          = @row[0];
  my $text_original_id = @row[1];
  my $text_rating      = @row[2];

  $sth->finish();


  if(defined $rating && $text_original_id == undef){

    my $text_id = $mgr->{CGI}->param('text_id') || undef;


    my $table = $mgr->{Tables}->{TEXT_ORIG};

    my $dbh = $mgr->connect();
    my $sth = $dbh->prepare(<<SQL);

SELECT  original_id, user_id, avg_rating, num_ratings
FROM   $table
WHERE  original_id = ?

SQL

    unless ($sth->execute($text_id)) {
      warn sprintf("[Error:] Trouble selecting data from [%s].".
                   "Reason: [%s].", $table, $dbh->errstr());
      $mgr->fatal_error("Database error.");
    }

    my @row = $sth->fetchrow_array();
    my $original_id   = @row[0];
    my $user_id       = @row[1];
    my $avg_rating    = @row[2];
    my $num_ratings   = @row[3];

    $sth->finish();


    my $table = $mgr->{Tables}->{TEXT_RATING};

    my $dbh = $mgr->connect();
    $dbh->do("LOCK TABLES $table WRITE");
    my $sth = $dbh->prepare(<<SQL);


INSERT INTO $table (user_id, text_original_id, text_rating)
VALUES (?, ?, ?)

SQL

    unless ($sth->execute($user_id, $original_id, $rating))
      {
	  warn sprintf("[Error:] Trouble adding user to %s. " .
	  	       "Reason: [%s].", $table, $dbh->errstr());
	  $dbh->do("UNLOCK TABLES");
	  $mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    $sth->finish();


    $avg_rating = (($avg_rating * $num_ratings) + $rating) / ($num_ratings+1);
    $num_ratings += 1;

    my $table = $mgr->{Tables}->{TEXT_ORIG};
    my $dbh = $mgr->connect();
    $dbh->do("LOCK TABLES $table WRITE");
    my $sth = $dbh->prepare(<<SQL);

UPDATE LOW_PRIORITY $table SET avg_rating=?, num_ratings=?
WHERE original_id = ?

SQL

    unless ($sth->execute($avg_rating, $num_ratings, $text_id))
    {
	  warn sprintf("[Error:] Trouble adding user to %s. " .
	  	     "Reason: [%s].", $table, $dbh->errstr());
	  $dbh->do("UNLOCK TABLES");
	  $mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");
    $sth->finish();

  }#end if


  $self->show_text_original($mgr);

}#end text_original_rating



#################################################################
#CALL: $self->show_trans_rating($mgr)				#
#								#
#RETURN: 							#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################
sub text_trans_rating {
  my ($self, $mgr) = @_;
  my $rating = $mgr->{CGI}->param('rating') || undef;
  my $user_id =$mgr->{Session}->get("UserId");
  my $text_id = $mgr->{CGI}->param('text_id') || undef;

  #test wether current user rates this text#############
  my $table = $mgr->{Tables}->{TEXT_RATING};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT user_id, text_trans_id, text_rating
FROM   $table
WHERE  user_id = ? AND text_trans_id = ?

SQL

  unless ($sth->execute($user_id, $text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @row = $sth->fetchrow_array();
  my $user_id          = @row[0];
  my $text_trans_id    = @row[1];
  my $text_rating      = @row[2];

  $sth->finish();

if(defined $rating && $text_trans_id==undef){

  my $trans_text_id = $mgr->{CGI}->param('trans_text_id') || undef;


  my $table = $mgr->{Tables}->{TEXT_TRANS};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT  trans_id, user_id, avg_rating, num_ratings
FROM   $table
WHERE  trans_id = ?

SQL

  unless ($sth->execute($trans_text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @row = $sth->fetchrow_array();
  my $trans_id      = @row[0];
  my $user_id       = @row[1];
  my $avg_rating    = @row[2];
  my $num_ratings   = @row[3];

  $sth->finish();


  my $table = $mgr->{Tables}->{TEXT_RATING};

  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);


INSERT INTO $table (user_id, text_trans_id, text_rating)
VALUES (?, ?, ?)

SQL

  unless ($sth->execute($user_id, $trans_id, $rating))
    {
	warn sprintf("[Error:] Trouble adding user to %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

  $dbh->do("UNLOCK TABLES");

  $sth->finish();


  $avg_rating = (($avg_rating * $num_ratings) + $rating) / ($num_ratings+1);
  $num_ratings += 1;

    my $table = $mgr->{Tables}->{TEXT_TRANS};
    my $dbh = $mgr->connect();
    $dbh->do("LOCK TABLES $table WRITE");
    my $sth = $dbh->prepare(<<SQL);

UPDATE LOW_PRIORITY $table SET avg_rating = ?, num_ratings = ?
WHERE trans_id = ?

SQL

  unless ($sth->execute($avg_rating, $num_ratings, $trans_text_id))
    {
	warn sprintf("[Error:] Trouble adding user to %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

  $dbh->do("UNLOCK TABLES");
  $sth->finish();
}#end if


$self->show_text_translation($mgr);

}#end text_trans_rating




#################################################################
#CALL: $self->delete_text($mgr)					#
#								#
#RETURN: 							#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################
sub delete_text {
  my ($self, $mgr) = @_;

  my $text_id = $mgr->{CGI}->param('text_id') || undef;
  my $trans_text_id = $mgr->{CGI}->param('trans_text_id') || undef;

  my $delete_trans = $mgr->{CGI}->param('delete_trans') || undef;
  my $delete_all_orig = $mgr->{CGI}->param('delete_all_orig') || undef;
  my $delete_all_trans = $mgr->{CGI}->param('delete_all_trans') || undef;
  my $dont_delete_orig = $mgr->{CGI}->param('dont_delete_orig') || undef;
  my $dont_delete_trans = $mgr->{CGI}->param('dont_delete_trans') || undef;

  my $delete_all_ok = $mgr->{CGI}->param('delete_all_ok') || undef;
  my $delete_trans_ok = $mgr->{CGI}->param('delete_trans_ok') || undef;

  my $delete_text = $mgr->{CGI}->param('delete_text') || undef;
  my $author_id = $mgr->{CGI}->param('author_id') || undef;
  my $cat_lang_id = $mgr->{CGI}->param('cat_lang_id') || undef;

  if(defined $delete_trans || defined $delete_trans_ok){$self->delete_trans($mgr);}#delete_trans($mgr);}
  elsif(defined $delete_all_orig || defined $delete_all_trans || defined $delete_all_ok){$self->delete_all($mgr);}#delete_all($mgr);}
  elsif(defined $dont_delete_orig || defined $dont_delete_trans){$self->show_text_see($mgr);}#show_text_see($mgr);
  else
  {
	$mgr->{Template} = $mgr->{TmplFiles}->{Text_Delete};

	$mgr->{TmplData}{TEXT_ID} = $text_id ;#insert text_id in template as hidden
	$mgr->{TmplData}{TRANS_TEXT_ID} = $trans_text_id ;#insert trans_text_id in template as hidden
	$mgr->{TmplData}{AUTHOR_ID} = $author_id ;#insert author_id in template as hidden
	$mgr->{TmplData}{CAT_LANG_ID} = $cat_lang_id ;#insert cat_lang_id_text_id in template as hidden

	$mgr->{TmplData}{PAGE_LANG_002114} = $mgr->{Func}->get_text($mgr, 2114);#delete_text Titel of this Page

	if(defined $trans_text_id){
	$mgr->{TmplData}{PAGE_LANG_002121} = $mgr->{Func}->get_text($mgr, 2121);#Original-text-information
	$mgr->{TmplData}{PAGE_LANG_002124} = $mgr->{Func}->get_text($mgr, 2124);#delete Translation
	$mgr->{TmplData}{PAGE_LANG_002125} = $mgr->{Func}->get_text($mgr, 2125);#delete all
	$mgr->{TmplData}{PAGE_LANG_002128} = $mgr->{Func}->get_text($mgr, 2123);#don't delete
	$mgr->{TmplData}{PAGE_LANG_002126} = $mgr->{Func}->get_text($mgr, 2126);#delete translation Button
	$mgr->{TmplData}{PAGE_LANG_002127} = $mgr->{Func}->get_text($mgr, 2127);#delete all Button
	$mgr->{TmplData}{PAGE_LANG_002123} = $mgr->{Func}->get_text($mgr, 21231);#don't delete Button

	$mgr->{TmplData}{SUBMIT_ORIG_TYPE} = 'hidden';
	$mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'submit';
	}
	else{

	$mgr->{TmplData}{PAGE_LANG_002120} = $mgr->{Func}->get_text($mgr, 2120);#Original-text-information
	$mgr->{TmplData}{PAGE_LANG_002122} = $mgr->{Func}->get_text($mgr, 2122);#delete Button
	$mgr->{TmplData}{PAGE_LANG_002123} = $mgr->{Func}->get_text($mgr, 2123);#don't delete Button
	$mgr->{TmplData}{SUBMIT_ORIG_TYPE} = 'submit';
	$mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'hidden';

	}
    }
}#end delete_text

#################################################################
#CALL: $self->delete_trans($mgr)				#
#								#
#RETURN: 							#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################
sub delete_trans {
  my ($self, $mgr) = @_;
  my $text_trans_id  = $mgr->{CGI}->param('trans_text_id') || undef;
  my $author_id     = $mgr->{CGI}->param('author_id') || undef;
  my $cat_lang_id   = $mgr->{CGI}->param('cat_lang_id') || undef;

#DELETE Translation##################
  my $table = $mgr->{Tables}->{TEXT_TRANS};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  trans_id = ?

SQL
  unless ($sth->execute($text_trans_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();



#DELETE Descriptions of Translation##################
  my $table = $mgr->{Tables}->{TEXT_DESC};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  trans_id = ?

SQL
  unless ($sth->execute($text_trans_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();


#DELETE Titles of Translation##################
  my $table = $mgr->{Tables}->{TEXT_TITLE};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  trans_id = ?

SQL
  unless ($sth->execute($text_trans_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();


#DELETE Ratings of Translations snd Original-Text##################
  my $table = $mgr->{Tables}->{TEXT_RATING};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_trans_id = ?

SQL
  unless ($sth->execute($text_trans_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();

#fill Template Text_Delete_Ok
  my $author_id = $mgr->{CGI}->param('author_id') || undef;
  my $cat_lang_id = $mgr->{CGI}->param('cat_lang_id') || undef;

  $mgr->{TmplData}{AUTHOR_ID} = $author_id ;#insert author_id in template as hidden
  $mgr->{TmplData}{CAT_LANG_ID} = $cat_lang_id ;#insert cat_lang_id_text_id in template as hidden

  $mgr->{Template} = $mgr->{TmplFiles}->{Text_Delete_TRANS_Ok};
  $mgr->{TmplData}{PAGE_LANG_002128} = $mgr->{Func}->get_text($mgr, 2128);#text deleted-information
  $mgr->{TmplData}{PAGE_LANG_002019} = $mgr->{Func}->get_text($mgr, 2019);#Category of deleted Text
  $mgr->{TmplData}{PAGE_LANG_002100} = $mgr->{Func}->get_text($mgr, 2100);#Author of deleted Text

  $mgr->{TmplData}{CAT_LINk} = $mgr->my_url(ACTION => "home", METHOD => "show_cat");
  $mgr->{TmplData}{TEXT_CAT} = $mgr->{Func}->get_text($mgr, $cat_lang_id);


#Author of deleted Text#####################
  my $table = $mgr->{Tables}->{USER};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT user_id, username, lastname, firstname, email
FROM   $table
WHERE  user_id = ?

SQL
  unless ($sth->execute($author_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $username  = @row[1];
  my $lastname  = @row[2];
  my $firstname = @row[3];
  my $email     = @row[4];
  $sth->finish();

  $mgr->{TmplData}{AUTHOR_LINK} = $mgr->my_url(ACTION => "user", METHOD => "mypage");
  $mgr->{TmplData}{TEXT_AUTOR} = $firstname . " " . $lastname;

  #$self->show_text_see($mgr)

}#delete_trans


#################################################################
#CALL: $self->delete_all($mgr)					#
#								#
#RETURN: 							#
#								#
#DESC: See SQL Statement. 					#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################
sub delete_all {
  my ($self, $mgr) = @_;
  my $text_orig_id  = $mgr->{CGI}->param('text_id') || undef;
  my $author_id     = $mgr->{CGI}->param('author_id') || undef;
  my $cat_lang_id   = $mgr->{CGI}->param('cat_lang_id') || undef;

#DELETE Translations of Original-Text##################
  my $table = $mgr->{Tables}->{TEXT_TRANS};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  original_id = ?

SQL
  unless ($sth->execute($text_orig_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();

#DELETE Descriptions of Translations Original-Text##################
  my $table = $mgr->{Tables}->{TEXT_DESC};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_orig_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();


#DELETE Titles of Translations snd Original-Text##################
  my $table = $mgr->{Tables}->{TEXT_TITLE};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_orig_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();


#DELETE Ratings of Translations snd Original-Text##################
  my $table = $mgr->{Tables}->{TEXT_RATING};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_original_id = ?

SQL
  unless ($sth->execute($text_orig_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();

#DELETE Original-Text##################
  my $table = $mgr->{Tables}->{TEXT_ORIG};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  original_id = ?

SQL
  unless ($sth->execute($text_orig_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }

  $sth->finish();

#fill Template Text_Delete_Ok
  my $author_id = $mgr->{CGI}->param('author_id') || undef;
  my $cat_lang_id = $mgr->{CGI}->param('cat_lang_id') || undef;

  $mgr->{TmplData}{AUTHOR_ID} = $author_id ;#insert author_id in template as hidden
  $mgr->{TmplData}{CAT_LANG_ID} = $cat_lang_id ;#insert cat_lang_id_text_id in template as hidden
  
  $mgr->{Template} = $mgr->{TmplFiles}->{Text_Delete_ALL_Ok};
  $mgr->{TmplData}{PAGE_LANG_002128} = $mgr->{Func}->get_text($mgr, 2128);#text deleted-information
  $mgr->{TmplData}{PAGE_LANG_002019} = $mgr->{Func}->get_text($mgr, 2019);#Category of deleted Text
  $mgr->{TmplData}{PAGE_LANG_002100} = $mgr->{Func}->get_text($mgr, 2100);#Author of deleted Text

  $mgr->{TmplData}{CAT_LINk} = $mgr->my_url(ACTION => "home", METHOD => "show_cat");
  $mgr->{TmplData}{TEXT_CAT} = $mgr->{Func}->get_text($mgr, $cat_lang_id);


#Author of deleted Text#####################
  my $table = $mgr->{Tables}->{USER};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT user_id, username, lastname, firstname, email
FROM   $table
WHERE  user_id = ?

SQL
  unless ($sth->execute($author_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $username  = @row[1];
  my $lastname  = @row[2];
  my $firstname = @row[3];
  my $email     = @row[4];
  $sth->finish();

  $mgr->{TmplData}{AUTHOR_LINK} = $mgr->my_url(ACTION => "user", METHOD => "mypage");
  $mgr->{TmplData}{TEXT_AUTOR} = $firstname . " " . $lastname;

}#delete_all



#################################################################
#CALL: $self->view_trans($mgr)					#
#								#
#RETURN: 							#
#								#
#DESC: 	Is called if presssed button for showing this Text in	#
#	other Languages						#
#								#
#Author: Hendrik Erler(erler@cs.tu-berlin.de)			#
#################################################################
sub view_trans {
  my ($self, $mgr) = @_;
  my $text_trans_lang_id = $mgr->{CGI}->param('text_trans_lang_id') || undef;
  my $text_orig_id = $mgr->{CGI}->param('text_id') || undef;


#get trans_id if exist. If exist not, then it is original-Text selected#######
  my $table = $mgr->{Tables}->{TEXT_TRANS};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT trans_id, lang_id ,original_id
FROM   $table
WHERE  original_id = ? AND lang_id = ?

SQL

  unless ($sth->execute($text_trans_lang_id,$text_orig_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $trans_id      = @row[0];
  $sth->finish();

  if(defined $trans_id){$self->{'trans_text_id'} = $trans_id;
    $self->show_text_translation($mgr);}
  else{$self->{'trans_text_id'} = undef;
    $self->show_text_original($mgr);}

}#end view_trans



1;















