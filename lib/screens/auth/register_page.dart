import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  static const Color primaryBlue = Color(0xFF3030B8);
  static const Color background = Color(0xFFF8F9FC);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ============================================================
  // CREATE ACCOUNT
  // ============================================================

Future<void> createAccount() async {
  final name = nameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text.trim();
  final confirmPassword = confirmPasswordController.text.trim();

  if (name.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    _showMessage('Please fill all fields');
    return;
  }

  if (password != confirmPassword) {
    _showMessage('Passwords do not match');
    return;
  }

  if (password.length < 6) {
    _showMessage('Password must be at least 6 characters');
    return;
  }

  setState(() {
    isLoading = true;
  });

  try {
    // STEP 1: Firebase Authentication
    debugPrint('STEP 1: Creating Firebase Auth account...');

    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    print('AUTH UID : ${FirebaseAuth.instance.currentUser?.uid}');

    if (user == null) {
      throw Exception('Firebase user is null');
    }

    debugPrint('STEP 1 SUCCESS: UID = ${user.uid}');

    // STEP 2: Update Firebase Auth profile
    debugPrint('STEP 2: Updating display name...');

    await user.updateDisplayName(name);

    debugPrint('STEP 2 SUCCESS');
    
    final currentUser = FirebaseAuth.instance.currentUser;

debugPrint('AUTH USER: ${currentUser?.uid}');
debugPrint('AUTH EMAIL: ${currentUser?.email}');
    // STEP 3: Create Firestore document
    debugPrint('STEP 3: Creating Firestore document...');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
      'uid': user.uid,
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    debugPrint('STEP 3 SUCCESS: Firestore document created');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully 🎉'),
      ),
    );

    Navigator.pop(context);

  } on FirebaseAuthException catch (e) {
    debugPrint('AUTH ERROR: ${e.code}');
    debugPrint('AUTH MESSAGE: ${e.message}');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Auth Error: ${e.code}'),
      ),
    );

  } on FirebaseException catch (e) {
    debugPrint('FIRESTORE ERROR: ${e.code}');
    debugPrint('FIRESTORE MESSAGE: ${e.message}');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Firestore Error: ${e.code}'),
      ),
    );

  } catch (e) {
    debugPrint('UNKNOWN ERROR: $e');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
      ),
    );

  } finally {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
}

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // INPUT FIELD
  // ============================================================

  Widget _inputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
    VoidCallback? onVisibilityPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 9),

        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF999999),
            ),
            prefixIcon: Icon(
              icon,
              color: Color(0xFF555555),
            ),

            suffixIcon: onVisibilityPressed != null
                ? IconButton(
                    onPressed: onVisibilityPressed,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF666666),
                    ),
                  )
                : null,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF777777),
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF777777),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: primaryBlue,
                width: 1.5,
              ),
            ),

            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),

            child: Column(
              children: [
                const SizedBox(height: 20),

                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: primaryBlue,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Logo
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/tera_logo.png',
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return const Icon(
                          Icons.favorite,
                          color: primaryBlue,
                          size: 30,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Title
                const Text(
                  'TERA Health',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF171717),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Create your account to start your health journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),

                const SizedBox(height: 30),

                // ==================================================
                // CARD
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    30,
                    28,
                    30,
                    28,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      // Name
                      _inputField(
                        label: 'Full Name',
                        hint: 'Enter your name',
                        icon: Icons.person_outline,
                        controller: nameController,
                      ),

                      const SizedBox(height: 18),

                      // Email
                      _inputField(
                        label: 'Email Address',
                        hint: 'you@example.com',
                        icon: Icons.email_outlined,
                        controller: emailController,
                      ),

                      const SizedBox(height: 18),

                      // Password
                      _inputField(
                        label: 'Password',
                        hint: '••••••••',
                        icon: Icons.lock_outline,
                        controller: passwordController,
                        obscureText: obscurePassword,
                        onVisibilityPressed: () {
                          setState(() {
                            obscurePassword =
                                !obscurePassword;
                          });
                        },
                      ),

                      const SizedBox(height: 18),

                      // Confirm password
                      _inputField(
                        label: 'Confirm Password',
                        hint: '••••••••',
                        icon: Icons.lock_outline,
                        controller:
                            confirmPasswordController,
                        obscureText:
                            obscureConfirmPassword,
                        onVisibilityPressed: () {
                          setState(() {
                            obscureConfirmPassword =
                                !obscureConfirmPassword;
                          });
                        },
                      ),

                      const SizedBox(height: 25),

                      // ==================================================
                      // CREATE ACCOUNT BUTTON
                      // ==================================================

                      SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: ElevatedButton(
                          onPressed:
                              isLoading ? null : createAccount,

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            foregroundColor: Colors.white,
                            elevation: 0,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(9),
                            ),
                          ),

                          child: isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Create Account',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight:
                                            FontWeight.w500,
                                      ),
                                    ),

                                    SizedBox(width: 8),

                                    Icon(
                                      Icons
                                          .arrow_forward,
                                      size: 18,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Already have account
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF555555),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // Security message
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEEF2),
                    borderRadius:
                        BorderRadius.circular(25),
                  ),

                  child: const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.lock,
                        size: 15,
                        color: Color(0xFF555555),
                      ),

                      SizedBox(width: 10),

                      Flexible(
                        child: Text(
                          'Your health data is protected and securely stored.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}