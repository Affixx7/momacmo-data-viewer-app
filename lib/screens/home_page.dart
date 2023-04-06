import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'data_viewer_settings_screen.dart';
import '../api/api.dart';
import '../api/api_value.dart';
import '../api/api_info.dart' as api_info;

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _apiImageKey = GlobalKey();
  Size _apiImageSize = Size(1, 1);

  void _getSize() {
    Size? size = _apiImageKey.currentContext!.size;
    setState(() {
      if (size != null) {
        _apiImageSize = _apiImageKey.currentContext!.size!;
      } else {
        _apiImageSize = Size(1, 1);
      }
    });
  }

  int activeIndex = 0;
  int calls = 0;
  var _index = 1;

  String stringResponse = "DEFAULT";
  late Uint8List outputImage;

  var _textController = TextEditingController();
  var pageController = PageController(initialPage: 1);

  var transController = TransformationController();
  var currentPageValue = 0.0;
  var photoController = PhotoViewController();
  var scaleStateController = PhotoViewScaleStateController();

  Offset localPosition = const Offset(-1, -1);
  Offset _position = Offset(0, 0);
  Offset points = Offset.zero;
  Size size = Size(1, 1);

  void onTapUp(DragUpdateDetails details) {
    //print(details.localPosition);

    setState(() {
      points = (details.localPosition);
    });
  }

  //List<Widget> buildTouchPoints() => points.map(pointToWidget).toList();
  Widget buildTouchPoint() => pointToWidget(points);

  Widget pointToWidget(Offset point) {
    return Positioned(
      top: point.dy,
      left: point.dx,
      child: Container(
        width: 1,
        height: 1,
        decoration: BoxDecoration(color: Colors.lightGreenAccent),
      ),
    );
  }

  //var photoController = PhotoViewController();

  var _showCursor = false;
  var _enableGestures = false;
  var _scrollPhysics = ScrollPhysics(parent: BouncingScrollPhysics());
  //var _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: const Text('Data Viewer'), actions: [
        IconButton(
            onPressed: (() => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GallerySettingsScreen()))),
            icon: Icon(Icons.settings))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => searchDialog(context),
        child: Icon(Icons.search),
      ),
      body: Stack(children: [
        PhotoViewGallery.builder(
            scrollPhysics: _scrollPhysics,
            pageController: pageController,
            onPageChanged: (index) {
              setState(() {
                _index = index++;
                ApiValue.setFrame(_index.toString());
                points = Offset.zero;

                scaleStateController.reset();

                // print(_index);
              });
            },
            itemCount: 8640,
            builder: (context, index) {
              index++;
              //_index = index;
              //index = int.parse(ApiValue.getFrame());
              //ApiValue.setFrame(index.toString());
              //print(ApiValue.frame);
              return PhotoViewGalleryPageOptions.customChild(
                disableGestures: true,
                //minScale: 1.0,
                //initialScale: 1.0,
                scaleStateController: scaleStateController,
                child: FutureBuilder(
                    future: fetchImage(
                        index: _index.toString(),
                        bucket: ApiValue.getBucket(),
                        project: ApiValue.getProject(),
                        folder: ApiValue.getFolder(),
                        dataset: ApiValue.getDataset(),
                        volume: ApiValue.getVolume()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final imageBytes = snapshot.data as Uint8List;
                        final memoryImage = Image.memory(
                          imageBytes,
                          key: _apiImageKey,
                        );

                        return Stack(children: [
                          _showCursor == true
                              ? PhotoView.customChild(
                                  controller: photoController,
                                  backgroundDecoration:
                                      BoxDecoration(color: Colors.white),
                                  disableGestures: true,
                                  child: Center(
                                      child: GestureDetector(
                                          // onDoubleTap: () =>
                                          //     scaleStateController
                                          //         .prevScaleState,
                                          onPanStart: (details) {
                                            setState(() {
                                              points = details.localPosition;
                                              _getSize();
                                            });
                                          },
                                          onPanUpdate: onTapUp,
                                          child: Stack(
                                            children: <Widget>[
                                              memoryImage,
                                              buildTouchPoint(),
                                            ],
                                          ))),
                                )
                              : PhotoView.customChild(
                                  // initialScale:
                                  //     scaleStateController.prevScaleState,
                                  //minScale: 1.0,
                                  controller: photoController,
                                  backgroundDecoration:
                                      BoxDecoration(color: Colors.white),
                                  scaleStateController: scaleStateController,
                                  enableRotation: false,
                                  disableGestures: _enableGestures,
                                  child: Center(
                                    child: GestureDetector(
                                        //onDoubleTap: () => scaleStateController.prevScaleState,
                                        //onPanUpdate: onTapUp,
                                        child: Stack(
                                      children: <Widget>[
                                        Image.memory(imageBytes),
                                        buildTouchPoint(),
                                      ],
                                    )),
                                  ),
                                ),
                        ]);
                      }
                      return Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Center(child: CircularProgressIndicator()));
                    }),
              );
            }),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: Colors.white38,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('(T, C)'), Text('(WIN, GRP)')],
                ),
                Expanded(
                    child: FutureBuilder(
                  future: fetchData(
                    bucket: ApiValue.getBucket(),
                    project: ApiValue.getProject(),
                    folder: ApiValue.getFolder(),
                    dataset: ApiValue.getDataset(),
                  ),
                  builder: (context, snapshot) {
                    final imageInfo = snapshot.data as api_info.ApiInfo?;
                    //print(snapshot.data);
                    if (snapshot.hasData) {
                      if (_apiImageSize != Size(1, 1)) {
                        final timeChanelPoints = points.scale(
                            (imageInfo!.lAxis![0].iLength! /
                                _apiImageSize.width),
                            (imageInfo.lAxis![1].iLength! /
                                _apiImageSize.height));

                        final timegrpTimewinPoints = points.scale(
                            (imageInfo.lAxis![2].iLength! /
                                _apiImageSize.width),
                            (imageInfo.lAxis![3].iLength! /
                                _apiImageSize.height));
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '(${timeChanelPoints.dx.toStringAsFixed(2)}, ${timeChanelPoints.dy.toStringAsFixed(2)})',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(${timegrpTimewinPoints.dx.toStringAsFixed(2)}, ${timegrpTimewinPoints.dy.toStringAsFixed(2)})',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }
                      // final timeChanelPoints = points.scale(
                      //     (imageInfo!.lAxis![0].iLength! /
                      //         MediaQuery.of(context).size.width),
                      //     (imageInfo.lAxis![1].iLength! /
                      //         MediaQuery.of(context).size.height));

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '(0.00, 0.00)',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '(0.00, 0.00)',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 20, left: 10),
                      child: Container(
                          height: 1,
                          child: LinearProgressIndicator(
                            color: Theme.of(context).accentColor,
                          )),
                    );
                  },
                )),

                // Expanded(
                //   child: Text(
                //     '${points.scale((1250.0 / 390), (380.0 / 118.8))}',
                //   ),
                // ),
                Text(
                  'Cursor View:',
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showCursor,
                    onChanged: (val) {
                      setState(() {
                        _enableGestures != val;
                        _showCursor = val;
                        if (val == true) {
                          _scrollPhysics = NeverScrollableScrollPhysics();
                        } else {
                          _scrollPhysics = BouncingScrollPhysics();
                        }
                      });
                    })
              ],
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              '${_index}/8640',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future searchDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Search for Specific Image'),
          content: TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: ApiValue.getFrame()),
              keyboardType: TextInputType.number),
          actions: [
            TextButton(
                onPressed: () {
                  _textController.clear();
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: (() {
                  final activeIndex = int.parse(_textController.text);
                  setState(() {
                    ApiValue.setFrame(_textController.text);
                    _index = activeIndex;
                  });
                  pageController.animateToPage(activeIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.bounceInOut);
                  _textController.clear();
                  Navigator.of(context).pop();
                  //submit(_textController.text);
                }),
                child: const Text('Submit'))
          ],
        ),
      );

  // void submit(String newIndex) {
  //   final activeIndex = int.parse(newIndex);
  //   // ApiValue.setFrame(newIndex);
  //   //setState(() {});

  //   pageController.animateToPage(activeIndex,
  //       duration: const Duration(milliseconds: 200), curve: Curves.bounceInOut);
  //   _textController.clear();

  //   Navigator.of(context).pop();
  // }
}
