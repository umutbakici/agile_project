class User {
  final String username;
  final int XP;
  final int gold;
  final Map<String, dynamic> achievements;
  final int level;
  final String mail;
  final String pic_url;
  final Map<String, dynamic> inventory;
  final Map<String, dynamic> stats;
  final Map<String, dynamic> jokers;
  final bool isAdmin;
  User(
      {this.username = "",
      this.XP = 0,
      this.level = 0,
      this.mail = "",
      this.pic_url = "",
      this.gold = 0,
      this.achievements = const {},
      this.inventory = const {},
      this.jokers = const {},
      this.stats = const {},
      this.isAdmin = false});

  @override
  String toString() {
    return 'User{username: $username, XP: $XP, level: $level, mail: $mail, pic_url: $pic_url, inventory: $inventory, stats: $stats, achivements: $achievements, jokers: $jokers, isAdmin: $isAdmin}';
  }

  User copyWith(
      {String username,
      String mail,
      String pic_url,
      int XP,
      int gold,
      int level,
      Map<String, dynamic> achievements,
      Map<String, dynamic> jokers,
      Map<String, dynamic> inventory,
      Map<String, dynamic> stats,
      bool isAdmin}) {
    return User(
        username: username ?? this.username,
        mail: mail ?? this.mail,
        pic_url: pic_url ?? this.pic_url,
        gold: gold ?? this.gold,
        level: level ?? this.level,
        achievements: achievements ?? this.achievements,
        jokers: jokers ?? this.jokers,
        inventory: inventory ?? this.inventory,
        stats: stats ?? this.stats,
        XP: XP ?? this.XP,
        isAdmin: isAdmin ?? this.isAdmin);
  }
}
