import 'package:chai/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authController = ref.read(authControllerProvider.notifier);
    final status = await authController.authStatus();

    if (status == AuthStatus.loggedIn) {
      if (mounted) {
        context.replace('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(authControllerProvider);

    return status.when(
      data: (_) => const RealSplashScreen(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const RealSplashScreen(),
    );
  }
}

class RealSplashScreen extends StatelessWidget {
  const RealSplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background2.png"),
            //fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('GateSoup'),
            ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/create-account');
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO:
// splash screen
// call login
// home
// big reset button on home for logout (for now)
// after:
// create account
// real profile/logout page
