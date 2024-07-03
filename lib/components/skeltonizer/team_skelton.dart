import 'package:admin/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';

class TeamSkeleton extends StatelessWidget {
  const TeamSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: mwhite,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Skeletonizer(
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (_, i) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  color: mgrey[200],
                ),
                Divider()
              ],
            );
          },
        ),
      ),
    );
  }
}
