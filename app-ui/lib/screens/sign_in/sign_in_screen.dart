import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/token.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'components/kakao_sign_in_button.dart';
import 'components/naver_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/sign_in/hello.png'),
                        Text('시작하기',
                            style: TextStyle(
                                fontSize: 12.0, color: kLiteFontColor)),
                        SizedBox(height: kDefaultPadding / 2),
                        Text('안녕하세요, 사장님',
                            style: TextStyle(
                                fontSize: 26.0, fontWeight: FontWeight.bold)),
                      ]),
                ),
                Container(
                  child: Column(
                    children: [
                      NaverSignInButton(
                        size: size,
                        signIn: naverLoginPressed,
                      ),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                      KakaoSignInButton(
                        size: size,
                        signIn: kakaoLoginPressed,
                      ),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                      Text('로그인 할 플랫폼을 선택해주세요!',
                          style:
                              TextStyle(fontSize: 12.0, color: kLiteFontColor)),
                    ],
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                ),
              ])),
    );
  }

  Future<void> naverLoginPressed() async {
    final url =
        Uri.parse('${getApi(API.NAVER_LOGIN)}?redirect_uri=$kAppUrlScheme');

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: kAppUrlScheme);

    final accessToken = Uri.parse(result).queryParameters['token'];

    context.read<Token>().token = accessToken;

    Navigator.of(context).push(_routeToHallScreen());
  }

  Future<void> kakaoLoginPressed() async {
    final url =
        Uri.parse('${getApi(API.KAKAO_LOGIN)}?redirect_uri=$kAppUrlScheme');

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: kAppUrlScheme);

    final accessToken = Uri.parse(result).queryParameters['token'];

    context.read<Token>().token = accessToken;

    Navigator.of(context).push(_routeToHallScreen());

    /* LOGOUT TEST CODE
    var dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get('$baseUrl/logout');

    print(response.data);
    */
  }

  Future<void> createStore() async {
    var dio = Dio();
    dio.options.headers['Authorization'] =
        'Bearer ${context.read<Token>().token!}';

    final getUserInfoResponse = await dio.get(getApi(API.GET_USER_INFO));

    final id = getUserInfoResponse.data['id'];

    dio.options.contentType = 'multipart/form-data';

    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    var storeData = FormData.fromMap({
      'name': 'yjyoon_store',
      'category': 1,
      'city': '서울',
      'country': '광진구',
      'town': '광장동',
      'roadCode': '000000000000',
      'road': '아차산로 549',
      'zipCode': '04983',
      'description': '상세 설명',
      'images': [
        await MultipartFile.fromFile(image!.path),
      ]
    });

    final createStoreResponse = await dio.post(
        getApi(API.CREATE_STORE, parameter: id.toString()),
        data: storeData);

    print(createStoreResponse.data);
  }

  void showLoginFailDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
                child: Text(
              "로그인 오류",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("로그인 도중 오류가 발생하였습니다.", style: TextStyle(fontSize: 14)),
                SizedBox(height: kDefaultPadding / 5),
                Text("네트워크 연결 상태를 확인해주세요.", style: TextStyle(fontSize: 14)),
              ]),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('확인')),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }
}

Route _routeToHallScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HallScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
