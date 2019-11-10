
import 'package:http/http.dart' as http;

class StrapiReq {
  final String host = 'http://192.168.1.106:1337/';
  // ignore: missing_return
  Future<http.Response> request(String endpoint,{Map<String, dynamic> body,Map<String, dynamic> headers, String method }) async {
    String uri = host + endpoint;
    print(uri);
    if (method.toLowerCase() == 'post') {
      return await http.post(uri, body : body, headers : headers);
    }
    if( method.toLowerCase() == 'get') {
      return await http.get(uri, headers : headers);
    }
  }
}