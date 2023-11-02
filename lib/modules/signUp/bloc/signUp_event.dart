abstract class SignUpEvent {}

class OnSignUpAccountEvent extends SignUpEvent {
  String email;
  String password;

  OnSignUpAccountEvent(this.email, this.password);
}

class OnInitInputUserProfileEvent extends SignUpEvent {}

class OnConfirmInputUserProfileEvent extends SignUpEvent {
  String name;
  DateTime dateTime;
  int sex;
  String address;

  OnConfirmInputUserProfileEvent(this.name, this.dateTime, this.sex, this.address);
}

class OnErrorEvent extends SignUpEvent {
  String message;

  OnErrorEvent(this.message);
}
