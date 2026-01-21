import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/widget/theme_icon.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildImageProfile(context),
                  SizedBox(height: context.setHeight(10)),
                  Text('John Doe', style: context.headlineLarge()),
                  SizedBox(height: context.setHeight(10)),
                ],
              ),
            ),
            SizedBox(height: context.setHeight(30)),
            _buildStatus(context),
          ],
        ),
        ThemeIcon(top: 0, right: 15),
      ],
    );
  }
}

Widget _buildImageProfile(BuildContext context) {
  return Stack(
    children: [
      CircleAvatar(
        radius: 53,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/back_ground_auth.jpg'),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: context.colorTheme.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 20),
        ),
      ),
    ],
  );
}

Widget _buildStatus(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(25),
          vertical: context.setMinSize(20),
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text('24', style: context.headlineLarge()),
            Text('BOOKS READ', style: context.bodyMedium()),
          ],
        ),
      ),
      SizedBox(width: context.setWidth(20)),
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(25),
          vertical: context.setMinSize(20),
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          children: [
            Text('24', style: context.headlineLarge()),
            Text('HOURS READ', style: context.bodyMedium()),
          ],
        ),
      ),
    ],
  );
}
