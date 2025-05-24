class HistoryItem
{
  final int? id;
  final String? title;
  final String? type;
  final String? data;
  final String? category;
  final DateTime? date;

  HistoryItem({this.id, this.title, this.type, this.data, this.category, this.date});

  factory HistoryItem.fromMap(Map data)
  {
    return HistoryItem(
      id: data['id'],
      title: data['title'],
      type: data['type'],
      data: data['data'],
      category: data['category'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date'])
    );
  }
}