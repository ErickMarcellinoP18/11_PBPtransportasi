import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  FlutterTts flutterTts = FlutterTts();
  double volume = 2.0;
  double pitch = 1.0;
  double speechRate = 0.7;
  List<String>? languages;
  String langCode = "ID";

  List<String> textList = [
    'aplikasinya biasa aja',
    'yagitudeh',
    'aplikasi nya sangat bagus',
    'ini tes aja sih',
    // Tambahkan teks lain jika diperlukan
  ];

  String currentlyPlayingText = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    languages = List.from(await flutterTts.getLanguages);
    setState(() {});
  }

  void initSetting() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    speechRate = 0.5; // Atur sesuai dengan kecepatan yang diinginkan
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setLanguage(langCode);
  }

  void _speak(String textSpeak) async {
    initSetting();
    await flutterTts.speak(textSpeak);
  }

  void _stop() async {
    await flutterTts.stop();
    currentlyPlayingText = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text To Speech"),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: textList.length,
          itemBuilder: (context, index) {
            String text = textList[index];
            return Card(
              margin: EdgeInsets.all(8), // Jarak antara setiap Card
              child: ListTile(
                title: Row(
                  children: [
                    const SizedBox(width: 8),
                    Text("75% "),
                    Text(text),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (currentlyPlayingText == text) {
                          _stop();
                        } else {
                          _speak(text);
                          currentlyPlayingText = text;
                        }
                      },
                      child: Icon(
                        Icons.speaker_notes_outlined,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
