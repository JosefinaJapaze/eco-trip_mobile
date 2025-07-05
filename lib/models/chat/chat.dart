
class ChatData {
  int? driverId;
  String? driverName;
  List<ChatParticipant>? participants;

  ChatData({
    this.driverId,
    this.driverName,
    this.participants,
  });

  factory ChatData.fromMap(Map<String, dynamic> json) => ChatData(
    driverId: json["driver_id"],
    driverName: json["driver_name"],
    participants: json["participants"] != null 
        ? (json["participants"] as List<dynamic>).map((e) => ChatParticipant.fromMap(e)).toList()
        : null,
  );

  Map<String, dynamic> toMap() => {
    "driver_id": driverId,
    "driver_name": driverName,
    "participants": participants?.map((e) => e.toMap()).toList(),
  };
}

class ChatParticipant {
  int? id;
  String? name;

  ChatParticipant({
    this.id,
    this.name,
  });

  factory ChatParticipant.fromMap(Map<String, dynamic> json) => ChatParticipant(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}

class Chat {
  int? id;
  int? tripId;
  ChatData? chatData;
  String? lastMessage;
  DateTime? lastMessageTime;

  Chat({
    this.id,
    this.tripId,
    this.chatData,
    this.lastMessage,
    this.lastMessageTime
  });

  factory Chat.fromMap(Map<String, dynamic> json) => Chat(
    id: json["id"],
    tripId: json["trip_id"],
    chatData: ChatData.fromMap(json["data"]),
    lastMessage: json["last_message"],
    lastMessageTime: json["last_message_time"] != null 
        ? DateTime.parse(json["last_message_time"]) 
        : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "trip_id": tripId,
    "data": chatData?.toMap(),
    "last_message": lastMessage,
    "last_message_time": lastMessageTime?.toIso8601String(),
  };
} 