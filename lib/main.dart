// Importa tu propia pantalla desde la carpeta screens (debe haber un archivo home_screen.dart ahí)
// import 'package:app_prueba2/screens/home_screen.dart';
import 'package:app_prueba2/screens/counter_screen.dart';

// Importa el paquete de widgets con diseño Material (botones, appbar, etc.)
import 'package:flutter/material.dart';

// Función principal: punto de entrada de la app
void main() {
  runApp(
    const MyApp(), // Lanza la app pasando el widget raíz (MyApp)
  );
}

// Widget principal de tu aplicación. Usa StatelessWidget porque no necesita cambiar su estado.
class MyApp extends StatelessWidget {
  // Constructor constante para optimizar rendimiento
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna el widget principal de la app: MaterialApp
    return const MaterialApp(
      debugShowCheckedModeBanner:
          false, // Oculta el banner de "debug" que aparece arriba a la derecha
      // home: HomeScreen(), // Widget que se muestra como pantalla principal
      home: CounterScreen(),
      // HomeScreen lo importaste desde tu archivo personalizado en screens/
    );
  }
}
