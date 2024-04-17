import 'package:json_annotation/json_annotation.dart';
part 'content.g.dart';

@JsonSerializable()
class Content {
  String name;
  int age;
  DateTime lastSeen;
  int bounty;
  String description;
  List<String> imageUrls;

  Content({
    required this.name,
    required this.age,
    required this.lastSeen,
    required this.bounty,
    required this.description,
    required this.imageUrls,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
