import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pipeline_demo/config/env.dart';
import 'package:flutter_pipeline_demo/firebase_options_dev.dart'
    as firebase_options;
import 'package:flutter_pipeline_demo/main.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebase_options.DefaultFirebaseOptions.currentPlatform,
  );
  Env.init(apiUrl: 'https://prod-api.example.com', flavorName: 'Production');
  app.main();
}
