<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <%@page import="java.io.StringWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.cloud.datastore.QueryResults"%>
<%@page import="com.google.cloud.bigquery.QueryResult"%>
<%@page import="com.google.cloud.datastore.StructuredQuery.PropertyFilter"%>
<%@page import="com.google.cloud.datastore.Entity"%>
<%@page import="com.google.cloud.datastore.Query"%>
<%@page import="com.google.cloud.storage.Blob"%>
<%@page import="com.google.cloud.storage.BlobInfo"%>
<%@page import="com.google.cloud.storage.BlobId"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.google.auth.oauth2.ServiceAccountCredentials"%>
<%@page import="com.google.cloud.datastore.DatastoreOptions"%>
<%@page import="com.google.cloud.datastore.Datastore"%>
<%@page import="java.security.MessageDigest"%>
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
			
			if (request.getParameter("btnLogin") != null) {
				//btnLogin Ditekan
				String email = request.getParameter("emailLogin");
				String password = request.getParameter("passwordLogin");
				if(!email.equalsIgnoreCase("") && !password.equalsIgnoreCase(""))
				{
					//Email & Password Tidak Kosong
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
					Query<Entity> query1 =
						    Query.newEntityQueryBuilder().setKind("TableUser")
						    .setFilter(PropertyFilter.eq("email", email))
						    .setFilter(PropertyFilter.eq("password", hexString.toString()))
						    .build();
					QueryResults<Entity> results1 = datastore.run(query1);
					String returnValue = "",returnEmail = "",returnBlob = "";
					boolean	 emailsama = false;
					
					if (results1.hasNext()) {
						while (results1.hasNext() && emailsama == false) { 
				             Entity entity1 = results1.next(); 
				             returnValue = entity1.getString("name"); 
				             returnEmail = entity1.getString("email"); 
				             returnBlob = entity1.getString("foto"); 
				             if(returnEmail.equalsIgnoreCase(email)) 
				             { 
				              //email sama dengan yang dimasukkan 
				              emailsama = true; 
				             }  
				            } 
				            if(emailsama == true) 
				            {  
				             session.setAttribute("sName", returnValue); 
				             session.setAttribute("sEmail", returnEmail); 
				        		session.setAttribute("fotoUser", returnBlob);
				             session.removeAttribute("errorM"); 
				             response.sendRedirect("index.jsp"); 
				       }else
				       {
				    	      //Data di Database Tidak Ditemukan yang Cocok      
				    	      session.setAttribute("errorM", "Email / Password Salah");
				    	   }
					}			
					else
					{
						//Data di Database Tidak Ditemukan yang Cocok						
						session.setAttribute("errorM", "Email / Password Salah");
					}
				}
				else
				{
					//Email & Password Kosong
					session.setAttribute("errorM", "Mohon Melengkapi Data Terlebih Dahulu");					
				}				
			}
			
			if (request.getQueryString() != null && request.getQueryString().equalsIgnoreCase("LogOut")) {
				session.removeAttribute("sName");
				session.removeAttribute("sEmail");
				session.removeAttribute("sPassword");
				session.removeAttribute("sKey");
				session.removeAttribute("alertSubmit");
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
                    <a class="navbar-brand" href="index.jsp"><img src="assets/img/monkaS.png" alt="" style="height:50px;height:50px;"></a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse yamm" id="navigation">
                    <div class="button navbar-right">
                    	<%
                        	if(session.getAttribute("sName") == null)
                        	{
                        %>
                        		<a href="register.jsp"><button class="navbar-btn nav-button wow bounceInRight login" data-wow-delay="0.4s">Login</button></a>		
                        <%
                        	}
                        	else
                        	{
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
                        <h1 class="page-title">Register / Log In </h1>               
                    </div>
                </div>
            </div>
        </div>
        <!-- End page header -->
 
<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>
        <!-- register-area -->
        <div class="register-area" style="background-color: rgb(249, 249, 249);">
            <div class="container">

                <div class="col-md-6">
                    <div class="box-for overflow">
                        <div class="col-md-12 col-xs-12 register-blocks">
                            <h2>New account : </h2> 
                            <form action=""<%= blobstoreService.createUploadUrl("/Upload") %>" " method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" id="name">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="text" class="form-control" id="email">
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password">
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-default" onclick="insertClick()">Register</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="box-for overflow">                         
                        <div class="col-md-12 col-xs-12 login-blocks">
                            <h2>Login : </h2> 
                            <form action="register.jsp" method="post">
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="text" class="form-control" id="email" name="emailLogin">
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="passwordLogin">
                                </div>
                                <div class="text-center">
                                    <button type="submit" name="btnLogin" class="btn btn-default"> Log in</button>
                                </div>
                                <div class="form-group">
                                	<%
			                        	if(session.getAttribute("errorM") != null)
			                        	{
			                        %>
                                    		<label for="errorLogin">* <% out.print(session.getAttribute("errorM").toString()); %> </label>
                                    <%
			                        	}
			                        	else
			                        	{
			                        %>
			                        		<label for="errorLogin"> </label>
			                        <%	
			                        	}
			                        %>                                    
                                </div>
                            </form>
                            <br>                             
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
		$nama = "";
		$harga = "";
		$qty = "";
		function insertClick(){
			var name = $("input#name").val();
			var email = $("input#email").val();
			var password = $("input#password").val();
			$.ajax({
				url: "/database",
				method: "post",
				data: {"action":"insert", "name":name, "email": email, "password":password}
			 }).done(function(result){
				 //alert("Berhasil");
				 //alert(result);
			 }).error(function(xhr, ajaxOptions, thrownError){
				//alert(thrownError);
			 });
			 
		}
		</script>
    </body>
</html>