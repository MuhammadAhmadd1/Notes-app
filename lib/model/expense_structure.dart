import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();


class ExpenseStructure {
  ExpenseStructure({
    required this.title,
    required this.description,
    required this.date,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final String description;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }
}
