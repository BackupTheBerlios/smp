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
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.3 $ =~ /(\d+)\.(\d+)/;

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

my $method = $mgr->{CGI}->param('method') || 'trans_desc'; #'text_new';

if ($method eq 'text_new'){
  $self->show_text_new($mgr);}

elsif ($method eq 'text_direction'){
  $self->check_text_direction($mgr);}

elsif ($method eq 'text_upload'){
  $self->show_text_upload($mgr);}

elsif ($method eq 'text_description'){
  $self->show_text_description($mgr);}

elsif ($method eq 'text_message'){
  $self->show_text_message($mgr);}

elsif ($method eq 'text_message_way'){
  $self->show_way($mgr);}

elsif ($method eq 'text_confirm_save'){
  $self->show_text_confirm_save($mgr);}

elsif ($method eq 'create_text'){
  $self->show_text_new($mgr);}


elsif ( ($method eq 'trans_desc') || ($method eq 'text_trans') ){
  $self->show_trans_desc($mgr);}

elsif ($method eq 'text_trans_contents'){
  $self->show_trans_contents($mgr);}

return 1;
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
my ($self, $mgr,$cat_mes, $lang_mes, $title_mes, $text_mes) = @_;

my $title = $mgr->{CGI}->param('title') || "";
my $text_desc = $mgr->{CGI}->param('text_desc') || "";

my $text_cat_id = $mgr->{CGI}->param('text_cat_id') || undef;
my $text_lang_id = $mgr->{CGI}->param('text_desc_lang_id') || undef;
my $file = $mgr->{CGI}->param('file') || undef;
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
$mgr->{TmplData}{PAGE_LANG_002032} = $mgr->{Func}->get_text($mgr, 2032); 
$mgr->{TmplData}{PAGE_LANG_002033} = $mgr->{Func}->get_text($mgr, 2033); 
$mgr->{TmplData}{PAGE_LANG_002034} = $mgr->{Func}->get_text($mgr, 2034); 


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

my @cat_loop_data= $self->get_below_cats($mgr) ;
 

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
 
$mgr->{TmplData}{TEXT_LOOP_LANG}=\@lang_loop_data;

###################### In Bearbeitung #######################################
my $punkt=100;
$mgr->{TmplData}{TEXT_MAX_VAL}= $punkt;
my $text;
my $mylength;
my $act_val;

if (defined $mytext){
	$text=$mytext;
	$mylength= length($text);
	$act_val= $punkt -length($text);}

else{

	if (defined $file){
			$text="Text uploaden: OK";
	
		if (($punkt - length($text))<0) {
			$text = "Text zu lang @§$&%&!!";}

		$mylength= length($text);
		$act_val= $punkt -length($text);
	}else{
		$mylength=0;
		$act_val=$punkt;
	     }
    }

$mgr->{TmplData}{TEXT}= $text;
$mgr->{TmplData}{TEXT_LENG}= $mylength;
$mgr->{TmplData}{TEXT_ACT_VAL}= $act_val;

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
my $text = $mgr->{CGI}->param('mytext') || undef;

my $upload = $mgr->{CGI}->param('upload') || undef;
my $text_send = $mgr->{CGI}->param('send') || undef;

my $cat_mes=0;
my $lang_mes=0;
my $title_mes=0;
my $text_mes=0;


if (defined $upload) { $self->show_text_upload($mgr); }

elsif(defined $text_send ) {

	if (!$title){$title_mes=1;}
	if (!$text_cat_id){$cat_mes=1;}
	if (!$text_lang_id){$lang_mes=1;}
	if (!$text){$text_mes=1;}

	if ( ((($cat_mes==1) or ($lang_mes==1)) or ($title_mes==1)) or ($text_mes==1)){

		#Hidden-Var des 2. Formular setzen.  
		$mgr->{TmplData}{PAGE_ACTION}=$mgr->{Action};
		$mgr->{TmplData}{PAGE_SID}= $mgr->{SessionId};
		my $lang = $mgr->{Language};
		$mgr->{TmplData}{PAGE_LANG}= $mgr->{SystemLangs}->{$lang};

		 $self->show_text_new($mgr,$cat_mes, $lang_mes, $title_mes, $text_mes);

	} else { 
		###check_length(text)#############
		###check_Codierung(text)#############

		$self->show_text_confirm_save($mgr);
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

my $text_desc = $mgr->{CGI}->param('text_desc') || undef;

my $text_id;

### save text  #######

	$self->title_save($mgr, $text_id);
	if (defined $text_desc) {$self->description_save($mgr, $text_id);}

}


#################################################################################################
#CALL: $self->title_save($mgr, $text_id).									#						
#
#DESC:  Save a title of a text, a translation or a description								#
#      												#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)						#
#################################################################################################

sub title_save{
my ($self, $mgr, $text_id) = @_;

}



#################################################################################################
#CALL: $self->description_save($mgr, $text_id).							#						
#
#DESC: Save a Description of a text, a translation or a description				#
#      												#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)						#
#################################################################################################

sub description_save{
my ($self, $mgr, $text_id) = @_;

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
my $description = $mgr->{CGI}->param('text_desc') || "";
my $submit = $mgr->{CGI}->param('sendup') || undef;


if (defined $submit){ $self->show_text_new($mgr);}
else{


$mgr->{TmplData}{PAGE_LANG_002000} = $mgr->{Func}->get_text($mgr, 2000);
$mgr->{TmplData}{PAGE_LANG_002001} = $mgr->{Func}->get_text($mgr, 2001);
$mgr->{TmplData}{PAGE_LANG_002002} = $mgr->{Func}->get_text($mgr, 2002);
$mgr->{TmplData}{PAGE_LANG_002003} = $mgr->{Func}->get_text($mgr, 2003);
$mgr->{TmplData}{PAGE_LANG_002004} = $mgr->{Func}->get_text($mgr, 2004);

$mgr->{Template} = $mgr->{TmplFiles}->{Text_Upload};

$mgr->{TmplData}{TEXT_TITLE}=$title;
$mgr->{TmplData}{TEXT_DESCRIPTION}=$description;
$mgr->{TmplData}{TEXT_LANG}=$textlang;
$mgr->{TmplData}{TEXT_CAT}=$textcat;


#Hidden-Var des 2. Formular setzen.  
$mgr->{TmplData}{PAGE_ACTION}=$mgr->{Action};
$mgr->{TmplData}{PAGE_SID}= $mgr->{SessionId};
my $lang = $mgr->{Language};
$mgr->{TmplData}{PAGE_LANG}= $mgr->{SystemLangs}->{$lang};
 
}
	



}

#########################################################################################################################################
#CALL: $self->show_text_upload($mgr).													#						
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

	#if (defined $text_id){
	#	$self->description_save($mgr, $text_id);
	#	$self->title_save($mgr, $text_id);

		##### Confirmation###########
		my $mes1_002015= $mgr->{Func}->get_text($mgr, 2015); 
		my $mes2_002016= $mgr->{Func}->get_text($mgr, 2016); 

		$mgr->{TmplData}{TEXT_MES1_DICO} = 2015;
		$mgr->{TmplData}{TEXT_MES2_DICO} = 2016;

		$self->show_text_message($mgr, $mes1_002015, $mes2_002016);
	#} else { 
		#### ERROR '################
	#}
	

}else{
	

	if (defined $desc_lang_id ){
		$mgr->{TmplData}{TEXT_LANG_ID_SELECT} = $desc_lang_id;
		my $nr = $self->get_lang_name_id($mgr,$desc_lang_id);
		my $lang_name = $mgr->{Func}->get_text($mgr, $nr);
		
		$mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= $lang_name ; }

	else{ $mgr->{TmplData}{TEXT_LANG_NAME_SELECT}= '-----------'; }

$mgr->{TmplData}{TEXT_TITLE} = $title; 
$mgr->{TmplData}{TEXT_DESC} = $desc; 


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
$mgr->{TmplData}{PAGE_LANG_002007} = $mgr->{Func}->get_text($mgr, 2007);


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


if (defined $new_text){ $self->show_text_new($mgr); }
elsif (defined $see_text){ $self->show_text_see($mgr); }
elsif (defined $new_desc){ $self->show_text_description($mgr); }
elsif ((defined $mes1_dico) && (defined $mes2_dico) ) {

my $mes1 = $mgr->{Func}->get_text($mgr, $mes1_dico); 
my $mes2 = $mgr->{Func}->get_text($mgr, $mes2_dico); 
$mgr->{TmplData}{TEXT_MES1_DICO} = $mes1_dico;
$mgr->{TmplData}{TEXT_MES2_DICO} = $mes2_dico;
	
$self->show_text_message($mgr, $mes1, $mes2);

	   }



}

#########################################################################################################################################
#CALL: $self->show_text_confirm_save($mgr).													#
#																	#
#														#
#DESC:  														#
#																	#
#Author: Giovanni Ngapout(ngapout@cs.tu-berlin.de)											#
#########################################################################################################################################

sub show_text_confirm_save{

	my ($self, $mgr) = @_;


my $title = $mgr->{CGI}->param('title') || undef;
my $text_cat_id = $mgr->{CGI}->param('text_cat_id') || undef;
my $text_lang_id = $mgr->{CGI}->param('text_desc_lang_id') || undef;
my $text = $mgr->{CGI}->param('mytext') || undef;
my $text_desc = $mgr->{CGI}->param('text_desc') || undef;

my $text_change = $mgr->{CGI}->param('text_change') || undef;
my $text_save = $mgr->{CGI}->param('text_save') || undef;

if (defined $text_change){$self->show_text_new($mgr);}
elsif (defined $text_save){
		
		$self->text_save($mgr);
		##### Confirmation###########
		my $mes1_002035= $mgr->{Func}->get_text($mgr, 2035); 
		my $mes2_002036= $mgr->{Func}->get_text($mgr, 2036); 

		$mgr->{TmplData}{TEXT_MES1_DICO} = 2035;
		$mgr->{TmplData}{TEXT_MES2_DICO} = 2036;

		$self->show_text_message($mgr, $mes1_002035, $mes2_002036);
 
}else{

		my $title_mess_002039 	= $mgr->{Func}->get_text($mgr, 2039);
		my $Code_mess2_002040 	= $mgr->{Func}->get_text($mgr, 2040); 
		my $length_mess2_002041 = $mgr->{Func}->get_text($mgr, 2041); 
		my $punct_tomove_mess2_002042 = $mgr->{Func}->get_text($mgr, 2042); 
		my $act_punct_mess2_002043 = $mgr->{Func}->get_text($mgr, 2043); 
		my $new_punct_mess2_002044 = $mgr->{Func}->get_text($mgr, 2044); 

###########Provisoire#########
my $textcounter = $mgr->{CGI}->param('textcounter') || 0;
my $freicounter = $mgr->{CGI}->param('freicounter') || 0;
my $punkt= $textcounter + $freicounter;
		my @array_data = (
				{ TEXT_MESS  => $title_mess_002039 ,       TEXT_MESS_VAL  => $title} ,
				{ TEXT_MESS  => $Code_mess2_002040 ,       TEXT_MESS_VAL  => 'Unicode (OK)'} ,
				{ TEXT_MESS  => $length_mess2_002041 ,     TEXT_MESS_VAL  => $freicounter } ,
				{ TEXT_MESS  => $punct_tomove_mess2_002042,TEXT_MESS_VAL  => $freicounter } ,
				{ TEXT_MESS  => $act_punct_mess2_002043  ,  TEXT_MESS_VAL => $punkt},
				{ TEXT_MESS  => $new_punct_mess2_002044 ,  TEXT_MESS_VAL  =>  $textcounter }
			      );
		
		$mgr->{TmplData}{TEXT_LOOP_MES}=\@array_data;
		$mgr->{TmplData}{PAGE_LANG_002037} = $mgr->{Func}->get_text($mgr, 2037);
		$mgr->{TmplData}{PAGE_LANG_002038} = $mgr->{Func}->get_text($mgr, 2038);

		$mgr->{TmplData}{TEXT_TITLE} = $title ;
		$mgr->{TmplData}{TEXT_DESCRIPTION}= $text_desc;
		$mgr->{TmplData}{TEXT_LANG}=$text_lang_id;
		$mgr->{TmplData}{TEXT_CAT}=$text_cat_id;
		$mgr->{TmplData}{TEXT}=$text;

		$mgr->{TmplData}{TEXT_COUNTER}=$textcounter;
		$mgr->{TmplData}{FREI_COUNTER}=$freicounter;

		$mgr->{Template} = $mgr->{TmplFiles}->{Text_Conf_Save};



     }
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


if (defined $send_desc){

	if ((defined $trans_desc_lang_id ) && (defined  $trans_title) &(defined $trans_desc )) {

		### Speichern Text_id trans_title trans_desc dans text_trans_contenns

		$self->show_trans_contents($mgr);
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

		if (!$trans_desc ){ $mgr->{TmplData}{PAGE_LANG_002518} = $mgr->{Func}->get_text($mgr, 2518);}
		
		$mgr->{TmplData}{PAGE_LANG_002510} = $mgr->{Func}->get_text($mgr, 2510);
		$mgr->{TmplData}{PAGE_LANG_002512} = $mgr->{Func}->get_text($mgr, 2512);
		$mgr->{TmplData}{PAGE_LANG_002513} = $mgr->{Func}->get_text($mgr, 2513);
		$mgr->{TmplData}{PAGE_LANG_002516} = $mgr->{Func}->get_text($mgr, 2516);
		$mgr->{TmplData}{PAGE_LANG_002517} = $mgr->{Func}->get_text($mgr, 2517);
		$mgr->{TmplData}{PAGE_LANG_002519} = $mgr->{Func}->get_text($mgr, 2519);
		$mgr->{TmplData}{PAGE_LANG_002520} = $mgr->{Func}->get_text($mgr, 2520);
		$mgr->{Template} = $mgr->{TmplFiles}->{Text_Trans_Desc};
		}
}else{

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

		$mgr->{TmplData}{PAGE_LANG_002510} = $mgr->{Func}->get_text($mgr, 2510);
		$mgr->{TmplData}{PAGE_LANG_002512} = $mgr->{Func}->get_text($mgr, 2512);
		$mgr->{TmplData}{PAGE_LANG_002513} = $mgr->{Func}->get_text($mgr, 2513);
		$mgr->{TmplData}{PAGE_LANG_002516} = $mgr->{Func}->get_text($mgr, 2516);
		$mgr->{TmplData}{PAGE_LANG_002517} = $mgr->{Func}->get_text($mgr, 2517);
		$mgr->{TmplData}{PAGE_LANG_002519} = $mgr->{Func}->get_text($mgr, 2519);
		$mgr->{TmplData}{PAGE_LANG_002520} = $mgr->{Func}->get_text($mgr, 2520);
		
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
  my ($self, $mgr) = @_;


my $trans_desc_change = $mgr->{CGI}->param('trans_desc_change') || undef;
my $trans_send = $mgr->{CGI}->param('trans_send') || undef;


if (defined $trans_desc_change){}

elsif(defined  $trans_send){

my $mes1_2521 = $mgr->{Func}->get_text($mgr, 2521);
my $mes2_2522 = $mgr->{Func}->get_text($mgr, 2522);
$self->show_text_message($mgr,$mes1_2521, $mes2_2522);


}

else {
# übernehmen les params
 	
$mgr->{TmplData}{PAGE_LANG_002500} = $mgr->{Func}->get_text($mgr, 2500);
$mgr->{TmplData}{PAGE_LANG_002501} = $mgr->{Func}->get_text($mgr, 2501);
$mgr->{TmplData}{PAGE_LANG_002503} = $mgr->{Func}->get_text($mgr, 2503);
$mgr->{TmplData}{PAGE_LANG_002504} = $mgr->{Func}->get_text($mgr, 2504);
$mgr->{TmplData}{PAGE_LANG_002505} = $mgr->{Func}->get_text($mgr, 2505);

	
$mgr->{Template} = $mgr->{TmplFiles}->{Text_Trans_contents};}




}


#########################################################################################################################################
#CALL: $self->get_below_cats($mgr).													#
#																	#
#RETURN: @array of {Cat_id & Cat_name in the actual language} of the below Categories (no parent <=> cat_count=0)			#
#	 (Ex. lang=de  ({CAT_ID => 8, CAT_NAME =>'Ägyptologie'}, {CAT_ID => 14, CAT_NAME =>'Völkerkunde'} )   				#													#
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





1;

