import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/services/FlashCardService.dart';
import 'package:quizlet_clone/core/utilities/StrapiConfig.dart';

class FlashCardImageGetter {
  static const host = StrapiConfig.host;

  static NetworkImage getImage({@required String imageUrl}) {
    return NetworkImage(host + imageUrl);
  }

  static Future<NetworkImage> findImage({@required String lessonId}) async {
    var flashCards = await FlashCardService.instance.getFlashCards(lessonId: lessonId);
    for(var fc in flashCards) {
      if(fc.imageUrl != null) return NetworkImage(fc.imageUrl);
    }
    return null;
  }
}