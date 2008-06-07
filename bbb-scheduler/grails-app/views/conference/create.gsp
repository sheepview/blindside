

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
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:conference,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="number">Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:conference,field:'number','errors')}">
                                    <input type="text" id="number" name="number" value="${fieldValue(bean:conference,field:'number')}" />
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
                                	
                                    <!--input type="text" id="attendees" name="attendees" value="${fieldValue(bean:conference,field:'attendees')}"/-->
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
