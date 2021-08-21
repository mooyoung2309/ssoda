import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'step_help.dart';
import 'step_text.dart';

class EventImage extends StatefulWidget {
  final event;
  EventImage({Key? key, required this.event}) : super(key: key);

  @override
  _EventImageState createState() => _EventImageState();
}

class _EventImageState extends State<EventImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [StepText(step: 4), StepHelp(step: 4)]),
          SizedBox(height: kDefaultPadding),
          Column(
            children: [
              Container(
                  child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.25,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 2,
                  autoPlay: false,
                ),
                items: List.generate(
                    widget.event.images.length,
                    (index) => ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        child: GestureDetector(
                            onTap: () {
                              _getImageFromGallery(context, index);
                            },
                            child: widget.event.images[index] == null
                                ? ElevatedButton(
                                    onPressed: () {
                                      _getImageFromGallery(context, index);
                                    },
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      color: kLiteFontColor,
                                      size: 50,
                                    )),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kScaffoldBackgroundColor),
                                        overlayColor:
                                            MaterialStateProperty.all<Color>(
                                                kShadowColor),
                                        side: MaterialStateProperty.all<BorderSide>(
                                            BorderSide(color: kLiteFontColor))),
                                  )
                                : Stack(children: [
                                    Image.file(
                                        File(widget.event.images[index]!),
                                        fit: BoxFit.cover),
                                    if (widget.event.images.last == null &&
                                            widget.event.images.length ==
                                                index + 2 ||
                                        widget.event.images.length == index + 1)
                                      Positioned(
                                          right: 10,
                                          top: 10,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (widget.event.images.last ==
                                                    null)
                                                  widget.event.images
                                                      .removeLast();
                                                widget.event.images[index] =
                                                    null;
                                              });
                                            },
                                            child: Icon(Icons.cancel_rounded,
                                                size: 32,
                                                color: Colors.white
                                                    .withOpacity(0.9)),
                                          ))
                                  ])))).cast<Widget>().toList(),
              )),
              SizedBox(height: kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 16, color: kLiteFontColor),
                  Text(
                    ' 좌우 슬라이드로 최대 3장까지 등록할 수 있어요!',
                    style: TextStyle(color: kLiteFontColor, fontSize: 12),
                  )
                ],
              )
            ],
          )
        ]);
  }

  Future _getImageFromGallery(BuildContext context, int index) async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (widget.event.images[index] == null && widget.event.images.length < 3)
        widget.event.images.add(null);
      widget.event.images[index] = image!.path;
    });
  }
}
