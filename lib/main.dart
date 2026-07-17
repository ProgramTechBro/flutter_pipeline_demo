import 'package:flutter/material.dart';
import 'package:flutter_pipeline_demo/config/env.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget of the application.
class MyApp extends StatefulWidget {
  /// Creates the root app widget.
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDark ? ThemeData.dark() : ThemeData.light(),
      home: CounterPage(onToggleTheme: _toggleTheme),
    );
  }
}

/// Displays the counter UI along with environment info.
class CounterPage extends StatefulWidget {
  /// Creates the counter page.
  const CounterPage({required this.onToggleTheme, super.key});

  /// Callback invoked when the theme toggle button is pressed.
  final VoidCallback onToggleTheme;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _increment() {
    setState(() => _count++);
  }

  void _reset() {
    setState(() => _count = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Env.flavorName),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Environment: ${Env.flavorName}'),
            Text('API URL: ${Env.apiUrl}'),
            const SizedBox(height: 20),
            Text('Count: $_count', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: _reset,
            backgroundColor: Colors.red,
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: _increment,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'config/env.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text(Env.flavorName)),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Environment: ${Env.flavorName}'),
//               Text('API URL: ${Env.apiUrl}'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
