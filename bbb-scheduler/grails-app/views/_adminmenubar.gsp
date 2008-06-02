<g:if test="${!session.userId}">
	<span class="menuButton">
		<g:link controller="user" action="login">Log in</g:link>
	</span>
</g:if>
<g:else>
	<span class="menuButton">
		<g:link controller="conference" action="list">
			Manage Conferences
		</g:link>
	</span>
	<span class="menuButton">
		<g:link controller="user" action="list">
			Manage Users
		</g:link>
	</span>
	<span class="menuButton">
		<g:link controller="user" action="logout">
			Log out
		</g:link>
	</span>
</g:else>