import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';

final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

GenerativeModel ai() {
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
    location: 'asia-southeast1',
    auth: auth,
  ).generativeModel(
    model: "gemini-1.5-flash",
    generationConfig: generationConfig,
    safetySettings: safetySettings,
    systemInstruction: Content.system(systemPrompt),
  );
}
