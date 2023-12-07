import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResponses {
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 409:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 406:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        // throw BadRequestException(response.body.toString());
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        // throw UnauthorisedException(response.body.toString());
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      // case 406:
      //   throw UnauthorisedException(response.body.toString());
      case 422:
        // throw UnauthorisedException(response.body.toString());
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 500:
        // throw UnauthorisedException(response.body.toString());
        return jsonDecode(response.body);
      default:
        return jsonDecode(response.body);
    }
  }
}
