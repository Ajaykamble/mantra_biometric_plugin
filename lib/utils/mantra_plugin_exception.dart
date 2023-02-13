import 'dart:convert';

abstract class MantraPluginAppException implements Exception {
  String? code;
  String? message;
  String? description;

  MantraPluginAppException([this.code, this.message, this.description]) : super();

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() => {"code": code ?? "", "message": message ?? "", "description": description ?? ""};
}

class RDClientNotFound extends MantraPluginAppException {
  RDClientNotFound([String? code, String? message, String? description]) : super(code, message, description);

  @override
  String toString() {
    super.toString();
    return jsonEncode({"code": code ?? "", "message": message ?? "", "description": description ?? ""});
  }
}

class RDException extends MantraPluginAppException {
  RDException([String? code, String? message, String? description]) : super(code, message, description);
  @override
  String toString() {
    super.toString();
    return jsonEncode({"code": code ?? "", "message": message ?? "", "description": description ?? ""});
  }
}
