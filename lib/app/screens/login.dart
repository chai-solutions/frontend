import 'package:chai/app/widgets/text_field.dart';
import 'package:chai/app/widgets/toasts.dart';
import 'package:chai/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              width: 300,
              child: const LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.airplanemode_active, size: 60, color: Colors.white),
          const SizedBox(height: 20),
          const Text(
            'Login',
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 20),
          GSTextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'email is required';
              } else if (!value.contains('@')) {
                return 'invalid email address';
              }
              return null;
            },
            placeholder: 'Username',
          ),
          const SizedBox(height: 10),
          GSTextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'password is required';
              }
              if (value.length < 8) {
                return 'must be >= 8 characters';
              }
              return null;
            },
            concealed: true,
            placeholder: 'Password',
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                /* // Handle forgot password */
              },
              child: const Text(
                'Forgot password?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final authStatus = ref.watch(authControllerProvider);

              return ElevatedButton(
                onPressed: () => _submit(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: authStatus.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Log In'),
              );
            },
          ),
          const SizedBox(height: 20),
          (errorMessage != null
              ? Text(errorMessage!)
              : const SizedBox.shrink()),
          (errorMessage != null
              ? const SizedBox(height: 20)
              : const SizedBox.shrink()),
          TextButton(
            onPressed: () {
              context.go('/create-account');
            },
            child: Text(
              "Don't have an account? Create one.",
              style: TextStyle(color: Colors.lightBlue[100]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _submit(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        this.errorMessage = null;
      });

      final authController = ref.read(authControllerProvider.notifier);
      final errorMessage = await authController.login(
        email: _emailController.value.text,
        password: _passwordController.value.text,
      );

      if (errorMessage == null) {
        if (context.mounted) {
          infoToast(
            context: context,
            title: 'Welcome!',
            message: 'You are now logged in.',
            icon: const Icon(Icons.flight_takeoff),
          );
          context.replace('/home');
        }
      } else {
        setState(() {
          this.errorMessage = errorMessage;
        });
      }
    }
  }
}
