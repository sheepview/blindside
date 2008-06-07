class Conference {
	String name
	Integer number
	Integer pin
	Integer numberOfAttendees
	String attendees
	Date startDateTime = new Date()
	Date endDateTime = new Date()
	Date dateCreated
	Date lastUpdated
	
//	static hasMany = [attendees:Attendee]
	static optionals = [ 'attendees' ]
	
	static constraints = {
		name(maxLength:50, blank:false)
		number(maxLength:10,blank:false)
		pin(maxLength:20,blank:false)
		startDateTime(validator: {return it > new Date()})
		endDateTime(validator: {return it > new Date()})
		numberOfAttendees()
		attendees()
	}

    static mapping = {
        attendees type: 'text'
    }
    	
	String toString() {"${this.name}"}
}
