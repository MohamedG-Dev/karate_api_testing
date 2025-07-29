function fn() {
	var env = karate.env; // get system property 'karate.env'
	karate.log('karate.env system property was:', env);
	if (!env) {
		env = 'staging';
	}
	var config = {
		env: env,
		myVarName: 'someValue',
		username: 'admin1',
		password: 'welcome',
		_url: 'http://localhost:9897'
	}
	if (env == 'dev') {
		config.username = 'Thomas',
			config.password = 'shelby'
	} else if (env == 'e2e') {
		config.username = 'Arthur',
			config.password = 'shelby'
	} else if (env == 'staging') {
		config.username = 'staginguser',
			config.password = 'stagingpassword',
			config._url = 'http://staging.localhost:9897'
	} else if (env == 'preprod') {
		config.username = 'preproduser',
			config.password = 'preprod',
			config._url = 'http://preprod.localhost:9897'
	} else if (env == 'production') {
		config.username = 'productionusername',
			config.password = 'productionpassword',
			config._url = 'http://prod.localhost:9897'
	}
	return config;
}