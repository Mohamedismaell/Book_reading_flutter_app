// import 'package:bookreading/features/book/data/models/books.dart';
// import 'package:flutter/material.dart';

// class ReaderHeader extends StatefulWidget {
//   const ReaderHeader({super.key, required this.currentChapterIndex, required this.book});
//   final ValueNotifier<int> currentChapterIndex;
//   final BookModel book;
//   @override
//   State<ReaderHeader> createState() => _ReaderHeaderState();
// }

// class _ReaderHeaderState extends State<ReaderHeader> {
//        bool _areToolsVisible = false;

 



//  final bool areToolsVisible;
  

//  void toggleTools() {
//     setState(() {
//       _areToolsVisible = !_areToolsVisible;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {

 
//     return ValueListenableBuilder<int>(
//       valueListenable: widget.currentChapterIndex,
//       builder: (context, chapterIndex, _) => IgnorePointer(
//         ignoring: !widget.areToolsVisible,
//         child: AnimatedOpacity(
//           opacity: widget.areToolsVisible ? 1.0 : 0.0,
//           duration: Duration(milliseconds: 200),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () => context.canPop() ? context.pop() : null,
//                 color: context.colorTheme.onSurface,
//                 icon: Icon(Icons.arrow_back, size: context.setMinSize(26)),
//               ),

//               // Spacer(),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: context.setMinSize(40),
//                   ),
//                   child: Column(
//                     // crossAxisAlignment: CrossAxisAlignment.center
//                     // mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         widget.book.author!,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.center,
//                         style: context.headlineSmall().copyWith(
//                           color: context.colorTheme.onSurface.withOpacity(0.9),
//                         ),
//                       ),
//                       SizedBox(height: context.setHeight(4)),
//                       Text(
//                         "Chapter $chapterIndex ",
//                         style: context.bodyMedium().copyWith(
//                           // fontSize: context.setSp(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               //Todo Tool Bar
//               Icon(
//                 Icons.bookmark,
//                 size: context.setMinSize(32),
//                 color: context.colorTheme.primary,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// };
//   }
// }

