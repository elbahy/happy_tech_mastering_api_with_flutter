class UserState {}

final class UserInitial extends UserState {}

final class UserLoginLoadingState extends UserState {}

final class UserLoginSuccessState extends UserState {}

final class UserLoginErrorState extends UserState {
  final String error;
  UserLoginErrorState(this.error);
}

final class UserSignUpLoadingState extends UserState {}

final class UserSignUpSuccessState extends UserState {}

final class UserSignUpErrorState extends UserState {
  final String error;

  UserSignUpErrorState({required this.error});
}

final class UploadProfilePicState extends UserState {}

final class UpdateLocationState extends UserState {}
