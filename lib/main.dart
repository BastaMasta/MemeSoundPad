import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meme_soundpad/search_page.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

import 'meme_lib.dart';

void main() {
  runApp(
    const MaterialApp(
      home: SoundPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class SoundPage extends StatefulWidget {
  const SoundPage({super.key});

  @override
  State<SoundPage> createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  late AudioPlayer player;
  double currentvol = 0.5;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setAsset("assets/audio/intro.mp3");
    player.setVolume(sqrt(10));
    player.play();
    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
    });
    PerfectVolumeControl.stream.listen((volume) {
      if (volume != currentvol) {
        //only execute button type check once time
        player.stop();
      }
      setState(() {
        currentvol = volume;
      });
    });
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
              children: <Widget>[
                memeAudioButton(
                  buttonName: "Jaldi Waha Se Hato",
                  fileName: "jaldi_waha_se_hato",
                ),
                memeAudioButton(
                  buttonName: "Bacche Teri...",
                  fileName: "bacche_teri",
                ),
                memeAudioButton(
                  buttonName: "Rom Rom Bhaiyo",
                  fileName: "rom_rom_bhaiyo",
                ),
                memeAudioButton(
                  buttonName: "Hum pe to Hai No",
                  fileName: "hum_pe_to_hai_no",
                ),
                memeAudioButton(
                  buttonName: "Notty hora ke BKL",
                  fileName: "notty_hora_ke_bkl",
                ),
                memeAudioButton(
                  buttonName: "Tapa-Tap",
                  fileName: "tapa_tap",
                ),
                memeAudioButton(
                  buttonName: "Emotional Damage",
                  fileName: "emotional_damage",
                ),
                memeAudioButton(
                  buttonName: "System Faad Denge",
                  fileName: "system_faad_denge",
                ),
                memeAudioButton(
                  buttonName: "Amma Bhen pe aa Jaunga",
                  fileName: "amma_bhen",
                ),
                memeAudioButton(
                  buttonName: "Tum dono ki MKC",
                  fileName: "tum_dono_ki_mkc",
                ),
                memeAudioButton(
                  buttonName: "Chal Bosadike",
                  fileName: "chal_bhosadike",
                ),
                memeAudioButton(
                  buttonName: "Asambhav BC",
                  fileName: "asambhav",
                ),
                memeAudioButton(
                  buttonName: "Kuch Bhi?",
                  fileName: "kuch_bhi",
                ),
                memeAudioButton(
                  buttonName: "Ruko Zara",
                  fileName: "sabr",
                ),
                memeAudioButton(
                  buttonName: "Thoda Busy",
                  fileName: "thoda_busy",
                ),
                dualMemeButton(
                  buttonNames: ["Conjajulations", "Lottery"],
                  fileNames: ["conjajulation_brother", "abababa_lottery"],
                ),
                memeAudioButton(
                  buttonName: "Ab Bol Na MC",
                  fileName: "ab_bol_na_mc",
                ),
                memeAudioButton(
                  buttonName: "Aurat ka Chakkar",
                  fileName: "aurat_ka_chakkar",
                ),
                memeAudioButton(
                  buttonName: "R2H - BSDK",
                  fileName: "bhosssdike",
                ),
                memeAudioButton(
                  buttonName: "Macchar Ki Jhaat",
                  fileName: "bsdk_mc_macchar_ki_jhaat",
                ),
                memeAudioButton(
                  buttonName: "Bheek Maangne ka Tareeka",
                  fileName: "bheek_maange",
                ),
                memeAudioButton(
                  buttonName: "Koi Baat Nahi",
                  fileName: "koi_baat_nhi",
                ),
                memeAudioButton(
                  buttonName: "Paisa Barbaad BC",
                  fileName: "paisa_barbaad",
                ),
                memeAudioButton(
                  buttonName: "Doob Ke Mar Jaayenge",
                  fileName: "saale_doob_ke_mar_jayenge",
                ),
                memeAudioButton(
                  buttonName: "Ghus Jaao Meri Gaand Me",
                  fileName: "lakdi_gaand",
                ),
                memeAudioButton(
                  buttonName: "Chala Jaa BSDK",
                  fileName: "chala_jaa_bsdk",
                ),
                memeAudioButton(
                  buttonName: "Kya Scene Hai",
                  fileName: "kya_scene_hai",
                ),
                memeAudioButton(
                  buttonName: "Bhen Ke Lode",
                  fileName: "bhen_ke_lode",
                ),
                memeAudioButton(
                  buttonName: "Lavde na Bhojyam",
                  fileName: "lavde_na_bhojyam",
                ),
                memeAudioButton(
                  buttonName: "Hypocrisy Ki Seema",
                  fileName: "hypocrisy_ki_bhi_seema_hoti_hai",
                ),
                memeAudioButton(
                  buttonName: "Mahesh Dalle",
                  fileName: "mahesh_dalle",
                ),
                memeAudioButton(
                  buttonName: "ELvish Bhaai",
                  fileName: "elvish_bhai",
                ),
                memeAudioButton(
                  buttonName: "Kaise Kaise Log",
                  fileName: "kaise_kaise_log",
                ),
                memeAudioButton(
                  buttonName: "Maaro Mujhe",
                  fileName: "maaro_mujhe",
                ),
                memeAudioButton(
                  buttonName: "Has re Halkat",
                  fileName: "has_re_halkat",
                ),
                memeAudioButton(
                  buttonName: "Kya Gunda Banega Re Tu",
                  fileName: "kya_gunda",
                ),
                memeAudioButton(
                  buttonName: "Paisa Hi Paisa",
                  fileName: "paisa_hi_paisa",
                ),
                memeAudioButton(
                  buttonName: "Bade Harami Ho Beta",
                  fileName: "harami_ho_beta",
                ),
                memeAudioButton(
                  buttonName: "Maa Chod Di",
                  fileName: "maa_chod_di",
                ),
                memeAudioButton(
                  buttonName: "No Passion",
                  fileName: "no_passion",
                ),
                memeAudioButton(
                  buttonName: "Restaurant Jao na",
                  fileName: "restaurant_jaao_na_bc",
                ),
                memeAudioButton(
                  buttonName: "Aand Bhaat",
                  fileName: "aand_bhat",
                ),
                memeAudioButton(
                  buttonName: "Sharam Karo",
                  fileName: "sharam_dk",
                ),
                memeAudioButton(
                  buttonName: "Kya Re Bhikmangya?",
                  fileName: "bhikmangya",
                ),
                memeAudioButton(
                  buttonName: "Pagal Aurat",
                  fileName: "pagal_aurat",
                ),
                memeAudioButton(
                  buttonName: "Samajh Rahe Ho?",
                  fileName: "samajh_rahe_ho",
                ),
                memeAudioButton(
                  buttonName: "Kya Dekhna Padh Raha Hai",
                  fileName: "kya_dekhna",
                ),
                memeAudioButton(
                  buttonName: "B.Tech Anthem",
                  fileName: "mar_gaya_madarchod",
                ),
                moreComingButton(),
              ],
            );
          }),
        ),
      ),
      backgroundColor: const Color(0xffDDDDDD),
    );
  }

  Widget baseMemeAudioButton(
      {required String buttonName, required String fileName, int state = 0}) {
    if (state == 0) {
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
    } else {
      return TextButton(
        onPressed: () async {
          player.stop();
          setState(() {});
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
  }

  Widget memeAudioButton(
      {required String buttonName, required String fileName}) {
    return TextButton(
      onPressed: () async {
        await player.setAsset('assets/audio/$fileName.mp3');
        await player.setVolume(sqrt(10));
        await player.play();
        print("Hello");
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
