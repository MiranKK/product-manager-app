import 'package:clothes_store_app/style/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9775FA),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/background-img.png",
              width: 200.w,
            ),
          ),
          Positioned(
            bottom: 60.h,
            left: 30.w,
            child: Container(
              padding: EdgeInsets.all(10.r),
              width: 300.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10.h,
                children: [
                  Text(
                    "Look Good, Feel Good",
                    style: CustomTextStyle().mediumBlackBoldText,
                  ),
                  Text(
                    "Create your individual & unique style and look amazing everyday.",
                    style: CustomTextStyle().xxsmallBlackText.copyWith(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Row(
                    spacing: 10.w,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150.w, 50.h),
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              "/register",
                            );
                          },
                          child: Text(
                            "Register",
                            style: CustomTextStyle().xxsmallBlackBoldText
                                .copyWith(color: const Color(0xff9775FA)),
                          ),
                        ),
                      ),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150.w, 50.h),
                            backgroundColor: const Color(0xff9775FA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          onPressed: () {
                             Navigator.pushReplacementNamed(
                              context,
                              "/login",
                            );
                          },
                          child: Text(
                            "Login",
                            style: CustomTextStyle().xxsmallWhiteBoldText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
