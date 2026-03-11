import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CityScreen extends ConsumerWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text("City"),
          TextField(decoration: InputDecoration(label: Text("Введите город"))),
        ],
      ),
    );
  }
}
