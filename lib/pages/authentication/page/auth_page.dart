import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_flutter/pages/authentication/state/auth_state.dart';

class AuthPage extends StatelessWidget {
  final ValueNotifier<bool> isDarkMode;
  const AuthPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthState(),
      child: Consumer<AuthState>(
        builder: (context, authState, child) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                authState.signInWithGoogle(context, isDarkMode);
              },
              child: const Text('Sign in with Google'),
            ),
          ),
        ),
      ),
    );
  }
}
