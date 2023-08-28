import 'dart:convert';
import 'package:http/http.dart' as http;
class HttpHelper{
  String baseUrl ='https://api.pdf.co/v1/file/';
  Future<dynamic> getData({
    required String Url,
    String? token,
  })async
  {
    Map<String,String> headers ={
      'Content-Type': 'application/json',
      'Accept':'*/*'
    };
    if(token != null)
    {
      headers.addAll({
        'Authorization':token
      });
    }
    http.Response response =  await http.get(Uri.parse("$baseUrl$Url"),headers: headers);
    if(response.statusCode ==200){
      return jsonDecode(response.body);
    }
    else
      {
        throw Exception("error from get statuscode :  ${response.statusCode}");
      }
  }

  Future<dynamic> postData({ required String Url ,required dynamic boady,String? token  })async
  {
    Map<String,String> headers ={
     // 'Content-Type': 'text/plain',
      'Accept':'*/*'
    };

    if(token != null)
      {
        headers.addAll({
         'Authorization':token
        });
      }
      http.Response response =  await http.post(Uri.parse("$baseUrl$Url"),
      body: boady,
      headers: headers,
    );
    if(response.statusCode ==200){
      return jsonDecode(response.body);
    }
    else
    {
      throw Exception("error from post statuscode :  ${response.statusCode}");
    }
  }


  Future<dynamic> postMultiPartData  ({
    required String Url
    ,required Map<String,String> data,
    required String filepath,
    required String api,
    required String nameinjson  })async
   {
     var headers = {
       'x-api-key': 'shoroukfadl975@gmail.com_633a22e9a62ef74629b724a8fb1c34aa08b31411f5a46ab530b7f6832bd8cbb51c526329'
     };
     var request = http.MultipartRequest('POST',
         Uri.parse('$baseUrl$Url'));
     request.fields.addAll(data);
     request.files.add(await http.MultipartFile.fromPath(
         nameinjson, filepath));
     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();
     if (response.statusCode == 200) {
       return jsonDecode(await response.stream.bytesToString());
     }
     else {
       print(response.reasonPhrase);
     }
  }

  Future<dynamic> putData({ required String Url ,required dynamic boady,String? token  })async
  {
    Map<String,String> headers ={
      'Content-Type': 'application/json',
      'Accept':'*/*'
    };
    if(token != null)
    {
      headers.addAll({
        'Authorization':token!
      });
    }
    http.Response response =  await http.put(Uri.parse("$baseUrl$Url"),
      body: boady,
      headers: headers,
    );
    if(response.statusCode ==200){
      return jsonDecode(response.body);
    }
    else
    {
      throw Exception("error from put statuscode :  ${response.statusCode}");
    }
  }

  Future<dynamic> delete({ required String Url ,required dynamic boady,String? token  })async
  {
    Map<String,String> headers ={
      'Content-Type': 'application/json',
      'Accept':'*/*'
    };

    if(token != null)
    {
      headers.addAll({
        'Authorization':token
      });
    }
    http.Response response =  await http.delete(Uri.parse("$baseUrl$Url"),
      body: boady,
      headers: headers,
    );
    if(response.statusCode ==200){
      return jsonDecode(response.body);
    }
    else
    {
      throw Exception("error from put statuscode :  ${response.statusCode}");
    }
  }
}