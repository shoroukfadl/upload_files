class UploadFilesModel{
  String? url;
  String? name;
  bool? error;
  int? status;
UploadFilesModel.fromjson(Map<String,dynamic> json)
{
  url =json['url'];
  name =json['name'];
  error =json['error'];
  status =json['status'];
}
}