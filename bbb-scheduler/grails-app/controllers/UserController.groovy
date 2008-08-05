            
class UserController extends BaseController {

	VolunteerOttawaService volunteerOttawaService
	
    def beforeInterceptor = [action:this.&auth,
    							except:['login', 'logout', 'vologin']]
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        if(!params.max) params.max = 10
        [ userList: User.list( params ) ]
    }

    def show = {
        def user = User.get( params.id )

        if(!user) {
            flash.message = "User not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ user : user ] }
    }

    def delete = {
        def user = User.get( params.id )
        if(user) {
            user.delete()
            flash.message = "User ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "User not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def user = User.get( params.id )

        if(!user) {
            flash.message = "User not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ user : user ]
        }
    }

    def update = {
        def user = User.get( params.id )
        if(user) {
            user.properties = params
            if(!user.hasErrors() && user.save()) {
                flash.message = "User ${params.id} updated"
                redirect(action:show,id:user.id)
            }
            else {
                render(view:'edit',model:[user:user])
            }
        }
        else {
            flash.message = "User not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def user = new User()
        user.properties = params
        return ['user':user]
    }

    def save = {
        def user = new User(params)
        if(!user.hasErrors() && user.save()) {
            flash.message = "User ${user.id} created"
            redirect(action:show,id:user.id)
        }
        else {
            render(view:'create',model:[user:user])
        }
    }
        
    def login = {
    	if (request.method == "GET") {
    		session.email = null
    		def user = new User()
    	} else {
    		def user = User.findByEmailAndPassword(params.email, params.password)
    		if (user) {
    			session.email = user.email
    			redirect(controller:'conference')
    		} else {
    			flash['message'] = 'Please enter a valid email and password'
    		}
    	}
    }
    
    def logout = {
    	session.email = null
    	flash['message'] = 'Successfully logged out'
    	redirect(controller:'user', action:'login')
    }    
    
    def vologin = {
    	
    	def res = volunteerOttawaService.loginToVo(params.sessionId)
    	flash['message'] = "Please enter a $res"
    	redirect(controller:'user',action:'login')
    }
}