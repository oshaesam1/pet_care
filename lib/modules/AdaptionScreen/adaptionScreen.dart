import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

import '../../dataBase/dataBaseUtilities.dart';
import '../../models/Posts.dart';
import '../../shared/colors.dart';
import '../HomeScreen/postWidget.dart';

class adaptionScreen extends StatelessWidget {
  static const String routeName = 'adapt';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot<Posts>>(
            stream: DataBaseUtils.readPostsFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Some Thing went Wrong ...');
              }
              var post = snapshot.data?.docs.map((e) => e.data()).toList();
              var toRemove = [];

              post?.forEach((element) {
                if (element.type != "Adaption") {
                  toRemove.add(element);
                }
              });
              post?.removeWhere((e) => toRemove.contains(e));

              return ListView.builder(
                reverse: true,
                itemBuilder: (context, index) {
                  // print(pet?.length);
                  return postWiget(post![index]);
                },
                itemCount: post?.length ?? 0,
              );
            },
          ),
        )
      ],
    );
  }
}
