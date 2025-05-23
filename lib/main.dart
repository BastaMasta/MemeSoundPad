import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meme_soundpad/search_page.dart';
import 'package:path_provider/path_provider.dart';
import 'meme_lib.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase - like opening the secure line to headquarters
  await Firebase.initializeApp();

  runApp(
    const MaterialApp(
      home: SoundPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

// File IO

class Filer {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/memedb.json');
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$counter');
  }
}

class SoundPage extends StatefulWidget {
  const SoundPage({super.key});

  @override
  State<SoundPage> createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  late AudioPlayer player;
  var sortedMemeList = [...allMemeList];
  int currDoubleID = 127;
  List<Widget> memeWidgets = [];
  // List to store json data
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;

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

  // Fetch data method - like sending a runner to the filing cabinet
  Future<void> fetchData() async {
    try {
      // Access the "items" collection (drawer) in our Firestore filing cabinet
      final snapshot =
          await FirebaseFirestore.instance.collection('items').get();

      // Convert each document to a map and add to our list
      final fetchedItems = snapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        items = fetchedItems;
        isLoading = false;
      });

      // Optional: Save the JSON locally for offline access
      await saveJsonLocally(fetchedItems);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  // Save JSON data locally - like making a photocopy of the files
  Future<void> saveJsonLocally(List<Map<String, dynamic>> data) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/items_data.json');

      // Convert list to JSON string and write to file
      await file.writeAsString(jsonEncode(data));
      print('JSON data saved locally at: ${file.path}');
    } catch (e) {
      print('Error saving JSON locally: $e');
    }
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
                  color: Color(0xffffffff),
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
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
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
            color: Colors.white,
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
              color: Colors.white,
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

  Widget moreComingButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4.0, 4.0),
              color: Colors.grey.shade700,
            ),
          ],
        ),
        child: const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "More Meme Templates Coming Soon!",
              textAlign: TextAlign.center,
              style: TextStyle(
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
      ),
    );
  }
}
