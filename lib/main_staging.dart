import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'firebase_options_dev.dart' as firebase_options;
import 'config/env.dart';
import 'main.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebase_options.DefaultFirebaseOptions.currentPlatform);
  Env.init(apiUrl: 'https://staging-api.example.com', flavorName: 'Staging');
  app.main();
}