class Paging<T> {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  Paging({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory Paging.fromJson(Map<String, dynamic> json, Function fromJsonModel) {
    final items = json['results'].cast<Map<String, dynamic>>();
    return Paging<T>(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: new List<T>.from(
        items.map((itemsJson) => fromJsonModel(itemsJson)),
      ),
    );
  }
}
