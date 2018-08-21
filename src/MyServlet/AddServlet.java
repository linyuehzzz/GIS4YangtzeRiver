package MyServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.utils.Station;
import com.utils.StationDao;

/**
 * Servlet implementation class AddServlet
 */
@WebServlet("/AddServlet")
public class AddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddServlet() {
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
               
    	Station s = new Station();
    	if(request.getParameter("Coordinate")!=null) {
            String Coordinate = request.getParameter("Coordinate");
            String Coordinate_1 = Coordinate;
            s.setCoordinate(Coordinate_1);
    	};
    	if(request.getParameter("StationName")!=null) {
        	String StationName = request.getParameter("StationName");
        	String StationName_1 = StationName;
        	s.setStationName(StationName_1);
    	};
    	if(request.getParameter("RiverName")!=null) {
            String RiverName = request.getParameter("RiverName");
            String RiverName_1 = RiverName;
            s.setRiverName(RiverName_1);
    	}
    	if(request.getParameter("Section")!=null) {
            String Section = request.getParameter("Section");
            String Section_1 = Section;
            s.setSection(Section_1);
    	};
        if(request.getParameter("PH")!=null) {
            BigDecimal PH = new BigDecimal(request.getParameter("PH"));
            BigDecimal PH_1 = PH;
            s.setPH(PH_1);
        };
        if(request.getParameter("DO")!=null) {
            BigDecimal DO = new BigDecimal(request.getParameter("DO"));
            BigDecimal DO_1 = DO;
            s.setDO(DO_1);
        };
        if(request.getParameter("CODMn")!=null) {
            BigDecimal CODMn = new BigDecimal(request.getParameter("CODMn"));
            BigDecimal CODMn_1 = CODMn;
            s.setCODMn(CODMn_1);
        };
        if(request.getParameter("NH3_N")!=null) {
            BigDecimal NH3_N = new BigDecimal(request.getParameter("NH3_N"));
            BigDecimal NH3_N_1 = NH3_N;
            s.setNH3_N(NH3_N_1);
        }
        if(request.getParameter("WQThisWeek")!=null) {
            String WQThisWeek = request.getParameter("WQThisWeek");
            String WQThisWeek_1 = WQThisWeek;
            s.setQualityThisWeek(WQThisWeek_1);
        };
        if(request.getParameter("WQLastWeek")!=null) {
            String WQLastWeek = request.getParameter("WQLastWeek");
            String WQLastWeek_1 = WQLastWeek;
            s.setQualityLastWeek(WQLastWeek_1);
        };
        if(request.getParameter("MainPollutant")!=null) {
            String MainPollutant = request.getParameter("MainPollutant");
            String MainPollutant_1 = MainPollutant;
            s.setMainPollutant(MainPollutant_1);
        };
        if(request.getParameter("UpdateUser")!=null) {
            String UpdateUser = request.getParameter("UpdateUser");
            String UpdateUser_1 = UpdateUser;
            s.setUpdateUser(UpdateUser_1);
        };
        if(request.getParameter("CreateUser")!=null) {
            String CreateUser = request.getParameter("CreateUser");
            String CreateUser_1 = CreateUser;
            s.setCreateUser(CreateUser_1);
        };
     
        int flag = StationDao.addStation(s);           
        PrintWriter out = response.getWriter();
        out.println(flag);

	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
