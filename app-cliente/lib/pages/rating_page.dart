import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int _rating = 0;
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, size: 24),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Illustration
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.secondaryGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star_rounded,
                color: AppTheme.secondaryGreen,
                size: 60,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "¡Asistencia Finalizada!",
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Tu opinión es muy importante para nosotros. ¿Cómo calificarías el trabajo del mecánico?",
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppTheme.textGray,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 48),
            
            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => setState(() => _rating = index + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: index < _rating ? AppTheme.accentYellow : Colors.grey.shade300,
                      size: 48,
                    ),
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 48),
            
            // Comment Field
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Déjanos un comentario (Opcional)",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Escribe aquí tu experiencia...",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
            
            const SizedBox(height: 48),
            
            ElevatedButton(
              onPressed: () {
                if (_rating == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Por favor, selecciona una calificación"))
                  );
                  return;
                }
                _showSuccessDialog();
              },
              child: const Text("Enviar calificación"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.check_circle_rounded, color: AppTheme.secondaryGreen, size: 64),
            const SizedBox(height: 24),
            Text(
              "¡Gracias!",
              style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "Tu calificación ha sido enviada correctamente.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
              child: const Text("Volver al inicio"),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
