
import 'package:http/http.dart' as http;

class StrapiReq {
  final String host = 'https://frozen-cove-66834.herokuapp.com/';
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