import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// Clase principal del proyecto
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de debug
      home: CounterScreen(), // Pantalla principal
    );
  }
}

// Pantalla principal del contador
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;
  double rotationSpeed = 1; // 1: derecha, -1: izquierda, 0: detenido

  // Es un método que creamos dentro de la clase _CounterScreenState
  void increase() {
    counter++;
    rotationSpeed = 1; // cambia dirección
    setState(() {}); // actualiza estado
  }

  // Es un método que creamos dentro de la clase _CounterScreenState
  void decrease() {
    if (counter > 0) {
      counter--;
      rotationSpeed = -1; // cambia dirección inversa
      setState(() {}); // actualiza estado
    }
  }

  // Es un método que creamos dentro de la clase _CounterScreenState
  void reset() {
    counter = 0;
    rotationSpeed = 0; // detiene rotación
    setState(() {}); // actualiza estado
  }

  @override
  Widget build(BuildContext context) {
    const fontSize30 = TextStyle(fontSize: 30);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Material(
          elevation: 4,
          color: Colors.blue,
          child: SafeArea(
            child: Center(
              child: Text(
                'CounterScreen',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Click Counter', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text('$counter', style: fontSize30),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: RotatingFlutterLogo(size: 350, speed: rotationSpeed),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Extraemos el widget Row para optimizar el código
      floatingActionButton: CustomFloatingActions(
        // Se está mandando la referencia a la función, no lo estoy ejecutando
        increaseFn: increase,
        decreaseFn: decrease,
        resetFn: reset,
      ),
    );
  }
}

// Widget personalizado para los botones flotantes
class CustomFloatingActions extends StatelessWidget {
  // Declaro las funciones
  final Function increaseFn;
  final Function decreaseFn;
  final Function resetFn;

  // Constructor: agregamos las funciones como required
  const CustomFloatingActions({
    super.key,
    required this.increaseFn,
    required this.decreaseFn,
    required this.resetFn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          // Retorna el llamado de la función setState, que a su vez, ejecuta el cambio de estado
          onPressed: () => decreaseFn(),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.exposure_minus_1_outlined),
        ),
        FloatingActionButton(
          onPressed: () => resetFn(),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.refresh),
        ),
        FloatingActionButton(
          onPressed: () => increaseFn(),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.exposure_plus_1_outlined),
        ),
      ],
    );
  }
}

// Widget que rota el logo de Flutter
class RotatingFlutterLogo extends StatefulWidget {
  final double size;
  final double speed; // 1: derecha, -1: izquierda, 0: detenido

  const RotatingFlutterLogo({
    super.key,
    this.size = 100,
    required this.speed,
  });

  @override
  State<RotatingFlutterLogo> createState() => _RotatingFlutterLogoState();
}

class _RotatingFlutterLogoState extends State<RotatingFlutterLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(); // Comienza la animación
  }

  // Se llama cuando el widget se actualiza (por ejemplo, al cambiar la velocidad)
  @override
  void didUpdateWidget(RotatingFlutterLogo oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.speed == 0) {
      _controller.stop(); // Detiene la animación
    } else {
      _controller.repeat(); // Reanuda la animación
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.speed > 0
              ? Curves.linear // Rotación hacia la derecha
              : const _ReverseCurve(Curves.linear), // Rotación hacia la izquierda
        ),
      ),
      child: FlutterLogo(size: widget.size),
    );
  }
}

// Curva personalizada para invertir la rotación
class _ReverseCurve extends Curve {
  final Curve original;
  const _ReverseCurve(this.original);

  @override
  double transform(double t) => 1.0 - original.transform(t);
}
