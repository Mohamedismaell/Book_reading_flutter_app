import 'package:bookreading/core/di/service_locator.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/widget/theme_icon.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  final user = sl<SupabaseClient>().auth.currentUser;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    print('appMetadata ===> ${user!.userMetadata}');
    super.build(context);
    return Stack(
      children: [
        ListView(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildImageProfile(context),
                  SizedBox(height: context.setHeight(10)),
                  Text(
                    user!.userMetadata!['full_name'],
                    style: context.headlineLarge(),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.setHeight(25)),
            _buildStatus(context),
            SizedBox(height: context.setHeight(35)),
            _buildReadingPreference(context),
            SizedBox(height: context.setHeight(20)),
            _buildSetting(context),
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
        radius: 50,
        backgroundImage: AssetImage('assets/images/back_ground_auth.jpg'),
        backgroundColor: Colors.transparent,
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            print("Edit profile");
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: context.colorTheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
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
          color: context.colorTheme.surfaceContainer.withOpacity(0.1),
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
          color: context.colorTheme.surfaceContainer.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          children: [
            Text('128', style: context.headlineLarge()),
            Text('HOURS READ', style: context.bodyMedium()),
          ],
        ),
      ),
    ],
  );
}

Widget _buildReadingPreference(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Reading Preference', style: context.headlineSmall()),
      SizedBox(height: context.setHeight(16)),
      Container(
        decoration: BoxDecoration(
          color: context.colorTheme.surface.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [],
          border: Border.all(
            color: context.colorTheme.surfaceContainer.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            _buildOption(
              context,
              icon: Icons.text_fields_rounded,
              title: 'Text',
            ),

            _buildOption(
              context,
              icon: Icons.language_rounded,
              title: 'Language',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildOption(
  BuildContext context, {
  required IconData icon,
  required String title,
  bool spreadLine = true,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: () => print('Option Tapped'),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.setSp(8),
            vertical: context.setSp(14),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.surfaceContainer.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(icon, size: context.setSp(20)),
                ),
              ),
              SizedBox(width: context.setWidth(16)),
              Expanded(child: Text(title, style: context.bodyLarge())),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: context.setSp(20),
                  color: context.colorTheme.surfaceContainer.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
        spreadLine
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: context.setSp(16)),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: context.colorTheme.surfaceContainer,
                ),
              )
            : SizedBox(),
      ],
    ),
  );
}

Widget _buildSetting(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Setting', style: context.headlineSmall()),
      SizedBox(height: context.setHeight(16)),
      Container(
        decoration: BoxDecoration(
          color: context.colorTheme.surface.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [],
          border: Border.all(
            color: context.colorTheme.surfaceContainer.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            _buildOption(
              context,
              icon: Icons.person_outline_outlined,
              title: 'Account Setting',
            ),
            _buildOption(
              context,
              icon: Icons.notifications_outlined,
              title: 'Notification',
            ),
            _buildOption(
              context,
              icon: Icons.logout_rounded,
              title: 'LogOut',
              spreadLine: false,
            ),
          ],
        ),
      ),
    ],
  );
}
