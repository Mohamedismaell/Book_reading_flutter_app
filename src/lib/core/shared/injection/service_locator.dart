import 'package:bookreading/features/auth/di/auth_injection.dart';
import 'package:bookreading/features/book/di/book_injection.dart';
import 'package:bookreading/features/book_marks/di/book_marks_injection.dart';
import 'package:bookreading/features/home/di/home_injection.dart';
import 'package:bookreading/features/library/di/library_injection.dart';
import 'package:bookreading/features/progress/di/progress_injection.dart';

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
  BookDi.init();
  ProgressDi.init();
  BookMarksDi.init();
  HomeDi.init();
  LibraryDi.init();
  // PostDi.init();
  // ProfileDi.init(profileBox);
}
