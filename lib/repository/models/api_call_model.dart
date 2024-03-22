// class ApiModel {
//   final String discription;
//   final String api;

//   ApiModel({
//     required this.api,
//     required this.discription,
//   });
// }

class ApiModel {
  final String word;
  final String phonetic;
  final String audio;

  final String partOfSpeech;
  final String mainDefinition;
  final String example;

  final List<String> synonyms;
  final List<String> antonyms;

  final String partOfSpeech2;
  final String definition2;
  final String example2;

  final List<String> synonyms2;
  final List<String> antonyms2;

  ApiModel(
      {required this.audio,
      required this.example,
      required this.mainDefinition,
      required this.partOfSpeech,
      required this.phonetic,
      required this.word,
      required this.antonyms,
      required this.synonyms,
      required this.antonyms2,
      required this.definition2,
      required this.example2,
      required this.partOfSpeech2,
      required this.synonyms2});
}
