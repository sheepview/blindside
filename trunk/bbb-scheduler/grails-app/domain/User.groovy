class User {
	String email
	String password
	String firstName
	String lastName
	SortedSet conferences
	Date dateCreated
	Date lastUpdated
	User createdBy
	User modifiedBy
			
	static hasMany = [ conferences: Conference ]
	
	static constraints = {
		email(email:true,unique:true)
		password(matches:/[\w\d]+/,length:6..12)
		firstName(blank:false)
		lastName(blank:false)	
	}
	
	String toString() {"${this.firstName} ${this.lastName}"}
}
