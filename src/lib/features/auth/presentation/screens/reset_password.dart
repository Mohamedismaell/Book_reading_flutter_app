import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/features/auth/presentation/widget/arrow_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/enums/orb_position.dart';
import '../../../../core/widget/orb.dart';
import '../widget/reset_password_card.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final minHeight =
        media.size.height - media.padding.top - media.padding.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Orb(position: OrbPosition.topRight, isCyan: false),
          Orb(position: OrbPosition.bottomRight),
          Orb(position: OrbPosition.bottomLeft, isCyan: false),
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.setWidth(16),
                        ),
                        child: ResetPasswordCard(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //! Arrow Back
          context.canPop() ? ArrowBack() : const SizedBox(),
        ],
      ),
    );
  }
}
