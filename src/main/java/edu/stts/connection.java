package edu.stts;

import java.io.FileInputStream;
import java.io.IOException;

import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.auth.oauth2.ServiceAccountCredentials;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

public class connection {
	private static connection conn;
	private Datastore datastore;
	private Storage storage = null;
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	

	private connection() {
		try {
			datastore = DatastoreOptions.newBuilder().setProjectId("inlaid-agility-170309").
					setCredentials(ServiceAccountCredentials.fromStream(new FileInputStream("My Project-b3225e5a13dd.json"))).build().getService();
			
			Storage storage = StorageOptions.newBuilder().setProjectId("inlaid-agility-170309").setCredentials(ServiceAccountCredentials.fromStream(new FileInputStream("My Project-b3225e5a13dd.json"))).build().getService();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Datastore getDatastore() {
		return datastore;
	}
	
	public Storage getStorage() {
		return storage;
	}

	public BlobstoreService getBlobstore() {
		return blobstoreService;
	}
	
	public static connection getInstance() {
		if(conn == null) {
			conn = new connection();
		}
		return conn;
	}
}
