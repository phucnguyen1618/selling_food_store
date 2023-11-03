import 'package:selling_food_store/models/user_info.dart';

abstract class ProfileEvent {}

class OnLoadingProfileEvent extends ProfileEvent {}

class OnDisplayProfileEvent extends ProfileEvent {
  UserInfo? userInfo;

  OnDisplayProfileEvent(this.userInfo);
}

class OnErrorEvent extends ProfileEvent {
  String error;

  OnErrorEvent(this.error);
}

class OnSignOutEvent extends ProfileEvent {}

class OnConfirmSignOutEvent extends ProfileEvent {}

class OnSignOutSuccessEvent extends ProfileEvent {}