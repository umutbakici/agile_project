import 'package:agile_project/models/room.dart';
import 'package:agile_project/models/user.dart';

class InitCurrentUserAction {
  final String username;
  InitCurrentUserAction(this.username);
}

class UserLoadedAction {
  final User user;
  UserLoadedAction(this.user);
}

class RoomUpdatedAction {
  final Room room;
  RoomUpdatedAction(this.room);
}

class NotificationAddAction {
  final String notification;
  NotificationAddAction(this.notification);
}

class TestAction {}
