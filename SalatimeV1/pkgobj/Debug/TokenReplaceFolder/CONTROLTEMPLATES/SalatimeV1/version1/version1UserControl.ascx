<%@ Assembly Name="SalatimeV1, Version=1.0.0.0, Culture=neutral, PublicKeyToken=a53d7f9de946e09d" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="version1UserControl.ascx.cs" Inherits="SalatimeV1.version1.version1UserControl" %>


<style>
        #map {
            height: 300px;
            background: #6699cc;
            display: block;
        }
</style>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAvJdI8P545r7g_uJvFl9NyrHtv4rZlP-k"></script>
<script type="text/javascript" src="http://praytimes.org/code/v2/js/PrayTimes.js"></script>
<link href="https://metroui.org.ua/css/metro.css" rel="stylesheet">

 
  <div class="grid">
        <div class="row cells12">
            <div class="cell"></div>
            <div class="cell colspan10" style="text-align:center"><h1>Setting</h1></div>
            <div class="cell"></div>
        </div>
        <div class="row cells2" style="min-width: 500px;">
            <!--Begin : Google Maps -->
            <div class="cell">
                <!-- Begin : Search Zonne -->
                <div class="row cells5" runat="server" ID="Search">
                    <div class="cell colspan4">
                            <div class="input-control text">
                                <input type="text" placeholder='Search'  id="name" >
                            </div>
                            <input type="button" class="image-button icon-right" onclick="codeAddress()" value="Location" >  <img src="../_layouts/15/images/MyFristApp/location.png" runat="server" class="icon">
                    </div>
                </div>
                <!-- END : Search Zonne -->
                <!-- Begin : Maps -->
                <div class="row">
                    <div class="row">
                        <div class="cell">
                            <div id="map"></div>
                        </div>
                    </div>
                </div>
                <!-- Begin : Maps -->
            </div>
            <!--END : Google Maps -->
            <!-- Salat Time Affichage -->
            <div class="cell " style="padding-left:20px ">
                
                <b> Calculation method  :</b> Umm al-Qura University, Makkah
                <br>
                <b> Date :</b> <div id="date"></div> 
                
            </div>
            <br> <br>
            <div class="cell ">

                <div class="example" data-text="Salat TIme">
                    <table class="table striped" >

                        <tbody>
                            <tr>
                                <td>Fajr</td>
                                <td id="Fajr">b</td>
                            </tr>
                            <tr>
                                <td>Sunrise</td>
                                <td id="Sunrise">b</td>
                            </tr>
                            <tr>
                                <td>Dhuhr</td>
                                <td id="Dhuhr">b</td>
                             </tr>
                            <tr>
                                <td>Asr</td>
                                <td id="Asr">b</td>
                            </tr>
                            <tr>
                                <td>Maghrib</td>
                                <td id="Maghrib">b</td>
                             </tr>
                            <tr>
                                <td>Isha</td>
                                <td id="Isha">b</td>
                             </tr>
                        </tbody>
                    </table>
                </div>


                <center runat="server" >
                    longitude : 
                       <input id="lng" runat="server" type="text"   ClientIDMode="Static" readonly /> 
                    latitude :
                       <input id="lat" runat="server" type="text"  ClientIDMode="Static" readonly /> 
                       <asp:Button ID="btnSubmit" CssClass="button" runat="server"      Text="Set" onclick="btnSubmit_Click" />
                </center>
            </div>
        </div>
    </div>



 <script type="text/javascript"> 
     var lat, lng, geocoder, map;
     
     function pageLoad() {
         lat = document.getElementById("lat").value;
         lng = document.getElementById("lng").value;
        // alert("lat " + lat + "   Lng" + lng);
         initialize(lat, lng);
         update(lat, lng);
         document.getElementById('lat').value = lat;
         document.getElementById('lng').value = lng;
     }


     function initialize(lat, Lng) {
         geocoder = new google.maps.Geocoder();

         var latlng = new google.maps.LatLng(lat, Lng);
         var mapOptions = {
             zoom: 8,
             center: latlng
         }
         map = new google.maps.Map(document.getElementById("map"), mapOptions);
     }

     function codeAddress() {
         var address = document.getElementById("name").value;
         geocoder.geocode({ 'address': address }, function (results, status) {
             if (status == google.maps.GeocoderStatus.OK) {
                 lat = results[0].geometry.location.lat();
                 lng = results[0].geometry.location.lng();
                 update(lat, lng);
                 map.setCenter(results[0].geometry.location);
                 var marker = new google.maps.Marker({
                     map: map,
                     position: results[0].geometry.location
                 });
             } else {
                 alert("Geocode was not successful for the following reason: " + status);
             }
         });
     }
     function update(lat, lng) {
         var date = new Date(); // today
         var times = prayTimes.getTimes(date, [lat, lng], 1);
         var list = ['Fajr', 'Sunrise', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
         document.getElementById('lat').value = lat;
         document.getElementById('lng').value = lng;

         document.getElementById('date').innerHTML = date.toLocaleDateString();
         document.getElementById('Fajr').innerHTML = times[list[0].toLowerCase()];
         document.getElementById('Sunrise').innerHTML = times[list[1].toLowerCase()];
         document.getElementById('Dhuhr').innerHTML = times[list[2].toLowerCase()];
         document.getElementById('Asr').innerHTML = times[list[3].toLowerCase()];
         document.getElementById('Maghrib').innerHTML = times[list[4].toLowerCase()];
         document.getElementById('Isha').innerHTML = times[list[5].toLowerCase()];

     }

    </script>
  
