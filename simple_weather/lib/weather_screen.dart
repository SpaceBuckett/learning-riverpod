import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_weather/main.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Indicator'),
      ),
      body: Column(
        children: [
          currentWeather.when(
              error: (_, __) => const Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
              loading: () => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
              data: (data) => Text(
                    data,
                    style: const TextStyle(fontSize: 30),
                  )),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (BuildContext context, int index) {
                final city = City.values[index];
                final isSelected = city == ref.watch(cityProvider);
                return ListTile(
                  title: Text(city.name),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () {
                    ref
                        .read(
                          cityProvider.notifier,
                        )
                        .state = city;
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
