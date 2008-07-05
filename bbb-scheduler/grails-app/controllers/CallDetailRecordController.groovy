import java.text.SimpleDateFormat
            
class CallDetailRecordController extends BaseController {
    def beforeInterceptor = [action:this.&auth]
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        if(!params.max) params.max = 10
//        [ callDetailRecordList: CallDetailRecord.list( params ) ]
//        if (params.start)
			def conf = new Integer(params.conferenceNumber)
			def startTime = new Date(new Long(params.start))
			def endTime = new Date(new Long(params.start) + 5*60*1000)
			flash.message = "${startTime} ${endTime}"
//			CallDetailRecord.findAllByConferenceNumberAndDateJoinedBetween(conf, startTime, endTime)]
        	return [ callDetailRecordList: 
        		CallDetailRecord.findAllByConferenceNumberAndDateJoinedBetween(conf, startTime, endTime)]
//        		CallDetailRecord.findAllByConferenceNumberAndDateJoinedGreaterThan(conf, startTime)]
//        else 
 //       	return [ callDetailRecordList: CallDetailRecord.findAllByStartDateTimeGreaterThanEquals(new Date() - 1)]  
    }

    def show = {
        def callDetailRecord = CallDetailRecord.get( params.id )

        if(!callDetailRecord) {
            flash.message = "CallDetailRecord not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ callDetailRecord : callDetailRecord ] }
    }

    def delete = {
        def callDetailRecord = CallDetailRecord.get( params.id )
        if(callDetailRecord) {
            callDetailRecord.delete()
            flash.message = "CallDetailRecord ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "CallDetailRecord not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def callDetailRecord = CallDetailRecord.get( params.id )

        if(!callDetailRecord) {
            flash.message = "CallDetailRecord not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ callDetailRecord : callDetailRecord ]
        }
    }

    def update = {
        def callDetailRecord = CallDetailRecord.get( params.id )
        if(callDetailRecord) {
            callDetailRecord.properties = params
            if(!callDetailRecord.hasErrors() && callDetailRecord.save()) {
                flash.message = "CallDetailRecord ${params.id} updated"
                redirect(action:show,id:callDetailRecord.id)
            }
            else {
                render(view:'edit',model:[callDetailRecord:callDetailRecord])
            }
        }
        else {
            flash.message = "CallDetailRecord not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def callDetailRecord = new CallDetailRecord()
        callDetailRecord.properties = params
        return ['callDetailRecord':callDetailRecord]
    }

    def save = {
        def callDetailRecord = new CallDetailRecord(params)
        if(!callDetailRecord.hasErrors() && callDetailRecord.save()) {
            flash.message = "CallDetailRecord ${callDetailRecord.id} created"
            redirect(action:show,id:callDetailRecord.id)
        }
        else {
            render(view:'create',model:[callDetailRecord:callDetailRecord])
        }
    }
}