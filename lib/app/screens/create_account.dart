import 'package:chai/app/widgets/toasts.dart';
import 'package:chai/controllers/auth.dart';
import 'package:chai/controllers/create_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
                color: Colors.blue[800], // Card background color
                borderRadius: BorderRadius.circular(15),
              ),
              width: 300,
              child: const CreateAccountForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
            'Create Account',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'name is required';
              }
              return null;
            },
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Full Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'email is required';
              } else if (!value.contains('@')) {
                return 'invalid email address';
              }
              return null;
            },
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
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
            style: const TextStyle(
              color: Colors.black,
            ),
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'password confirmation is required';
              }
              if (value.length < 8) {
                return 'must be >= 8 characters';
              }
              if (value != _passwordController.value.text) {
                return 'passwords do not match';
              }
              return null;
            },
            obscureText: true,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Confirm password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
                    : const Text('Sign Up'),
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
          ElevatedButton.icon(
            icon: const Icon(Icons.shop),
            onPressed: () {
              // Handle Google Sign-In
            },
            label: const Text('Sign In with Google'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              minimumSize: const Size(140, 40),
            ),
          ),
          TextButton(
            onPressed: () {
              context.go('/login');
            },
            child: Text(
              "Already have an account? Login.",
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _submit(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        this.errorMessage = null;
      });

      final createAccountController =
          ref.read(createAccountControllerProvider.notifier);
      final errorMessage = await createAccountController.createAccount(
        name: _nameController.value.text,
        email: _emailController.value.text,
        password: _passwordController.value.text,
      );

      if (errorMessage == null) {
        if (context.mounted) {
          infoToast(
            context: context,
            title: 'Account creation successful!',
            message: 'You may now log in.',
          );
          context.replace('/login');
        }
      } else {
        setState(() {
          this.errorMessage = errorMessage;
        });
      }
    }
  }
}
