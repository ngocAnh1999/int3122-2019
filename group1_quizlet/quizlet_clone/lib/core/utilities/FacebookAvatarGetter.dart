import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FacebookProfileGetter {
  static dynamic getProfile({@required String accessToken}) async {
    var graphResponse = await http.get(
        'https://graph.facebook.com/v4.0/me?fields=id,first_name,last_name,email&access_token=$accessToken');
    return await jsonDecode(graphResponse.body);
  }

  static String getAvatarUrl({@required String facebookId}) {
    print(facebookId);
    return 'http://graph.facebook.com/$facebookId/picture?width=500&height=500';
  }
}
