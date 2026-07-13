class RequestResponseModel {
  final int id;
  final bool success;

  RequestResponseModel({required this.id, required this.success});

  factory RequestResponseModel.fromJson(Map<String, dynamic> json) {
    return RequestResponseModel(id: json["id"] ?? 0, success: true);
  }
}
