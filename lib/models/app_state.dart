import 'package:agile_project/models/user.dart';

class AppState {
  final bool isLoggedIn;
  final User user;

  AppState({this.isLoggedIn = false, this.user});

  AppState copyWith({bool isLoggedIn, User user}) {
    return AppState(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn, user: user ?? this.user);
  }
}
