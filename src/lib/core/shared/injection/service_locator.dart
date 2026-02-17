import 'package:bookreading/features/auth/di/auth_injection.dart';

import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:bookreading/core/shared/injection/common_di.dart';
import 'package:bookreading/features/onboarding/di/on_boarding_injection.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies({
  required Box<bool> onboardingBox,
  // required Box<String> profileBox,
}) async {
  await CommonDi.init();
  OnboardingDi.init(onboardingBox: onboardingBox);
  AuthDi.init();
  // HomeDi.init();
  // PostDi.init();
  // BookMarksDi.init();
  // ProfileDi.init(profileBox);
}
