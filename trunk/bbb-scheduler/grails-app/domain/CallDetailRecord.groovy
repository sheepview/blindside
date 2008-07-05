
class CallDetailRecord {
	Integer conferenceNumber
	String channelId
	Integer userNumber
	Date dateJoined
	Date dateLeft
	String callerName
	String callerNumber
	
    def CallDetailRecord() {}
    	
	String toString() {"${this.callerName} ${this.callerNumber}"}
}