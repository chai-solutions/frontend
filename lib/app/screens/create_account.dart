import 'package:chai/app/widgets/buttons.dart';
import 'package:chai/app/widgets/text_field.dart';
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
                color: Theme.of(context).primaryColor,
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
            ),
          ),
          const SizedBox(height: 20),
          GSTextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'name is required';
              }
              return null;
            },
            placeholder: 'Full Name',
          ),
          const SizedBox(height: 10),
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
            placeholder: 'Email',
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
            placeholder: 'Passwordl',
            concealed: true,
          ),
          const SizedBox(height: 10),
          GSTextFormField(
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
            placeholder: 'Confirm password',
            concealed: true,
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final authStatus = ref.watch(authControllerProvider);

              return SizedBox(
                width: double.infinity,
                child: GSButton(
                  buttonType: GSButtonType.primary,
                  onPressed: () => _submit(context, ref),
                  changeDisableColor: !authStatus.isLoading,
                  loading: authStatus.isLoading,
                  text: 'Create',
                ),
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
              context.go('/login');
            },
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(text: 'Login.'),
                ],
              ),
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
