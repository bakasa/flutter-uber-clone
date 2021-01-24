import 'package:flutter/material.dart';
import 'package:flutter_uber_clone/Assistants/requestAssistant.dart';
import 'package:flutter_uber_clone/DataHandler/appData.dart';
import 'package:flutter_uber_clone/Models/address.dart';
import 'package:flutter_uber_clone/configMaps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class AssistantMethods{

    static Future<String> searchCoordinateAddress(Position position,context)async{

    String placeAddress="";
    String st1,st2,st3,st4;
    String url="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response=await RequestAssistant.getRequest(url);

    if(response!="failed"){

      st1=response["results"][0]["address_components"][3]["long_name"];
      st2=response["results"][0]["address_components"][4]["long_name"];
      st3=response["results"][0]["address_components"][5]["long_name"];
      st4=response["results"][0]["address_components"][6]["long_name"];
      placeAddress=st1+ ", " +st2 + ", " + st3 + ", " + st4;

      Address userPickUpAddress=new Address();
      userPickUpAddress.longitute=position.longitude as String;
      userPickUpAddress.latitude=position.latitude as String;
      userPickUpAddress.placeName=placeAddress;

      Provider.of<AppData>(context,listen: false).updatePickupLocationAddress(userPickUpAddress);

    }

    return placeAddress;
  }
}