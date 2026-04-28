import "package:flutter/material.dart";
import "package:audioplayers/audioplayers.dart";
import "story_brain.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Isang Araw Bilang Freshman",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E)),
        useMaterial3: true,
      ),
      home: const StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final StoryBrain _storyBrain = StoryBrain();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // --- Colours ---
  static const Color kPrimary    = Color(0xFF1A237E); // deep navy
  static const Color kAccent     = Color(0xFF1565C0); // medium blue
  static const Color kBackground = Color(0xFFF0F2FB); // soft off-white blue
  static const Color kCardBg     = Colors.white;
  static const Color kTextDark   = Color(0xFF1A1A2E);

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound(String fileName) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource("audio/$fileName"));
    } catch (_) {}
  }

  Future<void> _makeChoice(int choiceIndex) async {
    await _playSound("click.mp3");
    setState(() {
      _storyBrain.nextScene(choiceIndex);
    });
    if (_storyBrain.isGameOver()) {
      final String type = _storyBrain.getEndingType();
      if (type == "good") {
        await _playSound("success.mp3");
      } else if (type == "bad") {
        await _playSound("fail.mp3");
      } else {
        await _playSound("neutral.mp3");
      }
      await Future.delayed(const Duration(milliseconds: 350));
      if (mounted) _showEndingDialog();
    }
  }

  void _showEndingDialog() {
    final String type  = _storyBrain.getEndingType();
    final String title = _storyBrain.getEndingTitle();
    String message;
    Color  headerColor;
    IconData headerIcon;

    switch (type) {
      case "good":
        message =
            "Congratulations, Alex!\n\n"
            "Natapos mo ang unang araw mo nang may tagumpay! "
            "Nagkaroon ka ng bagong kaibigan, sumali sa org, at "
            "nagawa pa ang homework. Handa ka na para bukas!";
        headerColor = const Color(0xFF2E7D32);
        headerIcon  = Icons.star_rounded;
        break;
      case "bad":
        message =
            "Ay nako, Alex!\n\n"
            "Medyo mahirap ang unang araw mo. Pero huwag mawalan ng "
            "pag-asa - bukas ay isang bagong pagkakataon. "
            "Kayang-kaya mo!";
        headerColor = const Color(0xFFC62828);
        headerIcon  = Icons.sentiment_dissatisfied_rounded;
        break;
      default:
        message =
            "Okay naman, Alex!\n\n"
            "Hindi masyadong exciting, pero hindi rin stressful. "
            "Nakarating ka sa lahat ng klase at uwi kang ligtas. "
            "One step at a time, freshy!";
        headerColor = const Color(0xFF0277BD);
        headerIcon  = Icons.sentiment_neutral_rounded;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: headerColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                child: Column(
                  children: [
                    Icon(headerIcon, color: Colors.white, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              // Body
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.65,
                    color: Color(0xFF333355),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Restart button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.replay_rounded, size: 20),
                    label: const Text(
                      "Maglaro Ulit",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: headerColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      setState(() {
                        _storyBrain.restart();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Choice button widget ──────────────────────────────────
  Widget _buildChoiceButton(String label, String text, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Label badge
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Choice text
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> choices = _storyBrain.getChoices();
    final labels = ["A", "B", "C", "D"];
    final btnColors = [kPrimary, kAccent, const Color(0xFF1B5E20), const Color(0xFF4A148C)];

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Isang Araw Bilang Freshman",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── Scene Image ──────────────────────────────────
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    _storyBrain.getImagePath(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1A237E), Color(0xFF42A5F5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Icon(Icons.school_rounded, size: 80, color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Story Text Card ──────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Card(
                  color: kCardBg,
                  elevation: 3,
                  shadowColor: Colors.indigo.withAlpha(60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                    child: SingleChildScrollView(
                      child: Text(
                        _storyBrain.getStoryText(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.7,
                          color: kTextDark,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Choice Buttons or Ending label ────────────────
            if (!_storyBrain.isGameOver())
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < choices.length; i++) ...[
                      _buildChoiceButton(
                        labels[i],
                        choices[i],
                        btnColors[i % btnColors.length],
                        () => _makeChoice(i),
                      ),
                      if (i < choices.length - 1) const SizedBox(height: 10),
                    ],
                  ],
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 0, 14, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty, color: Colors.grey, size: 16),
                    SizedBox(width: 6),
                    Text(
                      "Katapusan ng kwento...",
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
