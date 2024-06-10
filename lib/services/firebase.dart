import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase.g.dart';

@riverpod
FirebaseAuth auth(AuthRef ref) {
  return FirebaseAuth.instanceFor(app: Firebase.app());
}

@riverpod
FirebaseFirestore db(DbRef ref) {
  return FirebaseFirestore.instanceFor(app: Firebase.app());
}

@riverpod
GenerativeModel ai(AiRef ref) {
  const systemPrompt = """
You are a helpful multilingual assistant that understand English and Bahasa Indonesia.

Your duty is to summarize conversations between lecturer and students.
You should be able to summarize based on conversations dominant language.
You can response as effective as possible while keeping the summarization simple.
""";

  final generationConfig = GenerationConfig(
    maxOutputTokens: 512,
    temperature: 0.7,
    topP: 0.4,
    topK: 32,
  );

  final safetySettings = [
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
  ];

  return FirebaseVertexAI.instanceFor(
    app: Firebase.app(),
    location: 'asia-southeast1',
    auth: ref.watch(authProvider),
  ).generativeModel(
    model: "gemini-1.5-flash",
    generationConfig: generationConfig,
    safetySettings: safetySettings,
    systemInstruction: Content.system(systemPrompt),
  );
}
