import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/screens/create_event/create_complete/create_complete_screen.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class CreateEventButton extends StatelessWidget {
  final Event event;
  final ScreenshotController screenshotController;
  const CreateEventButton(
      {Key? key, required this.event, required this.screenshotController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        child: Text(
          '이대로 등록하기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          final templateImagePath = await _saveTemplateImage(context);

          final storeId = context.read<SelectedStore>().id!;
          //await _createEvent(storeId);

          Navigator.of(context).pushAndRemoveUntil(
              slidePageRouting(
                  CreateCompleteScreen(templateImage: templateImagePath)),
              (Route<dynamic> route) => false);
        },
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  Future<void> _createEvent(int storeId) async {
    var dio = await authDio();

    dio.options.contentType = 'multipart/form-data';

    var eventData = FormData.fromMap({
      'title': event.title,
      'startDate':
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(event.period.startDate),
      'finishDate': event.period.finishDate == null
          ? null
          : DateFormat('yyyy-MM-ddTHH:mm:ss').format(event.period.finishDate!),
      'images': List.generate(event.images.length,
          (index) => MultipartFile.fromFileSync(event.images[index]!)),
      'hashtags': event.hashtagList,
      'requirements': event.requireList,
      'template': event.template.id
    });

    var eventResponse = await dio
        .post(getApi(API.CREATE_EVENT, suffix: '/$storeId'), data: eventData);

    var rewardsData = FormData();

    for (int i = 0; i < event.rewardList.length; i++) {
      if (event.rewardList[i] == null) continue;
      rewardsData.fields
          .add(MapEntry('rewards[$i].name', event.rewardList[i]!.name));
      rewardsData.fields.add(
          MapEntry('rewards[$i].level', event.rewardList[i]!.level.toString()));
      rewardsData.fields.add(
          MapEntry('rewards[$i].price', event.rewardList[i]!.price.toString()));
      rewardsData.fields.add(
          MapEntry('rewards[$i].count', event.rewardList[i]!.count.toString()));
      rewardsData.fields.add(MapEntry('rewards[$i].category',
          event.rewardList[i]!.category.index.toString()));
      rewardsData.files.add(MapEntry('rewards[$i].image',
          MultipartFile.fromFileSync(event.rewardList[i]!.imgPath)));
    }

    var rewardsResponse = await dio.post(
        getApi(API.CREATE_REWARDS, suffix: '/${eventResponse.data}'),
        data: rewardsData);
  }

  Future<String> _saveTemplateImage(BuildContext context) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final result = await screenshotController.captureAndSave(tempPath);

    return result!;
  }
}
