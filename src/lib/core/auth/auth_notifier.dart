import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../di/service_locator.dart';

class AuthNotifier extends ChangeNotifier {
  bool isRecoveringPassword = false;
  AuthNotifier() {
    _subscription = sl<SupabaseClient>().auth.onAuthStateChange.listen((event) {
      debugPrint("***Event  ${event.event.name}***");
      if (event.event == AuthChangeEvent.passwordRecovery) {
        isRecoveringPassword = true;
      }

      if (event.event == AuthChangeEvent.signedOut) {
        isRecoveringPassword = false;
      }
      notifyListeners();
    });
  }
  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
