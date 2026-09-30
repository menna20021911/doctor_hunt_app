import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../generated/app_colore.dart';
import '../widgets/auth_widgets.dart';

const int kOtpLength = 6;

void showForgotPasswordSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => const _ForgotFlow(),
  );
}

class _ForgotFlow extends StatefulWidget {
  const _ForgotFlow();

  @override
  State<_ForgotFlow> createState() => _ForgotFlowState();
}

class _ForgotFlowState extends State<_ForgotFlow> {
  final _supabase = Supabase.instance.client;
  int _step = 0; 
  bool _loading = false;

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _rePassCtrl = TextEditingController();
  final _codeCtrls = List.generate(kOtpLength, (_) => TextEditingController());
  final _codeFocus = List.generate(kOtpLength, (_) => FocusNode());

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _rePassCtrl.dispose();
    for (final c in _codeCtrls) {
      c.dispose();
    }
    for (final f in _codeFocus) {
      f.dispose();
    }
    super.dispose();
  }

  void _msg(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _loading = true);
    try {
      await action();
    } on AuthException catch (e) {
      _msg(e.message);
    } catch (e) {
      _msg(e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }


  Future<void> _sendEmail() async {
    final email = _emailCtrl.text.trim();
    if (!email.contains('@')) return _msg('أدخل بريد صحيح');
    await _run(() async {
      await _supabase.auth.resetPasswordForEmail(email);
      setState(() => _step = 1);
    });
  }


  Future<void> _verifyCode() async {
    final code = _codeCtrls.map((c) => c.text).join();
    if (code.length < kOtpLength) return _msg('أدخل الكود كامل');
    await _run(() async {
      await _supabase.auth.verifyOTP(
        type: OtpType.recovery,
        email: _emailCtrl.text.trim(),
        token: code,
      );
      setState(() => _step = 2);
    });
  }


  Future<void> _updatePassword() async {
    if (_passCtrl.text.length < 6) return _msg('6 أحرف على الأقل');
    if (_passCtrl.text != _rePassCtrl.text) return _msg('كلمتا السر غير متطابقتين');
    await _run(() async {
      await _supabase.auth.updateUser(UserAttributes(password: _passCtrl.text));
      if (!mounted) return;
      Navigator.pop(context);
      _msg('تم تغيير كلمة السر بنجاح');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              Center(
                child: Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: KeyedSubtree(
                  key: ValueKey(_step),
                  child: switch (_step) {
                    0 => _emailStep(),
                    1 => _codeStep(),
                    _ => _passwordStep(),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String t, String d) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Text(d,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
          const SizedBox(height: 24),
        ],
      );

  Widget _emailStep() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Forgot password',
              'Enter your email for the verification process, we will send a code to your email.'),
          AuthField(
            controller: _emailCtrl,
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          AuthButton(text: 'Continue', loading: _loading, onPressed: _sendEmail),
        ],
      );

  Widget _codeStep() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Enter $kOtpLength Digits Code',
              'Enter the $kOtpLength digits code that you received on your email.'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(kOtpLength, (i) => _otpBox(i)),
          ),
          const SizedBox(height: 28),
          AuthButton(text: 'Continue', loading: _loading, onPressed: _verifyCode),
        ],
      );

  Widget _otpBox(int i) => Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: _codeCtrls[i],
          focusNode: _codeFocus[i],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primary),
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
          onChanged: (v) {
            if (v.isNotEmpty && i < kOtpLength - 1) {
              _codeFocus[i + 1].requestFocus();
            } else if (v.isEmpty && i > 0) {
              _codeFocus[i - 1].requestFocus();
            }
          },
        ),
      );

  Widget _passwordStep() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Reset Password',
              'Set the new password for your account so you can login and access all the features.'),
          AuthField(
              controller: _passCtrl, hint: 'New Password', isPassword: true),
          const SizedBox(height: 14),
          AuthField(
              controller: _rePassCtrl,
              hint: 'Re-enter Password',
              isPassword: true),
          const SizedBox(height: 24),
          AuthButton(
              text: 'Update Password',
              loading: _loading,
              onPressed: _updatePassword),
        ],
      );
}