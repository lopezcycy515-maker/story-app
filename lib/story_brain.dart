// story_brain.dart
// Manages all scenes and story logic.

import 'scene.dart';

class StoryBrain {
  // Private: current scene index
  int _currentScene = 0;

  // Private: all scenes in the story
  final List<Scene> _scenes = [
    // ─────────────────────────────────────────
    // SCENE 0 – Morning: Wake Up Decision
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Umaga ng Agosto. Ikaw si Alex, isang bagong college freshman sa '
          'Pamantasan ng Lungsod ng Maynila.\n\n'
          'Tumutugtog ang alarm mo ng 5:30 AM. Kinakabahan ka pero excited na excited! '
          'Ito na — ang iyong unang araw bilang college student.\n\n'
          'Ano ang gagawin mo?',
      imagePath: 'assets/images/campus.jpg',
      choices: [
        '🌅  Bumangon agad at maghanda nang maaga',
        '😴  Pindotin ang snooze... sandali lang...',
      ],
      nextScenes: [1, 2],
    ),

    // ─────────────────────────────────────────
    // SCENE 1 – Arrived Early (Good Path Start)
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Galing! Bumangon ka agad, naligo, at kumain ng almusal.\n\n'
          'Nakarating ka sa campus nang 7:30 AM — maaga pa! Sa may entrance, '
          'nakita mo ang malaking tarpaulin:\n\n'
          '"FRESHMAN ORIENTATION — Bulwagang Kalayaan, 8:00 AM"\n\n'
          'May hawak ka ring campus map. Ano ang gagawin mo?',
      imagePath: 'assets/images/orientation.jpg',
      choices: [
        '🎓  Pumunta sa Freshman Orientation',
        '🗺️  Libutin muna ang campus at hanapin ang klase',
      ],
      nextScenes: [3, 4],
    ),

    // ─────────────────────────────────────────
    // SCENE 2 – Running Late (Risky Path)
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Ay sus! Tatlong beses mong pinindot ang snooze. 7:45 AM na — late ka na!\n\n'
          'Nagmamadaling nagbihis at lumabas ng bahay. Sa daan, nakita mo ang '
          'isang karinderya na may mainit na tapsilog at lugaw.\n\n'
          'Kumakalam ang tiyan mo pero naghihintay ang klase...',
      imagePath: 'assets/images/campus.jpg',
      choices: [
        '🏃  Tumalon na sa jeep — basta makarating sa klase!',
        '🍳  Kumain muna — gutom na gutom talaga ako',
      ],
      nextScenes: [5, 6],
    ),

    // ─────────────────────────────────────────
    // SCENE 3 – Orientation: Social Moment
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Ang orientation ay puno ng mga kapwa freshmen na parang kinakabahan din!\n\n'
          'Nakakatuwa — para kang hindi nag-iisa. Umupo ka at sa tabi mo ay '
          'isang batang babae na ngumingiti — si Maya.\n\n'
          '"First day mo rin?" tanong niya.',
      imagePath: 'assets/images/orientation.jpg',
      choices: [
        '💬  "Oo! Ikaw din? Ako si Alex!" — Makipag-usap kay Maya',
        '📝  Ngumiti lang at mag-focus sa orientation',
      ],
      nextScenes: [7, 8],
    ),

    // ─────────────────────────────────────────
    // SCENE 4 – Exploring Campus, Found Classroom
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Naglibot ka sa campus — ay grabe, malaki at maganda pala ito!\n\n'
          'May fountain, mga puno, at maraming estudyante. Nahanap mo ang iyong '
          'silid-aralan bago pa mag-umpisa ang klase.\n\n'
          'Unti-unting pumasok ang mga estudyante. Nasa pintuan ka pa lang at '
          'naghahanap ng upuan. Saan ka uupo?',
      imagePath: 'assets/images/classroom.jpg',
      choices: [
        '✏️  Umupo sa harap — para mas matuto at aktibo',
        '🎒  Umupo sa likod — para mas relaxed',
      ],
      nextScenes: [7, 8],
    ),

    // ─────────────────────────────────────────
    // SCENE 5 – Barely Made It to Class
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Hinga! Nakarating ka sa klase nang halos oras na — 8:01 AM. Close call!\n\n'
          'Maganda naman ang unang klase kahit medyo kinakabahan ka pa. '
          'Nang mag-tanghali, kumakalam na ang tiyan mo at puno ng estudyante ang pasilyo.\n\n'
          'Ano ang gagawin mo para sa tanghalian?',
      imagePath: 'assets/images/classroom.jpg',
      choices: [
        '🍚  Pumunta sa canteen at kumain kasama ang iba',
        '📖  Manatili sa classroom at mag-review ng notes',
      ],
      nextScenes: [9, 8],
    ),

    // ─────────────────────────────────────────
    // SCENE 6 – Late Arrival After Breakfast
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Kinain mo ang tapsilog — masarap nga! Pero nang makarating ka sa klase, '
          '8:20 na.\n\n'
          'Bukas ang pintuan at ang lahat ay nakatingin sa iyo, kasama ang propesor '
          'na seryosong nakatayo.\n\n'
          '"Estudyante, late ka."\n\n'
          'Namula ka. Ano ang gagawin mo?',
      imagePath: 'assets/images/classroom.jpg',
      choices: [
        '😔  Humingi ng pasensya nang tahimik at umupo',
        '😅  Mag-explain at gumawa ng dahilan',
      ],
      nextScenes: [8, 10],
    ),

    // ─────────────────────────────────────────
    // SCENE 7 – Made Friends! Org Fair
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Wow, ang saya! Nagkaroon ka ng bagong kaibigan at aktibo ka sa buong araw ng klase.\n\n'
          'Pagkatapos ng huling klase, may malaking event sa labas — ang ORG FAIR! '
          'Maraming organizations ang nag-iimbitahan. '
          'Kasama mo si Maya at ang mga bago mong kakilala.\n\n'
          '"Sumali ka!" sabi ni Maya na excited.',
      imagePath: 'assets/images/orgfair.jpg',
      choices: [
        '🙋  Sumali sa isang organization!',
        '🏠  Uwi na — pagod na pero masaya ang araw',
      ],
      nextScenes: [11, 12],
    ),

    // ─────────────────────────────────────────
    // SCENE 8 – Quiet Day, Back Home
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Natapos ang araw. Hindi naman masama — normal lang.\n\n'
          'Nakarating ka sa lahat ng klase at nakikinig ka naman. '
          'Uwi ka na at sa bahay, may notebook ka puno ng assignments at '
          'readings para bukas.\n\n'
          'Ano ang gagawin mo ngayon?',
      imagePath: 'assets/images/homework.jpg',
      choices: [
        '📚  Gawin agad ang homework — maaga pa naman',
        '📱  Pahinga muna at manood ng TikTok... gagawin ko bukas yon',
      ],
      nextScenes: [12, 10],
    ),

    // ─────────────────────────────────────────
    // SCENE 9 – Canteen: Social Lunch
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Masayang tanghalian! Nakaupo ka sa isang mesa at nakikinig sa kwento ng '
          'mga bagong kakilala.\n\n'
          'Nagtawanan kayo at nagpalitan ng numbers. Nag-bonding kayo tungkol sa '
          'mga klase at sa campus life.\n\n'
          'Pagkatapos ng klase, dumaan kayo sa ORG FAIR. Maraming booths na '
          'nag-iimbitahan. Ano ang gagawin mo?',
      imagePath: 'assets/images/canteen.jpg',
      choices: [
        '🤝  Sumali sa isang organization kasama ang mga bago mong kaibigan!',
        '😴  Uwi na, pagod na ako — pero masaya naman ang araw',
      ],
      nextScenes: [11, 12],
    ),

    // ─────────────────────────────────────────
    // SCENE 10 – BAD ENDING
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Ay nako...\n\n'
          'Hindi naging maganda ang unang araw. Naistress ka, late ka, hindi ka '
          'handa, at pagod na pagod ka. Sa bahay, nakahiga ka nang walang nagawa.\n\n'
          'Maraming assignments ang nakabimbin, at hindi ka sigurado kung '
          'kaaya-aya ba ang kolehiyo para sa iyo.\n\n'
          'Pero huwag mawalan ng pag-asa...\n'
          'Bukas ay isang bagong simula. 💪',
      imagePath: 'assets/images/ending_bad.jpg',
      isEnding: true,
      endingTitle: '😔  Napakahirap na Unang Araw',
      endingType: 'bad',
    ),

    // ─────────────────────────────────────────
    // SCENE 11 – GOOD ENDING
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'AMAZING! 🎉\n\n'
          'Ang unang araw mo bilang freshman ay isang tunay na tagumpay!\n\n'
          'Nagkaroon ka ng bagong kaibigan si Maya at ang grupo nila, '
          'nag-sign up ka sa isang organization, aktibo ka sa klase, at '
          'masaya ka na masaya.\n\n'
          'Pagdating sa bahay, maaga mong ginawa ang homework.\n\n'
          '"Crush na crush ko ang kolehiyo!" — isip mo habang humihimbing. 🌟',
      imagePath: 'assets/images/ending_good.jpg',
      isEnding: true,
      endingTitle: '🌟  Magandang Unang Araw!',
      endingType: 'good',
    ),

    // ─────────────────────────────────────────
    // SCENE 12 – NEUTRAL ENDING
    // ─────────────────────────────────────────
    Scene(
      storyText:
          'Natapos ang iyong unang araw bilang freshman.\n\n'
          'Hindi masyadong exciting, hindi rin masyadong stressful — okay lang.\n\n'
          'Nakapagturo ka at umuwi nang ligtas. '
          'Baka bukas ay mas maraming magandang mangyayari.\n\n'
          'One day at a time, freshy! 😊',
      imagePath: 'assets/images/ending_neutral.jpg',
      isEnding: true,
      endingTitle: '😊  Okay Naman ang Unang Araw',
      endingType: 'neutral',
    ),
  ];

  // ─────────────────────────────────────────
  // PUBLIC METHODS
  // ─────────────────────────────────────────

  /// Returns the story text of the current scene.
  String getStoryText() => _scenes[_currentScene].storyText;

  /// Returns the image path of the current scene.
  String getImagePath() => _scenes[_currentScene].imagePath;

  /// Returns the list of choice labels for the current scene.
  List<String> getChoices() => _scenes[_currentScene].choices;

  /// Advances to the next scene based on the choice made.
  void nextScene(int choiceIndex) {
    _currentScene = _scenes[_currentScene].nextScenes[choiceIndex];
  }

  /// Returns true if the current scene is an ending.
  bool isGameOver() => _scenes[_currentScene].isEnding;

  /// Returns the ending title of the current scene.
  String getEndingTitle() => _scenes[_currentScene].endingTitle;

  /// Returns the ending type: 'good', 'bad', 'neutral', or ''.
  String getEndingType() => _scenes[_currentScene].endingType;

  /// Resets the story back to the beginning.
  void restart() => _currentScene = 0;
}
