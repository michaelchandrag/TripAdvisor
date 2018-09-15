<!DOCTYPE html>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.cloud.datastore.QueryResults"%>
<%@page import="com.google.cloud.bigquery.QueryResult"%>
<%@page import="com.google.cloud.datastore.StructuredQuery.PropertyFilter"%>
<%@page import="com.google.cloud.datastore.Entity"%>
<%@page import="com.google.cloud.datastore.Query"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.google.auth.oauth2.ServiceAccountCredentials"%>
<%@page import="com.google.cloud.datastore.DatastoreOptions"%>
<%@page import="com.google.cloud.datastore.Datastore"%>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>TRIPADVISOR | RESTAURANT & TOURISM PLACE</title>
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


        <div class="slider-area">
            <div class="slider">
                <div id="bg-slider" class="owl-carousel owl-theme">

                    <div class="item"><img src="assets/img/slide1/tourism1.jpg" alt="Mirror Edge"></div> 
                    <div class="item"><img src="assets/img/slide1/tourism2.jpg" alt="The Last of us"></div> 
                    <div class="item"><img src="assets/img/slide1/tourism3.jpg" alt="GTA V"></div>   

                </div>
            </div>
            <div class="container slider-content">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12">
                        <h2 style="color:black;font-size:36px;">Find Tours, activities and many more</h2>
                        <div class="search-form wow pulse" data-wow-delay="0.8s">

                            <form action="" class=" form-inline">
                                <div class="form-group">
                                    <input id="txtSearch" type="text" class="form-group" placeholder="Destination or activity">
                                </div>
                                <input id="btnSearch" class="btn search-btn" type="button" value="Find">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- property area -->
        <div class="content-area recent-property" style="padding-bottom: 60px; background-color: rgb(252, 252, 252);">
            <div class="container">   
                <div class="row">
                    <div class="col-md-12  padding-top-40 properties-page">
                        <div class="col-md-12 "> 
                            <div class="col-xs-10 page-subheader sorting pl0">
                            </div>

                            <div class="col-xs-2 layout-switcher">                        
                            </div><!--/ .layout-switcher-->
                        </div>

                        <div class="col-md-12 "> 
                            <div id="list-type" class="proerty-th">
<!-- LOAD TOURISM PLACE DATASTORE -->
<%! %>
<%
	String a = request.getQueryString();
	//out.println("<h1>"+a+"</h1>");
	int currentPage = 0;
	String find = "";
	if(a ==null)
	{
		currentPage = 0;
	}
	else
	{
		if(a.contains("currentPage"))			
		{
			String req = request.getParameter("currentPage");
			currentPage =Integer.parseInt(req);	
		}
		if(a.contains("find"))
		{
			find = request.getParameter("find");
		}
	}
	int data = 8; //menampilkan berapa data per page
	Datastore datastore;
	datastore = DatastoreOptions.newBuilder().setProjectId("inlaid-agility-170309").
				setCredentials(ServiceAccountCredentials.fromStream(new FileInputStream("My Project-b3225e5a13dd.json"))).build().getService();
	Query<Entity> query1 = Query.newEntityQueryBuilder()
							.setKind("TablePlace")
							//.setLimit(data)
							//.setOffset(currentPage*4)
							.build();
	QueryResults<Entity> results1 = datastore.run(query1);
	
	//out.println("<h1>JUMLAH DATA : "+jumlahData+"</h1>");
	int ctrData = 0;
	int jumlahData = 0;//index data dimulai dari 0 - habis
	int offset = currentPage*data;
	while(results1.hasNext())
	{
		Entity entity1 = results1.next();
		String name = entity1.getString("nama").toLowerCase();
		String alamat = entity1.getString("alamat").toLowerCase();
		String lokasi = entity1.getString("lokasi").toLowerCase();
		if((ctrData >= offset && ctrData < (currentPage*data)+data) && (find=="" || (find!="" && (name.contains(find) || lokasi.contains(find) || alamat.contains(find)))))
		{
			out.println("<div class='col-sm-6 col-md-3 p0'>");
			out.println("<div class='box-two proerty-item'>");
			out.println("<div class='item-thumb'>");
			out.println("<a href='place.jsp?ID="+ entity1.getString("idPlace") +"' ><img src='Serve?blob-key="+entity1.getString("foto").toString() +"'style='height:225px;width:265px'></a>");
			out.println("</div>");//TUTUP DIV KETIGA
			
			
			//BAGIAN OBJECT RESTAURANT
			out.println("<div class='item-entry overflow'>");
			out.println("<h5><a href='resto.jsp?ID="+ entity1.getString("idPlace") +"'>"+name+"</a></h5>");
			out.println("<div class='dot-hr'></div>");
			out.println("<span class='pull-left'><b> Address :</b> "+ entity1.getString("alamat")+" </span>");
			out.println("<div class='property-icon'>");
			out.println("</div>");
			//BAGIAN AKHIR OBJECT RESTAURANT
			
			
			
			out.println("</div>");//TUTUP DIV KEEMPAT
			
			
			out.println("</div>");//TUTUP DIV KEDUA
			out.println("</div>");//TUTUP DIV PERTAMA
			
		}
		if(find == "" || (find!="" && (name.contains(find) || lokasi.contains(find) || alamat.contains(find))))
		{
			ctrData++;
		}
	}
	jumlahData = ctrData;
	if(jumlahData == 0)
	{
		out.println("<h1>Sorry!!! No Result Found. </h1>");
	}
%>    
                            </div>
                        </div>
                        <div class="col-md-12"> 
                            <div class="pull-right">
                                <div class="pagination">
                                    <ul>
                                    <%
                                  //index sebagai jumlah data
                                	int halamanAwal = 0;
                                	int halamanAkhir = jumlahData/data;
                                	//link = 'index.jsp'
                                	//link = 'index.jsp?currentPage=0'
                                	//link = 'index.jsp?find=ASD&currentPage=0'
                                	//out.println("<h1>JUMLAH HALAMAN : "+index+"</h1>");
                                	if(find == "")
                                	{
                                		if((currentPage*data)+data < jumlahData)
                                		{
                                			if(currentPage != 0)
                                			{
                                				out.println("<li><a href='index-6.jsp?find="+find+"&currentPage="+(currentPage-1)+"'>Prev</a></li>");
                                			}
                                			out.println("<li><a href='index-6.jsp?currentPage="+(currentPage+1)+"'>Next</a></li>");
                                		}
                                		else
                                		{	
                                			if(currentPage != 0){

                                    			out.println("<li><a href='index-6.jsp?currentPage="+(currentPage-1)+"'>Prev</a></li>");
                                				
                                			}
                                		}
                                	}
                                	else
                                	{
                                		if((currentPage*data)+data < jumlahData)
                                		{
                                			if(currentPage != 0)
                                			{
                                				out.println("<li><a href='index-6.jsp?find="+find+"&currentPage="+(currentPage-1)+"'>Prev</a></li>");
                                			}
                                			out.println("<li><a href='index-6.jsp?find="+find+"&currentPage="+(currentPage+1)+"'>Next</a></li>");
                                			
                                		}
                                		else
                                		{
                                			if(currentPage != 0){

                                    			out.println("<li><a href='index-6.jsp?currentPage="+(currentPage-1)+"'>Prev</a></li>");
                                				
                                			}
                                		}
                                	}
                                    %>
                                    </ul>
                                </div>
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
        $("document").ready(function()
		{
    		$("#btnSearch").click(function()
  			{
    			var txtSearch = $("#txtSearch").val();
    			if(txtSearch == "" || txtSearch == " ")
    			{
    				alert("Type a keyword!");
    			}
    			else
  				{

        			//alert(txtSearch);
        			var link = "index-6.jsp?find="+txtSearch.toLowerCase();
        			//link = http://index.jsp?=namaRestaurant
        			window.location.href = link;
  				}
    		
    		
  				
  			});
    	
    	});
        </script>    
    </body>
</html>