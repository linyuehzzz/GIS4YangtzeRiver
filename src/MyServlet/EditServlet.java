package MyServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.utils.StationDao;

/**
 * Servlet implementation class EditServlet
 */
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String StationName = request.getParameter("StationName");
        String StationName_1 = StationName;
        String UpdateUser = request.getParameter("UpdateUser");
        String UpdateUser_1 = UpdateUser;
        String FieldName = request.getParameter("FieldName");
        String FieldName_1 = FieldName;
        
        if(FieldName_1.equals("µãÎ»Ãû³Æ")) {
        	String FieldValue = request.getParameter("FieldValue");
        	String FieldValue_1 = FieldValue;
            int flag = StationDao.updateStationSN(StationName_1, FieldValue_1, UpdateUser_1);       
            PrintWriter out = response.getWriter();
            out.println(flag);
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
