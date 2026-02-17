// import 'dart:math';

// import 'package:bookreading/core/helper/size_provider/size_provider.dart';
// import 'package:flutter/material.dart';

// extension SizedHelperExtension on BuildContext {
//   bool get isLandscape =>
//       MediaQuery.of(this).orientation == Orientation.landscape;

//   double get screenWidth => isLandscape
//       ? MediaQuery.of(this).size.height
//       : MediaQuery.of(this).size.width;

//   double get screenHeight => isLandscape
//       ? MediaQuery.of(this).size.width
//       : MediaQuery.of(this).size.height;

//   SizeProvider get sizeProvider => SizeProvider.of(this);
//   double get scalewidth => sizeProvider.width / sizeProvider.baseSize.width;
//   double get scaleheight => sizeProvider.height / sizeProvider.baseSize.height;

//   double setWidth(num w) {
//     return w * scalewidth;
//   }

//   double setHeight(num h) {
//     return h * scaleheight;
//   }

//   double setSp(num f) {
//     return f * scaleheight;
//   }

//   double setMinSize(num size) {
//     return size * min(scaleheight, scalewidth);
//   }
// }
// //MediaQuery.of(context).size.width,
