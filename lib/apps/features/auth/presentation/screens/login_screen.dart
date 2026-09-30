import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: unused_import
import '../../../../generated/app_colore.dart';
import '../../../../generated/app_text.dart';
import '../../../../generated/style_atom.dart';
import '../controller/app_auth_states.dart';
import '../controller/auth_bloc.dart';
import '../controller/auth_event.dart';
import '../widgets/auth_widgets.dart';
import 'Home_screen.dart';
import 'forgot_password_sheet.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SignInRequested(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AppAuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AuthScaffold(
        title: AppText.welcomeBack,
        subtitle: AppText.authSubtitle,
        bottom: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(AppText.noAccount, style: AppTextStyles.authLink),
            AuthLink(
              text: AppText.joinUs,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignUpScreen()),
              ),
            ),
          ],
        ),
        children: [
          const GoogleButton(),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AuthField(
                  controller: _emailController,
                  hint: AppText.emailHint,
                  showCheck: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v != null && v.contains('@')
                      ? null
                      : AppText.enterValidEmail,
                ),
                const SizedBox(height: 14),
                AuthField(
                  controller: _passwordController,
                  hint: AppText.passwordHint,
                  isPassword: true,
                  validator: (v) =>
                      v != null && v.length >= 6 ? null : AppText.passwordMin,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<AuthBloc, AppAuthState>(
            builder: (context, state) => AuthButton(
              text: AppText.login,
              loading: state is AuthLoading,
              onPressed: _submit,
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: AuthLink(
              text: AppText.forgotPassword,
              onTap: () => showForgotPasswordSheet(context),
            ),
          ),
        ],
      ),
    );
  }
}