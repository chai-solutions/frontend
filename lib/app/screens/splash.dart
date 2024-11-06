import 'package:chai/app/widgets/buttons.dart';
import 'package:chai/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png"),
              const SizedBox(height: 10),
              Text(
                'GateSoup',
                style: GoogleFonts.cairo()
                    .copyWith(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 50,
                child: GSButton(
                  buttonType: GSButtonType.primary,
                  text: 'Login',
                  onPressed: () {
                    context.go('/login');
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 50,
                child: GSButton(
                  buttonType: GSButtonType.secondary,
                  text: 'Create account',
                  onPressed: () {
                    context.go('/create-account');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
