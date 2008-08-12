          
class ConferenceController extends BaseController {
    def beforeInterceptor = [action:this.&auth]
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        if(!params.max) params.max = 10
        if (params.past)
        	return [ conferenceList: Conference.findAllByStartDateTimeLessThan(new Date())]
        else 
        	return [ conferenceList: Conference.findAllByStartDateTimeGreaterThanEquals(new Date() - 1)]        	
    }

    def show = {
        def conference = Conference.get( params.id )

        if(!conference) {
            flash.message = "Conference not found with id ${params.id}"
            redirect(action:list)
        }
        else { 
			def startTime = conference.startDateTime
			def endTime = new Date(new Long(conference.startDateTime.time) + new Long(conference.lengthOfConference)*60*60*1000)
        	def attendeesList = 
        		Attendees.findAllByConferenceNumberAndDateJoinedBetween(conference.conferenceNumber, startTime, endTime)
        	return [ conference : conference, attendeesList : attendeesList ] 
        }
    }

    def delete = {
        def conference = Conference.get( params.id )
        if(conference) {
            conference.delete()
            flash.message = "Conference ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "Conference not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def conference = Conference.get( params.id )

        if(!conference) {
            flash.message = "Conference not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ conference : conference ]
        }
    }

    def update = {
        def conference = Conference.get( params.id )
        if(conference) {
            conference.properties = params
            if(!conference.hasErrors() && conference.save()) {
                flash.message = "Conference ${params.id} updated"
                redirect(action:show,id:conference.id)
            }
            else {
                render(view:'edit',model:[conference:conference])
            }
        }
        else {
            flash.message = "Conference not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def conference = new Conference()
        conference.properties = params     
        conference.conferenceName = "Test-"   
        return ['conference':conference]
    }

    def save = {
        def conference = new Conference(params)       
        conference.conferenceNumber = 80000 + Conference.count() 
        if(!conference.hasErrors() && conference.save()) {
            flash.message = "Conference ${conference.id} created"
            redirect(action:show,id:conference.id)
        }
        else {
            render(view:'create',model:[conference:conference])
        }
    }
}