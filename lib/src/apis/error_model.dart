class ErrorModel {
  String error;
  int status;

  ErrorModel({this.error, this.status});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['status'] = status;
    return data;
  }
}