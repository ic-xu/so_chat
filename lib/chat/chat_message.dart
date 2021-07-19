
import 'dart:convert' show json;


class ChatMessage {
  late String message;
  late int type;
  late int direction;
  late String toOrFromUserId;

  ChatMessage(this.message, this.type, this.direction, this.toOrFromUserId);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  static ChatMessage fromMap(Map<String, dynamic> json) {
    return new ChatMessage(json["message"], json["type"], json["direction"],
        json["toOrFromUserId"]);
  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map["message"] = this.message;
    map["type"] = this.type;
    map["direction"] = this.direction;
    map["toOrFromUserId"] = this.toOrFromUserId;
    return map;
  }

  static ChatMessage fromJson(String message) {
    return fromMap(json.decoder.convert(message));
  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  String toJson() {
    return json.encode(toMap());
  }
  
}
