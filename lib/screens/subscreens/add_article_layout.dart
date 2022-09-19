import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartmedia/models/user.dart' as Model;
import 'package:smartmedia/providers/user_provider.dart';
import 'package:smartmedia/ressources/firestore_methods.dart';
import 'package:smartmedia/utils/colors.dart';
import 'package:smartmedia/utils/utils.dart';
import 'package:smartmedia/widgets/text_field_input.dart';

class AddArticleLayout extends StatefulWidget {
  const AddArticleLayout({Key? key}) : super(key: key);

  @override
  State<AddArticleLayout> createState() => _AddArticleLayoutState();
}

class _AddArticleLayoutState extends State<AddArticleLayout> {
  void clearImage() {
    _file = null;
  }

  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  final GroupButtonController articleKeys = GroupButtonController();
  bool _isLoading = false;
  void postImage(String uid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profImage);
      var waiting = true;

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        return showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: const Center(
                    child: Text(
                  " نشر المحتوى بنجاح",
                  style: TextStyle(fontSize: 20, color: primaryColor),
                  textDirection: TextDirection.rtl,
                )),
                children: [
                  SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "غلق النافذه",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: primaryColor),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/journalist/homeScreen');
                    },
                  )
                ],
              );
            });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
//----------------------------------------------------

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          print("(----------------------------------------)");

          return SimpleDialog(
            contentPadding: const EdgeInsets.all(5),
            title: const Center(
                child: Text(
              "اضافه منشور",
              style: TextStyle(fontSize: 15, color: primaryColor),
              textDirection: TextDirection.rtl,
            )),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'أخد صوره من الكاميرة',
                  textDirection: TextDirection.rtl,
                ),
                onPressed: () async {
                  Uint8List file = await pickImage(ImageSource.camera);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('اختيار صوره ',
                    textDirection: TextDirection.rtl),
                onPressed: () async {
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "غلق النافذه",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    articleKeys.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Model.User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: secondColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Flexible(
                child: Text(
              'اضافه صوره/فيديو',
              style: TextStyle(color: white, fontSize: 18),
            )),
            Flexible(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: primaryColor),
                    onPressed: () =>
                        postImage(user!.uid, user.username, user.photoUrl),
                    child: const Text(
                      'نشر',
                      style: TextStyle(color: white),
                    )))
          ],
        ),
        centerTitle: true,
        backgroundColor: secondColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _isLoading ? const LinearProgressIndicator() : Container(),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage((user!.photoUrl).toString()),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textDirection: TextDirection.rtl,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          labelStyle: TextStyle(color: white),
                          hintText: "تعليق عن المحتوى",
                          hintStyle: TextStyle(color: white)),
                      style: TextStyle(color: white),
                    )),
                Column(
                  children: [
                    Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.upload_rounded,
                          color: Colors.blue,
                        ),
                        onPressed: (() => _selectImage(context)),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: (Center(
                child: GroupButton(
                    controller: articleKeys,
                    options: GroupButtonOptions(
                        borderRadius: BorderRadius.circular(25),
                        spacing: 5,
                        selectedTextStyle: const TextStyle(
                            fontSize: 12,
                            color: white,
                            fontWeight: FontWeight.bold),
                        unselectedTextStyle: const TextStyle(
                            fontSize: 12,
                            color: darkColor,
                            fontWeight: FontWeight.bold)),
                    buttons: const [
                      "تكنولوجيا",
                      "رياضه",
                      "سياسه",
                      "حرب",
                      "سياسه خارجيه",
                      "اقتصاد",
                      "أخرى"
                    ],
                    maxSelected: 5,
                    isRadio: false,
                    onSelected: ((value, index, isSelected) {
                      if (isSelected) {
                        articleKeys.selectedIndex;
                      } else if (!isSelected) {
                        articleKeys.unselectIndex(index);
                        print(articleKeys);
                      }
                    })),
              )),
            ),
            SizedBox(
              child: _file != null
                  ? SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Image.memory(
                        _file!,
                        alignment: Alignment.center,
                        width: 300,
                      ))
                  : SizedBox(height: 0),
            ),
          ],
        ),
      ),
    );
  }
}
