enum Units {
  standard("standard"), // Кельвин
  metric("metric"), // Цельсия
  imperial("imperial"); // Фаренгейт

  const Units(this.type);

  final String type;
}
