import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/city/presentation/providers/city_provider.dart';

class CityScreen extends ConsumerStatefulWidget {
  const CityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CityScreenState();
}

class _CityScreenState extends ConsumerState<CityScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        ref.read(cityControllerProvider.notifier).onSearch(controller.text);
      } else {
        ref.read(cityControllerProvider.notifier).onClearSearch();
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cities = ref.watch(cityControllerProvider);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text("City", style: TextStyle(fontSize: 18)),
          TextField(
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(hintText: "Введите город"),
            onChanged: ref.read(cityControllerProvider.notifier).onSearch,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (ctx, index) {
                final city = cities[index];
                return ListTile(
                  title: Text(
                    city.name,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  trailing: GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () {
                      ref
                          .read(cityControllerProvider.notifier)
                          .onRemoveCity(city);
                    },
                  ),
                  onTap: () {
                    ref
                        .read(cityControllerProvider.notifier)
                        .onSelectCity(city);
                    controller.clear();
                    if (mounted) {
                      context.go("weather");
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
