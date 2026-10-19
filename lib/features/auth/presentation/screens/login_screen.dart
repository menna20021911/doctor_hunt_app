import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_text.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_widgets.dart';
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
    return BlocListener<AuthBloc, AuthState>(
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
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      v != null && v.contains('@') ? null : 'أدخل بريد صحيح',
                ),
                const SizedBox(height: 14),
                AuthField(
                  controller: _passwordController,
                  hint: AppText.passwordHint,
                  isPassword: true,
                  validator: (v) => v != null && v.length >= 6
                      ? null
                      : 'كلمة السر 6 أحرف على الأقل',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => showForgotPasswordSheet(context),
              child: const Text(
                AppText.forgotPassword,
                style: AppTextStyles.authSmall,
              ),
            ),
          ),
          const SizedBox(height: 40),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => AuthButton(
              text: AppText.logIn,
              loading: state is AuthLoading,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
