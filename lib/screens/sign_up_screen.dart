import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/already_have_an_account_widget.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/custom_form_button.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/custom_input_field.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/page_header.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/page_heading.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/pick_image_widget.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/send_location.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const SendLocation(),
        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(
          child: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserSignUpSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign Up Successful')));
              } else if (state is UserSignUpErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            builder: (context, state) {
              return Form(
                key: userCubit.signUpFormKey,
                child: Column(
                  children: [
                    const PageHeader(),
                    const PageHeading(title: 'Sign-up'),
                    //! Image
                    const PickImageWidget(),
                    const SizedBox(height: 16),
                    //! Name
                    CustomInputField(
                      labelText: 'Name',
                      hintText: 'Your name',
                      isDense: true,
                      controller: userCubit.signUpName,
                    ),
                    const SizedBox(height: 16),
                    //!Email
                    CustomInputField(
                      labelText: 'Email',
                      hintText: 'Your email',
                      isDense: true,
                      controller: userCubit.signUpEmail,
                    ),
                    const SizedBox(height: 16),
                    //! Phone Number
                    CustomInputField(
                      labelText: 'Phone number',
                      hintText: 'Your phone number ex:01234567890',
                      isDense: true,
                      controller: userCubit.signUpPhoneNumber,
                    ),
                    const SizedBox(height: 16),
                    //! Password
                    CustomInputField(
                      labelText: 'Password',
                      hintText: 'Your password',
                      isDense: true,
                      obscureText: true,
                      suffixIcon: true,
                      controller: userCubit.signUpPassword,
                    ),
                    //! Confirm Password
                    CustomInputField(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Your password',
                      isDense: true,
                      obscureText: true,
                      suffixIcon: true,
                      controller: userCubit.confirmPassword,
                    ),
                    const SizedBox(height: 22),
                    //!Sign Up Button
                    state is UserSignUpLoadingState
                        ? const CircularProgressIndicator()
                        : CustomFormButton(
                            innerText: 'Signup',
                            onPressed: () {
                              userCubit.signUp();
                            },
                          ),
                    const SizedBox(height: 18),
                    //! Already have an account widget
                    const AlreadyHaveAnAccountWidget(),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
