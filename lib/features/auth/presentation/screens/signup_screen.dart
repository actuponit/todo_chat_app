import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/auth_bloc.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Timer? debounce;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      // context.read<SignInCubit>().emailChanged(emailController.text);
    });
  }

  void _onPasswordChanged() {
    // context.read<SignInCubit>().passwordChanged(passwordController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
          }
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text('User Signed up'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            Navigator.of(context).pushReplacementNamed('home');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 100,),
                TextFormField(
                  key: const Key('signUp_emailInput_textField'),
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    errorText: null,
                  ),
                  
                  onChanged: (String value) {
                    if (debounce?.isActive ?? false) debounce?.cancel();
                    debounce = Timer(const Duration(milliseconds: 500), () {
                      // context.read<SignInCubit>().emailChanged(value);
                    });
                  },
                ),
                TextFormField(
                  key: const Key('signUp_passwordInput_textField'),
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    errorText: null,
                  ),
                  onChanged: (String value) {
                    // context.read<SignInCubit>().passwordChanged(value);
                  },
                ),
                TextFormField(
                  key: const Key('name_input_textField'),
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    errorText: null,
                  ),
                  onChanged: (String value) {
                    // context.read<SignInCubit>().passwordChanged(value);
                  },
                ),
                const SizedBox(height: 50.0),
                RichText(text: TextSpan(
                  text: 'Already have an account?',
                  children: [
                    TextSpan(
                      text: ' Login ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushReplacementNamed('login');
                        },
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      )
                  ],
                )),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  key: const Key('signUp_continue_elevatedButton'),
                  onPressed: () {
                    final email = emailController.text;
                    final password = passwordController.text;
                    final name = nameController.text;
                    if (state is AuthLoading) return;
                    if (email.isEmpty || password.isEmpty || name.isEmpty) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context).colorScheme.error,
                            content: const Text('Please fill in all fields.'),
                          ),
                        );
                      return;
                    }
                    context.read<AuthBloc>().add(AuthRegisterStarted(email, password, name));
                  },
                  child: state is AuthLoading
                    ? const CircularProgressIndicator(backgroundColor: Colors.white)
                    : const Text('Sign Up'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}