import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Car Icon Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.directions_car_filled_rounded,
                  color: AppTheme.primaryBlue,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Iniciar sesión",
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Accede a tu cuenta de Conductor",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppTheme.textGray,
                ),
              ),
              const SizedBox(height: 48),
              
              // Form Fields
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Correo electrónico",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "tu@email.com",
                      prefixIcon: Icon(Icons.email_outlined, color: AppTheme.textGray, size: 20),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Contraseña",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "••••••••",
                      prefixIcon: Icon(Icons.lock_outline_rounded, color: AppTheme.textGray, size: 20),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        _showForgotPasswordDialog(context);
                      },
                      child: const Text(
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              if (authProvider.isLoading)
                const Center(child: CircularProgressIndicator(color: AppTheme.primaryBlue))
              else
                ElevatedButton(
                  onPressed: () async {
                    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ingresa tus credenciales"))
                      );
                      return;
                    }

                    final success = await authProvider.login(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (success) {
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, '/permissions');
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error al iniciar sesión. Verifica tu correo y contraseña."),
                            backgroundColor: AppTheme.emergencyRed,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Ingresar"),
                ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿No tienes cuenta? ",
                    style: GoogleFonts.inter(color: AppTheme.textGray),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/register'),
                    child: const Text(
                      "Regístrate aquí",
                      style: TextStyle(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Recuperar Contraseña"),
        content: const Text("Se te enviará un correo con instrucciones para restablecer tu cuenta."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Correo enviado."))
              );
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(100, 40)),
            child: const Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
