

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Conference</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Conference List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Conference</g:link></span>
        </div>
        <div class="body">
            <h1>Show Conference</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>   
            
            <div class="dialog">
                <table>
                    <tbody>            
                        <tr class="prop">
                            <td valign="top" class="name">Conference Name:</td>
                            
                            <td valign="top" class="value">${conference.conferenceName}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Conference ID:</td>
                            
                            <td valign="top" class="value">${conference.conferenceNumber}#</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Start Date Time:</td>
                            
                            <td valign="top" class="value">${conference.startDateTime}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Length Of Conference:</td>
                            
                            <td valign="top" class="value">${conference.lengthOfConference} hour(s)</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Number Of Attendees:</td>
                            
                            <td valign="top" class="value">${conference.numberOfAttendees}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Email:</td>
                            
                            <td valign="top" class="value">${conference.email}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Date Created:</td>
                            
                            <td valign="top" class="value">${conference.dateCreated}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Last Updated:</td>
                            
                            <td valign="top" class="value">${conference.lastUpdated}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Owner:</td>
                            
                            <td valign="top" class="value">${conference?.fullname}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Invitation Email:</td>
                            
                            <td valign="top" class="value">
                            	This is a sample email you can send to people you want to invite.<br/>
                            	-----------------------------------------------------------------<br/><br/>
                            	Please join me for a conference on ${conference.startDateTime}. <br/><br/>
                            	Here are the information needed to join the conference: <br/>
                            	&nbsp;<br/>
                            	Phone Number: 613-731-1141 <br/>
                            	Conference: ${conference.conferenceNumber}# <br/>
                            	&nbsp;<br/>
                            	Regards, <br/><br/>
                            	${conference?.fullname}
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${conference?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
        <div class="body">
            <h1>Attendees List</h1>
            <div class="list">
                <table>
                    <thead>
                        <tr>                       
                   	        <g:sortableColumn property="callerName" title="Caller Name" />                        
                   	        <g:sortableColumn property="callerNumber" title="Caller Number" />
                   	        <g:sortableColumn property="dateJoined" title="Date Joined" />
                        	<g:sortableColumn property="dateLeft" title="Date Left" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${attendeesList}" status="i" var="attendees">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>${attendees.callerName?.encodeAsHTML()}</td>
                        
                            <td>${attendees.callerNumber?.encodeAsHTML()}</td>
                        
                            <td>${attendees.dateJoined?.encodeAsHTML()}</td>
                        	<td>${attendees.dateLeft?.encodeAsHTML()}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <!--div class="paginateButtons">
                <g:paginate total="${Attendees.count()}" />
            </div-->
        </div>
    </body>
</html>
