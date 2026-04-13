import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Crea tu cuenta",
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Únete a AsistAuto",
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Obtén asistencia vial inteligente en segundos.",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppTheme.textGray,
                ),
              ),
              const SizedBox(height: 40),
              
              _buildLabel("Nombres y Apellidos"),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Escribe tu nombre completo",
                  prefixIcon: Icon(Icons.person_outline_rounded, color: AppTheme.textGray, size: 20),
                ),
              ),
              const SizedBox(height: 20),
              
              _buildLabel("Correo electrónico"),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "tu@email.com",
                  prefixIcon: Icon(Icons.email_outlined, color: AppTheme.textGray, size: 20),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              
              _buildLabel("Teléfono de contacto"),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: "Ej: +591 70000000",
                  prefixIcon: Icon(Icons.phone_outlined, color: AppTheme.textGray, size: 20),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              
              _buildLabel("Contraseña"),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Crea una contraseña segura",
                  prefixIcon: Icon(Icons.lock_outline_rounded, color: AppTheme.textGray, size: 20),
                ),
                obscureText: true,
              ),
              
              const SizedBox(height: 48),
              
              if (authProvider.isLoading)
                const Center(child: CircularProgressIndicator(color: AppTheme.primaryBlue))
              else
                ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Por favor, completa los campos obligatorios"))
                      );
                      return;
                    }

                    final success = await authProvider.register(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      password: _passwordController.text,
                    );
                    
                    if (success) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("¡Cuenta creada con éxito! Ya puedes iniciar sesión."),
                            backgroundColor: AppTheme.secondaryGreen,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error al registrar. Intenta con otro correo."),
                            backgroundColor: AppTheme.emergencyRed,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Registrarme ahora"),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          color: AppTheme.textDark,
        ),
      ),
    );
  }
}
