import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatRepository{

  String get api_key => dotenv.env['GEMINI_API_KEY'] ?? " ";
  String get BASE_URL => "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$api_key";

  Future<String> getBotResponse(String Prompts) async{
    final response = await http.post(Uri.parse(BASE_URL),
    headers: {
      'Content-Type': 'application/json'
    },
      body: jsonEncode({
        "contents": [{
          "parts":[{"text": Prompts}]
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