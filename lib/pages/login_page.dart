
import 'package:flutter/material.dart';
import '../app_data.dart';
import '../constants/app_colors.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import 'inscription_page.dart';

class LoginPage extends StatefulWidget {
  final AuthService authService;
  final VoidCallback onLoginSuccess;

  const LoginPage({
    super.key,
    required this.authService,
    required this.onLoginSuccess,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Connexion à l'API PHP
  Future<void> _handleLogin() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid || _isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final error = await widget.authService.login(
      identifier: _identifierController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _errorMessage = error;
    });

    if (error == null) {
      widget.onLoginSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryDarkBlue,
              AppColors.backgroundLight,
            ],
            stops: [0.0, 0.42],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.workspace_premium_rounded,
                        size: 46,
                        color: AppColors.primaryDarkBlue,
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      AppData.appName,
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'KAUMO KIPONGO ROMANIE',
                      style: TextStyle(
                        color: Color(0xFFDBEAFE),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Connexion',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryDarkBlue,
                                ),
                              ),

                              const SizedBox(height: 6),

                              const Text(
                                'Connectez-vous pour accéder au CV, à la famille et aux contacts.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textMuted,
                                ),
                              ),

                              const SizedBox(height: 18),

                              CustomTextField(
                                controller: _identifierController,
                                labelText: 'Adresse e-mail',
                                hintText: 'Ex. romanie@gmail.com',
                                prefixIcon: Icons.email_outlined,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return 'L\'e-mail est obligatoire.';
                                  }

                                  if (!value.contains('@') ||
                                      !value.contains('.')) {
                                    return 'Veuillez saisir un e-mail valide.';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 14),

                              CustomTextField(
                                controller: _passwordController,
                                labelText: 'Mot de passe',
                                prefixIcon: Icons.lock_outline,
                                obscureText: _obscurePassword,
                                showVisibilityToggle: true,
                                onToggleVisibility: () {
                                  setState(() {
                                    _obscurePassword =
                                        !_obscurePassword;
                                  });
                                },
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) => _handleLogin(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Le mot de passe est obligatoire.';
                                  }

                                  return null;
                                },
                              ),

                              if (_errorMessage != null) ...[
                                const SizedBox(height: 14),

                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF2F2),
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.errorRed
                                          .withValues(alpha: 0.35),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: AppColors.errorRed,
                                        size: 20,
                                      ),

                                      const SizedBox(width: 8),

                                      Expanded(
                                        child: Text(
                                          _errorMessage!,
                                          style: const TextStyle(
                                            color: AppColors.errorRed,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              const SizedBox(height: 20),

                              SizedBox(
                                height: 48,
                                child: FilledButton(
                                  onPressed:
                                      _isLoading ? null : _handleLogin,
                                  style: FilledButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryDarkBlue,
                                    foregroundColor: AppColors.pureWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child:
                                              CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.pureWhite,
                                          ),
                                        )
                                      : const Text(
                                          'Se connecter',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const InscriptionPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Vous n’avez pas de compte ? Créer un compte',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.primaryDarkBlue,
                                    fontWeight: FontWeight.w600,
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
            ),
          ),
        ),
      ),
    );
  }
}
