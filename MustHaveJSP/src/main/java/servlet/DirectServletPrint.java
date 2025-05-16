package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//서블릿 생성을 위한 첫번째로 HttpServlet 클래스를 상속한다.
public class DirectServletPrint extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	/*
		사용자가 post방식으로 전송한 요청을 처리하기 위해 doPost() 메서드를
		오버라이딩 한다. 만약 해당 메서드가 오버라이딩 되지 않으면 요청을
		처리할 메서드가 없으므로 405에러가 발생하게 된다.
	*/
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		// 서블릿에서 직접 HTML태그를 출력하기 위해 문서의 컨텐츠 타입을
		// 설정한다. 콘텐츠타입은 “text/html”으로, 캐릭터셋은 “UTF-8”로 지정
		resp.setContentType("text/html;charset=UTF-8");
		// 직접 출력을 위해 PrintWriter 객체를 생성한다.
		PrintWriter writer = resp.getWriter();
		// 출력할 내용을 기술한다.
		writer.println("<html>");
		writer.println("<head><title>DirectServletPrint</title></hrad>");
		writer.println("<body>");
		writer.println("<h2>서블릿에서 직접 출력합니다.</h2>");
		writer.println("<p>jsp로 포워드 하지 않습니다.</p>");
		writer.println("</body>");
		writer.println("</html>");
		 // 객체 자원을 해제한다. 
		writer.close();
		/*
	    	이방식은 JSP페이지 없이 서블릿에서 직접 내용을 출력해야 할때 
	    	사용한다. API통신시(XML or JSON) 주로 사용하게 된다.
			대부분의 경우에는 JSP를 통해 출력하는 쪽이 편리
	    */
	}
}
