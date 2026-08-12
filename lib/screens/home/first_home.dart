import 'package:flutter/material.dart';
import 'package:clone_spotify/screens/auth/email_login.dart';
import 'package:clone_spotify/screens/auth/email_register.dart';

class FirstHome extends StatelessWidget {
  const FirstHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;

            // Chiều cao khu vực background.
            // Giới hạn để phù hợp nhiều kích thước màn hình.
            final backgroundHeight = (screenHeight * 0.52).clamp(280.0, 430.0);

            // Khoảng cách hai bên.
            final horizontalPadding = screenWidth * 0.15;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: Column(
                children: [
                  // ======================================================
                  // BACKGROUND + SPOTIFY LOGO
                  // ======================================================
                  SizedBox(
                    width: double.infinity,
                    height: backgroundHeight,

                    child: Stack(
                      children: [
                        // ------------------------------------------------
                        // BACKGROUND
                        // ------------------------------------------------
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,

                          child: Image.asset(
                            'lib/assets/images/logo/spotify_background.png',

                            width: double.infinity,

                            fit: BoxFit.fitWidth,
                          ),
                        ),

                        // ------------------------------------------------
                        // SPOTIFY LOGO
                        // ------------------------------------------------
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,

                          child: Center(
                            child: Image.asset(
                              'lib/assets/images/logo/spotify_logo.png',

                              width: 48,
                              height: 48,

                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ======================================================
                  // TITLE
                  // ======================================================
                  const SizedBox(height: 14),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),

                    child: Text(
                      'Millions of Songs.\nFree on Spotify.',

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,

                        fontSize: 23,

                        fontWeight: FontWeight.bold,

                        height: 1.25,
                      ),
                    ),
                  ),

                  // ======================================================
                  // KHOẢNG CÁCH TITLE → BUTTON
                  // ======================================================
                  const SizedBox(height: 26),

                  // ======================================================
                  // BUTTON AREA
                  // ======================================================
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),

                    child: Column(
                      children: [
                        // ================================================
                        // SIGN UP
                        // ================================================
                        SizedBox(
                          width: double.infinity,
                          height: 40,

                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EmailRegister(),
                                ),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1ED760),

                              foregroundColor: Colors.black,

                              elevation: 0,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),

                            child: const Text(
                              'Sign up free',

                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 9),

                        // ================================================
                        // GOOGLE
                        // ================================================
                        _loginButton(
                          text: 'Continue with Google',

                          icon: 'lib/assets/images/logo/icon_gg.png',

                          onPressed: () {
                            print('Google clicked');
                          },
                        ),

                        const SizedBox(height: 9),

                        // ================================================
                        // FACEBOOK
                        // ================================================
                        _loginButton(
                          text: 'Continue with Facebook',

                          icon: 'lib/assets/images/logo/icon_fb.png',

                          onPressed: () {
                            print('Facebook clicked');
                          },
                        ),

                        const SizedBox(height: 9),

                        // ================================================
                        // APPLE
                        // ================================================
                        _loginButton(
                          text: 'Continue with Apple',

                          icon: 'lib/assets/images/logo/icon_apple.jpg',

                          onPressed: () {
                            print('Apple clicked');
                          },
                        ),

                        const SizedBox(height: 7),

                        // ================================================
                        // LOGIN
                        // ================================================
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EmailLogin(),
                              ),
                            );
                          },

                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                          ),

                          child: const Text(
                            'Log in',

                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 14,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Khoảng trống cuối màn hình
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ====================================================================
  // GOOGLE / FACEBOOK / APPLE BUTTON
  // ====================================================================

  Widget _loginButton({
    required String text,
    required String icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 40,

      child: OutlinedButton(
        onPressed: onPressed,

        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,

          side: const BorderSide(color: Colors.white70, width: 1),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),

          padding: EdgeInsets.zero,
        ),

        child: Row(
          children: [
            // ============================================================
            // ICON
            // ============================================================
            SizedBox(
              width: 45,

              child: Center(
                child: Image.asset(
                  icon,

                  width: 19,
                  height: 19,

                  fit: BoxFit.contain,
                ),
              ),
            ),

            // ============================================================
            // TEXT
            // ============================================================
            Expanded(
              child: Center(
                child: Text(
                  text,

                  style: const TextStyle(
                    color: Colors.white,

                    fontSize: 13,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // ============================================================
            // CÂN BẰNG TEXT
            // ============================================================
            const SizedBox(width: 45),
          ],
        ),
      ),
    );
  }
}
