import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/sign_in/sign_in_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(_routeToSignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0, height: 1.2);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyTextStyle: bodyStyle,
      descriptionPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: kScaffoldBackgroundColor,
      imagePadding: const EdgeInsets.fromLTRB(8.0, 64.0, 8.0, 8.0),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: kScaffoldBackgroundColor,
      pages: [
        PageViewModel(
          title: "환영합니다!",
          body: "SSODA는 사업주들을 위한 SNS 해시태그 이벤트 마케팅 매니저입니다.",
          image: Image.asset('assets/images/on_boarding/festivate.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "쉽고 간편한 이벤트 관리",
          body: "그동안 수동으로 제작했던 SNS 이벤트를 이제는 SSODA에서 터치 몇 번으로 쉽게 등록하고 관리해보세요.",
          image: Image.asset('assets/images/on_boarding/drag.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "이벤트 참여 체크 자동화",
          body:
              "이제 고객들의 SNS 이벤트 참여 게시물을 일일이 확인하실 필요 없어요. SSODA가 알아서 전부 체크해드릴게요.",
          image: Image.asset('assets/images/on_boarding/done_checking.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "마케팅 효과를 한 눈에",
          body:
              "그동안 SNS 이벤트 마케팅 효과를 알 수 없어 답답하셨죠? 이제는 SSODA가 한 눈에 보기 쉽게 정리해드릴게요.",
          image: Image.asset('assets/images/on_boarding/all_the_data.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('건너뛰기'),
      next: const Icon(Icons.arrow_forward_ios_rounded),
      done: const Text('시작하기', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastOutSlowIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: kLiteFontColor,
        activeColor: kThemeColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: kScaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

Route _routeToSignInScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const SignInScreen(),
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