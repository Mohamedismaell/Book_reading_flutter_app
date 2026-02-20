import 'package:flutter/material.dart';

class FinishedBooksDispaly extends StatelessWidget {
  const FinishedBooksDispaly({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(children: [Text('Finished Books'), Spacer(), Text('Sort by')]),
        ],
      ),
    );
  }
}
