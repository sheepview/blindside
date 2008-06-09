

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create Conference</title>         
    </head>
    <body>
        <div class="nav">
        	<div class="nav">
        		<g:render template="/adminmenubar" />
        	</div>
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Conference List</g:link></span>
        </div>
        <div class="body">
            <h1>Create Conference</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${conference}">
            <div class="errors">
                <g:renderErrors bean="${conference}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="conferenceName">Conference Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'conferenceName','errors')}">
                                    <input type="text" id="conferenceName" name="conferenceName" value="${fieldValue(bean:conference,field:'conferenceName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="conferenceNumber">Conference Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'conferenceNumber','errors')}">
                                    <input type="text" id="conferenceNumber" name="conferenceNumber" value="${fieldValue(bean:conference,field:'conferenceNumber')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pin">Pin:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'pin','errors')}">
                                    <input type="text" id="pin" name="pin" value="${fieldValue(bean:conference,field:'pin')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="startDateTime">Start Date Time:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'startDateTime','errors')}">
                                    <g:datePicker name="startDateTime" value="${conference?.startDateTime}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="endDateTime">End Date Time:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'endDateTime','errors')}">
                                    <g:datePicker name="endDateTime" value="${conference?.endDateTime}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberOfAttendees">Number Of Attendees:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'numberOfAttendees','errors')}">
                                    <input type="text" id="numberOfAttendees" name="numberOfAttendees" value="${fieldValue(bean:conference,field:'numberOfAttendees')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="attendees">Attendees:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'attendees','errors')}">
                                    <g:textArea id="attendees" name="attendees" value="${fieldValue(bean:conference,field:'attendees')}" rows="5" cols="40"/>
                                </td>
                            </tr>                         

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user">User:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'user','errors')}">
                                    <g:select optionKey="id" from="${User.list()}" name="user.id" value="${conference?.user?.id}" ></g:select>
                                </td>
                            </tr> 
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
