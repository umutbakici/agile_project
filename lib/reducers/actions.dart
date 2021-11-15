import 'package:agile_project/models/user.dart';

class InitCurrentUserAction {
  final String username;
  InitCurrentUserAction(this.username);
}

class UserLoadedAction {
  final User user;
  UserLoadedAction(this.user);
}

class TestAction {}
