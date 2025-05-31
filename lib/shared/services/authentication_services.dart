//Signin-Signup Services Class
import 'package:office_book_app/shared/hive_database/models/user_model.dart';
import 'package:office_book_app/shared/hive_database/services/hive_user_services.dart';

class AuthenticationServices {
  AuthenticationServices._internal();
  static AuthenticationServices instance = AuthenticationServices._internal();
  factory AuthenticationServices() => instance;

  //Validate Sign up credentials
  String validateSignUpCredentials({
    required UserModel userModel,
    required String confirmPassword,
  }) {
    // Check if fields are empty
    if (userModel.firstName.trim().isEmpty ||
        userModel.email.trim().isEmpty ||
        userModel.password.isEmpty ||
        confirmPassword.isEmpty) {
      return 'All fields are required.';
    }

    // Email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(userModel.email)) {
      return 'Invalid email format.';
    }

    // Password length
    if (userModel.password.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Confirm password check
    if (userModel.password != confirmPassword) {
      return 'Passwords do not match.';
    }

    return "";
  }

  String validateSignInCredentials({required String email}) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email format.';
    }
    return "";
  }

  //SignUp user
  Future<bool> signUpUser({required UserModel userModel}) async {
    return await HiveUserServices.instance.addUser(userModel: userModel);
  }

  //SignIn User
  Future<UserModel?> signInUser({
    required String email,
    required String password,
  }) async {
    return await HiveUserServices.instance.fetchUser(email: email);
  }
}
