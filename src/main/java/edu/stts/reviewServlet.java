package edu.stts;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.auth.oauth2.ServiceAccountCredentials;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.datastore.*;
import com.google.cloud.storage.Storage;
import com.google.api.client.util.store.DataStore;

/**
 * Servlet implementation class reviewServlet
 */
public class reviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private connection conn = connection.getInstance();
	
	private Datastore ds = conn.getDatastore();
	private KeyFactory kf = ds.newKeyFactory().setKind("TableReview");
	private KeyFactory kfResto = ds.newKeyFactory().setKind("TableResto");
	private KeyFactory kfPlace = ds.newKeyFactory().setKind("TablePlace");
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		ServletContext sc = request.getSession().getServletContext();  
		  response.getWriter().println("Servlet version = " + sc.getMajorVersion() + "." + sc.getMinorVersion());
		  
		PrintWriter out = response.getWriter();
		System.out.println("Name : " );
		String action = request.getParameter("action");
		if(action.equals("insert")) {
			String idTarget = request.getParameter("idTarget");
			String isiReview = request.getParameter("isiReview");
			String namaUsr = request.getParameter("namaUsr");
			String ratingReview = request.getParameter("ratingReview");

			System.out.println("Name : " + idTarget);
			System.out.println("Email : " + isiReview);
			System.out.println("Password : " + namaUsr);
			System.out.println("Password : " + ratingReview);
			System.out.println("Servlet version = " + sc.getMajorVersion() + "." + sc.getMinorVersion());
			//Long harga = Long.parseLong(req.getParameter("email"));
			//Long qty = Long.parseLong(req.getParameter("password"));
			insert(idTarget , isiReview , namaUsr, ratingReview);
			
		}
		
	}
	
	private void insert(String idTarget, String isiReview, String namaUsr, String ratingReview) {

		Key barangKey = ds.allocateId(kf.newKey());
		Entity user = Entity.newBuilder(barangKey)
			    .set("idTarget", idTarget)
			    .set("isiReview",isiReview)
			    .set("namaUser",namaUsr)
			    .set("rating",ratingReview)
			    .build();
		ds.put(user);
		
	}

}
