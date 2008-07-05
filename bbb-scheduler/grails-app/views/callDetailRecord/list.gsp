

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>CallDetailRecord List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New CallDetailRecord</g:link></span>
        </div>
        <div class="body">
            <h1>CallDetailRecord List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="callerName" title="Caller Name" />
                        
                   	        <g:sortableColumn property="callerNumber" title="Caller Number" />
                        
                   	        <g:sortableColumn property="channelId" title="Channel Id" />
                        
                   	        <g:sortableColumn property="conferenceNumber" title="Conference Number" />
                        
                   	        <g:sortableColumn property="dateJoined" title="Date Joined" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${callDetailRecordList}" status="i" var="callDetailRecord">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${callDetailRecord.id}">${callDetailRecord.id?.encodeAsHTML()}</g:link></td>
                        
                            <td>${callDetailRecord.callerName?.encodeAsHTML()}</td>
                        
                            <td>${callDetailRecord.callerNumber?.encodeAsHTML()}</td>
                        
                            <td>${callDetailRecord.channelId?.encodeAsHTML()}</td>
                        
                            <td>${callDetailRecord.conferenceNumber?.encodeAsHTML()}</td>
                        
                            <td>${callDetailRecord.dateJoined?.encodeAsHTML()}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${CallDetailRecord.count()}" />
            </div>
        </div>
    </body>
</html>
