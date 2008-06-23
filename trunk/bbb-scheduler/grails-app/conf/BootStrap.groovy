class BootStrap {

     def init = { servletContext ->
     	println 'bootstrapping'
     	final String EMAIL_ADMIN = 'adminra@test.com'
     	final String PASSWORD = 'secret'
     	final String FIRSTNAME = 'RA'
     	final String LASTNAME = 'ADMIN'
     	if (!User.findByEmail(EMAIL_ADMIN)) {
     		println 'saving new user'
     		new User(email:EMAIL_ADMIN, password:PASSWORD, firstName:FIRSTNAME, lastName:LASTNAME).save()
     		User a = User.findByEmail(EMAIL_ADMIN)
     		println a.email
     	}
     }
     
     def destroy = {
     }
} 