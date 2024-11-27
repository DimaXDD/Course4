import "package:flutter/services.dart";


class PermissionService{
  static const platform = MethodChannel("permission");

  static Future<bool> checkPermission(String permission) async{
    try{
      final bool result = await platform.invokeMethod("checkPermission", permission);
      return result;
    }
    catch(e){
      return false;
    }
  }
}