class AppState {
  final bool isLoggedIn;
  final String username;

  AppState({this.isLoggedIn = false, this.username = "statetest"});

  AppState copyWith({bool isLoggedIn, String username}) {
    return AppState(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        username: username ?? this.username);
  }
}
