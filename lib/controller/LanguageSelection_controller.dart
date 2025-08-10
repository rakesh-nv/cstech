import 'package:get/get.dart';

class LanguageSelectionController extends GetxController {
  var setLanguage = 'English'.obs;

  final List<Map<String, String>> languages = [
    {'name': 'English', 'subtitle': 'Hi'},
    {'name': 'Hindi', 'subtitle': 'नमस्ते'},
    {'name': 'Bengali', 'subtitle': 'হ্যালো'},
    {'name': 'Kannada', 'subtitle': 'ನಮಸ್ಕಾರ'},
    {'name': 'Punjabi', 'subtitle': 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ'},
    {'name': 'Tamil', 'subtitle': 'வணக்கம்'},
    {'name': 'Telugu', 'subtitle': 'హలో'},
    {'name': 'French', 'subtitle': 'Bonjour'},
    {'name': 'Spanish', 'subtitle': 'Hola'},
  ];

  void getLanguage(String? lang) {
    setLanguage.value = lang ?? 'English';
  }
}
