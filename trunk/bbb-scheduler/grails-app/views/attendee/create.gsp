

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create Attendee</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Attendee List</g:link></span>
        </div>
        <div class="body">
            <h1>Create Attendee</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${attendee}">
            <div class="errors">
                <g:renderErrors bean="${attendee}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="conference">Conference:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:attendee,field:'conference','errors')}">
                                    <g:select optionKey="id" from="${Conference.list()}" name="conference.id" value="${attendee?.conference?.id}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:attendee,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:attendee,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="emailAddress">Email Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:attendee,field:'emailAddress','errors')}">
                                    <input type="text" id="emailAddress" name="emailAddress" value="${fieldValue(bean:attendee,field:'emailAddress')}"/>
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
