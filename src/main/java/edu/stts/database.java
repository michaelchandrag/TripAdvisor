package edu.stts;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

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
 * Servlet implementation class database
 */
public class database extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private connection conn = connection.getInstance();
	
	private Datastore ds = conn.getDatastore();
	private KeyFactory kf = ds.newKeyFactory().setKind("TableUser");
	
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		System.out.println("MASUK");
		PrintWriter out = resp.getWriter();
		String action = req.getParameter("action");
		
		if(action.equals("delete")) {
			//Long id = Long.parseLong(req.getParameter("id"));
			//delete(id);
		}
		
		if(action.equals("insert")) {
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			System.out.println("Name : " + name);
			System.out.println("Email : " + email);
			System.out.println("Password : " + password);
			
			//Long harga = Long.parseLong(req.getParameter("email"));
			//Long qty = Long.parseLong(req.getParameter("password"));
			String plainText = password; 
			MessageDigest mdAlgorithm = null;
			try {
				mdAlgorithm = MessageDigest.getInstance("MD5");
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			mdAlgorithm.update(plainText.getBytes()); 
			 
			byte[] digest = mdAlgorithm.digest(); 
			StringBuffer hexString = new StringBuffer(); 
			 
			for (int i = 0; i < digest.length; i++) { 
			    plainText = Integer.toHexString(0xFF & digest[i]); 
			 
			    if (plainText.length() < 2) { 
			        plainText = "0" + plainText; 
			    } 
			 
			    hexString.append(plainText); 
			}
			insert(name, email, hexString.toString());
		}
		
		/*if(action.equals("edit")) {
			Long id = Long.parseLong(req.getParameter("id"));
			String nama = req.getParameter("nama");
			Long harga = Long.parseLong(req.getParameter("harga"));
			Long qty = Long.parseLong(req.getParameter("qty"));
			edit(id, nama, harga, qty);
		}*/
//		
//		String nama = req.getParameter("nama");
//		System.out.println("Ini Nama = "+nama);
//		String harga = req.getParameter("harga");
//		System.out.println("Ini harga = "+harga);
//		String qty = req.getParameter("qty");
//		System.out.println("Ini qty= "+qty);
//		
//		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
//		Date date = new Date();
//		System.out.println(dateFormat.format(date));
//		String tampDateTime = dateFormat.format(date);
//		Datastore datastore = DatastoreOptions.newBuilder().setProjectId("shoppingcart-182405").
//	    		setCredentials(ServiceAccountCredentials.fromStream(new FileInputStream("ShoppingCart-70489f4e859c.json"))).build().getService();
//		
//		KeyFactory keyFactory = datastore.newKeyFactory().setKind("barang");
//		Key taskKey = datastore.allocateId(keyFactory.newKey());
//		Entity task = Entity.newBuilder(taskKey)
//			    .set("harga", Long.parseLong(harga))
//			    .set("nama", nama)
//			    .set("qty",Long.parseLong(qty))
//			    .set("time", tampDateTime)
//			    .build();
//		
//		datastore.put(task);
//		
//		System.out.println("Sukses");
//
//		resp.sendRedirect("index.jsp");
		out.println("BERHASIL");
	}
	
	/*private void delete(Long id) {
		Key barangKey = kf.newKey(id);
		ds.delete(barangKey);
	}*/
	
	/*private void edit(Long id, String nama, long harga, long qty) {
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
		String tampDateTime = dateFormat.format(date);
		
		
		Key barangKey = kf.newKey(id);
		Entity barang = Entity.newBuilder(barangKey)
				.set("harga", harga)
			    .set("nama", nama)
			    .set("qty",qty)
			    .set("time", tampDateTime)
			    .build();
		ds.put(barang);
	}*/
	
	private void insert(String name, String email, String password) {
		/*DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
		String tampDateTime = dateFormat.format(date);
		*/
		
		Key barangKey = ds.allocateId(kf.newKey());
		Entity user = Entity.newBuilder(barangKey)
				.set("name", name)
			    .set("foto", "AMIfv96TrHkb_YFF2dzPiN86PlPnuWrNjTIuwItg1fdpkevnYsTNeJNmUCvEfgOEjLB6BdNS7th9lTgUFKoPQUv4eTq4xzWidi10dXJrhd14REAiYCpLhR1i4moFLBZ5BBpbhOgjTMgyr0UeLyG9RgdpoVgswk6pZDU75e4ZpqTZWCam1wVaGbqj00Kmajj10QX8Gpnygsa6kglCcC-KISR1eDA1m9yPSOFvslJ8R-KNRIxqNvOkNpSuEUIXd8iFWnwD7IgsbDFn8mljASo2V7wWjzsVe-z3iBt4470DTSlQ6NhLBQE9xXUctnrVHezDmf9HxBNHSb3he1NxvEQutgh5qD3MgFDwzIOvIHsC-icpLplISh1YrspCVx37THXbdP2XifzEKjHueqcQNAwLQh3yV-bL2DMnJD2-WCkT8oaKcnPxRbH_HdM ")
			    .set("email", email)
			    .set("password",password)
			    .build();
		ds.put(user);
	}
		
}
