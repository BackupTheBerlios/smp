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
			      action  => 'home',
			      script  => 'Home'
			     },
                             {
                              action  => 'text',
                              script  => 'Text'
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
       DbUser   => 'wurch'
};

$SESSION = {
	    ExpTime  => 36000,
	    SessDir  => 'sessions',
	    SessFile => 'session',
};

$SYSTEM_LANGS = {
		1 => 'de',
		2 => 'en'
};

$TABLES = {
	   CATS       => 'lingua_categories',
	   DICT       => 'lingua_dictionary',
	   LANG       => 'lingua_languages',
	   USER       => 'lingua_user',
	   USER_BLOCK => 'lingua_user_blocked',
	   USER_DESC  => 'lingua_user_desc',
	   USER_LANG  => 'lingua_user_lang'
};

$TMPL = {
	 Error     => 'lingua_error.tmpl',
	 Home      => 'lingua_home.tmpl',
	 Home_Cats => 'lingua_home_categories_admin.tmpl',
	 User_Pers => 'lingua_user_pers.tmpl',
};

1;
