
import 'package:http/http.dart' as http;

class StrapiReq {
  final String host = 'http://10.20.7.185:1337/';
  // ignore: missing_return
  Future<http.Response> request(String endpoint,{Map<String, dynamic> body,Map<String, dynamic> headers, String method }) async {
    String uri = host + endpoint;
    if (method.toLowerCase() == 'post') {
      return await http.post(uri, body : body, headers : headers);
    }
    if( method.toLowerCase() == 'get') {
      return await http.get(uri, headers : headers);
    }
  }
}