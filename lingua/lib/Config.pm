package lib::Config;

$CONFIG = {
           Charset       => 'utf-8',
           DefaultModule => {
                             action  => 'home',
                             script  => 'Home'
                            },
           ModuleDir     => 'modules',
           Modules       => [
                             {
                              action  => 'text',
                              script  => 'Text'
                             },
                             {
                              action  => 'home',
                              script  => 'Home'
                             },
                             {
                              action  => 'user',
                              script  => 'User'
                             },
                            ],
           TmplDir       => 'templates' 
};

$DB = {
       DataBase => 'lingua',
       DbHost   => '',
       DbPass   => '',
       DbPort   => '',
       DbUser   => 'root'
};

$SESSION = {
            ExpTime  => 36000,
            SessDir  => 'sessions',
            SessFile => 'session',
};

$SYSTEM_LANGS = {
		 1 => 'de',
		 2 => 'en',
		 3 => 'fr'
};

$TABLES = {
           CATS       => 'lingua_categories',
           DICT       => 'lingua_dictionary',
           LANG       => 'lingua_languages',
           USER       => 'lingua_user',
           USER_BLOCK => 'lingua_user_blocked',
           USER_DESC  => 'lingua_user_desc',
           USER_LANG  => 'lingua_user_lang',
	   TEXT_ORIG  => 'lingua_original_text',
	   TEXT_TRANS => 'lingua_translation_text',
	   TEXT_DESC  => 'lingua_text_description',
	   TEXT_TITLE => 'lingua_text_header',
	   TEXT_RATING =>'lingua_text_rating'
};

$TMPL = {
         Error     => 'lingua_error.tmpl',
         Home      => 'lingua_home.tmpl',
         Home_Cats => 'lingua_home_categories_admin.tmpl',
         User_MyPage => 'lingua_user_pers.tmpl',
	 User_Reg1 => 'lingua_user_reg1.tmpl',	 
	 User_Reg2 => 'lingua_user_reg2.tmpl',	 
	 User_Reg3 => 'lingua_user_reg3.tmpl',	 
	 User_Reg4=> 'lingua_user_reg4.tmpl',	 
	 User_Reg5 => 'lingua_user_reg5.tmpl',	 
	 Text_New => 'lingua_text_new.tmpl',
 	 Text_Upload => 'lingua_text_upload.tmpl',
	 Text_Description => 'lingua_text_description.tmpl',
	 Text_Message => 'lingua_text_message.tmpl',
	 Text_Conf_Save => 'lingua_text_confirm_save.tmpl',
	 Text_Show => 'lingua_text_show.tmpl',
	 Text_Trans_contents => 'lingua_text_trans_contents.tmpl'
};

1;






