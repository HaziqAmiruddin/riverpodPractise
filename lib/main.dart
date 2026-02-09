import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_practise/features/auth/presentation/pages/splash_screen.dart';
// import 'package:river_pod_practise/features/auth/presentation/riverpod/auth_controller.dart';
// import 'package:river_pod_practise/features/auth/presentation/riverpod/auth_provider.dart';
// import 'package:river_pod_practise/features/home_page/presentation/pages/home_page.dart';
import 'package:river_pod_practise/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final auth = ref.watch(authControllerProvider);

    // switch (auth.status) {
    //   case AuthStatus.unknown:
    //     return const SplashScreen();

    //   case AuthStatus.unauthenticated:
    //     return const LoginPage();

    //   case AuthStatus.authenticated:
    //     return const MyHomePage(title: 'Flutter Riverpod Exercise');
    // }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(title: 'Flutter Riverpod Exercise'),
      home: SplashScreen(),
    );
  }
}
