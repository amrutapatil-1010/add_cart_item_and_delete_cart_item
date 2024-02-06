class AddProductResponse {
  String? message;

  AddProductResponse({this.message});

  AddProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    return data;
  }
}
