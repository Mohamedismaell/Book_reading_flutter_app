import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookreading/features/auth/presentation/widgets/arrow_back.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/enums/orb_position.dart';
import '../../../../core/widget/orb.dart';
import '../widgets/forget_password_card.dart';

class FogetPasswordPage extends StatelessWidget {
  const FogetPasswordPage({super.key});

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
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        //here chanfe
                        child: ForgetPasswordCard(),
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
