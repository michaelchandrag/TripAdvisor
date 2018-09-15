package edu.stts;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;


public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlobKey blobKey = new BlobKey(request.getParameter("blob-key"));
		
        blobstoreService.serve(blobKey, response);

		String id = request.getParameter("idTarget");
	}

}
