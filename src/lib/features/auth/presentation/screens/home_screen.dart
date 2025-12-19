import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;
  String? userEmail;

  @override
  void initState() {
    super.initState();

    // Check if already signed in
    final session = supabase.auth.currentSession;
    if (session != null) {
      userEmail = session.user.email;
    }

    // Listen for login/logout events
    supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      setState(() {
        userEmail = session?.user.email;
      });
    });
  }

  Future<void> _signInWithGoogle() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutter://login-callback',
    );
  }

  Future<void> _signOut() async {
    await supabase.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Reading App')),
      body: Center(
        child: userEmail == null
            ? ElevatedButton(
                onPressed: _signInWithGoogle,
                child: const Text('Sign in with Google'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, $userEmail'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signOut,
                    child: const Text('Sign out'),
                  ),
                ],
              ),
      ),
    );
  }
}
