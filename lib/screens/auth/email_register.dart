import 'package:flutter/material.dart';
import 'package:clone_spotify/screens/auth/pass_register.dart';

class EmailRegister extends StatefulWidget {
  const EmailRegister({super.key});

  @override
  State<EmailRegister> createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegister> {
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();

  bool get _hasEmail => _emailController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    // Tự động focus vào ô Email
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _emailFocusNode.requestFocus();
      }
    });

    // Cập nhật trạng thái nút Next
    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  // ============================================================
  // NEXT
  // ============================================================
  void _next() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      return;
    }

    debugPrint('Email: $email');

    // Chuyển sang màn hình Password
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PassRegister()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1D),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================================================
            // CREATE ACCOUNT - GIỮA PHÍA TRÊN
            // ============================================================
            const Padding(
              padding: EdgeInsets.only(top: 18),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Create account',
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

            // ============================================================
            // MAIN CONTAINER
            // ============================================================
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
                      // ==================================================
                      // BACK BUTTON
                      // ==================================================
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

                      // ==================================================
                      // TITLE
                      // ==================================================
                      const Text(
                        "What's your email?",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // ==================================================
                      // EMAIL INPUT
                      // ==================================================
                      SizedBox(
                        height: 27,

                        child: TextField(
                          controller: _emailController,

                          focusNode: _emailFocusNode,

                          keyboardType: TextInputType.emailAddress,

                          textInputAction: TextInputAction.done,

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

                      const SizedBox(height: 5),

                      // ==================================================
                      // DESCRIPTION
                      // ==================================================
                      const Text(
                        "You'll need to confirm this email later.",

                        style: TextStyle(color: Color(0xFF858585), fontSize: 5),
                      ),

                      const SizedBox(height: 24),

                      // ==================================================
                      // NEXT BUTTON
                      // ==================================================
                      Center(
                        child: SizedBox(
                          height: 21,

                          child: ElevatedButton(
                            // QUAN TRỌNG:
                            // Có email -> bấm được
                            // Chưa nhập -> disabled
                            onPressed: _hasEmail ? _next : null,

                            style: ElevatedButton.styleFrom(
                              elevation: 0,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),

                              backgroundColor: _hasEmail
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
                              'Next',

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
