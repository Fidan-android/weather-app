import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForecastScreen extends ConsumerWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, index) {
          return _forecastBlock();
        },
      ),
    );
  }

  Widget _forecastBlock() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: BoxBorder.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            Icon(Icons.sunny, color: Colors.yellow),
            Text("мин/макс температура"),
            Text("Описание"),
          ],
        ),
      ),
    );
  }
}
