import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class RequestAssistancePage extends StatefulWidget {
  const RequestAssistancePage({super.key});

  @override
  State<RequestAssistancePage> createState() => _RequestAssistancePageState();
}

class _RequestAssistancePageState extends State<RequestAssistancePage> {
  String? _selectedService;
  String? _selectedUrgency = 'Media - Urgente';

  final List<Map<String, dynamic>> _services = [
    {'name': 'Mecánica General', 'color': const Color(0xFFDBEAFE), 'textColor': const Color(0xFF1E40AF)},
    {'name': 'Autoeléctrica', 'color': const Color(0xFFFEF3C7), 'textColor': const Color(0xFF92400E)},
    {'name': 'Parchado y Llantas', 'color': const Color(0xFFF3E8FF), 'textColor': const Color(0xFF6B21A8)},
    {'name': 'Grúa', 'color': const Color(0xFFFEE2E2), 'textColor': const Color(0xFF991B1B)},
    {'name': 'Baterías', 'color': const Color(0xFFDCFCE7), 'textColor': const Color(0xFF166534)},
    {'name': 'Diagnóstico Electrónico', 'color': const Color(0xFFE0E7FF), 'textColor': const Color(0xFF3730A3)},
    {'name': 'Cerrajería Automotriz', 'color': const Color(0xFFFFEDD5), 'textColor': const Color(0xFF9A3412)},
  ];

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
          "Solicitar asistencia",
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, color: AppTheme.primaryBlue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Asistencia de emergencia",
                          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: AppTheme.textDark),
                        ),
                        Text(
                          "Completa el formulario y te conectaremos con el taller más cercano en minutos",
                          style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textGray),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            Text(
              "¿Qué tipo de servicio necesitas?*",
              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _services.map((service) {
                final isSelected = _selectedService == service['name'];
                return ChoiceChip(
                  label: Text(service['name']),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _selectedService = selected ? service['name'] : null);
                  },
                  backgroundColor: service['color'],
                  selectedColor: service['textColor'],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : service['textColor'],
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  side: BorderSide.none,
                  showCheckmark: false,
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            
            Text(
              "Nivel de urgencia*",
              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark),
            ),
            const SizedBox(height: 16),
            _buildUrgencyOption("Alta - Emergencia", "El vehículo está detenido o en situación peligrosa", AppTheme.emergencyRed),
            _buildUrgencyOption("Media - Urgente", "Necesito asistencia pronto pero no es crítico", AppTheme.accentYellow),
            _buildUrgencyOption("Baja - Programada", "Puedo esperar, no es urgente", AppTheme.secondaryGreen),
            
            const SizedBox(height: 32),
            
            Text(
              "Evidencia (Opcional)",
              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildEvidenceButton(Icons.mic_rounded, "Audio", Colors.blue),
                const SizedBox(width: 12),
                _buildEvidenceButton(Icons.camera_alt_rounded, "Fotos", Colors.orange),
                const SizedBox(width: 12),
                _buildEvidenceButton(Icons.edit_note_rounded, "Texto", Colors.green),
              ],
            ),
            
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // Simular envío
                Navigator.pushNamed(context, '/tracking');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                minimumSize: const Size(double.infinity, 60),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send_rounded, size: 20),
                  const SizedBox(width: 12),
                  Text("Enviar solicitud de asistencia", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildUrgencyOption(String title, String subtitle, Color color) {
    final isSelected = _selectedUrgency == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedUrgency = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: isSelected 
                ? Center(child: Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)))
                : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                  Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textGray)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEvidenceButton(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
