import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/repositories/FlashCardRepository.dart';
import 'package:quizlet_clone/core/utilities/HttpService.dart';
import 'package:quizlet_clone/core/utilities/StrapiConfig.dart';

class FlashCardRepositoryStrapiImpl implements FlashCardRepository {
  static const _endpoint = StrapiConfig.flashCardEndpoint;

  @override
  Future<int> countFlashCards({String lessonId}) async {
    var response = await HttpService.get(
        endpoint: _endpoint + '/' + StrapiConfig.countEndpoint);
    return response;
  }

  @override
  Future<List<FlashCard>> getFlashCards({String lessonId}) async {
    var response =
        await HttpService.get(endpoint: _endpoint, params: {'lesson': lessonId})
            as List;
    return new List<FlashCard>.from(
        response.map((fc) => FlashCard.fromMap(fc, fc['id'])));
  }
}
