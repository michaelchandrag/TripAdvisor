package edu.stts;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;
import java.util.*;
import java.nio.charset.Charset;

/**
 * Servlet implementation class Wishlist
 */
public class Wishlist extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private connection conn = connection.getInstance();
	
	private Datastore ds = conn.getDatastore();
	private KeyFactory kf = ds.newKeyFactory().setKind("TableWishlistResto");
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Wishlist() {
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
			String idResto = req.getParameter("idResto");
			update(id,idResto,status,user);
		}
		//System.out.println(id);
		//System.out.println(user);
	}
	private void insert(String user, String idResto) {

		Key barangKey = ds.allocateId(kf.newKey());
		Entity query = Entity.newBuilder(barangKey)
			    .set("user", user)
			    .set("idResto",idResto)
			    .set("status","1" )
			    .build();
		ds.put(query);
		
	}
	
	private void delete(String autoID)
	{
		Key id = kf.newKey(autoID);
		ds.delete(id);
	}
	
	private void update(String id,String idResto, String status, String user)
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
				.set("idResto", idResto)
			    .set("status", status)
			    .set("user",user)
			    .build();
		ds.put(query);
	}
}
