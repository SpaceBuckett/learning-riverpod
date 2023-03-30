import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_weather/weather_screen.dart';

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
      home: const WeatherScreen(),
    );
  }
}

enum City {
  london,
  newyork,
  warsaw,
}

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.london: '❄',
      City.newyork: '☁',
      City.warsaw: '🌤',
    }[city]!,
  );
}

final cityProvider = StateProvider<City?>(
  (ref) => null,
);

final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(cityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return '🙊';
  }
});

// final pageIndicator = StateNotifierProvider((ref) {
//   return UpdatePage();
// });

// class UpdatePage extends StateNotifier<int> {
//   UpdatePage() : super(0);

//   void updatePage(int pageNumber) {
//     state = pageNumber;
//   }
// }
