class UserState {}

final class UserInitial extends UserState {}

final class UserLoginLoadingState extends UserState {}

final class UserLoginSuccessState extends UserState {}

final class UserLoginErrorState extends UserState {
  final String error;
  UserLoginErrorState(this.error);
}
