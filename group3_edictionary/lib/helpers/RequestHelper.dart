import 'package:http/http.dart' as http;

class RequestHelper {
  final String host = 'https://safe-sierra-54080.herokuapp.com/';

  Future<http.Response> request(String endpoint, { Map<String, dynamic> body,Map<String, dynamic> headers, String method }) async {
    String uri = '$host$endpoint';
    
    if (method.toLowerCase() == 'post')
      return await http.post(uri, body : body, headers : headers);
    
    if (method.toLowerCase() == 'get')
      return await http.get(uri, headers : headers);

    if (method.toLowerCase() == 'put')
      return await http.put(uri, headers : headers, body : body);
    
    if (method.toLowerCase() == 'delete')
      return await http.delete(uri, headers : headers);
  }
}