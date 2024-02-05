import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
import 'package:welcome/screens/home_screen.dart';
import 'package:welcome/screens/sign_up_screen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isSignInDialogShown = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://ec2-35-172-247-23.compute-1.amazonaws.com:4000/login'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
      body: <String, String>{
        'email': email,
        'password': password,
      },
    );

    switch (response.statusCode) {
      case 200:
        // If the server returns a 200 OK response, parse the JSON.
        return jsonDecode(response.body);
      case 401:
        throw Exception("이메일 인증에 실패하였습니다.");
      case 402:
        throw Exception("이메일 또는 비밀번호가 잘못되었습니다.");
      default:
        throw Exception("이메일 또는 비밀번호가 잘못되었습니다.");
    }
  }

  loginButtonPressed() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      var result = await login(email, password);
      // 로그인 성공. `result`를 사용하여 추가 작업을 수행합니다.
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const homeScreen()),
          ));
    } catch (e) {
      // 로그인 실패. 에러 메시지를 표시합니다.
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("로그인 실패"),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("확인"))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset('assets/Backgrounds/Spline.png')),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
        )),
        const RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
          child: const SizedBox(),
        )),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 240),
          top: isSignInDialogShown ? -50 : 0,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const SizedBox(
                      width: 260,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello Me",
                              style: TextStyle(
                                fontSize: 60,
                                fontFamily: "Poppins",
                                height: 1.2,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "안녕한 하루",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Poppins",
                                height: 1.2,
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // 'Forgot Password?' 텍스트가 눌렸을 때 수행할 작업
                            print('Forgot Password? 텍스트가 눌렸습니다.');
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.black, // 텍스트 색상을 파란색으로 설정
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment:
                    //       MainAxisAlignment.spaceAround, // 아이콘들 사이에 공간을 균등하게 배분
                    //   children: <Widget>[
                    //     IconButton(
                    //       icon: const Icon(FontAwesomeIcons.google),
                    //       onPressed: () {
                    //         // Google 아이콘이 눌렸을 때 수행할 작업
                    //       },
                    //     ),
                    //     IconButton(
                    //       icon: const Icon(FontAwesomeIcons.facebook),
                    //       onPressed: () {
                    //         // Facebook 아이콘이 눌렸을 때 수행할 작업
                    //       },
                    //     ),
                    //   ],
                    // ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // 로그인 버튼이 눌렸을 때 수행할 작업
                        loginButtonPressed();
                        print('로그인 버튼이 눌렸습니다.');
                      },
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  // 버튼의 모양을 설정
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.white)))),
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Poppins",
                          height: 1.2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have account?  ",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              // 'Forgot Password?' 텍스트가 눌렸을 때 수행할 작업
                              print('Sign Up 텍스트가 눌렸습니다.');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const SignUpScreen()),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.black, // 텍스트 색상을 파란색으로 설정
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        )
      ],
    ));
  }
}
