extension StringExtension on String? {
  bool isNotNullOrEmpty() => this != null && this!.isNotEmpty;
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension IntExtension on int? {
  bool isNotNull() => this != null;
  bool isNull() => this == null;
}

extension ListExtension<T> on List<T>? {
  bool isNotNullOrEmpty() => this != null && this!.isNotEmpty;
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension MapExtension<K, V> on Map<K, V>? {
  bool isNotNullOrEmpty() => this != null && this!.isNotEmpty;
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
