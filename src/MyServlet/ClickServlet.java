package MyServlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.utils.Station;
import com.utils.StationDao;

/**
 * Servlet implementation class ClickServlet
 */
@WebServlet("/ClickServlet")
public class ClickServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClickServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String coordinate = request.getParameter("coordinate");
        if(coordinate != null)
        {
        	Station s = new Station();      	
            s = StationDao.getClickResult(coordinate);
            String json = Station.Object2Json(s);
            response.setCharacterEncoding("UTF-8");    
            response.setContentType("application/json; charset=utf-8");    
            PrintWriter writer = response.getWriter();  
            writer.append(json);
        }
        else return;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
