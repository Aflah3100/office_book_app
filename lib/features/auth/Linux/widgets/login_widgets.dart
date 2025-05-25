import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:office_book_app/core/app_assets.dart';
import 'package:office_book_app/core/app_colors.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      elevation: 10,
      child: Container(
        width: 500,
        height: 550,
        padding: const EdgeInsets.only(top: 60),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A3A3A), Color(0xFF2C2C2C)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              radius: 40,
              child: Image.asset(AppAssets.officeBookImage1),
            ),
            const SizedBox(height: 10),
            Text(
              'Welcome Back',
              style: GoogleFonts.publicSans(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryOrangeLight,
              ),
            ),
            Text(
              'Organize Your Work Day',
              style: GoogleFonts.publicSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 450,
              child: LoginTextField(
                hintText: 'Username',
                textEditingController: TextEditingController(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 450,
              child: LoginTextField(
                hintText: "Password",
                textEditingController: TextEditingController(),
                obscureText: true,
              ),
            ),

            const SizedBox(height: 30),

            //Login-button
            const LoginButton(),
            const SizedBox(height: 10),

            //SignUp-Button
            const SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.obscureText,
  });

  final String hintText;
  final TextEditingController textEditingController;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: textEditingController,
      obscureText: obscureText != null ? obscureText! : false,

      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hintText,
        hintStyle: GoogleFonts.publicSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        'New to Office Desk? Sign Up',
        style: GoogleFonts.publicSans(
          fontWeight: FontWeight.w300,
          fontSize: 14,
          color: AppColors.iconColor,
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 450,
        height: 48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE35C35), Color(0xFFCC6B3D)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            'LOGIN',
            style: GoogleFonts.publicSans(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
