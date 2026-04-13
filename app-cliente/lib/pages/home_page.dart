import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(-17.7833, -63.1821), // Ejemplo: Santa Cruz, Bolivia
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: Stack(
        children: [
          // Mapa en segundo plano
          const GoogleMap(
            initialCameraPosition: _kInitialPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          
          // Header Azul
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 40),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryBlue, Color(0xFF004DCF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "¡Hola, ${authProvider.user?.name ?? 'Carlos'}!",
                        style: GoogleFonts.outfit(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "¿Necesitas asistencia vehicular?",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Avatar con Logout
                  GestureDetector(
                    onTap: () {
                      _showLogoutDialog(context, authProvider);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        backgroundColor: AppTheme.primaryBlue,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Solicitud Activa Card
          Positioned(
            top: 160,
            left: 20,
            right: 20,
            child: _buildActiveRequestCard(),
          ),
          
          // Botón SOS Inferior
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla de solicitud
                    Navigator.pushNamed(context, '/request');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.emergencyRed,
                    minimumSize: const Size(double.infinity, 64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 10,
                    shadowColor: AppTheme.emergencyRed.withOpacity(0.4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline_rounded, size: 28, color: Colors.white),
                      const SizedBox(width: 12),
                      Text(
                        "Solicitar asistencia ahora",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveRequestCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.info_outline_rounded, color: AppTheme.primaryBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Solicitud activa",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E7FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "En Camino",
                        style: TextStyle(
                          color: Color(0xFF4338CA),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Taller Mecánico El Rápido",
                  style: GoogleFonts.inter(color: AppTheme.textGray, fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textGray),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cerrar sesión"),
        content: const Text("¿Estás seguro que deseas salir?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              authProvider.logout();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            child: const Text("Cerrar sesión", style: TextStyle(color: AppTheme.emergencyRed)),
          ),
        ],
      ),
    );
  }
}
