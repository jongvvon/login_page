import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
import 'package:welcome/screens/sign_in_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isSignInDialogShown = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _qcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> register(
      String email, String password, String nickname, String qcode) async {
    final response = await http.post(
      Uri.parse(
          'http://ec2-35-172-247-23.compute-1.amazonaws.com:4000/register'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
      body: <String, String>{
        'email': email,
        'password': password,
        'nickname': nickname,
        'qcode': qcode,
      },
    );

    switch (response.statusCode) {
      case 200:
        // If the server returns a 200 OK response, parse the JSON.
        return jsonDecode(response.body);
      case 408:
        throw Exception("닉네임이 중복되었습니다.");
      case 409:
        throw Exception("이메일이 중복되었습니다.");
      case 401:
        throw Exception("이메일 인증에 실패하였습니다.");
      case 402:
        throw Exception("이메일 혹은 비밀번호 오류입니다.");
      default:
        throw Exception("입력하신 정보를 다시 확인해주세요.");
    }
  }

  registerButtonPressed() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String nickname = _nicknameController.text;
    String qcode = _qcodeController.text;

    try {
      var result = await register(email, password, nickname, qcode);
      // 회원가입 성공. 플로팅 메시지를 표시합니다.
      Fluttertoast.showToast(
        msg: '회원가입에 성공하였습니다. 이메일 인증을 해주세요.',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const SignInScreen()),
        ),
      );
      // `result`를 사용하여 추가 작업을 수행합니다.
    } catch (e) {
      // 회원가입 실패. 플로팅 메시지를 표시합니다.
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                          );
                        },
                        icon: const Icon(Icons.arrow_back_rounded)),
                    const SizedBox(
                      height: 50,
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
                        // suffix: TextButton(
                        //   onPressed: () {},
                        //   child: const Text(
                        //     '중복확인',
                        //     style: TextStyle(color: Colors.black87),
                        //   ),
                        // ),
                        // constraints: const BoxConstraints(
                        //   maxHeight: 60,
                        // ),
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
                    TextFormField(
                      controller: _nicknameController,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        labelText: 'Nickname',
                        // suffix: TextButton(
                        //   onPressed: () {},
                        //   child: const Text(
                        //     '중복확인',
                        //     style: TextStyle(color: Colors.black87),
                        //   ),
                        // ),
                        // constraints: const BoxConstraints(
                        //   maxHeight: 60,
                        // ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _qcodeController,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        labelText: 'Q-code',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // 로그인 버튼이 눌렸을 때 수행할 작업
                        registerButtonPressed();
                        print('회원가입 버튼이 눌렸습니다.');
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
                        '회원가입',
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
                            "Already have an account?  ",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              // 'Forgot Password?' 텍스트가 눌렸을 때 수행할 작업
                              print('Log in 텍스트가 눌렸습니다.');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const SignInScreen()),
                                ),
                              );
                            },
                            child: const Text(
                              'Log in',
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
