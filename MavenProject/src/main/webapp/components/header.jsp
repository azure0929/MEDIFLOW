<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.service.spring.domain.Member" %>

<%
    Member loggedInMember = (Member) session.getAttribute("loggedInMember");
%>

<header>
	<div class="header-inner">
		<div class="logo">
			<a href="/index.jsp"><img src="/img/logo.webp" alt="logo" /></a>
		</div>
		<nav>
			<ul>
				<%
					if (loggedInMember != null) {
				%>
					<li><a href="/member/mypage.jsp"><span><%= loggedInMember.getmName() %></span>님</a></li>
				<%
					} else {
				%>
					<li class="profile"><img src="/img/profile.webp" alt="profile" /></li>
				<%
					}
				%>
			</ul>
		</nav>
	</div>
</header>