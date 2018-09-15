<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <%@page import="java.security.MessageDigest"%>
<%@page import="com.google.api.gax.paging.Page"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="com.google.cloud.storage.Blob"%>
<%@page import="com.google.cloud.storage.BlobInfo"%>
<%@page import="com.google.cloud.storage.BlobId"%>
<%@page import="com.google.cloud.storage.StorageOptions"%>
<%@page import="com.google.cloud.storage.Storage"%>
<%@page import="com.google.cloud.datastore.Key"%>
<%@page import="com.google.cloud.datastore.KeyFactory"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.*"%>
<%@page import="com.google.cloud.datastore.QueryResults"%>
<%@page import="com.google.cloud.bigquery.QueryResult"%>
<%@page import="com.google.cloud.datastore.StructuredQuery.PropertyFilter"%>
<%@page import="com.google.cloud.datastore.Entity"%>
<%@page import="com.google.cloud.datastore.Query"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.*"%>
<%@page import="com.google.auth.oauth2.ServiceAccountCredentials"%>
<%@page import="com.google.cloud.datastore.DatastoreOptions"%>
<%@page import="com.google.cloud.datastore.Datastore"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>

<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>
<html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>GARO ESTATE | Register page</title>
        <meta name="description" content="GARO is a real-estate template">
        <meta name="author" content="Kimarotec">
        <meta name="keyword" content="html5, css, bootstrap, property, real-estate theme , bootstrap template">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700,800' rel='stylesheet' type='text/css'>

        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
        <link rel="icon" href="favicon.ico" type="image/x-icon">

        <link rel="stylesheet" href="assets/css/normalize.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/fontello.css">
        <link href="assets/fonts/icon-7-stroke/css/pe-icon-7-stroke.css" rel="stylesheet">
        <link href="assets/fonts/icon-7-stroke/css/helper.css" rel="stylesheet">
        <link href="assets/css/animate.css" rel="stylesheet" media="screen">
        <link rel="stylesheet" href="assets/css/bootstrap-select.min.css"> 
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/icheck.min_all.css">
        <link rel="stylesheet" href="assets/css/price-range.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.css">  
        <link rel="stylesheet" href="assets/css/owl.theme.css">
        <link rel="stylesheet" href="assets/css/owl.transitions.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
    </head>
    <body>
    <%!  %>
		<%				
			//Tidak Terdapat Seesion Name
			Datastore datastore;		
		
			datastore = DatastoreOptions.newBuilder().setProjectId("inlaid-agility-170309").
					setCredentials(ServiceAccountCredentials.fromStream(new FileInputStream("My Project-b3225e5a13dd.json"))).build().getService();
			
			KeyFactory kf = datastore.newKeyFactory().setKind("TableUser");
			
			if(session.getAttribute("sName") != null)
			{				
				Query<Entity> query1 =
					    Query.newEntityQueryBuilder().setKind("TableUser")
					    .setFilter(PropertyFilter.eq("email", session.getAttribute("sEmail").toString()))
					    .build();
				QueryResults<Entity> results1 = datastore.run(query1);
				String returnPassword = "",returnValue = "";
				if (results1.hasNext()) {
					Entity entity1 = results1.next();
					returnValue = entity1.getString("name");
					returnPassword = entity1.getString("password");
					session.setAttribute("sName", returnValue);
					//session.setAttribute("sPassword", returnPassword);
					session.setAttribute("sKey", entity1.getKey().getId().toString());
				}
			}
			if (request.getParameter("btnChange") != null) {

		    	System.out.println("masuk if");
				String email = request.getParameter("emailProfile");
				String name = request.getParameter("nameProfile");
				String password = request.getParameter("passwordProfile");
				String confirmPassword = request.getParameter("ConfirmPasswordProfile");

		    	System.out.println("masuk if lagi");
				if(email!="" && name!="")
				{
			    	System.out.println("masuk1");
					if(password.equalsIgnoreCase(confirmPassword))
					{
				    	System.out.println("masuk2");
						//Password dan ConfrimPassword sudah sama
						String plainText = password; 
						MessageDigest mdAlgorithm = MessageDigest.getInstance("MD5"); 
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
						Long keyTableUser = Long.parseLong(session.getAttribute("sKey").toString());
						Key userKey = kf.newKey(keyTableUser);
						Entity userTable = Entity.newBuilder(userKey)
								.set("name", name)
								.set("email", session.getAttribute("sEmail").toString())
							    .set("password", hexString.toString())
							    .build();
						datastore.put(userTable);
						response.sendRedirect("index.jsp");
					}
				}else{

			    	System.out.println("masuk else");
				}
				
			}
		%>
        <div id="preloader">
            <div id="status">&nbsp;</div>
        </div>
        <!-- Body content -->

       
        <div class="header-connect">
            <div class="container">
                <div class="row">
                    <div class="col-md-5 col-sm-8  col-xs-12">
                        <div class="header-half header-call">
                            <p>
                                <span><i class="pe-7s-call"></i> +62 87824622895</span>
                                <span><i class="pe-7s-mail"></i> tripadvisor@canmican.isa</span>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-2 col-md-offset-5  col-sm-3 col-sm-offset-1  col-xs-12">
                        <div class="header-half header-social">
                            <ul class="list-inline">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>            
        <!--End top header -->

        <nav class="navbar navbar-default ">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navigation">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
<%	  
                        		if(session.getAttribute("sEmail") != null)
                            	{
                        %>                              
                        	<a class="navbar-brand" href="index.jsp"><img src="Serve?blob-key=<%out.print(session.getAttribute("fotoUser"));%>" alt="" style="height:50px;height:50px;"></a>      	          	
                       <%		
                                }
                        		else
                                {
                       	%>
                                	
                    				<a class="navbar-brand" href="index.jsp"><img src="assets/img/monkaS.png" alt="" style="height:50px;height:50px;"></a>
                       	<%		
                                }
                                                   		
                        %>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse yamm" id="navigation">
                    <div class="button navbar-right">
                    	<%
                        	if(session.getAttribute("sName") == null)
                        	{
                        		out.print("<input type='hidden' id='sessUser' value='null'>");
                        %>
                        		<a href="register.jsp"><button class="navbar-btn nav-button wow bounceInRight login" data-wow-delay="0.4s">Login</button></a>		
                        <%
                        	}
                        	else
                        	{
                        		out.print("<input type='hidden' id='sessUser' value='"+session.getAttribute("sEmail")+"'>");
                        %>
                        		<a href="register.jsp?LogOut"><button type="submit" class="navbar-btn nav-button wow bounceInRight login" name="btnLogout" data-wow-delay="0.4s">Hi, <% out.print(session.getAttribute("sName").toString()); %> , Log Out</button></a>
                        <%	
                        	}   
                        	//Button Profile & Submit
                        	if(session.getAttribute("sEmail") != null)
                        	{
                        		if(session.getAttribute("sEmail").toString().equalsIgnoreCase("rio"))
                            	{
                        %>                              
                        			<a href="submit-property.jsp"><button class="navbar-btn nav-button wow fadeInRight" data-wow-delay="0.5s">Submit</button></a>       
                        			<a href="submit-foto.jsp"><button class="navbar-btn nav-button wow fadeInRight" data-wow-delay="0.5s">Submit Foto</button></a>  	          	
                        <%		
                                }
                        		else
                                {
                       	%>
                                	<a href="profile.jsp"><button class="navbar-btn nav-button wow fadeInRight" data-wow-delay="0.5s">Profile</button></a> 
                       	<%		
                                }
                            }                        		
                        %>
                    </div>
                    <ul class="main-nav nav navbar-nav navbar-right">
                        <li class="wow fadeInDown" data-wow-delay="0.1s"><a class="" href="index.jsp">Restaurant</a></li>
                        <li class="wow fadeInDown" data-wow-delay="0.1s"><a class="" href="index-6.jsp">Tourism Place</a></li>
                        <li class="wow fadeInDown" data-wow-delay="0.4s"><a href="contact.jsp">Contact</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
        <!-- End of nav bar -->

        <div class="page-head"> 
            <div class="container">
                <div class="row">
                    <div class="page-head-content">
                        <h1 class="page-title">Profile </h1>               
                    </div>
                </div>
            </div>
        </div>
        <!-- End page header -->
 

        <!-- register-area -->
        <div class="register-area" style="background-color: rgb(249, 249, 249);">
            <div class="container">

                <div class="col-md-6">
                    <div class="box-for overflow">
                        <div class="col-md-12 col-xs-12 register-blocks">
                            <h2>Change Profile : </h2> 
                            <form action="#" method="post">
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <%
                                    	if(session.getAttribute("sName") != null)
                                    	{                                    		
                                    %>
                                    		<input type="text" class="form-control" id="name" name="nameProfile" value="<% out.print(session.getAttribute("sName").toString()); %>"> 	
                                    <%	
                                    	}
                                    	else
                                    	{
                                    %>
                                    		<input type="text" class="form-control" id="name" name="nameProfile">
                                    <% 		
                                    	}
                                    %>                                    
                                </div>
                                <div class="form-group">
                                	<label for="email">Email</label>
                                	<%
                                    	if(session.getAttribute("sEmail") != null)
                                    	{
                                    %>
                                    		<input type="text" class="form-control" id="email" name="emailProfile" disabled value="<% out.print(session.getAttribute("sEmail").toString()); %>"> 	
                                    <%	
                                    	}
                                    	else
                                    	{
                                    %>
                                    		<input type="text" class="form-control" id="email" name="emailProfile" disabled>
                                    <% 		
                                    	}
                                    %>                                   
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>                                   
                                    <input type="password" class="form-control" id="password" name="passwordProfile" required>                            
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">Confirm Password</label>                                   
                                    <input type="password" class="form-control" id="confirmPassword" name="ConfirmPasswordProfile" required>                            
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-default" name="btnChange">Change</button>
                                </div>
                            </form>
                            
                            
                            <form action="<%= blobstoreService.createUploadUrl("/Upload") %>" method="post" enctype="multipart/form-data">
                            
                            <input type="hidden" id="idTarget" name="idTarget" value=<%out.print(session.getAttribute("sEmail").toString()); %>>
                            	 <input type="text" name="foo">
           					 <input type="file" name="myFile">
           					 	<input type="hidden" name="action" value="upload">
		         
                            	<input type="submit" value="Submit" name="submit"/>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="box-for overflow">                         
                        <div class="col-md-12 col-xs-12 login-blocks"> 
                        <h2>Wishlist : </h2></br>
                        <label for="restaurant">Restaurant</label></br>
                     	<%
                     		//mengambil idResto dari table TableWishlistResto
                     		//nilai kembalian berupa array yang berisi idResto
	                     	Query<Entity> query2 =	Query.newEntityQueryBuilder().setKind("TableWishlistResto").setFilter(PropertyFilter.eq("user", session.getAttribute("sEmail").toString())).build();
                       		QueryResults<com.google.cloud.datastore.Entity> results2 = datastore.run(query2);                     	
                     		ArrayList<String> idResto = new ArrayList<String>();
                     		ArrayList<String> autoID = new ArrayList<String>();
                     		ArrayList<String> status = new ArrayList<String>();
                     		while(results2.hasNext())
                     		{
                     			Entity wishlist = results2.next();
                     			idResto.add(wishlist.getString("idResto")); //menampung isi idResto
                     			autoID.add(wishlist.getKey().getId().toString()); //menampung key dari datastore
                     			status.add(wishlist.getString("status")); //menampung status wishlist (1=aktif 0=tidak aktif)
                     		}
                     		
                     		//mengambil nama resto dari table Resto menggunakan ArrayList id resto
                     		Query<Entity> query3 =	Query.newEntityQueryBuilder().setKind("TableResto").build();
                     		QueryResults<com.google.cloud.datastore.Entity> results3 = datastore.run(query3); 
                     		int ctr = 1;
                     		while(results3.hasNext())
                     		{
                     			Entity entityResto = results3.next();
                     			String id = entityResto.getString("idResto");
                     			boolean match = false;
                     			int indeks = 0; //indeks digunakan untuk mendapatkan key dari datastore tableWishlistResto
                     			
                     			for(int i=0;i<idResto.size();i++)
                     			{
                     				if(id.equals(idResto.get(i)))
                     				{
                     					indeks = i;
                     					match = true;
                     				}
                     			}
                     			if(match == true)
                     			{
                     				//menampilkan nama resto
                     				if(status.get(indeks).equals("1"))
                     				{

                         				String link = "resto.jsp?ID="+id;
                         				out.println(ctr+". <a href='"+link+"'>"+entityResto.getString("nama")+"</a>&nbsp&nbsp&nbsp");
                         				int co = indeks;
                         				out.println("<img src='assets/img/icon/delete2.png' class='removeWishlist' id='"+co+"' width='7' height='7'>");
                         				out.println("<input type='hidden' id='status"+indeks+"' value='"+status.get(indeks)+"'>");
                         				out.println("<input type='hidden' id='id"+indeks+"' value='"+autoID.get(indeks)+"'>");
                         				out.println("<input type='hidden' id='idResto"+indeks+"' value='"+idResto.get(indeks)+"'>");
                         				out.println("</br>");
                         				ctr++;
                     				}
                     			}
                     		}
                     	%>
                        
                        </br>
                        <label for="tplace">Tourism Place</label></br>    
                        <%
                     		//mengambil idPlace dari table TableWishlistPlace
                     		//nilai kembalian berupa array yang berisi idPlace
	                     	query2 =	Query.newEntityQueryBuilder().setKind("TableWishlistPlace").setFilter(PropertyFilter.eq("user", session.getAttribute("sEmail").toString())).build();
                       		results2 = datastore.run(query2);                     	
                     		ArrayList<String> idPlace = new ArrayList<String>();
                     		autoID = new ArrayList<String>();
                     		status = new ArrayList<String>();
                     		while(results2.hasNext())
                     		{
                     			Entity wishlist = results2.next();
                     			idPlace.add(wishlist.getString("idPlace")); //menampung isi idResto
                     			autoID.add(wishlist.getKey().getId().toString()); //menampung key dari datastore
                     			status.add(wishlist.getString("status")); //menampung status wishlist (1=aktif 0=tidak aktif)
                     		}
                     		
                     		//mengambil nama place dari table Place menggunakan ArrayList id place
                     		query3 =	Query.newEntityQueryBuilder().setKind("TablePlace").build();
                     		results3 = datastore.run(query3); 
                     		ctr = 1;
                     		while(results3.hasNext())
                     		{
                     			Entity entityPlace = results3.next();
                     			String id = entityPlace.getString("idPlace");
                     			boolean match = false;
                     			int indeks = 0; //indeks digunakan untuk mendapatkan key dari datastore tableWishlistPlace
                     			
                     			for(int i=0;i<idPlace.size();i++)
                     			{
                     				if(id.equals(idPlace.get(i)))
                     				{
                     					indeks = i;
                     					match = true;
                     				}
                     			}
                     			if(match == true)
                     			{
                     				//menampilkan nama place
                     				if(status.get(indeks).equals("1"))
                     				{

                         				String link = "place.jsp?ID="+id;
                         				out.println(ctr+". <a href='"+link+"'>"+entityPlace.getString("nama")+"</a>&nbsp&nbsp&nbsp");
                         				int co = indeks;
                         				out.println("<img src='assets/img/icon/delete2.png' class='removeWishlistPlace' id='"+co+"' width='7' height='7'>");
                         				out.println("<input type='hidden' id='status"+indeks+"' value='"+status.get(indeks)+"'>");
                         				out.println("<input type='hidden' id='id"+indeks+"' value='"+autoID.get(indeks)+"'>");
                         				out.println("<input type='hidden' id='idPlace"+indeks+"' value='"+idPlace.get(indeks)+"'>");
                         				out.println("</br>");
                         				ctr++;
                     				}
                     			}
                     		}
                     	%>   
                        </div>                        
                    </div>
                </div>
            </div>
        </div>      

        <!-- Footer area-->
        <div class="footer-area">
            <div class="footer-copy text-center">
                <div class="container">
                    <div class="row">
                        <div class="pull-left">
                            <span> (C) <a href="http://www.KimaroTec.com">KimaroTheme</a> , All rights reserved 2016  </span> 
                        </div> 
                        <div class="bottom-menu pull-right">                             
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="assets/js/modernizr-2.6.2.min.js"></script>
        <script src="assets/js/jquery-1.10.2.min.js"></script> 
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/js/bootstrap-select.min.js"></script>
        <script src="assets/js/bootstrap-hover-dropdown.js"></script>
        <script src="assets/js/easypiechart.min.js"></script>
        <script src="assets/js/jquery.easypiechart.min.js"></script>
        <script src="assets/js/owl.carousel.min.js"></script>
        <script src="assets/js/wow.js"></script>
        <script src="assets/js/icheck.min.js"></script>
        <script src="assets/js/price-range.js"></script>
        <script src="assets/js/main.js"></script>		
        <script>
           $(document).ready(function () {
                $(".removeWishlist").click(function()
       			{
                	var indeks = $(this).attr("id");
                	var status = $("#status"+indeks).val();
                	var id = $("#id"+indeks).val();
                	//alert(id);
                	var idResto = $("#idResto"+indeks).val();
                	var sessUser = $("#sessUser").val();
                	//alert(idResto);
                	$.ajax({
           				url: "/Wishlist",
           				method: "post",
           				data: {"id":id,"user":sessUser,"action":"update","status":status,"idResto":idResto}
           			 }).done(function(result){
           				 alert("Success!");
           				 location.reload();
           			 }).error(function(xhr, ajaxOptions, thrownError){
           				alert(thrownError);
           			 });
        		
       			});
                $(".removeWishlistPlace").click(function()
               			{
                        	var indeks = $(this).attr("id");
                        	var status = $("#status"+indeks).val();
                        	var id = $("#id"+indeks).val();
                        	//alert(id);
                        	var idPlace = $("#idPlace"+indeks).val();
                        	var sessUser = $("#sessUser").val();
                        	//alert(idResto);
                        	$.ajax({
                   				url: "/WishlistPlace",
                   				method: "post",
                   				data: {"id":id,"user":sessUser,"action":"update","status":status,"idPlace":idPlace}
                   			 }).done(function(result){
                   				 alert("Success!");
                   				 location.reload();
                   			 }).error(function(xhr, ajaxOptions, thrownError){
                   				alert(thrownError);
                   			 });
                		
               			});
            });
        </script>
    </body>
</html>