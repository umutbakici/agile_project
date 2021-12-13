class User {
  final String username;
  final int XP;
  final int gold;
  final int level;
  final String mail;
  final String pic_url;
  final Map<String, dynamic> inventory;
  final Map<String, dynamic> stats;
  User(
      {this.username = "",
      this.XP = 0,
      this.level = 0,
      this.mail = "",
      this.gold = 0,
      this.pic_url = "",
      this.inventory = const {},
      this.stats = const {}});
  @override
  String toString() {
    return 'User{username: $username, XP: $XP, level: $level, mail: $mail,pic_url: $pic_url, inventory: $inventory, stats: $stats}';
  }

  User copyWith(
      {String username,
      String mail,
      String pic_url,
      int XP,
      int gold,
      int level,
      Map<String, dynamic> inventory,
      Map<String, dynamic> stats}) {
    return User(
        username: username ?? this.username,
        mail: mail ?? this.mail,
        pic_url: pic_url ?? this.pic_url,
        gold: gold ?? this.gold,
        level: level ?? this.level,
        inventory: inventory ?? this.inventory,
        stats: stats ?? this.stats,
        XP: XP ?? this.XP);
  }
}
