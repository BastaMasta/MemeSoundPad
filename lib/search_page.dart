import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import 'meme_lib.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late AudioPlayer player;

  late Widget searchBody;

  @override
  void initState() {
    searchBody = blankPage();
    super.initState();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  List<Meme> filteredMemes = [];

  Widget blankPage() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Column(
            children: [
              Icon(
                Icons.search,
                size: 100.0,
                color: Colors.grey.withOpacity(0.5),
              ),
              const Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Type something in the search bar to begin searching",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(),
          Container(),
        ],
      ),
    );
  }

  Widget sadPage() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Column(
            children: [
              Icon(
                Icons.crisis_alert,
                size: 100.0,
                color: Colors.grey.withOpacity(0.5),
              ),
              const Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "We're Sorry! we dont have that meme yet!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "\nYou can send us an email at\n ✉ feedback@bastamasta.dev\n to request for a meme to be added!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(),
          Container(),
        ],
      ),
    );
  }

  Widget resultsPage({required List<Meme> memeList}) {
    return Flexible(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        childAspectRatio: 1.2,
        crossAxisCount: 2,
        children: memeList
            .map(
              (meme) => TextButton(
                onPressed: () async {
                  await player.setAsset('assets/audio/${meme.fileName}.mp3');
                  await player.setVolume(sqrt(10));
                  player.play();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          fit: BoxFit.cover,
                          image:
                              AssetImage("assets/images/${meme.fileName}.png"),
                          opacity: const AlwaysStoppedAnimation(.5),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            meme.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(1.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xff1B262C),
                ),
                child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu)),
              ),
            );
          },
        ),
        backgroundColor: const Color(0xff152744),
        title: const Text("Meme SoundPad"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.zero,
            bottom: Radius.circular(5),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (player.playing) {
                player.stop();
              }
            },
            icon: const Icon(Icons.stop),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4.0, 15.0, 4.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 4.0, 5.0, 4.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Enter Meme name",
                        ),
                        onChanged: (param) {
                          if (param.isEmpty) {
                            setState(() {
                              searchBody = blankPage();
                            });
                          } else {
                            filteredMemes = allMemeList
                                .where(
                                  (meme) => meme.searchParams
                                      .toLowerCase()
                                      .contains(param),
                                )
                                .toList();
                            if (filteredMemes.isNotEmpty) {
                              setState(() {
                                searchBody =
                                    resultsPage(memeList: filteredMemes);
                              });
                            } else {
                              setState(() {
                                searchBody = sadPage();
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            searchBody,
          ],
        ),
      ),
    );
  }
}
