import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class LibraryAppBar extends StatelessWidget {
  const LibraryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('My Library', style: context.textTheme.headlineMedium),
          // Spacer(),
          InkWell(
            onTap: () {
              //Show menu or something
            },
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
