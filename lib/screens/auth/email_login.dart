import 'package:flutter/material.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool get _canLogin =>
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    // Tự động mở bàn phím khi vào màn hình
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _emailFocusNode.requestFocus();
      }
    });

    _emailController.addListener(() {
      setState(() {});
    });

    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) return;

    // TODO: Xử lý login ở đây
    debugPrint('Email: $email');
    debugPrint('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1D),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // HEADER
            // =========================
            const Padding(
              padding: EdgeInsets.only(top: 18),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // =========================
            // MAIN CONTAINER
            // =========================
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                color: const Color(0xFF111111),

                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // =========================
                      // BACK BUTTON
                      // =========================
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =========================
                      // EMAIL TITLE
                      // =========================
                      const Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // =========================
                      // EMAIL INPUT
                      // =========================
                      SizedBox(
                        height: 27,
                        child: TextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,

                          keyboardType: TextInputType.emailAddress,

                          textInputAction: TextInputAction.next,

                          onSubmitted: (_) {
                            _passwordFocusNode.requestFocus();
                          },

                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),

                          cursorColor: Colors.black,

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF858585),

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide.none,
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide.none,
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // =========================
                      // PASSWORD TITLE
                      // =========================
                      const Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // =========================
                      // PASSWORD INPUT
                      // =========================
                      SizedBox(
                        height: 27,
                        child: TextField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,

                          obscureText: true,

                          keyboardType: TextInputType.visiblePassword,

                          textInputAction: TextInputAction.done,

                          onSubmitted: (_) {
                            if (_canLogin) {
                              _login();
                            }
                          },

                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),

                          cursorColor: Colors.black,

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF858585),

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide.none,
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide.none,
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // =========================
                      // LOGIN BUTTON
                      // =========================
                      Center(
                        child: SizedBox(
                          height: 21,
                          child: ElevatedButton(
                            onPressed: _canLogin ? _login : null,

                            style: ElevatedButton.styleFrom(
                              elevation: 0,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),

                              backgroundColor: _canLogin
                                  ? const Color(0xFF686868)
                                  : const Color(0xFF5A5A5A),

                              disabledBackgroundColor: const Color(0xFF5A5A5A),

                              foregroundColor: Colors.black,

                              disabledForegroundColor: const Color(0xFF1A1A1A),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),

                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
