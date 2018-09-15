package edu.stts;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

/**
 * Servlet implementation class Load
 */
@WebServlet("/Load")
public class Load extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    @Override  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 	BlobKey blobKey = new BlobKey(request.getParameter("blob-key"));
        blobstoreService.serve(blobKey, response);
   
	}

}
