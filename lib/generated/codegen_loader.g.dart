// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "get_started": "Get started",
  "onboarding_screen": {
    "first_page": {
      "title": "Welcome to SignSyncAI",
      "microcopy": "Discover a new way of learning and communicating with AI-driven app that is designed for students with hearing and speech impairments."
    },
    "second_page": {
      "title": "Empower Your Learning Journey!",
      "microcopy": "Enjoy features like AR barcode scanning, speech-to-text, and AI conversation summaries."
    }
  }
};
static const Map<String,dynamic> id = {
  "get_started": "Mulai sekarang",
  "onboarding_screen": {
    "first_page": {
      "title": "Selamat Datang di SignSyncAI",
      "microcopy": "Temukan cara baru dalam belajar dan berkomunikasi dengan teknologi AI yang dirancang untuk siswa dengan keterbatasan pendengaran dan bicara."
    },
    "second_page": {
      "title": "Tingkatkan Perjalanan Belajar Kamu!",
      "microcopy": "Nikmati fitur-fitur seperti pemindaian barcode AR, speech-to-text, dan ringkasan chat dengan AI."
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "id": id};
}
