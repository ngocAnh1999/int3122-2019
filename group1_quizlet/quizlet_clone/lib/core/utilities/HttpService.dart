import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quizlet_clone/core/utilities/StrapiConfig.dart';

class HttpService {
  static const _host = StrapiConfig.host;

  static dynamic get({@required String endpoint, Map params}) async {
//    print('Calling API...');
    var query = '';
    if (params != null) {
      query = '?';
      params.forEach((key, value) {
        query += key + '=' + value;
      });
    }
//    print(_host + endpoint + query);
    var response = await http.get(_host + '/' + endpoint + query);
//    print('Finished');
    if (response.statusCode == 200) {
//      print('Success');
      return jsonDecode(response.body);
    } else {
//      print('Error');
      return null;
    }
  }
}
