import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_practise/features/auth/presentation/pages/login_screen.dart';
import 'package:river_pod_practise/features/auth/presentation/riverpod/auth_state.dart';
import 'package:river_pod_practise/features/home_page/presentation/pages/home_page.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authControllerProvider, (prev, next) {
      next.whenData((status) {
        if (status == AuthStatus.authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MyHomePage(title: "Home")),
          );
        }

        if (status == AuthStatus.unauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      });
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
