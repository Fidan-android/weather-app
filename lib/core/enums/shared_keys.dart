enum SharedKeys {
  selectedCity("selected_city", String),
  selectedUnit("selected_unit", String),
  history("history_city", List<String>);

  const SharedKeys(this.key, this.type);

  final String key;
  final Type type;
}
