            
class AttendeeController extends BaseController {
    def beforeInterceptor = [action:this.&auth, except:[]]
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        if(!params.max) params.max = 10
        [ attendeeList: Attendee.list( params ) ]
    }

    def show = {
        def attendee = Attendee.get( params.id )

        if(!attendee) {
            flash.message = "Attendee not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ attendee : attendee ] }
    }

    def delete = {
        def attendee = Attendee.get( params.id )
        if(attendee) {
            attendee.delete()
            flash.message = "Attendee ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "Attendee not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def attendee = Attendee.get( params.id )

        if(!attendee) {
            flash.message = "Attendee not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ attendee : attendee ]
        }
    }

    def update = {
        def attendee = Attendee.get( params.id )
        if(attendee) {
            attendee.properties = params
            if(!attendee.hasErrors() && attendee.save()) {
                flash.message = "Attendee ${params.id} updated"
                redirect(action:show,id:attendee.id)
            }
            else {
                render(view:'edit',model:[attendee:attendee])
            }
        }
        else {
            flash.message = "Attendee not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def attendee = new Attendee()
        attendee.properties = params
        return ['attendee':attendee]
    }

    def save = {
        def attendee = new Attendee(params)
        if(!attendee.hasErrors() && attendee.save()) {
            flash.message = "Attendee ${attendee.id} created"
            redirect(action:show,id:attendee.id)
        }
        else {
            render(view:'create',model:[attendee:attendee])
        }
    }
}