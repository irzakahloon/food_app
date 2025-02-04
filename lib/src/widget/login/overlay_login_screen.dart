import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/util/custom_page_route.dart';
import '../../../core/util/error_message.dart';
import '../../blocs/auth_bloc.dart';
import '../../blocs/user_bloc.dart';
import '../../model/user.dart';
import '../../screens/register/register_screen.dart';

class OverlayLoginScreen extends StatelessWidget {
  OverlayLoginScreen({Key? key}) : super(key: key);
  final GlobalKey _formKey = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColor.themeSecondary,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 50.0,
              width: 20.0,
              color: AppColor.themePrimary,
            ),
            Text(
              " SIGN IN",
              style: TextStyle(
                fontSize: 38,
                color: AppColor.themePrimary,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          height: 320.0,
          width: 320.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      FormTextField(
                        label: 'Email',
                        controller: email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormTextField(
                        label: 'Password',
                        obsecureText: true,
                        controller: password,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: const Text(
                      //         "Forgot Password?",
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.normal,
                      //           fontSize: 14.0,
                      //           color: Colors.black,
                      //           decoration: TextDecoration.underline,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.themePrimary,
                          AppColor.themeSecondary,
                        ],
                        stops: const [0.6, 2],
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (!(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email.text.toString()))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: ErrorMessage(
                                  message: 'Please Enter Valid Email'),
                            ),
                          );
                          return;
                        }
                        if (RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(password.text.trim())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: ErrorMessage(
                                  message: 'Please Enter Long User Name'),
                            ),
                          );
                          return;
                        }
                        context.read<AuthBloc>().loginWithEmail(
                              email.text.trim(),
                              password.text.trim(),
                            );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            "Or",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 250.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // loginOption(
              //     url: "assets/images/fb.png",
              //     onPressed: () {
              //       context.read<AuthBloc>().loginFacebook();
              //     }),
              // loginOption(url: "assets/images/twitter.png", onPressed: () {}),
              loginOption(
                  url: "assets/images/google.png",
                  onPressed: ()async {
                    await context.read<AuthBloc>().googleLogin();
                   }),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(350),
                    topRight: Radius.circular(350),
                  ),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      CustomPageRoute(
                        builder: (const RegisterScreen1()),
                      ),
                    );
                  },
                  child: const Text(
                    "Create new account",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  loginOption({required String url, required Function onPressed}) {
    return SizedBox(
      height: 50.0,
      width: 250.0,
      child: TextButton(
        style: ElevatedButton.styleFrom(primary: Colors.white),
        onPressed: () {
          onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                url,
                height: 30,
                width: 30,
              ),
              const Text(
                'Continue with Google Account',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.obsecureText = false,
  }) : super(key: key);
  final String label;
  final bool obsecureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TextFormField(
          obscureText: obsecureText,
          controller: controller,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            fillColor: Colors.grey.shade100,
            filled: true,
            enabledBorder: InputBorder.none,
            hintText: label,
            hintStyle: Theme.of(context).textTheme.labelMedium,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
