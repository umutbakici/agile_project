import 'dart:typed_data';

class Room {
  String roomID;
  int guestScore;
  int hostScore;
  String gameStatus;
  String category;
  List<dynamic> players;
  int createdAt;
  List<dynamic> questionIds;

  Map<String, dynamic> toMap() {
    return {
      "roomID": roomID,
      "guestScore": guestScore,
      "hostScore": hostScore,
      "gameStatus": gameStatus,
      "category": category,
      "players": players,
      "createdAt": createdAt,
      "questionIds": questionIds,
    };
  }

  @override
  String toString() {
    return 'Room{roomID: $roomID, gameStatus: $gameStatus, category: $category, players:$players, createdAt: $hostScore, createdAt: $hostScore, questionIds: $questionIds, guestScore:$guestScore}';
  }

  Room(
      {this.roomID: "",
      this.guestScore = 0,
      this.hostScore = 0,
      this.gameStatus: "WAIT",
      this.category: "",
      this.createdAt: 0,
      this.questionIds: const [],
      this.players: const []});

  Room copyWith(
      {String roomID,
      int guestScore,
      int hostScore,
      String gameStatus,
      String category,
      List<dynamic> players,
      List<dynamic> questionIds,
      int createdAt}) {
    return Room(
        roomID: roomID ?? this.roomID,
        guestScore: guestScore ?? this.guestScore,
        hostScore: hostScore ?? this.hostScore,
        gameStatus: gameStatus ?? this.gameStatus,
        category: category ?? this.category,
        players: players ?? this.players,
        questionIds: questionIds ?? this.questionIds,
        createdAt: createdAt ?? this.createdAt);
  }
}
