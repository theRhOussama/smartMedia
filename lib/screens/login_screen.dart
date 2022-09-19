import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:smartmedia/ressources/auth_method.dart';
import 'package:smartmedia/screens/signup_screen.dart';
import 'package:smartmedia/utils/colors.dart';
import 'package:smartmedia/utils/utils.dart';
import 'package:smartmedia/widgets/text_field_input.dart';

import '../responsive/mobilescreen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/webscreen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  bool isLoding = false;

  void loginUser() async {
    isLoding = true;
    String res = await AuthMethods().login(
        email: _emailInputController.text,
        password: _passwordInputController.text);
    if (res == "success") {
      {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              WebScreenLayout: WebScreen(),
              mobileScreenLayout: MobileScreenLayout()),
        ));
      }

      setState(() {
        isLoding = true;
      });
      print('success');
    } else {
      showSnackBar(res, context);
      setState(() {
        isLoding = false;
      });
    }
  }

  navigateToSignUpScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SvgPicture.asset(
            'assets/1.svg',
            height: 150,
            color: Colors.white,
          ),
          centerTitle: true),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            //svg image
            const SizedBox(height: 10),
            Center(
                child: isLoding
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: primaryColor,
                      ))
                    : const Text('!مرحبا بكم',
                        style: TextStyle(color: secondColor, fontSize: 58))),
            const SizedBox(height: 20),
            SvgPicture.asset(
              'assets/test5.svg',
              height: 150,
            ),
            const SizedBox(height: 35)
            //textField input for email
            ,
            TextFieldInput(
              textEditingController: _emailInputController,
              typeOfInput: 'text',
              hintText: ' البريد الألكتروني',
              textInputType: TextInputType.emailAddress,
              icon: Icon(Icons.email),
              isPass: false,
            ),
            SizedBox(height: 30),
            //textfield input for password
            // ignore: prefer_const_constructors
            TextFieldInput(
                textEditingController: _passwordInputController,
                hintText: 'القن السري',
                typeOfInput: 'text',
                textInputType: TextInputType.emailAddress,
                icon: Icon(Icons.password),
                isPass: true),
            //button Login
            SizedBox(height: 20),
            InkWell(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: primaryColor),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            //Transitioning for sign up
            SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: TextButton.icon(
                      style:
                          TextButton.styleFrom(backgroundColor: primaryColor),
                      label: const Text(
                        'تسجيل الحساب',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: white,
                            fontSize: 15),
                      ),
                      icon: const Icon(
                        Icons.app_registration,
                        color: white,
                      ),
                      onPressed: navigateToSignUpScreen,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: const Text(
                    ' !لا تمتلك حساب',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            )
          ]),
        )),
      ),
    );
  }
}
