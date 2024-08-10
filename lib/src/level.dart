class Level implements Comparable<Level> {

  final String name;
  final int value;

  const Level(this.name, this.value);

  static const Level all = Level('all', 0);

  static const Level off = Level('off', 2000);

  static const Level verbose = Level('VERBOSE', 300);

  static const Level debug = Level('DEBUG', 500);

  static const Level info = Level('INFO', 800);

  static const Level warning = Level('WARNING', 900);

  static const Level error = Level('ERROR', 1000);

  static const List<Level> levels = [
    all,
    verbose,
    debug,
    info,
    warning,
    error,
    off,
  ];

  @override
  bool operator ==(Object other) => other is Level && value == other.value;

  bool operator <(Level other) => value < other.value;

  bool operator <=(Level other) => value <= other.value;

  bool operator >(Level other) => value > other.value;

  bool operator >=(Level other) => value >= other.value;

  @override
  int compareTo(Level other) => value - other.value;

  @override
  int get hashCode => value;

  @override
  String toString() => name;
}
