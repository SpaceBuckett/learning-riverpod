import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigator/root/root_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

final pageIndicator = StateNotifierProvider((ref) {
  return UpdatePage();
});

class UpdatePage extends StateNotifier<int> {
  UpdatePage() : super(0);

  void updatePage(int pageNumber) {
    state = pageNumber;
  }
}
