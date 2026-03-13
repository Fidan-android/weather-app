enum SharedKeys {
  selectedCity("selected_city", String),
  history("history_city", List<String>);

  const SharedKeys(this.key, this.type);

  final String key;
  final Type type;
}
