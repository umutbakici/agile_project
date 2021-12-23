class User {
  final String username;
  final int XP;
  final int gold;
  final bool isAdmin;
  final Map<String, dynamic> achievements;
  final int level;
  final String mail;
  final Map<String, dynamic> inventory;
  final Map<String, dynamic> stats;
  final Map<String, dynamic> jokers;
  User(
      {this.username = "",
      this.XP = 0,
      this.level = 0,
      this.mail = "",
      this.gold = 0,
      this.isAdmin = false,
      this.achievements = const {},
      this.inventory = const {},
      this.jokers = const {},
      this.stats = const {}});
  @override
  String toString() {
    return 'User{username: $username, isAdmin: $isAdmin XP: $XP, level: $level, mail: $mail, inventory: $inventory, stats: $stats, achivements: $achievements, jokers: $jokers}';
  }

  User copyWith(
      {String username,
      String mail,
      int XP,
      int gold,
      int level,
      bool isAdmin,
      Map<String, dynamic> achievements,
      Map<String, dynamic> jokers,
      Map<String, dynamic> inventory,
      Map<String, dynamic> stats}) {
    return User(
        username: username ?? this.username,
        mail: mail ?? this.mail,
        gold: gold ?? this.gold,
        level: level ?? this.level,
        achievements: achievements ?? this.achievements,
        jokers: jokers ?? this.jokers,
        inventory: inventory ?? this.inventory,
        stats: stats ?? this.stats,
        isAdmin: isAdmin ?? this.isAdmin,
        XP: XP ?? this.XP);
  }
}
