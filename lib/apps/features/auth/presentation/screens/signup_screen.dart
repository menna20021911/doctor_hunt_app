import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/app_colore.dart';
import '../../../../generated/app_text.dart';
import '../../../../generated/style_atom.dart';
import '../controller/app_auth_states.dart';
import '../controller/auth_bloc.dart';
import '../controller/auth_event.dart';
import '../widgets/auth_widgets.dart';
import 'Home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _agreed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لازم توافق على الشروط والأحكام')),
      );
      return;
    }
    context.read<AuthBloc>().add(SignUpRequested(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ));
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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: AuthScaffold(
        title: AppText.joinUsTitle,
        subtitle: AppText.authSubtitle,
        bottom: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppText.haveAccount,
              style: AppTextStyles.authLink,
            ),
            AuthLink(
              text: AppText.logIn,
              onTap: () => Navigator.pop(context),
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
                  controller: _nameController,
                  hint: AppText.nameHint,
                  validator: (v) =>
                      v != null && v.trim().isNotEmpty ? null : 'أدخل الاسم',
                ),
                const SizedBox(height: 14),
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
                      : 'كلمة السر لازم تكون 6 أحرف على الأقل',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Checkbox(
                  value: _agreed,
                  activeColor: AppColors.primary,
                  visualDensity: VisualDensity.compact,
                  onChanged: (v) => setState(() => _agreed = v ?? false),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  AppText.agreeTerms,
                  style: AppTextStyles.authSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          BlocBuilder<AuthBloc, AppAuthState>(
            builder: (context, state) => AuthButton(
              text: AppText.signUp,
              loading: state is AuthLoading,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}