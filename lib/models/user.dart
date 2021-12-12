class User {
  final String username;
  final int XP;
  final int gold;
  final int level;
  final String mail;
  final Map<String, dynamic> inventory;
  User(
      {this.username = "",
      this.XP = 0,
      this.level = 0,
      this.mail = "",
      this.gold = 0,
      this.inventory = const {}});
  @override
  String toString() {
    return 'User{username: $username, XP: $XP, level: $level, mail: $mail, inventory: $inventory}';
  }

  User copyWith(
      {String username,
      String mail,
      int XP,
      int gold,
      int level,
      Map<String, dynamic> inventory}) {
    return User(
        username: username ?? this.username,
        mail: mail ?? this.mail,
        gold: gold ?? this.gold,
        level: level ?? this.level,
        inventory: inventory ?? this.inventory,
        XP: XP ?? this.XP);
  }
}
