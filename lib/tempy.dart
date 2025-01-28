import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meme_soundpad/search_page.dart';

import 'meme_lib.dart';

class TempHome extends StatefulWidget {
  const TempHome({super.key});

  @override
  State<TempHome> createState() => _TempHomeState();
}

class _TempHomeState extends State<TempHome> {
  late AudioPlayer player;
  var sortedMemeList = [...allMemeList];
  int currDoubleID = 127;
  List<Widget> memeWidgets = [];

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setAsset("assets/audio/intro.mp3");
    player.setVolume(sqrt(10));
    sortedMemeList.sort((a, b) => a.priorityID.compareTo(b.priorityID));
    for (int i = 0; i < sortedMemeList.length; i++) {
      if (!sortedMemeList[i].isDoubleMeme) {
        memeWidgets.add(memeAudioButton(
            buttonName: sortedMemeList[i].name,
            fileName: sortedMemeList[i].fileName));
      } else {
        if (sortedMemeList[i].doubleID == currDoubleID) {
          continue;
        } else {
          currDoubleID = sortedMemeList[i].doubleID;
          memeWidgets.add(
            dualMemeButton(
              buttonNames: [sortedMemeList[i].name, sortedMemeList[i + 1].name],
              fileNames: [
                sortedMemeList[i].fileName,
                sortedMemeList[i + 1].fileName
              ],
            ),
          );
        }
      }
    }
    player.play();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
              icon: const Icon(Icons.search),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: OrientationBuilder(builder: (context, orientation) {
            return GridView.count(
                childAspectRatio: 1.2,
                crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                children: memeWidgets);
          }),
        ),
      ),
      backgroundColor: const Color(0xffDDDDDD),
    );
  }

  Widget memeAudioButton(
      {required String buttonName, required String fileName}) {
    return TextButton(
      onPressed: () async {
        await player.setAsset('assets/audio/$fileName.mp3');
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
                image: AssetImage("assets/images/$fileName.png"),
                opacity: const AlwaysStoppedAnimation(.5),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  buttonName,
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
    );
  }

  Widget dualMemeButton(
      {required List<String> buttonNames, required List<String> fileNames}) {
    if (buttonNames.length > 2 || fileNames.length > 2) {
      throw "dualMemeButton takes only two button names and two file names";
    }
    return Row(
      children: <Widget>[
        Expanded(
          child: memeAudioButton(
            buttonName: buttonNames[0],
            fileName: fileNames[0],
          ),
        ),
        Expanded(
            child: memeAudioButton(
          buttonName: buttonNames[1],
          fileName: fileNames[1],
        ))
      ],
    );
  }
}
