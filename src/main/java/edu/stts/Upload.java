package edu.stts;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.Query;
import com.google.cloud.datastore.QueryResults;
import com.google.cloud.datastore.StructuredQuery.PropertyFilter;
import com.google.cloud.storage.Acl;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.Acl.Role;
import com.google.cloud.storage.Acl.User;

/**
 * Servlet implementation class Upload
 */
@WebServlet("/Upload")
public class Upload extends HttpServlet {
	
	private static connection conn = connection.getInstance();
	private static Datastore ds = conn.getDatastore();
	private static Storage storage = conn.getStorage();
	private static final String bucket = "inlaid-agility-170309.appspot.com";
    

	private static BlobstoreService blobstoreService = conn.getBlobstore();
	private static final long serialVersionUID = 1L;
       
    public Upload() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		 Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
	        List<BlobKey> blobKeys = blobs.get("myFile");

	        if (blobKeys == null || blobKeys.isEmpty()) {
	            res.sendRedirect("/");
	        } else {
	            //res.sendRedirect("/Serve?blob-key=" + blobKeys.get(0).getKeyString());
	        	String username = req.getSession().getAttribute("sEmail").toString();
	        	Query<Entity> query = Query.newEntityQueryBuilder().setFilter(PropertyFilter.eq("email", username)).setKind("TableUser").build();
			    QueryResults<Entity> results = ds.run(query);
			    while (results.hasNext()) {
			    	Entity entity = results.next();
		    		    Entity updatedEntity = Entity.newBuilder(entity)
		    		    		.set("foto", blobKeys.get(0).getKeyString())
		    		    		.build();
		    		    ds.update(updatedEntity);
			    }
				//session.setAttribute("fotoUser", returnBlob);
			    req.getSession().setAttribute("fotoUser", blobKeys.get(0).getKeyString());
	        	
			    res.sendRedirect("profile.jsp");
	        }
        	
        
        }
		
	}


