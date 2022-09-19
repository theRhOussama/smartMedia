import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartmedia/utils/colors.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key,required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
              .copyWith(right: 0),
          child: Row(
            children: [
              // ------------- HEADER SECTION
               CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      snap['profileImage'])),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       snap['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: ['Delete']
                                    .map((e) => InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ));
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: primaryColor,
                  ))
            ],
          ),
          //---------------------------------------------Image Section
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          child: Image.network(
              snap['photoPostUrl'],
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
        //Like COmment section
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: primaryColor,
                )),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.comment_sharp,
                color: primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send_sharp,
                color: primaryColor,
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(
                  Icons.bookmark_add_outlined,
                  color: primaryColor,
                ),
                onPressed: () {},
              ),
            ))
          ],
        ),
        //Desciption And Number of comments
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${snap['likes'].length} Likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  )),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8),
                child: RichText(
                  text:  TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                         TextSpan(
                          text: snap['description'],
                          style: const TextStyle(fontWeight: FontWeight.bold,color: darkColor),
                        )
                      ]),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text("View all comments",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey[800]),),),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text("30/08/2022",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey[800]),),),
            ],
          ),
        )
      ]),
    );
  }
}