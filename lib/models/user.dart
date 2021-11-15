class User {
  final String username;
  final int XP;
  final int gold;
  final int level;
  final String mail;
  User(
      {this.username = "",
      this.XP = 0,
      this.level = 0,
      this.mail = "",
      this.gold = 0});
  @override
  String toString() {
    return 'User{username: $username, XP: $XP, level: $level, mail: $mail}';
  }
}
