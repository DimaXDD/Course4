import 'package:flutter/services.dart';

class PhoneService{
    static const platform = MethodChannel("phone");
    static Future<void> callNumber(String phoneNumber) async{
      try{
          await platform.invokeMethod('callNumber', phoneNumber);
      }
      catch(e){
        print("Failed to call number");
      }
    }

}