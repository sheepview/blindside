class Attendee {
	Conference conference
	String name
	String emailAddress
	Date dateCreated
	Date lastUpdated
	
	static belongsTo = Conference
	
	static constraints = {
		conference(nullable:false)
		name(maxLength:50,blank:false)
		emailAddress(maxLength:50,email:true)		
	}
	
	String toString() {"${this.name}:${this.emailAddress}"}
}
