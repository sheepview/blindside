class Conference {
	String name
	Integer number
	Integer pin
	Integer numberOfAttendees
	Date startDateTime = new Date()
	Date endDateTime = new Date()
	Date dateCreated
	Date lastUpdated
	
	static hasMany = [attendees:Attendee]
	
	static constraints = {
		name(maxLength:50, blank:false)
		number(maxLength:10,blank:false)
		pin(maxLength:20,blank:false)
		startDateTime(validator: {return it > new Date()})
		endDateTime(validator: {return it > new Date()})
		numberOfAttendees()
	}
	
	String toString() {"${this.name}"}
}
