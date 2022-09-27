import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:smartmedia/ressources/firestore_methods.dart';
import 'package:smartmedia/screens/subscreens/CommentCard.dart';
import 'package:smartmedia/utils/colors.dart';

import '../../models/user.dart';
import '../../providers/user_provider.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController comments = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    comments.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: secondColor,
      appBar: AppBar(
        backgroundColor: secondColor,
        title: const Text("التعليقات"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: white, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap)
            .collection('comments')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount:( snapshot.data! as dynamic).docs.length ,
            itemBuilder: ((context, index) =>CommentCard() ));
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(

                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoUrl),
                    radius: 13,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: comments,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(color: white),
                        decoration: InputDecoration(
                            labelText: 'اكتب تعليقك',
                            hintMaxLines: 6,
                            labelStyle: const TextStyle(color: white),
                            suffix: Text(user.username),
                            suffixStyle: const TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            hintStyle: const TextStyle(color: white),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.add_box),
                        label: Text("تعليق"),
                        onPressed: () async {
                          await FireStoreMethods().postComment(
                              widget.snap,
                              comments.text,
                              user.uid,
                              user.username,
                              user.photoUrl);
                              setState(() {
                                comments.clear();
                              });
                        },
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}
