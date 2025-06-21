// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/core/app_enums.dart';
import 'package:office_book_app/features/home/screens/home_screen.dart';
import 'package:office_book_app/features/home/utils/home_screen_utils.dart';
import 'package:office_book_app/shared/hive_database/models/user_model.dart';
import 'package:office_book_app/shared/models/user_model.dart';
import 'package:office_book_app/shared/providers/login_provider.dart';
import 'package:office_book_app/shared/services/authentication_services.dart';
import 'package:office_book_app/shared/services/shared_prefs.dart';
import 'package:provider/provider.dart';

//User-Authentication Button
class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.confirmPasswordController,
    required this.pinController,
    required this.confirmPinController,
    required this.clickable,
  });

  //Text-field-controllers
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController confirmPasswordController;
  final TextEditingController pinController;
  final TextEditingController confirmPinController;
  final bool clickable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (clickable) {
          final LoginState loginMode =
              context.read<Loginprovider>().getLoginMode();

          //Signin-State
          if (loginMode == LoginState.signIn) {
            await _validateUserSignIn(context);
          } else {
            //SignUp-state
            await _validateUserSignUp(context);
          }
        }
      },
      child: Container(
        width: 450,
        height: 48,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                clickable
                    ? [Color(0xFFE35C35), Color(0xFFCC6B3D)]
                    : [Color(0xFF4A4A4A), Color(0xFF3A3A3A)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Consumer<Loginprovider>(
            builder: (ctx, loginProvider, _) {
              return Text(
                ((loginProvider.getLoginMode() == LoginState.signIn))
                    ? 'LOGIN'
                    : 'SIGNUP',
                style: GoogleFonts.publicSans(
                  color:
                      clickable
                          ? AppColors.textPrimary
                          : AppColors.textTertiary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _validateUserSignUp(BuildContext context) async {
    final userModel = HiveUserModel(
      userId: AuthenticationServices.instance.generateUserId(
        emailController.text,
      ),
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: AuthenticationServices.instance.hashPassword(
        passwordController.text,
      ),
      pin:
          context.read<Loginprovider>().getmPinChecked()
              ? AuthenticationServices.instance.hashPassword(pinController.text)
              : null,
      joinDate: HomeScreenUtilFunctions.getFormattedDate(DateType.all),
    );
    final validationStatus = AuthenticationServices.instance
        .validateSignUpCredentials(
          userModel: userModel,
          confirmPassword: confirmPasswordController.text,
          confirmPin: confirmPinController.text,
        );
    if (validationStatus.isEmpty) {
      //Signup-validation-success
      final signUpStatus = await AuthenticationServices.instance.signUpUser(
        userModel: userModel,
      );

      if (signUpStatus) {
        //Signup-Success

        //Set-shared-prefs
        final sharedPrefStatus = await SharedPrefs.instance.saveLoggedUser(
          user: UserModel(
            userId: userModel.userId,
            firstName: userModel.firstName,
            lastName: userModel.lastName ?? "",
            email: userModel.email,
            dateOfJoin: userModel.joinDate,
          ),
        );
        if (sharedPrefStatus) {
          //Route-to-home-screen
          Navigator.pushNamed(context, HomeScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("OOPS! ,Something went wrong!"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        //Signup-Failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("OOPS! ,Something went wrong!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      //Signup-validation-failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationStatus), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _validateUserSignIn(BuildContext context) async {
    final validationStatus = AuthenticationServices.instance
        .validateSignInCredentials(
          email: emailController.text,
          password: passwordController.text,
        );

    if (validationStatus.isEmpty || validationStatus == "") {
      //Signin-validation-success
      final userModel = await AuthenticationServices.instance.signInUser(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userModel != null) {
        //Sign-In-Success

        //Set-shared-pref
        final sharedPrefStatus = await SharedPrefs.instance.saveLoggedUser(
          user: UserModel(
            userId: userModel.userId,
            firstName: userModel.firstName,
            lastName: userModel.lastName ?? "",
            email: userModel.email,
            dateOfJoin: userModel.joinDate,
          ),
        );

        if (sharedPrefStatus) {
          //Route-to-home-screen
          Navigator.pushNamed(context, HomeScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("OOPS!, Something Went Wrong."),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        //Sign-in-failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid Login Credentials!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      //Signin-Validation-failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationStatus),
          backgroundColor: Colors.red,
          elevation: 10,
        ),
      );
    }
  }
}

//SignIn/SignUp Button
class SignInSignUpTextButton extends StatelessWidget {
  const SignInSignUpTextButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.confirmPasswordController,
    required this.pinController,
    required this.confirmPinController,
  });

  //Text-field-controllers
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController confirmPasswordController;
  final TextEditingController pinController;
  final TextEditingController confirmPinController;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final currentLoginState = context.read<Loginprovider>().getLoginMode();

        context.read<Loginprovider>().setLoginMode(
          loginMode:
              (currentLoginState == LoginState.signIn)
                  ? LoginState.signUp
                  : LoginState.signIn,
        );

        //Clear-controllers
        emailController.clear();
        passwordController.clear();
        firstNameController.clear();
        lastNameController.clear();
        confirmPasswordController.clear();
        pinController.clear();
        confirmPinController.clear();
      },
      child: Consumer<Loginprovider>(
        builder: (ctx, loginProvider, _) {
          return Text(
            (loginProvider.getLoginMode() == LoginState.signIn)
                ? 'New to Office Desk? Sign Up'
                : "Already a user? Sign In",
            style: GoogleFonts.publicSans(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: AppColors.iconColor,
            ),
          );
        },
      ),
    );
  }
}
