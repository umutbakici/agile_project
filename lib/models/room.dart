class Room {
  final String roomID;
  final String gameStatus;
  final String category;
  final List<dynamic> players;
  final int createdAt;

  Map<String, dynamic> toMap() {
    return {
      "roomID": roomID,
      "gameStatus": gameStatus,
      "category": category,
      "players": players,
      "createdAt": createdAt,
    };
  }

  @override
  String toString() {
    return 'Room{roomID: $roomID, gameStatus: $gameStatus, category: $category, players:$players, createdAt: $createdAt}';
  }

  Room(
      {this.roomID: "",
      this.gameStatus: "WAIT",
      this.category: "",
      this.createdAt: 0,
      this.players: const []});

  Room copyWith(
      {String roomID,
      String gameStatus,
      String category,
      List<dynamic> players,
      int createdAt}) {
    return Room(
        roomID: roomID ?? this.roomID,
        gameStatus: gameStatus ?? this.gameStatus,
        category: category ?? this.category,
        players: players ?? this.players,
        createdAt: createdAt ?? this.createdAt);
  }
}
