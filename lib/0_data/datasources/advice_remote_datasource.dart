import "dart:convert";

import "package:http/http.dart" as http;
import "package:learn_flutter_2_udemy/0_data/exceptions/exeptions.dart";
import "package:learn_flutter_2_udemy/0_data/models/advice_model.dart";

abstract class AdviceRemoteDatasource {
  /// requests a random advice from the api
  /// then returns a [AdviceModel] if succesful
  /// or throws a ServerException if unseccesful
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDatasourceImpl implements AdviceRemoteDatasource {
  final client = http.Client();

  @override
  Future<AdviceModel> getRandomAdviceFromApi() async{
    final response = await client.get(Uri.parse("https://api.flutter-community.de/api/v1/advice"),
    headers: {
      "content-type": "application/json"
    }); 
    if (response.statusCode != 200) {
      throw ServerException();
    }

    final responseBody = json.decode(response.body);

    return AdviceModel.fromJson(responseBody);
  }
}
