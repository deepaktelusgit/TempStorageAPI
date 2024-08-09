function fn(){
	
	var env = karate.env;
	var clientId = karate.properties['clientId'];
	var clientSecret =karate.properties['clientSecret'];

	karate.log('karate.env system property was:', env);
	karate.log('clientId:' + clientId);

	var config={
		baseURL : 'https://apigw-st.telus.com',
		authTokenURL : 'https://apigw-st.telus.com/st/token',
		env : 'it01', 
		mockResponseWLS_REZ : '',
		mockResponseWLN_BIZ : '',
		mockResponseWLS_BIZ : '',
		mockResponseWLS_CORP_ACTIVE : '',
    	mockResponseWLS_CORP_SUSPENDED : '',
    	mockResponseWLS_CORP_CANCELLED : '',
    	mockResponseWLS_BIZ_ACTIVE : '',
    	mockResponseWLS_BIZ_SUSPENDED : '',
    	mockResponseWLN_BIZ_ACTIVE : '',
    	mockResponseWLS_RES_ACTIVE : '',
    	mockResponseWLS_RES_SUSPENDED : '',
    	mockResponseWLN_RES_ACTIVE : ''
	};
	
	if (env == 'it01')
	{
		config.env='it01'		
	}
	else if (env=='it02')
	{
		config.env='it02'
	}else if (env=='it03')
	{
		config.env='it03'
	} else if (env=='it04')
	{
		config.env='it04'
		
	} else if (env=='pr') 
	{
		config.env='pr'
		config.baseURL = 'https://apigw-pr.telus.com/'
		config.authTokenURL = 'https://apigw-pr.telus.com/token'
	}

	karate.configure('connectTimeout',10000);
	karate.configure('readTimeout',10000);
	var result = karate.callSingle('classpath:feature/accessToken.feature', config);
	config.authInfo = result;
	karate.log("Current URL is : "+config.baseURL);
	karate.log("Current Env is : "+config.env);
	return config

}
