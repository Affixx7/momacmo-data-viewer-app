import 'package:flutter/material.dart';

import '../api/api_value.dart';

class GallerySettingsScreen extends StatefulWidget {
  const GallerySettingsScreen({Key? key}) : super(key: key);

  @override
  State<GallerySettingsScreen> createState() => _GallerySettingsScreenState();
}

class _GallerySettingsScreenState extends State<GallerySettingsScreen> {
  var textController = TextEditingController();

  // _buildOption takes the context, title, and type to build the option
  // context is needed by flutter to construct the ListTitle
  // title is the name of the option
  // type is the setting section it should belong to, ex: color should be of appearance type
  ListTile _buildOption(BuildContext context, String title, String type) {
    return ListTile(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                // dialogOption will open the screen where we can enter an input into a small screen
                return dialogOption(context, title, type);
              });
        },
        leading: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        trailing: Icon(Icons.arrow_forward_ios));
  }

  AlertDialog dialogOption(BuildContext context, String title, String type) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            // the following are ternary expression that will be check the title to make sure the correct value is being updated
            child: title == 'Bucket'
                ? TextField(
                    controller: textController,
                    decoration: InputDecoration(hintText: ApiValue.getBucket()),
                  )
                : title == 'Project'
                    ? TextField(
                        controller: textController,
                        decoration:
                            InputDecoration(hintText: ApiValue.getProject()),
                      )
                    : title == 'Folder'
                        ? TextField(
                            controller: textController,
                            decoration:
                                InputDecoration(hintText: ApiValue.getFolder()),
                          )
                        : title == 'Dataset'
                            ? TextField(
                                controller: textController,
                                decoration: InputDecoration(
                                    hintText: ApiValue.getDataset()),
                              )
                            : title == 'Volume'
                                ? TextField(
                                    controller: textController,
                                    decoration: InputDecoration(
                                        hintText: ApiValue.getVolume()),
                                    keyboardType: TextInputType.number,
                                  )
                                : Container(),
          ),
        ],
      ),
      actions: [
        // the bottom 2 options in the AlertDialog popup
        TextButton(
            onPressed: () {
              textController.clear();
              Navigator.of(context).pop();
            },
            child: Text('Cancel')),
        TextButton(
            onPressed: (() => (submit(context, textController.text, title))),
            child: const Text('Submit')),
      ],
    );
  }

  void submit(BuildContext context, String input, String title) {
    // setState will allow the updated values to be relized in the api_value.dart file
    // therefore when we get the next image we will get it according to the newly updated options in the setting screen
    setState(() {
      if (input != '') {
        if (title == 'Bucket') {
          ApiValue.setBucket(input);
        }
        if (title == 'Project') {
          ApiValue.setProject(input);
        }
        if (title == 'Folder') {
          ApiValue.setFolder(input);
        }
        if (title == 'Dataset') {
          ApiValue.setDataset(input);
        }
        if (title == 'Volume') {
          ApiValue.setVolume(input);
        }
      }
    });

    textController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Data Viewer Settings Page'),
        ),
        body: Container(
          //padding: const EdgeInsets.all(10),
          child: ListView(children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.api,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'API',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            _buildOption(context, "Bucket", 'api'),
            _buildOption(context, "Project", 'api'),
            _buildOption(context, "Folder", 'api'),
            _buildOption(context, "Dataset", 'api'),
            _buildOption(context, "Volume", 'api'),
          ]),
        ),
      );
}
