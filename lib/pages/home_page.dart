// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:dio_http/repository/api_call_repository.dart';
import 'package:dio_http/repository/models/api_call_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<ApiModel> _apiModel = [];

//   @override
//   void initState() {
//     _loadApiData();
//     super.initState();
//   }

//   Future<void> _loadApiData() async {
//     try {
//       final apiModels = await ApiCall().getApi();
//       setState(() {
//         _apiModel = apiModels;
//       });
//     } catch (e) {
//       debugPrint("API Call Error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ListView.separated(
//       separatorBuilder: (context, index) => const Divider(),
//       itemCount: _apiModel.length,
//       itemBuilder: (context, i) {
//         final one = _apiModel[i];
//         final oneApi = one.api;
//         final oneDes = one.discription;
//         return ListTile(title: Text(oneApi), subtitle: Text(oneDes));
//       },
//     ));
//   }
// }
////////////////////////////////////////////////////////
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void setPost() {
    setState(() {
      post = _controller.text;
    });
    if (post == "") {
      setState(() {
        post == "word";
      });
    }
  }

  void playAudioFromUrl(String url) async {
    await player.play(UrlSource(url));
  }

  final player = AudioPlayer();
  final _controller = TextEditingController();
  String post = "dog";

  List<ApiModel> _apiModels = [];

  Future<void> fetchData() async {
    // List<ApiModel> data = await ApiCall(post: post).getApi();
    List<ApiModel> data = await ApiCall(post: post).getApi();
    debugPrint(data.toString());
    setState(() {
      _apiModels = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setPost();
          fetchData();
        },
        child: const Icon(Icons.search, size: 33),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          // ApiModel apiModel = _apiModels[index];

          if (_apiModels.isNotEmpty) {
            ApiModel apiModel = _apiModels[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Search",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                        },
                      ),
                    ),
                  ),
                  const Divider(
                    height: 30,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  Center(
                    child: Text(
                      apiModel.word,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.black,
                  ),
                  Text(
                    "phonetics: ${apiModel.phonetic}",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Play Audio",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          playAudioFromUrl(apiModel.audio);
                        },
                        child: Icon(Icons.headphones, size: 40),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        "Part of speech: ${apiModel.partOfSpeech}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "Decription: ${apiModel.mainDefinition}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        "Exapmle: ${apiModel.example}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Part of speech: ${apiModel.partOfSpeech2}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "Decription: ${apiModel.definition2}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        "Exapmle: ${apiModel.example2}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 350.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
