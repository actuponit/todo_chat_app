import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../todo/presentation/bloc/todo_bloc.dart';
import '../blocs/bloc/auth_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  Timer? debounce;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoError) {
          print('TodoError: ${state.message}');
        } else if (state is TodoAdded) {
          print('TodoAdded: ${state.todoList}');
        } else if (state is TodoLoaded) {
          print('TodoLoaded: ${state.todoLists}');
        } else if (state is TodoLoading) {
          print('TodoLoading');
        } else {
          print('NO statate');
        }
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
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
                    content: const Text('User Logged in'),
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
                  const SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    key: const Key('signIn_emailInput_textField'),
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
                    key: const Key('signIn_passwordInput_textField'),
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
                  const SizedBox(height: 50.0),
                  RichText(
                      text: TextSpan(
                    text: 'Don\'t have an account? ',
                    children: [
                      TextSpan(
                        text: 'Register',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacementNamed('register');
                          },
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      )
                    ],
                  )),
                  const SizedBox(height: 50.0),
                  ElevatedButton(
                    key: const Key('signIn_continue_elevatedButton'),
                    onPressed: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      if (state is AuthLoading) return;
                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              content: const Text('Please fill in all fields.'),
                            ),
                          );
                        return;
                      }
                      context
                          .read<AuthBloc>()
                          .add(AuthLoginStarted(email, password));
                    },
                    child: state is AuthLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Login In'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
