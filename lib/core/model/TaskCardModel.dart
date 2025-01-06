// To parse this JSON data, do
//
//     final taskCardModel = taskCardModelFromJson(jsonString);

import 'dart:convert';

List<TaskCardModel> taskCardModelFromJson(String str) => List<TaskCardModel>.from(json.decode(str).map((x) => TaskCardModel.fromJson(x)));

String taskCardModelToJson(List<TaskCardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskCardModel {
    int? id;
    String? title;
    String? description;
    String? type;
    String? status;
    DateTime? duedate;

    TaskCardModel({
        this.id,
        this.title,
        this.description,
        this.type,
        this.status,
        this.duedate,
    });

    factory TaskCardModel.fromJson(Map<String, dynamic> json) => TaskCardModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        status: json["status"],
        duedate: json["duedate"] == null ? null : DateTime.parse(json["duedate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "type": type,
        "status": status,
        "duedate": duedate?.toIso8601String(),
    };
}
