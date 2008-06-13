dataSource {
	pooled = false
	driverClassName = "com.mysql.jdbc.Driver"
	username = "sa"
	password = ""
}

hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='org.hibernate.cache.EhCacheProvider'
}

// environment specific settings
environments {
	development {
		dataSource {
			pooled = true
			dbCreate = "create-drop" // one of 'create', 'create-drop','update'
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:hsqldb:mem:testDb"
		}
	}
	production {
		dataSource {
			pooled = true
			dbCreate = "update" // one of 'create', 'create-drop','update'
		}
	}
}