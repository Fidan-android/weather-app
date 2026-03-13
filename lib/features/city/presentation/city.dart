import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/city/data/providers/city_data_provider.dart';
import 'package:weather_app/features/city/presentation/providers/city_provider.dart';
import 'package:weather_app/features/city/presentation/state/city_state.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cityControllerProvider.notifier).onInit();
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
    final cityState = ref.watch(cityControllerProvider);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildHeader(cityState),
          TextField(
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(hintText: "Введите город"),
            onChanged: ref.read(cityControllerProvider.notifier).onSearch,
          ),
          Expanded(child: _buildBody(cityState)),
        ],
      ),
    );
  }

  Widget _buildHeader(CityState cityState) {
    final selectedCity = ref.watch(selectedCityProvider);
    if (selectedCity != null) {
      return Text(
        "Selected city: ${selectedCity.name}",
        style: TextStyle(fontSize: 18),
      );
    }
    return Text("City", style: TextStyle(fontSize: 18));
  }

  Widget _buildBody(CityState cityState) {
    if (cityState is CityLoadingState) {
      return Center(child: CircularProgressIndicator());
    }
    if (cityState is CityErrorState) {
      return Center(child: Text(cityState.errorMessage));
    }
    if (cityState is CityDataState) {
      final cities = cityState.cities;
      return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
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
                  ref.read(cityControllerProvider.notifier).onRemoveCity(city);
                },
              ),
              onTap: () {
                ref.read(cityControllerProvider.notifier).onSelectCity(city);
                focusNode.unfocus();
                controller.clear();
              },
            );
          },
        ),
      );
    }
    return SizedBox.shrink();
  }
}
