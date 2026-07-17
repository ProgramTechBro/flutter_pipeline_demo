import 'package:flutter/material.dart';
import 'package:flutter_pipeline_demo/config/env.dart';
import 'package:flutter_pipeline_demo/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    Env.init(apiUrl: 'https://test-api.example.com', flavorName: 'Test');
  });

  testWidgets('Counter starts at 0 and increments on tap', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Count: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Count: 1'), findsOneWidget);
  });

  testWidgets('Reset button sets counter back to 0', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Count: 2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    expect(find.text('Count: 0'), findsOneWidget);
  });

  testWidgets('Theme toggle button exists and is tappable', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byIcon(Icons.brightness_6), findsOneWidget);

    await tester.tap(find.byIcon(Icons.brightness_6));
    await tester.pump();

    expect(find.byIcon(Icons.brightness_6), findsOneWidget);
  });
}
