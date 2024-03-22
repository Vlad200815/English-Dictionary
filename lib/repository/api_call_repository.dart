import 'package:dio/dio.dart';
import 'package:dio_http/repository/models/api_call_model.dart';
import 'package:flutter/material.dart';

// class ApiCall {
//   Future<List<ApiModel>> getApi() async {
//     final response = await Dio().get("https://api.publicapis.org/entries");

//     final data = response.data as Map<String, dynamic>;
//     final entries = data['entries'] as List<dynamic>;

//     final apiModels = entries.map((entry) {
//       final api = entry["API"];
//       final description = entry["Description"];
//       debugPrint(ApiModel(api: api, discription: description).toString());
//       return ApiModel(api: api, discription: description);
//     }).toList();

//     return apiModels;
//   }
// }
/////////////////////////////////////
// class ApiCall {
//   String post;
//   ApiCall({required this.post});

//   Future<List<ApiModel>> getApi() async {
//     final response = await Dio()
//         .get("https://api.dictionaryapi.dev/api/v2/entries/en/" + post);
//     debugPrint(post);
//     final data = response.data[0];

//     final phonetics = data['phonetics'] as List<dynamic>;
//     final meanings = data['meanings'] as List<dynamic>;

//     final apiModels = phonetics.map((entry) {
//       return ApiModel(
//         audio: phonetics[1]['audio'] ?? "",
//         word: data['word'] ?? "",
//         phonetic: phonetics[1]['text'] ?? "",
//         partOfSpeech: meanings[0]['partOfSpeech'] ?? "",
//         mainDefinition: meanings[0]['definitions'][0]['definition'] ?? "",
//         example: meanings[0]['definitions'][0]['example'] ?? "",
//         synonyms: meanings[0]['synonyms']?.cast<String>() ?? "",
//         antonyms: meanings[0]['antonyms']?.cast<String>() ?? "",
//       );
//     }).toList();
//     return apiModels;
//   }
// }
//////////////////////
class ApiCall {
  final String post;
  ApiCall({required this.post});

  Future<List<ApiModel>> getApi() async {
    final response = await Dio()
        .get("https://api.dictionaryapi.dev/api/v2/entries/en/$post");

    final data = response.data[0];

    final phonetics = data['phonetics'] as List<dynamic>;
    final meanings = data['meanings'] as List<dynamic>;

    final apiModels = phonetics.map((entry) {
      try {
        return ApiModel(
          audio: phonetics.length > 1
              ? phonetics[1]['audio'] ??
                  "https://commondatastorage.googleapis.com/codeskulptor-assets/Evillaugh.ogg"
              : "https://commondatastorage.googleapis.com/codeskulptor-assets/Evillaugh.ogg",
          word: data['word'] ?? "",
          phonetic: phonetics.length > 1
              ? phonetics[1]['text'] ?? "-----------------------"
              : "---------------------",
          partOfSpeech: meanings[0]['partOfSpeech'] ?? "",
          mainDefinition: meanings[0]['definitions'][0]['definition'] ?? "",
          example: meanings[0]['definitions'][0]['example'] ??
              "------------------------------------",
          synonyms: meanings[0]['synonyms']?.cast<String>() ?? "",
          antonyms: meanings[0]['antonyms']?.cast<String>() ?? "",
          partOfSpeech2: meanings[1]['partOfSpeech'] ?? "",
          definition2: meanings[1]['definitions'][0]['definition'] ?? "",
          example2: meanings[1]['definitions'][0]['example'] ??
              "------------------------------------",
          antonyms2: meanings[1]['antonyms']?.cast<String>() ?? "",
          synonyms2: meanings[0]['synonyms']?.cast<String>() ?? "",
        );
      } catch (e) {
        debugPrint("Error creating ApiModel: $e");
        return ApiModel(
          audio: "",
          word: "Try another word",
          phonetic: "",
          partOfSpeech: "",
          mainDefinition: "",
          example: "",
          synonyms: [],
          antonyms: [],
          partOfSpeech2: "",
          definition2: "",
          example2: "",
          antonyms2: [],
          synonyms2: [],
        );
      }
    }).toList();
    return apiModels;
  }
}
