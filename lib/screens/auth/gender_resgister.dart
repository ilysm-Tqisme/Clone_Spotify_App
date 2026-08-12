import 'package:flutter/material.dart';
import 'package:clone_spotify/screens/auth/name_resgiter.dart';

class GenderRegister extends StatefulWidget {
  const GenderRegister({super.key});

  @override
  State<GenderRegister> createState() => _GenderRegisterState();
}

class _GenderRegisterState extends State<GenderRegister> {
  String? _selectedGender;

  bool _showGenderList = false;

  bool get _hasGender => _selectedGender != null;

  void _next() {
    if (_selectedGender == null) return;

    debugPrint('Gender: $_selectedGender');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NameRegister()),
    );
  }

  void _selectGender(String gender) {
    setState(() {
      _selectedGender = gender;
      _showGenderList = false;
    });
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
            // CREATE ACCOUNT - NẰM GIỮA PHÍA TRÊN
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
                        "What's your gender?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // ==================================================
                      // GENDER INPUT
                      // ==================================================
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showGenderList = !_showGenderList;
                          });
                        },

                        child: Container(
                          height: 27,
                          width: double.infinity,

                          padding: const EdgeInsets.symmetric(horizontal: 8),

                          decoration: BoxDecoration(
                            color: const Color(0xFF858585),

                            borderRadius: BorderRadius.circular(3),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                _selectedGender ?? 'Gender',

                                style: TextStyle(
                                  color: _selectedGender == null
                                      ? const Color(0xFF3A3A3A)
                                      : Colors.black,

                                  fontSize: 12,
                                ),
                              ),

                              Icon(
                                _showGenderList
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,

                                color: Colors.black,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ==================================================
                      // GENDER LIST
                      // ==================================================
                      if (_showGenderList) ...[
                        const SizedBox(height: 3),

                        Container(
                          width: double.infinity,

                          decoration: BoxDecoration(
                            color: const Color(0xFF858585),

                            borderRadius: BorderRadius.circular(3),
                          ),

                          child: Column(
                            children: [
                              _genderItem('Female'),

                              _genderItem('Male'),

                              _genderItem('Non-binary'),

                              _genderItem('Prefer not to say'),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 5),

                      // ==================================================
                      // DESCRIPTION
                      // ==================================================
                      const Text(
                        "You can change this later.",
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
                            onPressed: _hasGender ? _next : null,

                            style: ElevatedButton.styleFrom(
                              elevation: 0,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),

                              backgroundColor: _hasGender
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

  // ============================================================
  // GENDER ITEM
  // ============================================================
  Widget _genderItem(String gender) {
    return GestureDetector(
      onTap: () {
        _selectGender(gender);
      },

      child: Container(
        width: double.infinity,
        height: 27,

        padding: const EdgeInsets.symmetric(horizontal: 8),

        alignment: Alignment.centerLeft,

        child: Text(
          gender,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
