import 'package:flutter/material.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/screens/create_event/input_reward_info/input_reward_info_screen.dart';
import 'dart:io';

class EventReward extends StatefulWidget {
  final rewardList;
  const EventReward({Key? key, this.rewardList}) : super(key: key);

  @override
  _EventRewardState createState() => _EventRewardState();
}

class _EventRewardState extends State<EventReward> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 116,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.rewardList.length,
                padding: const EdgeInsets.fromLTRB(3, 6, 3, 6),
                separatorBuilder: (context, index) => SizedBox(width: 12),
                itemBuilder: (context, index) => widget.rewardList[index] ==
                        null
                    ? SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            _navigateToNextScreen(context, index);
                          },
                          child: Stack(children: [
                            Center(
                                child: Icon(
                              Icons.add,
                              size: 45,
                              color: Colors.black45,
                            )),
                          ]),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(0),
                              side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(color: Colors.black26)),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.grey.shade300),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                        ))
                    : GestureDetector(
                        onTap: () {
                          _navigateToNextScreen(context, index);
                        },
                        child: Container(
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                File(widget.rewardList[index].imgPath),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 110,
                                color: Colors.black38,
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${index + 1}단계',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '등록 완료',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ))),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 16, color: Colors.black45),
            Text(
              ' 최대 5단계까지 상품을 등록할 수 있어요!',
              style: TextStyle(color: Colors.black45, fontSize: 12),
            )
          ],
        )
      ],
    );
  }

  _navigateToNextScreen(BuildContext context, int index) async {
    final Reward? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InputRewardInfoScreen(
                  reward: widget.rewardList[index],
                )));

    if (result != null) {
      setState(() {
        widget.rewardList[index] = result;
        if (widget.rewardList.last != null && widget.rewardList.length < 5)
          widget.rewardList.add(null);
      });
    }
  }
}
