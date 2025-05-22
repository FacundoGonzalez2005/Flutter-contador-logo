import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 10; // ✅ Declarado correctamente como variable de estado

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
                'HomeScreen',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Click Counter', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('0', style: fontSize30), // Aún no se actualiza, como querés
            SizedBox(height: 20),
            Expanded(child: Center(child: RotatingFlutterLogo(size: 350))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter++;
          print('Hola mundo $counter'); // ✅ Esto ya funciona correctamente
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RotatingFlutterLogo extends StatefulWidget {
  final double size;

  const RotatingFlutterLogo({super.key, this.size = 100});

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
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: FlutterLogo(size: widget.size),
    );
  }
}
