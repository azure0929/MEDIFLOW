
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.service.spring.domain.Member"%>

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
				<li><a href="/member/bookings"><span><%= loggedInMember.getmName() %></span>님</a></li>
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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(() => {
      const $header = $('header');
      const headerHeight = $header.outerHeight();

      $(window).on('scroll', function() {
        const scrollPosition = $(this).scrollTop();

        if (scrollPosition > headerHeight) {
            $header.addClass('scrolled');
        } else {
            $header.removeClass('scrolled');
        }
      });
    });
</script>