import 'package:flutter/material.dart';

const List<String> stepTextList = [
  '이벤트 제목을 입력해주세요',
  '이벤트 보상을 등록해주세요',
  'SNS 게시글에 꼭 들어갈\n#해시태그를 등록해주세요',
  '이벤트 기간을 설정해주세요',
  '이벤트를 대표하는\n이미지를 등록해주세요',
  '세부적인 요청사항을\n선택해주세요',
  '마지막으로\n이벤트 템플릿을 골라주세요'
];

class StepText extends StatelessWidget {
  const StepText({
    Key? key,
    required int step,
  })  : _step = step,
        super(key: key);

  final int _step;

  @override
  Widget build(BuildContext context) {
    return Text(
      stepTextList[_step],
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
