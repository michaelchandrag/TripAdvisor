<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> 
<%@page import="java.io.StringWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.cloud.datastore.QueryResults"%>
<%@page import="com.google.cloud.bigquery.QueryResult"%>
<%@page import="com.google.cloud.datastore.Key"%>
<%@page import="com.google.cloud.datastore.KeyFactory"%>
<%@page import="com.google.cloud.datastore.StructuredQuery.PropertyFilter"%>
<%@page import="com.google.cloud.datastore.Entity"%>
<%@page import="com.google.cloud.datastore.Query"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.google.auth.oauth2.ServiceAccountCredentials"%>
<%@page import="com.google.cloud.datastore.DatastoreOptions"%>
<%@page import="com.google.cloud.datastore.Datastore"%>
<html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>GARO ESTATE | Submit property Page</title>
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
        <link href="css/animate.css" rel="stylesheet" media="screen">
        <link rel="stylesheet" href="assets/css/bootstrap-select.min.css"> 
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/icheck.min_all.css">
        <link rel="stylesheet" href="assets/css/price-range.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.css">  
        <link rel="stylesheet" href="assets/css/owl.theme.css">
        <link rel="stylesheet" href="assets/css/owl.transitions.css"> 
        <!-- <link rel="stylesheet" href="assets/css/wizard.css"> -->
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
    </head>
    <body>
		<%
		Datastore datastore;
		
		datastore = DatastoreOptions.newBuilder().setProjectId("inlaid-agility-170309").
				setCredentials(ServiceAccountCredentials.fromStream(new FileInputStream("My Project-b3225e5a13dd.json"))).build().getService();
		session.setAttribute("alertSubmit", "");
		if (request.getParameter("btnSubmitRestaurant") != null) {
			String nameRestaurant = request.getParameter("nameRestaurant");
			String addressRestaurant = request.getParameter("addressRestaurant");
			String phoneRestaurant = request.getParameter("phoneRestaurant");
			String openHoursRestaurant = request.getParameter("openHoursRestaurant");
			String closeHoursRestaurant = request.getParameter("closeHoursRestaurant");
			String locationRestaurant = request.getParameter("locationRestaurant");
			String facilityRestaurant = request.getParameter("facilityRestaurant");
			String typeRestaurant = request.getParameter("typeRestaurant");
			String capacityRestaurant = request.getParameter("capacityRestaurant");
			String descriptionRestaurant = request.getParameter("descriptionRestaurant");
			String parkingRestaurant = request.getParameter("parkingRestaurant");
			//String ratingRestaurant = request.getParameter("ratingRestaurant");
			//String reviewRestaurant = request.getParameter("reviewRestaurant");
						
			int idKeBerapa = 0;
			Query<Entity> query1 =
				    Query.newEntityQueryBuilder().setKind("TableResto")
				    .setFilter(PropertyFilter.eq("nama", nameRestaurant))
				    .setFilter(PropertyFilter.eq("alamat", addressRestaurant))
				    .build();
			QueryResults<Entity> results1 = datastore.run(query1);
			String returnValue = "",returnEmail = "";
			if (results1.hasNext()) {
				//Restaurant Sudah Terdaftar
				session.setAttribute("alertSubmit", "Restaurant Already Listed!");
			}			
			else
			{
				//Restaurant Belum Terdaftar
				//Hitung Dulu Sudah Sampai ID ke Berapa
				Query<Entity> query2 =
					    Query.newEntityQueryBuilder().setKind("TableResto").build();
				QueryResults<Entity> results2 = datastore.run(query2);
				if (results2.hasNext()) {
					while (results2.hasNext()) {
						Entity entity = results2.next();
						idKeBerapa++;						
					}
					idKeBerapa++;
				}			
				else
				{
					idKeBerapa = 1;
				}	
				
				//Sudah Dapat ID Resto Baru, Lakukan Insert ke Table Resto				
				KeyFactory kf = datastore.newKeyFactory().setKind("TableResto");
				Key barangKey = datastore.allocateId(kf.newKey());
				Entity user = Entity.newBuilder(barangKey)
						.set("nama", nameRestaurant)
					    .set("alamat", addressRestaurant)
					    .set("telp",phoneRestaurant)
					    .set("jam",openHoursRestaurant+" - "+closeHoursRestaurant)
					    .set("lokasi",locationRestaurant)
					    .set("fasilitas",facilityRestaurant)
					    .set("jenis",typeRestaurant)
					    .set("kapasitas",capacityRestaurant)
					    .set("desc",descriptionRestaurant)
					    .set("parkir",parkingRestaurant)
					    .set("rating",Integer.parseInt("0"))
					    .set("reviews",Integer.parseInt("0"))
					    .set("idResto","R"+idKeBerapa)
					    .set("foto","AMIfv977Wjn6bHQnQ2c2911InTKw5grbauQoTXkXeZKxhmVjjxM2wyvrc06wzy6oOWaqSIOOVF7D")
					    .build();
				datastore.put(user);
				session.setAttribute("alertSubmit", "Submit New Restaurant Done!");
			}        
		}
		
		if (request.getParameter("btnSubmitTourism") != null) {
			String nameTourism = request.getParameter("nameTourism");
			String addressTourism = request.getParameter("addressTourism");
			String phoneTourism = request.getParameter("phoneTourism");
			String openHoursTourism = request.getParameter("openHoursTourism");
			String closeHoursTourism = request.getParameter("closeHoursTourism");
			String locationTourism = request.getParameter("locationTourism");
			String facilityTourism = request.getParameter("facilityTourism");
			String typeTourism = request.getParameter("typeTourism");
			String descriptionTourism = request.getParameter("descriptionTourism");
			//String ratingTourism = request.getParameter("ratingTourism");
			//String reviewTourism = request.getParameter("reviewTourism");
			
			int idKeBerapa = 0;
			Query<Entity> query1 =
				    Query.newEntityQueryBuilder().setKind("TablePlace")
				    .setFilter(PropertyFilter.eq("nama", nameTourism))
				    .setFilter(PropertyFilter.eq("alamat", addressTourism))
				    .build();
			QueryResults<Entity> results1 = datastore.run(query1);
			String returnValue = "",returnEmail = "";
			if (results1.hasNext()) {
				//Tourism Place Sudah Terdaftar
				session.setAttribute("alertSubmit", "Tourism Place Already Listed!");
			}			
			else
			{
				//Tourism Place Belum Terdaftar
				//Hitung Dulu Sudah Sampai ID ke Berapa
				Query<Entity> query2 =
					    Query.newEntityQueryBuilder().setKind("TablePlace").build();
				QueryResults<Entity> results2 = datastore.run(query2);
				if (results2.hasNext()) {
					while (results2.hasNext()) {
						Entity entity = results2.next();
						idKeBerapa++;						
					}
					idKeBerapa++;
				}			
				else
				{
					idKeBerapa = 1;
				}				
				
				//Sudah Dapat ID Resto Baru, Lakukan Insert ke Table Resto				
				KeyFactory kf = datastore.newKeyFactory().setKind("TablePlace");
				Key barangKey = datastore.allocateId(kf.newKey());
				Entity user = Entity.newBuilder(barangKey)
						.set("nama", nameTourism)
					    .set("alamat", addressTourism)
					    .set("telp",phoneTourism)
					    .set("Jam",openHoursTourism+" - "+closeHoursTourism)
					    .set("lokasi",locationTourism)
					    .set("fasilitas",facilityTourism)
					    .set("jenis",typeTourism)
					    .set("desc",descriptionTourism)
					    .set("rating",Integer.parseInt("0"))
					    .set("review",Integer.parseInt("0"))
					    .set("idPlace","P"+idKeBerapa)
					    .set("foto","AMIfv977Wjn6bHQnQ2c2911InTKw5grbauQoTXkXeZKxhmVjjxM2wyvrc06wzy6oOWaqSIOOVF7D")
					    
					    .build();
				datastore.put(user);
				session.setAttribute("alertSubmit", "Submit New Tourism Place Done!");
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
                        <h1 class="page-title">Submit Page</h1>               
                    </div>
                </div>
            </div>
        </div>
        <!-- End page header -->

        <!-- property area -->
        <div class="content-area submit-property" style="background-color: #FCFCFC;">&nbsp;
            <div class="container">
                <div class="clearfix" > 
                    <div class="wizard-container">
                        <div class="wizard-card ct-wizard-orange" id="wizardProperty">
                            <form action="" method="">                        
                                <div class="wizard-header">
                                    <h3>
                                        <b>Submit</b> <br>
                                        <small>New Restaurant & New Tourism Place.</small>
                                    </h3>
                                </div>                                
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<!-- Resto & Tourism -area -->
        <div class="register-area" style="background-color: rgb(249, 249, 249);">
        	<div style="width: 50%;  margin-left: auto; margin-right: auto;" align="center">
            	<%
            		if(session.getAttribute("alertSubmit") != null)
            		{
            			out.print("<small>"+session.getAttribute("alertSubmit").toString()+"</small>");
            		}
            		else
            		{
            			out.print("<small></small>");
            		}
            	%>            	
            </div>
            <div class="container">				
                <div class="col-md-6">
                    <div class="box-for overflow">
                        <div class="col-md-12 col-xs-12 register-blocks">
                            <h2>Submit New Restaurant : </h2> 
                            <form action="#" method="post">
                                <div class="form-group">
                                    <label for="nameRestaurant">Restaurant Name</label>
                               		<input type="text" maxlength="18" required class="form-control" id="nameRestaurant" name="nameRestaurant">                               
                                </div>
                                <div class="form-group">
                                	<label for="addressRestaurant">Restaurant Address</label>
                               		<input type="text" maxlength="24" required class="form-control" id="addressRestaurant" name="addressRestaurant">                                
                                </div>
                                <div class="form-group">
                                    <label for="phoneRestaurant">Restaurant Phone</label>
                              		<input type="text" required onkeypress='return event.charCode >= 48 && event.charCode <= 57' class="form-control" id="phoneRestaurant" name="phoneRestaurant">                             
                                </div>
                                <div class="form-group">
                                    <label for="HoursRestaurant">Open Hours</label>
                              		<p>From</p>
                              		<input type="time" required class="form-control" id="openHoursRestaurant" name="openHoursRestaurant">
                              		<p> - </p>
                              		<p>Until</p>
                              		<input type="time" required class="form-control" id="closeHoursRestaurant" name="closeHoursRestaurant">                             
                                </div>
                                <div class="form-group">
                                    <label for="locationRestaurant">Restaurant Location</label>
                              		<input type="text" required class="form-control" id="locationRestaurant" name="locationRestaurant">                             
                                </div>
                                <div class="form-group">
                                    <label for="facilityRestaurant">Restaurant Facility</label>
                              		<textarea type="text" required class="form-control" id="facilityRestaurant" name="facilityRestaurant"></textarea>                             
                                </div>
                                <div class="form-group">
                                    <label for="typeRestaurant">Restaurant Type</label>
                              		<input type="text" required class="form-control" id="typeRestaurant" name="typeRestaurant">                             
                                </div>
                                <div class="form-group">
                                    <label for="capacityRestaurant">Restaurant Capacity</label>
                              		<input type="text" required class="form-control" id="capacityRestaurant" name="capacityRestaurant">                             
                                </div>
                                <div class="form-group">
                                    <label for="descriptionRestaurant">Restaurant Description</label>
                              		<textarea class="form-control" required id="descriptionRestaurant" name="descriptionRestaurant"></textarea>                             
                                </div>
                                <div class="form-group">
                                    <label for="parkingRestaurant">Restaurant Parking Area</label>
                              		<input type="text" required class="form-control" id="parkingRestaurant" name="parkingRestaurant">                            
                                </div>
                                <!-- <div class="form-group">
                                    <label for="ratingRestaurant">Restaurant Rating</label>
                              		<input type="number" required min="0" max="5" class="form-control" id="ratingRestaurant" name="ratingRestaurant">                             
                                </div>
                                <div class="form-group">
                                    <label for="reviewRestaurant">Restaurant Review</label>
                              		<input type="number" required min="0" class="form-control" id="reviewRestaurant" name="reviewRestaurant">                             
                                </div> -->
                                <div class="text-center">
                                    <button type="submit" class="btn btn-default" name="btnSubmitRestaurant">Submit Restaurant</button>
                                </div>
                            </form>                            
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="box-for overflow">                         
                        <div class="col-md-12 col-xs-12 login-blocks">  
                        	<h2>Submit New Tourism Place : </h2> 
                            <form action="#" method="post">
                                <div class="form-group">
                                    <label for="nameTourism">Tourism Place Name</label>
                               		<input type="text" maxlength="18" required class="form-control" id="nameTourism" name="nameTourism">                               
                                </div>
                                <div class="form-group">
                                	<label for="addressTourism">Tourism Place Address</label>
                               		<input type="text" maxlength="24" required class="form-control" id="addressTourism" name="addressTourism">                                
                                </div>
                                <div class="form-group">
                                    <label for="phoneTourism">Tourism Place Phone</label>
                              		<input type="text" required onkeypress='return event.charCode >= 48 && event.charCode <= 57' class="form-control" id="phoneTourism" name="phoneTourism">                             
                                </div>
                                <div class="form-group">
                                    <label for="HoursTourism">Open Hours</label>
                              		<p>From</p>
                              		<input type="time" required class="form-control" id="openHoursTourism" name="openHoursTourism">
                              		<p> - </p>
                              		<p>Until</p>
                              		<input type="time" required class="form-control" id="closeHoursTourism" name="closeHoursTourism">                             
                                </div>
                                <div class="form-group">
                                    <label for="locationTourism">Tourism Place Location</label>
                              		<input type="text" required class="form-control" id="locationTourism" name="locationTourism">                             
                                </div>
                                <div class="form-group">
                                    <label for="facilityTourism">Tourism Place Facility</label>
                              		<textarea type="text" required class="form-control" id="facilityTourism" name="facilityTourism"></textarea>                             
                                </div>
                                <div class="form-group">
                                    <label for="typeTourism">Tourism Place Type</label>
                              		<input type="text" required class="form-control" id="typeTourism" name="typeTourism">                             
                                </div>                                
                                <div class="form-group">
                                    <label for="descriptionTourism">Tourism Place Description</label>
                              		<textarea class="form-control" required id="descriptionTourism" name="descriptionTourism"></textarea>                             
                                </div>
                                <!-- <div class="form-group">
                                    <label for="ratingTourism">Tourism Place Rating</label>
                              		<input type="number" required min="0" max="5" class="form-control" id="ratingTourism" name="ratingTourism">                             
                                </div>
                                <div class="form-group">
                                    <label for="reviewTourism">Tourism Place Review</label>
                              		<input type="number" required min="0" class="form-control" id="reviewTourism" name="reviewTourism">                             
                                </div> -->
                                <div class="text-center">
                                    <button type="submit" class="btn btn-default" name="btnSubmitTourism">Submit Tourism Place</button>
                                </div>
                            </form>                          
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
    </body>
</html>