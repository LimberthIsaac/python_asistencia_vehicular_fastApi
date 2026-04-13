import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Success Indicator
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, color: AppTheme.secondaryGreen, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "¡Bienvenido!",
                        style: GoogleFonts.inter(
                          color: AppTheme.secondaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Map Icon Illustration
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: AppTheme.primaryBlue,
                  size: 60,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Permiso de ubicación",
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Necesitamos tu ubicación para encontrar talleres cercanos",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppTheme.textGray,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Info Cards
              _buildInfoCard(
                icon: Icons.send_rounded,
                title: "Ubicación en tiempo real",
                subtitle: "Encuentra los talleres más cercanos a tu posición actual",
                color: AppTheme.primaryBlue,
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                icon: Icons.error_outline_rounded,
                title: "Asistencia más rápida",
                subtitle: "Los talleres sabrán exactamente dónde estás",
                color: AppTheme.secondaryGreen,
              ),
              
              const Spacer(),
              
              // Buttons
              ElevatedButton.icon(
                onPressed: () {
                  // Simular permiso concedido
                  Navigator.pushReplacementNamed(context, '/home');
                },
                icon: const Icon(Icons.location_searching_rounded, size: 20),
                label: const Text("Permitir ubicación"),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                  style: TextButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    "Ingresar dirección manualmente",
                    style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                child: const Text(
                  "Omitir por ahora",
                  style: TextStyle(color: AppTheme.textGray),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
