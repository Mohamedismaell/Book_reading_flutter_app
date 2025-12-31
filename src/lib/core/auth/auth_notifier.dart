import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../di/service_locator.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier() {
    _subscription = sl<SupabaseClient>().auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn ||
          event.event == AuthChangeEvent.signedOut) {
        notifyListeners();
        print("***Event  ${event.event.name}***");
      }
    });
  }
  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
