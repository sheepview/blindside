class Conference implements Comparable {
	User owner
	String conferenceName
	Integer conferenceNumber
	Integer pin
	Integer numberOfAttendees
	String attendees
	Date startDateTime = new Date()
	Date endDateTime = new Date()
	Date dateCreated
	Date lastUpdated
		
	static optionals = [ 'attendees' ]
	
	static belongsTo = [owner:User]
	
	static constraints = {
		conferenceName(maxLength:50, blank:false)
		conferenceNumber(maxLength:10, unique:true, blank:false)
		pin(maxLength:20, blank:false)
		startDateTime(validator: {return it > new Date()})
		endDateTime(validator: {return it > new Date()})
		numberOfAttendees()
		attendees()
	}

    static mapping = {
        attendees type: 'text'
    }
    	
	String toString() {"${this.conferenceName}"}

    int compareTo(obj) {
        obj.id.compareTo(id)
    }

}
