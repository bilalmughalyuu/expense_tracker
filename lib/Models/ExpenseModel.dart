import 'dart:convert';

List<ExpenseModel> expenseModelFromJson(String str) => List<ExpenseModel>.from(
    json.decode(str).map((x) => ExpenseModel.fromJson(x)));

String expenseModelToJson(List<ExpenseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseModel {
  String? id;
  String? title;
  String? amount;
  String? category;
  DateTime? timeStamp;

  ExpenseModel({
    this.id,
    this.title,
    this.amount,
    this.category,
    this.timeStamp,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        category: json["category"],
        timeStamp: json["timeStamp"] == null
            ? null
            : DateTime.parse(json["timeStamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "category": category,
        "timeStamp": timeStamp?.toIso8601String(),
      };
}
