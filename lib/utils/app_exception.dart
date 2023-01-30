import 'dart:convert';


abstract class AppException implements Exception {
  String? code;
  String? message;
  String? description;

  AppException([this.code,this.message,this.description]):super();

  @override
  String toString() {
    return jsonEncode(toJson());
  }
  Map<String,dynamic> toJson()=>{"code":code??"","message":message??"","description":description??""};
}

class ClientNotFound extends AppException {
  ClientNotFound([String? code,String? message,String? description]) : super(code,message,description);
}