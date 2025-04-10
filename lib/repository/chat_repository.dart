import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatRepository{

  String get apikey => dotenv.env['GEMINI_API_KEY'] ?? " ";
  String get baseurl => "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apikey";

  Future<String> getBotResponse(String prompts) async{
    final response = await http.post(Uri.parse(baseurl),
    headers: {
      'Content-Type': 'application/json'
    },
      body: jsonEncode({
        "contents": [{
          "parts":[{"text": prompts}]
        }]
      })

    );

    try{
      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'];

      switch(response.statusCode){

        case 200:
          return text;

        case 401:
          return throw Exception("Bad Request");

        default:
          return throw Exception('Error');
      }

    }
    catch(e){
      return throw Exception("Unable to get The response,Check API key");
    }
  }
}