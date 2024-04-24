import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'idea_model.dart';

class ApiService {
  final _baseUrl = "https://www.boredapi.com/api";
  final _getRoute = "/activity/";

  Future<dynamic> getIdea() async {
    var url = Uri.parse(_baseUrl + _getRoute);
    Idea idea = Idea();
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // Parse JSON response into an Idea object
        idea = Idea.fromJson(jsonDecode(response.body));
      } else {
        // Return the HTTP status code as an error
        return response.statusCode;
      }
    } on SocketException catch (e) {
      // Handle network-related errors
      return 'Network error: $e';
    } on HttpException catch (e) {
      return 'HTTP error: $e';
    } on FormatException catch (e) {
      // Handle JSON decoding errors
      return 'JSON decoding error: $e';
    } catch (e) {
      // Handle any other unexpected errors
      return 'Unexpected error: $e';
    }
    return idea;
  }
}
