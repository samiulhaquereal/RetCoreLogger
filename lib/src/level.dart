class Tag implements Comparable<Tag> {

  final String name;
  final int value;

  const Tag(this.name, this.value);

  static const Tag all = Tag('all', 0);

  static const Tag off = Tag('off', 2000);

  static const Tag verbose = Tag('VERBOSE', 300);

  static const Tag debug = Tag('DEBUG', 500);

  static const Tag info = Tag('INFO', 800);

  static const Tag warning = Tag('WARNING', 900);

  static const Tag error = Tag('ERROR', 1000);

  static const List<Tag> levels = [
    all,
    verbose,
    debug,
    info,
    warning,
    error,
    off,
  ];

  @override
  bool operator ==(Object other) => other is Tag && value == other.value;

  bool operator <(Tag other) => value < other.value;

  bool operator <=(Tag other) => value <= other.value;

  bool operator >(Tag other) => value > other.value;

  bool operator >=(Tag other) => value >= other.value;

  @override
  int compareTo(Tag other) => value - other.value;

  @override
  int get hashCode => value;

  @override
  String toString() => name;
}
