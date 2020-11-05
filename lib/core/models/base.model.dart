import 'dart:convert';

final encoder = JsonEncoder.withIndent('\t');

abstract class Model<IdType> {
  IdType id;

  Model({this.id});
  Model.fromJson(Map<String, dynamic> json) : id = json["id"];

  Map<String, dynamic> toJson() => {"id": id};

  String toString() => '${this.runtimeType} ${encoder.convert(this.toJson())}';
}
