import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_consumer.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_strings.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/databases/cache/cache_helper.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/functions/upload_pic_api.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/sign_in_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  String? location;

  SignInModel? _signInModel;
  void loginWithEmailAndPassword() async {
    emit(UserLoginLoadingState());
    try {
      await ApiConsumer().post(Endpoints.login, data: {
        ApiKey.email: signInEmail.text,
        ApiKey.password: signInPassword.text
      }).then((value) {
        emit(UserLoginSuccessState());
        _signInModel = SignInModel.fromJson(value.data);
        Map<String, dynamic> successResponse =
            JwtDecoder.decode(_signInModel!.token);
        CacheHelper()
            .saveData(key: ApiKey.id, value: successResponse[ApiKey.id]);
      });
    } on DioException catch (e) {
      if (e.response!.statusCode == 403) {
        emit(UserLoginErrorState(e.response!.data['ErrorMessage']));
      } else if (e.response!.statusCode == 400) {
        if (e.response!.data['ErrorMessage'] == 'validationError') {
          emit(UserLoginErrorState(
              'invalid Email or password less than 6 characters '));
        }
      }
    }
  }

  uploadPic(XFile pic) {
    profilePic = pic;
    emit(UploadProfilePicState());
  }

  void signUp() async {
    emit(UserSignUpLoadingState());
    try {
      await ApiConsumer()
          .post(Endpoints.register,
              data: {
                ApiKey.email: signUpEmail.text,
                ApiKey.password: signUpPassword.text,
                ApiKey.confirmPassword: confirmPassword.text,
                ApiKey.name: signUpName.text,
                ApiKey.phone: signUpPhoneNumber.text,
                ApiKey.location: location,
                ApiKey.pic: uploadImageToAPI(profilePic!)
              },
              isFormData: true)
          .then((value) {
        emit(UserSignUpSuccessState());
      });
    } on DioException catch (e) {
      emit(UserSignUpErrorState(error: e.response!.data['ErrorMessage']));
    }
  }

  updateLocation(String location) {
    this.location = location;
    emit(UpdateLocationState());
  }
}
