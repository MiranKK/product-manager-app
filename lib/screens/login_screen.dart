import 'package:clothes_store_app/provider/auth_provider.dart';
import 'package:clothes_store_app/services/api_service.dart';
import 'package:clothes_store_app/style/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();

  bool isValidPassword(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    return passwordRegex.hasMatch(password);
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }

  bool _isvisable = true;
  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<void> _login() async {
    if (_key.currentState!.validate()) {
      final authprovider = Provider.of<AuthProvider>(context, listen: false);
      final token = await authprovider.login(
        _email.text.trim(),
        _password.text.trim(),
      );
      if (token) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        _email.clear();
        _password.clear();
        Navigator.pushNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authprovider.errorMessage ?? "Login failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Welcome back!",
                  style: CustomTextStyle().largeBlackBoldText,
                ),
              ),
              SizedBox(height: 15.h),
              Form(
                key: _key,
                child: Column(
                  spacing: 15.h,
                  children: [
                    TextFormField(
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!isValidEmail(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      style: CustomTextStyle().xxsmallBlackText,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                        prefixIcon: Icon(Icons.email_outlined, size: 18.w),
                        hintText: "Enter Email",
                        hintStyle: CustomTextStyle().xxsmallBlackText.copyWith(
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                    TextFormField(
                      controller: _password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }

                        return null;
                      },
                      obscureText: _isvisable,

                      style: CustomTextStyle().xxsmallBlackText,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                        prefixIcon: Icon(Icons.lock_outline, size: 18.w),
                        hintText: "Enter Password",
                        hintStyle: CustomTextStyle().xxsmallBlackText.copyWith(
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isvisable = !_isvisable;
                            });
                          },
                          child: _isvisable
                              ? Icon(Icons.visibility_off, size: 18.w)
                              : Icon(Icons.visibility, size: 18.w),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Create new account?",
                          style: CustomTextStyle().xxsmallBlackText.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/register");
                          },
                          child: Text(
                            "Register",
                            style: CustomTextStyle().xxsmallBlackBoldText,
                          ),
                        ),
                      ],
                    ),
                    Consumer<AuthProvider>(
                      builder: (context, authprovider, child) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(280.w, 52.h),
                          backgroundColor: const Color(0xff9775FA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: authprovider.isloading ? null : _login,
                        child: authprovider.isloading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Login",
                                style: CustomTextStyle().xxsmallWhiteBoldText,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
