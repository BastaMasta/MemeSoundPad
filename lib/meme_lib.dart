import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Meme {
  String name;
  String fileName;
  String searchParams;

  Meme(
      {required this.name, required this.fileName, required this.searchParams});
}

List<Meme> allMemeList = [
  Meme(
    name: "Aand Bhaat",
    fileName: "aand_bhat",
    searchParams:
        "deepak kalal dk aand bhaat lavda pav louda paav louda pav lavda paav lauda pav lauda paav",
  ),
  Meme(
    name: "Ab Bol Na MC",
    fileName: "ab_bol_na_mc",
    searchParams: "ab bol na madarchod mc baccha child",
  ),
  Meme(
    name: "Lottery",
    fileName: "abababa_lottery",
    searchParams: "abababa lottery lotry",
  ),
  Meme(
    name: "Asambhav BC",
    fileName: "asambhav",
    searchParams: "carryminati carry minati asambhav bc asambhav bhenchod",
  ),
  Meme(
    name: "Aurat Ka Chakkar",
    fileName: "aurat_ka_chakkar",
    searchParams: "hera pheri aurat ka chakkar babu bhaiya",
  ),
  Meme(
    name: "Bacche Teri...",
    fileName: "bacche_teri",
    searchParams:
        "carryminati carry minati bacche teri gaand maar dunga maa ki chut baccha child",
  ),
  Meme(
    name: "Bheek Maangne ka Tareeka",
    fileName: "bacche_teri",
    searchParams:
        "golmaal arshad waarsi ye bhi koi tareeka hua bheek maangne ka bheek maange ka tareeka",
  ),
  Meme(
    name: "Bhen Ke Lode",
    fileName: "bhen_ke_lode",
    searchParams:
        "modi behen ke lode behen ke laude behen ke loude behen ke lavde bhen ke lode bhen ke laude bhen ke loude bhen ke lavde bkl",
  ),
  Meme(
    name: "R2H - BSDK",
    fileName: "bhosssdike",
    searchParams: "round 2 hell desert dessert bhosadike bsdk",
  ),
  Meme(
    name: "Macchar Ki Jhaat",
    fileName: "bsdk_mc_macchar_ki_jhaat",
    searchParams:
        "roadies bhosadike madarchod behen ke loude macchar ki jhaat gaandu maa ki chut teri tatto ke soudagar bsdk mc bkl mkc",
  ),
  Meme(
    name: "Chal Bosadike",
    fileName: "chal_bhosadike",
    searchParams: "car chal bhosadike chal bsdk",
  ),
  Meme(
    name: "Chala Jaa BSDK",
    fileName: "chala_jaa_bsdk",
    searchParams: "old man chala jaa bhosadike chala jaa bsdk",
  ),
  Meme(
    name: "Conjajulations",
    fileName: "conjajulation_brother",
    searchParams: "conajajulations brother conajajulation congratulations",
  ),
  Meme(
    name: "Emotional Damage",
    fileName: "emotional_damage",
    searchParams: 'emotional damage steven he',
  ),
  Meme(
    name: "Bade Harami ho Beta",
    fileName: "harami_ho_beta",
    searchParams: 'bade harami ho beta',
  ),
  Meme(
    name: "Has Re Halkat",
    fileName: "has_re_halkat",
    searchParams: 'hera pheri baburao babu rao kya joke mara has re halkat',
  ),
  Meme(
    name: "Hum pe to Hai No",
    fileName: "hum_pe_to_hai_no",
    searchParams:
        "arpit bala hum pe to hai hi no hum pe to hai hi nahi hum pe to hai no",
  ),
  Meme(
    name: "Hypocrisy Ki Seema",
    fileName: "hypocrisy_ki_bhi_seema_hoti_hai",
    searchParams:
        "modi hypocrisy ki bhi seema hoti hai hypocrisy ki seema hoti hai",
  ),
  Meme(
    name: "Jaldi Waha se Hato",
    fileName: "jaldi_waha_se_hato",
    searchParams: 'jaldi waha se hato mai ke chodo mc',
  ),
  Meme(
    name: "kaise Kaise Log",
    fileName: "kaise_kaise_log",
    searchParams:
        'kaise kaise log rehte hai yaar kaise kaise log hote hai hai yaar kaise kaise log reh te hai yaar',
  ),
  Meme(
    name: "Koi Baat Nahi",
    fileName: "koi_baat_nhi",
    searchParams:
        'carryminati carry minati koi baat nahi hum to chutiye hai koi baat nhi hum to chutiye hai',
  ),
  Meme(
    name: "Kuch Bhi?",
    fileName: "kuch_bhi",
    searchParams: 'arnab goswami kuch bhi?',
  ),
  Meme(
    name: "Kya Dekhna Padh Raha Hai",
    fileName: "kya_dekhna",
    searchParams:
        'ye sab kya dekhna pad raha hai accha hai mai andha hu ye sab kya dekhna padh raha hai accha hai mai andha hu',
  ),
  Meme(
    name: "Kya Gunda Banega Re Tu",
    fileName: "kya_gunda",
    searchParams: "hera pheri baburao babu rao kya gunda banega re tu",
  ),
  Meme(
    name: "Kya Scene Hai",
    fileName: "kya_scene_hai",
    searchParams: "modi kya scene hai",
  ),
  Meme(
    name: "Ghus Jaao Meri Gaand Me",
    fileName: "lakdi_gaand",
    searchParams:
        "rabish kumar news reporter a lakdi kyu padi ho jaad me aaja ghus jaao meri gaand me",
  ),
  Meme(
    name: "Lavde na bhojyam",
    fileName: "lavde_na_bhojyam",
    searchParams: "modi lavde na bhojyam laude na bhojyam",
  ),
  Meme(
    name: "Maa Chod Di",
    fileName: "maa_chod_di",
    searchParams:
        "mirzapur bhaiyaji maa chod di aapne bhaiya ji maa chod di aapne",
  ),
  Meme(
    name: "Maaro Mujhe",
    fileName: "maaro_mujhe",
    searchParams: "pakistani are bhai maaro mujhe maro mujhe maaro",
  ),
  Meme(
    name: "Mahesh Dalle",
    fileName: "mahesh_dalle",
    searchParams: "mahesh dalle mamta interlude mamta's interlude",
  ),
  Meme(
    name: "B.Tech Anthem",
    fileName: "mar_gaya_madarchod",
    searchParams: 'btech anthem b.tech anthem mar gaya madarchod mar gaya mc',
  ),
  Meme(
    name: "No Passion",
    fileName: "no_passion",
    searchParams:
        'there is no passion no vision no agression no fucking mindset football club',
  ),
  Meme(
    name: "Notty Hora Ke",
    fileName: "notty_hora_ke_bkl",
    searchParams:
        'naughty hora ke notty hora ke nautty hora ke naughty hora kya notty hora kya nautty hora kya',
  ),
  Meme(
    name: "Pagal Aurat",
    fileName: "pagal_aurat",
    searchParams: "tmkoc jethalal pagar aurat",
  ),
  Meme(
    name: "Paisa Barbaad BC",
    fileName: "paisa_barbaad",
    searchParams:
        "carryminati carry minati paisa barbaad bhenchod paisa barbaad behenchod",
  ),
  Meme(
    name: "Paisa Hi Paise",
    fileName: "paisa_hi_paisa",
    searchParams: "hera pheri akshay kumaar paisa hi paisa hoga",
  ),
  Meme(
    name: "Restairant Jaao Na",
    fileName: "restaurant_jaao_na_bc",
    searchParams:
        "deepak kalal dk are bhosaike bhook lagi hai to restaurant me jaao na bhenchod restaurant jaao na bhenchod",
  ),
  Meme(
    name: "Rom Rom Bhaiyo",
    fileName: "rom_rom_bhaiyo",
    searchParams: "deepak kalal rom rom bhaiyo",
  ),
  Meme(
    name: "Doob Ke Mar Jaayenge",
    fileName: "saale_doob_ke_mar_jayenge",
    searchParams:
        "rabish kumar in baccho ke liye hum pedh paani aur ye glacier bacha rahe hai mai ti kehta hu glacier ko pighal jaane deeijye ye saale doob ke mar jaayenge",
  ),
  Meme(
    name: "Ruko Zara",
    fileName: "sabr",
    searchParams:
        "hindustani bhau hindustaani bhau ruko zara sabar karo bhau ruko jara sabar karo ruko zara sabr karo bhau ruko jara sabr karo",
  ),
  Meme(
    name: "Samajh Rahe Ho?",
    fileName: "samajh_rahe_ho",
    searchParams: "harsh beniwal samajh rahe ho samaj rahe ho",
  ),
  Meme(
    name: "Sharam karo",
    fileName: "sharam_dk",
    searchParams:
        "deepak kalal dk sharam karo bhagwaan se daro bhosadi walo sharam karo bhagwan se daro bhosadi walo sharam karo bhagwaan se daro bhosdi walo sharam karo bhagwan se daro bhosdi walo",
  ),
  Meme(
    name: "System Faad Denge",
    fileName: "system_faad_denge",
    searchParams: "deepak kalal system faad denge",
  ),
  Meme(
    name: "Tapa-Tap",
    fileName: "tapa_tap",
    searchParams: 'hindustani bhau hindustaani bhau tapatap tapa-tap tapa tap',
  ),
  Meme(
    name: "Thoda Busy",
    fileName: "thoda_busy",
    searchParams:
        'hindustani bhau hindustaani bhau thoda mai kaam me asia busy ho gaya tha na thoda mai aisa kaam me busy ho gaya thana',
  ),
];

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(5),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/pepe.png'),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Meme SoundPad',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(offset: Offset(2.0, 3.0), color: Colors.grey),
                      Shadow(offset: Offset(2.0, 4.0))
                    ]),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.grey[100],
            ),
            child: ListTile(
              leading: const Icon(Icons.rocket_launch),
              title: const Text('Developer Page'),
              onTap: () => {
                launchUrl(Uri.parse("https://bastamasta.dev")),
                Navigator.of(context).pop()
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('Feedback'),
            onTap: () => {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text("Feedback form not ready yet!"),
                ),
              ),
              Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_power_rounded),
            title: const Text('Exit App'),
            onTap: () => {
              Navigator.of(context).pop(),
              if (Platform.isAndroid)
                {
                  SystemChannels.platform
                      .invokeMethod<void>('SystemNavigator.pop', true)
                }
              else if (Platform.isIOS)
                {}
            },
          ),
        ],
      ),
    );
  }
}
