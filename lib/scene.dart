// scene.dart
// Represents a single page/scene in the story.

class Scene {
  final String storyText;
  final String imagePath;
  final List<String> choices;
  final List<int> nextScenes;
  final bool isEnding;
  final String endingTitle;
  final String endingType; // 'good', 'bad', 'neutral', or ''

  Scene({
    required this.storyText,
    required this.imagePath,
    this.choices = const [],
    this.nextScenes = const [],
    this.isEnding = false,
    this.endingTitle = '',
    this.endingType = '',
  });
}
