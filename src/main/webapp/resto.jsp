<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.cloud.datastore.QueryResults"%>
<%@page import="com.google.cloud.bigquery.QueryResult"%>
<%@page import="com.google.cloud.datastore.StructuredQuery.PropertyFilter"%>
<%@page import="com.google.cloud.datastore.*"%>
<%@page import="com.google.cloud.datastore.Query"%>
<%@page import="com.google.cloud.datastore.StructuredQuery.OrderBy"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.Math.*"%>
<%@page import="com.google.auth.oauth2.ServiceAccountCredentials"%>
<%@page import="com.google.cloud.datastore.DatastoreOptions"%>
<%@page import="com.google.cloud.datastore.Datastore"%>
<%@page import="com.google.cloud.datastore.Key"%> 
<%@page import="com.google.cloud.datastore.KeyFactory"%>


<%@page import="edu.stts.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>GARO ESTATE | Property  page</title>
        <meta name="description" content="company is a real-estate template">
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
        <link rel="stylesheet" href="assets/css/lightslider.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
    </head>
    <body>

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
                        <li class="wow fadeInDown" data-wow-delay="0.4s"><a href="contact.html">Contact</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
        <!-- End of nav bar -->
        
        

        <div class="page-head"> 
            <div class="container">
                <div class="row">
                    <div class="page-head-content">
                    <%
		                	Datastore datastore;
                			
                    		//untuk resto
                			String kode = request.getParameter("ID");
                			
		        			datastore = DatastoreOptions.newBuilder().setProjectId("inlaid-agility-170309").setCredentials(ServiceAccountCredentials.fromStream(new FileInputStream("My Project-b3225e5a13dd.json"))).build().getService();
						 KeyFactory keys = datastore.newKeyFactory().setKind("TableResto");
						 Key kodeResto = keys.newKey(kode);
						 
						 Query<com.google.cloud.datastore.Entity> query = Query.newEntityQueryBuilder().setKind("TableResto").setFilter(PropertyFilter.eq("idResto",kode)).build();
						
						
						 QueryResults<com.google.cloud.datastore.Entity> results = datastore.run(query);

						 
					 	//untuk wishlist
						String sessUser = "";
					 	if(session.getAttribute("sEmail") != null)
					 	{
					 		sessUser = session.getAttribute("sEmail").toString();
					 		KeyFactory keysWish = datastore.newKeyFactory().setKind("TableWishlistResto");
							Query<com.google.cloud.datastore.Entity> query2 = Query.newEntityQueryBuilder()
																			.setKind("TableWishlistResto")
																			.setFilter(PropertyFilter.eq("user",sessUser))
																			.setFilter(PropertyFilter.eq("idResto",kode))
																			.build();
																			
							QueryResults<com.google.cloud.datastore.Entity> results2 = datastore.run(query2);
							if(results2.hasNext())
							{
								//sudah ada di database wishlist
								//System.out.println("ada di database");
								Entity entity = results2.next();
								String status = entity.getString("status");
								String idResto = entity.getString("idResto");
								String key = entity.getKey().getId().toString();
								if(status.equals("0"))
								{
									out.print("<input type='hidden' id='hiddenStatus' value='"+status+"'>");
									out.print("<input type='hidden' id='hiddenIdResto' value='"+idResto+"'>");
									out.print("<input type='hidden' id='hiddenKey' value='"+key+"'>");
									out.print("<input type='hidden' id='hiddenWishlist' value='update'>");
								}
								else
								{
									out.print("<input type='hidden' id='hiddenWishlist' value='true'>");	
								}
								
							}
							else
							{
								//belum ada di database wishlist
								//System.out.println("tidak ada di database");
								out.print("<input type='hidden' id='hiddenWishlist' value='false'>");
							}
					 	}
						
					    Entity entity = results.next();
					    out.print("<input type='hidden' id='hiddenID' value='"+kode+"'>");

					%>
					
					    <h1 class='page-title'>Restaurant</h1>
				                                      
                    </div>
                </div>
            </div>
        </div>
        <!-- End page header -->

        <!-- property area -->
        <div class="content-area single-property" style="background-color: #FCFCFC;">&nbsp;
            <div class="container">   

                <div class="clearfix padding-top-40" >

                    <div class="col-md-8 single-property-content prp-style-1 ">
                        <div class="row">
                            <div class="light-slide-item">            
                                <div class="clearfix">
                                    <div class="favorite-and-print">
                                        <a id="btnWishlist" class="add-to-fav" href="" data-toggle="modal">
                                            <i class="fa fa-star-o"></i>
                                        </a>
                                        <a class="printer-icon " href="javascript:window.print()">
                                            <i class="fa fa-print"></i> 
                                        </a>
                                    </div> 

                                    <ul id="image-gallery" class="gallery list-unstyled cS-hidden">
                                        <li data-thumb="assets/img/property-1/property1.jpg"> 
                                            <img src="Serve?blob-key=<%out.print(entity.getString("foto").toString());%>" style="height720px;height:450px;" />
                                            
                                        </li>                                       
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="single-property-wrapper">
                            <div class="single-property-header">                                          
                                <h1 class="property-title pull-left"> <%out.println(entity.getString("nama").toString());%></h1>
                               
                            </div>

                           
                            <div class="section">
                                <h4 class="s-property-title">Description</h4>
                                <div class="s-property-content">
                                    <p>  <%out.println(entity.getString("desc").toString());%>  </p>
                                </div>
                            </div>
                            <!-- End description area  -->

                            <div class="section additional-details">

                                <h4 class="s-property-title">Details</h4>

                                <ul class="additional-details-list clearfix">
                                    <li>
                                        <span class="col-xs-6 col-sm-4 col-md-4 add-d-title">Area Parkir</span>
                                        <span class="col-xs-6 col-sm-8 col-md-8 add-d-entry"><%out.println(entity.getString("parkir").toString());%></span>
                                    </li>

                                    <li>
                                        <span class="col-xs-6 col-sm-4 col-md-4 add-d-title">Kapasitas</span>
                                        <span class="col-xs-6 col-sm-8 col-md-8 add-d-entry"><%out.println(entity.getString("kapasitas").toString());%></span>
                                    </li>
                                    <li>
                                        <span class="col-xs-6 col-sm-4 col-md-4 add-d-title">Fasilitas Tambahan</span>
                                        <span class="col-xs-6 col-sm-8 col-md-8 add-d-entry"><%out.println(entity.getString("fasilitas").toString());%></span>
                                    </li>
                                </ul>
                            </div>  
                            <!-- End additional-details area  -->           
                            
                            <!-- comment -->  
                            <div class="section property-comment"> 
                                <h4 class="s-property-title">Reviews</h4> 
                                
                                
                                <%
                                
                                //review
		    		        			Query<com.google.cloud.datastore.Entity> queryRev = Query.newEntityQueryBuilder().setKind("TableReview").setFilter(PropertyFilter.eq("idTarget",kode)).build();
		    						QueryResults<com.google.cloud.datastore.Entity> reviews = datastore.run(queryRev);
								int ctr = 0;
								float tot = 0;
		    					    if(!reviews.hasNext()){
		    					    	
		    						} else{

		    							while (reviews.hasNext()) {
		    					        Entity entityRev = reviews.next();
		    					        ctr++;
		    					        
		    					      //ambil data user
		    					      
		                               Query<Entity> qUser =
									    Query.newEntityQueryBuilder().setKind("TableUser")
									    .setFilter(PropertyFilter.eq("email", entityRev.getString("namaUser").toString()))
									    .build();
										QueryResults<Entity> resultUser = datastore.run(qUser);
										String returnBlob = "",returnUser="";
										
										if (resultUser.hasNext()) { 
									             Entity entity1 = resultUser.next();  
									             returnBlob = entity1.getString("foto");  
									             returnUser = entity1.getString("name");   
										} 
										
		    					        %>
		    					        <div class="col-md-12 p0">
			                        <aside class="sidebar sidebar-property blog-asside-right">
			                            <div class="dealer-widget">
			                                <div class="dealer-content">
			                                    <div class="inner-wrapper">
			
			                                        <div class="clear">
			                                            <div class="col-xs-4 col-sm-4 dealer-face">
			                                                <a href="">
   																<img src="Serve?blob-key=<%out.print(returnBlob.toString());%>" class="img-circle" style="height:150px;height:150px;">
			                                                </a>
			                                            </div>
			                                            <div class="col-xs-8 col-sm-8 ">
			                                                <h3 class="dealer-name">
			                                                    <a href=""><%out.println(returnUser.toString());%></a>       
			                                                </h3>    
			                                                <li><i class="pe-7s-map-marker strong"> </i> Lokasi</li>
			                                                <li> Rating yang Diberikan :  <%out.println(entityRev.getString("rating").toString());%></li>
			                                                <%
			                                                tot = tot + Float.parseFloat(entityRev.getString("rating"));
			                                                %>
			                                            </div>
			                                        </div>
			
			                                        <div class="clear">
			                                            <ul class="dealer-contacts">    
			                                            <p><%out.println(entityRev.getString("isiReview").toString());%></p>                                  
			                                            </ul>
			                                        </div>
			
			                                    </div>
			                                </div>
			                            </div>
			                        </aside>
			                    </div>
		    					        
		    					        <%
		    						}
		    						}
                                %>
								
                                
                                <%
		                        	if(session.getAttribute("sName") != null)
		                        	{
		                        %>
		                        		<div class="col-md-12 col-xs-12 login-blocks">
		                            <h2 div="namaAkun"><%out.println(session.getAttribute("sName").toString());%>'s Review</h2> 
		                            <form action="" method="post">
		                                <div class="form-group">
		                                    <label for="komentar">Your Review</label>
		                                    
		                                <div class="form-group">
		                                    <label for="name">Komentar</label>
		                                    <input type="textarea" name="isiReview" rows="4" cols="50" class="form-control" id="isiReview">
		                                    
		                                </div>
		                                <div class="form-group">
		                                    <label for="email">Rating (0-5)</label>
		                                    <input type="textarea" name="ratingReview" rows="4" cols="50" class="form-control" id="ratingReview">
		                                   
		                                </div>
		                                    <input type="hidden" name="namaUsr"  value=<%out.println(session.getAttribute("sEmail").toString());%> id="namaUsr">
		                                		<input type="hidden" name="idTarget"  value=<%out.println(kode.toString());%> id="idTarget">
		                                		
		                               	</div>
		                                <div class="text-center">
		                                    <button type="submit" class="btn btn-default" onclick="insertClick()">Post</button>
		                                </div>
		                            </form>
		                            <br>		                            
		                        </div>	
		                        <%
		                        	}
		                        %>
                        
                            </div> 
                            <!--  end comment-->        
                        </div>
                    </div>


                    <div class="col-md-4 p0">
                    <div class="panel panel-default sidebar-menu similar-property-wdg wow fadeInRight animated">
	
                        <aside class="sidebar sidebar-property blog-asside-right">
                            <div class="dealer-widget">
                                <div class="dealer-content">
                                    <div class="inner-wrapper">

                                        <div class="clear">
                                            <div class="col-xs-4 col-sm-4 dealer-face">
                                                <a href="">
                                                    <img src="assets/img/client-face1.png" class="img-circle">
                                                </a>
                                            </div>
                                            <div class="col-xs-8 col-sm-8 ">
                                                <h3 class="dealer-name">
                                                    <a ><%out.println(entity.getString("nama").toString());%></a> <br>
                                                    <span><%out.println(entity.getString("jenis").toString());%></span>   <br>
                                                    <span> Rating : <%out.println(tot/ctr);%></span> <br>
                                                    <span> Jumlah Review : <%out.println(ctr);%></span>  
                                                </h3>
                                                <div class="dealer-social-media">
                                                    <a class="twitter" target="_blank" href="">
                                                        <i class="fa fa-twitter"></i>
                                                    </a>
                                                    <a class="facebook" target="_blank" href="">
                                                        <i class="fa fa-facebook"></i>
                                                    </a>
                                                    <a class="gplus" target="_blank" href="">
                                                        <i class="fa fa-google-plus"></i>
                                                    </a>
                                                    <a class="linkedin" target="_blank" href="">
                                                        <i class="fa fa-linkedin"></i>
                                                    </a> 
                                                    <a class="instagram" target="_blank" href="">
                                                        <i class="fa fa-instagram"></i>
                                                    </a>       
                                                </div>

                                            </div>
                                        </div>

                                        <div class="clear">
                                            <ul class="dealer-contacts">                                       
                                                <li><i class="pe-7s-map-marker strong"> </i> <%out.println(entity.getString("alamat").toString());%></li>
                                                <li><i class="pe-7s-mail strong"> </i> <%out.println(entity.getString("telp").toString());%></li>
                                                <li><i class="pe-7s-call strong"> </i><%out.println(entity.getString("jam").toString());%></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </aside>
                        
                        <div class="panel-heading">
		<h3 class="panel-title">Suggestion</h3>
	</div>
	<div class="panel-body recent-property-widget">
		<ul>
			<li>
				
				<%
				Query<Entity> query1 =
						Query.newEntityQueryBuilder().setKind("TableResto")		
						.build();
				QueryResults<Entity> results1 = datastore.run(query1);
				String returnPassword = "",returnValue = "";
				int banyakDataResto = 0;
				ArrayList<String> idResto = new ArrayList<String>();
				ArrayList<String> namaResto = new ArrayList<String>();
				ArrayList<String> alamatResto = new ArrayList<String>();
				//ArrayList<String> gambarResto = new ArrayList<String>();
				if (results1.hasNext()) {
					//Jika Ada Data
					while(results1.hasNext())
					{
						//Mengisi ArrayList id, nama, alamat, gbr, dan menghitung banyak data
						Entity entity1 = results1.next();
						if(!request.getParameter("ID").equalsIgnoreCase(entity1.getString("idResto")))
						{
							//Jika Id Tidak Sama dengan Id Sekarang Maka Masuk List
							idResto.add(entity1.getString("idResto"));
							namaResto.add(entity1.getString("nama"));
							alamatResto.add(entity1.getString("alamat"));
							//gambarResto.add(entity1.getString("idResto"));
							banyakDataResto++;
						}					
					}	
				}

				int randomMuncul = 0;
				boolean kembar = true;
				ArrayList<Integer> randomResto = new ArrayList<Integer>();
				if(banyakDataResto > 0)
				{
					//Berarti ada Data yang harus ditampilkan sebagai suggestion
					if(banyakDataResto > 3)
					{
						//Data lebih dari 3 (lebih dari cukup, maka lakukan random data yang keluar)
						for(int i=0;i<3;i++)
						{
							kembar = true;
							while(kembar == true)
							{
								randomMuncul = (int) Math.floor(Math.random() * banyakDataResto);     // returns a number between 0 and X
								if(!randomResto.contains(randomMuncul))
								{
									//Tidak Ada yang Kembar
									kembar = false;
								}
							}
							randomResto.add(randomMuncul);
						}
						
						//Sudah dapat 3 radom-an, sekarang tampilkan
						for(int i = 0 ; i < 3 ; i++)
						{
							String link = "resto.jsp?ID="+idResto.get(randomResto.get(i));
							//Cetak Gambar Nya
							//out.println("<div class='col-md-3 col-sm-3 col-xs-3 blg-thumb p0'><a href='single.html'><img src='assets/img/demo/small-property-2.jpg'></a></div>");
							
							//Cetak Data Nya
							out.println("<div class='col-md-8 col-sm-8 col-xs-8 blg-entry'><h6> <a href='"+link+"'>"+namaResto.get(randomResto.get(i))+"</a></h6><span class='property-price'>"+alamatResto.get(randomResto.get(i))+"</span></div>");
						}	
					}
					else
					{
						//Data kurang dari sama dengan 3, maka tampilkan semua saja
						for(int i = 0 ; i < 3 ; i++)
						{
							String link = "resto.jsp?ID="+idResto.get(i);
							//Cetak Gambar Nya
							//out.println("<div class='col-md-3 col-sm-3 col-xs-3 blg-thumb p0'><a href='single.html'><img src='assets/img/demo/small-property-2.jpg'></a></div>");
							
							//Cetak Data Nya
							out.println("<div class='col-md-8 col-sm-8 col-xs-8 blg-entry'><h6> <a href='"+link+"'>"+namaResto.get(i)+"</a></h6><span class='property-price'>"+alamatResto.get(i)+"</span></div>");
						}
					}
				}
				%>	
			</li>
		</ul>
	</div>
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
        
        <script src="assets/js/vendor/modernizr-2.6.2.min.js"></script>
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
        <script type="text/javascript" src="assets/js/lightslider.min.js"></script>
        <script src="assets/js/main.js"></script>
		<script>
		$idTarget = "";
		$isiReview = "";
		$namaUsr = "";
		$ratingReview = "";
		function insertClick(){
			var idTarget = $("input#idTarget").val();
			var isiReview = $("input#isiReview").val();
			var namaUsr = $("input#namaUsr").val();
			var ratingReview = $("input#ratingReview").val();
			$.ajax({
				url: "/reviewServlet",
				method: "post",
				data: {"action":"insert", "idTarget":idTarget, "isiReview": isiReview, "namaUsr":namaUsr, "ratingReview":ratingReview}
			 }).done(function(result){
				 //alert("Berhasil");
				 //alert(result);
			 }).error(function(xhr, ajaxOptions, thrownError){
				//alert(thrownError);
			 });
			 
		}
		</script>
        <script>
            $(document).ready(function () {
            		
                $('#image-gallery').lightSlider({
                    gallery: true,
                    item: 1,
                    thumbItem: 9,
                    slideMargin: 0,
                    speed: 500,
                    auto: true,
                    loop: true,
                    onSliderLoad: function () {
                        $('#image-gallery').removeClass('cS-hidden');
                    }
                });
                
                
                $("#btnWishlist").click(function()
       			{
                	var sessUser = $("#sessUser").val();
                	var hiddenID = $("#hiddenID").val();
                	var hiddenWishlist = $("#hiddenWishlist").val();
                	if(hiddenWishlist == "true")
               		{
               			alert("Already in wishlist. To remove it, go to your profile page.");
               		}
                	else if(hiddenWishlist == "update")
               		{
                		var id = $("#hiddenKey").val();
                		var status = $("#hiddenStatus").val();
                		var idResto = $("#hiddenIdResto").val();
                		$.ajax({
            				url: "/Wishlist",
            				method: "post",
            				data: {"id":id,"user":sessUser,"action":"update","status":status,"idResto":idResto}
            			 }).done(function(result){
            				 alert("You have new wishlist!");
            				 $("#hiddenWishlist").val("true");
            			 }).error(function(xhr, ajaxOptions, thrownError){
            				alert(thrownError);
            			 });
               		}
                	else
                	{
                		if(sessUser == "null")
                    	{
                    		alert("You must login first!");
                    	}
                    	else
           				{
                    		//alert(hiddenWishlist);
                    		$.ajax({
                				url: "/Wishlist",
                				method: "post",
                				data: {"id":hiddenID,"user":sessUser,"action":"insert"}
                			 }).done(function(result){
                				 alert("You have new wishlist!");
                				 $("#hiddenWishlist").val("true");
                			 }).error(function(xhr, ajaxOptions, thrownError){
                				alert(thrownError);
                			 });
                    			
           				}
                	}
                	
                	//alert(hiddenID);
        		
       			});
            });
        </script>
    </body>
</html>