package edu.stts;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;

/**
 * Servlet implementation class WishlistPlace
 */
@WebServlet("/WishlistPlace")
public class WishlistPlace extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private connection conn = connection.getInstance();
	
	private Datastore ds = conn.getDatastore();
	private KeyFactory kf = ds.newKeyFactory().setKind("TableWishlistPlace");   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WishlistPlace() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String id = req.getParameter("id");
		String user = req.getParameter("user");
		String action = req.getParameter("action");
		if(action.equals("insert"))
		{
			insert(user,id);
		}
		if(action.equals("delete"))
		{
			delete(id);
		}
		if(action.equals("update"))
		{
			String status = req.getParameter("status");
			String idPlace = req.getParameter("idPlace");
			update(id,idPlace,status,user);
		}
		
	}
	private void insert(String user, String idPlace) {

		Key barangKey = ds.allocateId(kf.newKey());
		Entity query = Entity.newBuilder(barangKey)
			    .set("user", user)
			    .set("idPlace",idPlace)
			    .set("status","1" )
			    .build();
		ds.put(query);
		
	}
	
	private void delete(String autoID)
	{
		Key id = kf.newKey(autoID);
		ds.delete(id);
	}
	
	private void update(String id,String idPlace, String status, String user)
	{
		//Long keyTableUser = Long.parseLong(session.getAttribute("sKey").toString());
		if(status.equals("0"))
		{
			status = "1";
		}
		else
		{
			status= "0";
		}
		Long autoID = Long.parseLong(id);
		Key key = kf.newKey(autoID);
		//System.out.println(key);
		Entity query = Entity.newBuilder(key)
				.set("idPlace", idPlace)
			    .set("status", status)
			    .set("user",user)
			    .build();
		ds.put(query);
	}

}
