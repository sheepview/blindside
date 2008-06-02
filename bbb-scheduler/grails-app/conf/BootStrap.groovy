class BootStrap {

     def init = { servletContext ->
     println 'bootstrapping'
     	final String BACKUP_ADMIN = 'adminra'
     	if (!User.findByUserId(BACKUP_ADMIN)) {
     		new User(userId:BACKUP_ADMIN,password:'password').save()
     	}
     }
     def destroy = {
     }
} 