package edu.stts;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.*;

import com.google.api.gax.paging.Page;
import com.google.auth.oauth2.ServiceAccountCredentials;
import com.google.cloud.Timestamp;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.storage.*;
import com.google.cloud.storage.Acl.Role;
import com.google.cloud.storage.Acl.User;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;


/**
 * Servlet implementation class uploadFile
 */
@WebServlet("/uploadFile")
@MultipartConfig
public class uploadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static connection conn = connection.getInstance();
	private static Datastore ds = conn.getDatastore();
	private static KeyFactory kf = ds.newKeyFactory().setKind("TablePP");
	private static Storage storage = conn.getStorage();
	private static final String bucket = "inlaid-agility-170309.appspot.com";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public uploadFile() {
        super();
        // TODO Auto-generated constructor stub
    }


	private static BlobstoreService blobstoreService = conn.getBlobstore();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		 Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(request);
	        List<BlobKey> blobKeys = blobs.get("myFile");

	        if (blobKeys == null || blobKeys.isEmpty()) {
	        	response.sendRedirect("/");
	        } else {
	        	response.sendRedirect("/serve?blob-key=" + blobKeys.get(0).getKeyString());
	        }
		
        
	}
	
//    public static String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(request);
//        List<BlobKey> blobKeys = blobs.get("myFile");
//        byte[] data = blobstoreService.fetchData(blobKeys.get(0), 0, blobstoreService.MAX_BLOB_FETCH_SIZE - 1);
//        if (blobKeys == null || blobKeys.isEmpty()) {
//            response.sendRedirect("/");
//        } else {
//        	BlobId blobId = BlobId.of(bucket, blobKeys.get(0).getKeyString());
//    		String id = blobKeys.get(0).getKeyString();
//    		insertPost(request.getParameter("idTarget"), id);
//    		
//        	BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType("image/jpeg").setAcl(new ArrayList<>(Arrays.asList(Acl.of(User.ofAllUsers(), Role.READER)))).build();
//        	
//        	try {
//        		Blob blob2 = storage.create(blobInfo,data);
//        		HttpSession session = request.getSession();
//        		if(session.getAttribute("blobid") != null) {
//        			String blobidToDelete = session.getAttribute("blobid").toString(); 
//        			if(storage.delete(blobidToDelete))
//        				System.out.println("Succeed to delete" + blobidToDelete);
//        				else System.out.println("Failed to delete" + blobidToDelete);
//        		}
//        		session.setAttribute("blobid", id);
//        		return id;
//        	}catch(Exception e) {
//        		response.getWriter().append(e.getMessage());
//        	}
//        	
//        }
//		return "Failed";
//	}
    
	
}
