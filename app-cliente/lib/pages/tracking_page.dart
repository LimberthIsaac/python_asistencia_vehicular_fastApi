import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Seguimiento",
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Progress Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                children: [
                  _buildStatusBadge("En Atención", AppTheme.accentYellow),
                  const SizedBox(height: 24),
                  // Progress Bar
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(3)),
                      ),
                      Container(
                        height: 6,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(color: AppTheme.primaryBlue, borderRadius: BorderRadius.circular(3)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Vertical Stepper
                  _buildStep(Icons.access_time_filled_rounded, "Buscando taller", true, true),
                  _buildStep(Icons.check_circle_rounded, "Taller asignado", true, true),
                  _buildStep(Icons.local_shipping_rounded, "En camino", true, true),
                  _buildStep(Icons.build_circle_rounded, "En atención", true, false, isCurrent: true),
                  _buildStep(Icons.stars_rounded, "Finalizada", false, false),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Workshop Details Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Taller asignado", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.handyman_rounded, color: AppTheme.primaryBlue),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Taller Mecánico El Rápido", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                            Text("A 1.5 km de tu posición", style: GoogleFonts.inter(color: AppTheme.textGray, fontSize: 12)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: AppTheme.accentYellow, size: 18),
                          Text(" 4.8", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Simular finalización para ir a la pantalla de calificación
                      Navigator.pushNamed(context, '/rating');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
                      foregroundColor: AppTheme.primaryBlue,
                      elevation: 0,
                    ),
                    child: const Text("Ver perfil del taller"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildStep(IconData icon, String title, bool isCompleted, bool showLine, {bool isCurrent = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isCompleted ? AppTheme.primaryBlue : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? (isCurrent ? icon : Icons.check_rounded) : icon,
                color: isCompleted ? Colors.white : Colors.grey.shade400,
                size: 20,
              ),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 30,
                color: isCompleted ? AppTheme.primaryBlue : Colors.grey.shade200,
              ),
          ],
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
                  color: isCurrent ? AppTheme.primaryBlue : (isCompleted ? AppTheme.textDark : AppTheme.textGray),
                ),
              ),
              if (isCurrent)
                Text("En progreso...", style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textGray)),
            ],
          ),
        ),
        if (isCompleted && !isCurrent)
          const Icon(Icons.check_circle_outline_rounded, color: AppTheme.secondaryGreen, size: 20),
      ],
    );
  }
}
