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
           TmplDir       => 'templates',
	   TextPoints    => 1,
	   TransPoints   => 2,
	   InactivTime   => 28,
};

$DB = {
       DataBase => 'lingua',
       DbHost   => 'localhost',
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
           CATS           => 'lingua_categories',
           DICT           => 'lingua_dictionary',
           LANG           => 'lingua_languages',
           USER           => 'lingua_user',
           USER_BLOCK     => 'lingua_user_blocked',
           USER_REASON    => 'lingua_user_reason',
           USER_DESC      => 'lingua_user_desc',
           USER_LANG      => 'lingua_user_lang',
	   TEXT           => 'lingua_text',
	   TEXT_RES	  => 'lingua_text_reserve',
	   TEXT_RATING    => 'lingua_text_rating',
	   POINTS_INACTIV => 'lingua_inactiv_points'
};

$TMPL = {
         Error                => 'lingua_error.tmpl',
         Home_Tree            => 'lingua_home.tmpl',
	 User_MyPage          => 'lingua_user_pers.tmpl',
         User_UpdSyslang      => 'lingua_user_upd_syslang.tmpl',
         User_UpdPasswd       => 'lingua_user_upd_passwd.tmpl',
         User_PasswdOK        => 'lingua_user_passwd_ok.tmpl',
         User_UpdLangs        => 'lingua_user_upd_langs.tmpl',
         User_UpdDescEdit     => 'lingua_user_upd_descedit.tmpl',
         User_UpdDescNew      => 'lingua_user_upd_descnew.tmpl',
         User_AdmSearch       => 'lingua_user_adm_search.tmpl',
         User_Admin           => 'lingua_user_admin.tmpl',
         User_ReasonNew       => 'lingua_user_reason_new.tmpl',
         User_ReasonEdit      => 'lingua_user_reason_edit.tmpl',
         User_Reg1            => 'lingua_user_reg1.tmpl',
         User_Reg2            => 'lingua_user_reg2.tmpl',
         User_Reg3            => 'lingua_user_reg3.tmpl',
	 Text_New             => 'lingua_text_new.tmpl',
         Text_New_Ok          => 'lingua_text_new_ok.tmpl',
	 Text_New_Upload      => 'lingua_text_new_upload.tmpl',
	 Text_Cat_Show        => 'lingua_text_cat_show.tmpl',
	 Text_Trans           => 'lingua_text_trans.tmpl',
	 Text_Trans_Upload    => 'lingua_text_trans_upload.tmpl',
	 Text_Trans_Ok        => 'lingua_text_trans_ok.tmpl',
	 Text_User_Mes        => 'lingua_text_user.tmpl',
	 Text_Trans_Download  => 'lingua_text_to_trans_download.tmpl',
	 Text_Download 	      => 'lingua_text_download.tmpl'
};

1;











