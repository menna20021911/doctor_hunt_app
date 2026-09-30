import 'package:flutter/material.dart';
import '../../../../generated/app_colore.dart';
import '../../../../generated/image_assets.dart';

const _borderColor = Color(0xFFE5E7EB);
const _hintColor = Color(0xFF9CA3AF);

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    required this.bottom,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.screenTopGlow,
              AppColors.white,
              AppColors.mintGlow,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, c) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: c.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 90),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ...children,
                      const Spacer(),
                      Center(child: bottom),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.black12,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
                 children: [
  Image.asset(
    ImageAssets.google, 
    width: 20,
    height: 20,
    errorBuilder: (_, __, ___) =>
        const Icon(Icons.g_mobiledata, size: 26),
  ),
  const SizedBox(width: 8),
  const Text(
    'Google',
    style: TextStyle(fontSize: 14, color: Color(0xFF374151)),
  ),
]
              
            ),
          ),
        ),
      ),
    );
  }
}

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.showCheck = false,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final bool showCheck;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _obscure = widget.isPassword;

  OutlineInputBorder _border([Color color = _borderColor]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: widget.controller,
      builder: (context, value, _) {
        Widget? suffix;
        if (widget.isPassword) {
          suffix = IconButton(
            icon: Icon(
              _obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 20,
              color: const Color(0xFF374151),
            ),
            onPressed: () => setState(() => _obscure = !_obscure),
          );
        } else if (widget.showCheck && value.text.contains('@')) {
          suffix = const Icon(Icons.check, size: 20, color: Color(0xFF374151));
        }

        return TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: _hintColor, fontSize: 13),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffix,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            enabledBorder: _border(),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(Colors.red),
            focusedErrorBorder: _border(Colors.red),
          ),
        );
      },
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: loading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

class AuthLink extends StatelessWidget {
  const AuthLink({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}