import 'package:flutter/material.dart';

void main() {
  runApp(const QuantumPresentationApp());
}

class QuantumPresentationApp extends StatelessWidget {
  const QuantumPresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum Coherence & Decoherence',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  int _currentSlide = 0;

  final List<Widget> _slides = [
    const SlideOne(),
    const SlideTwo(),
    const SlideThree(),
    const SlideFour(),
    const SlideFive(),
  ];

  void _nextSlide() {
    if (_currentSlide < _slides.length - 1) {
      setState(() {
        _currentSlide++;
      });
    }
  }

  void _prevSlide() {
    if (_currentSlide > 0) {
      setState(() {
        _currentSlide--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background decoration
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple.withOpacity(0.2),
                blurRadius: 100,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.15),
                blurRadius: 100,
              ),
            ),
          ),
          // Slide content
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: KeyedSubtree(
                      key: ValueKey<int>(_currentSlide),
                      child: _slides[_currentSlide],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        color: Colors.black26,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _currentSlide > 0 ? _prevSlide : null,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Previous'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.white30,
              ),
            ),
            Text(
              'Slide ${_currentSlide + 1} of ${_slides.length}',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            TextButton.icon(
              onPressed: _currentSlide < _slides.length - 1 ? _nextSlide : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.white30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideContent extends StatelessWidget {
  final String title;
  final List<String> bulletPoints;
  final IconData icon;

  const SlideContent({
    super.key,
    required this.title,
    required this.bulletPoints,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 48, color: Colors.blueAccent),
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        ...bulletPoints.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, right: 16.0),
                    child: Icon(Icons.circle, size: 12, color: Colors.deepPurpleAccent),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        fontSize: 24,
                        height: 1.5,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

// Slide 1: Title
class SlideOne extends StatelessWidget {
  const SlideOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.blur_on, size: 120, color: Colors.blueAccent),
        const SizedBox(height: 32),
        const Text(
          'Quantum Coherence & Decoherence',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: 100,
          height: 4,
          color: Colors.deepPurpleAccent,
        ),
        const SizedBox(height: 24),
        const Text(
          'Understanding the fragile nature of quantum states',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

// Slide 2: Coherence
class SlideTwo extends StatelessWidget {
  const SlideTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlideContent(
      title: 'What is Quantum Coherence?',
      icon: Icons.waves,
      bulletPoints: [
        'Quantum coherence is the fundamental property that allows particles to exist in a superposition of states simultaneously.',
        'It represents a definite phase relationship between different states of a quantum system.',
        'This principle is what makes quantum interference possible, as famously demonstrated in the double-slit experiment.',
        'Coherence is the "magic" that gives quantum computers their exponential processing power compared to classical computers.'
      ],
    );
  }
}

// Slide 3: Superposition
class SlideThree extends StatelessWidget {
  const SlideThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlideContent(
      title: 'The Power of Coherent States',
      icon: Icons.hub,
      bulletPoints: [
        'A qubit in a coherent state is not just 0 or 1, but a complex combination of both until measured.',
        'Schrödinger\\'s cat is a macroscopic thought experiment illustrating a coherent superposition of being alive and dead.',
        'Coherence allows multiple qubits to become entangled, linking their fates inextricably regardless of distance.',
        'Maintaining this state requires near-perfect isolation from the external environment.'
      ],
    );
  }
}

// Slide 4: Decoherence
class SlideFour extends StatelessWidget {
  const SlideFour({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlideContent(
      title: 'What is Quantum Decoherence?',
      icon: Icons.blur_off,
      bulletPoints: [
        'Decoherence is the loss of quantum coherence, transitioning a system back to classical, definite states.',
        'It occurs when a quantum system interacts with its environment (e.g., stray photons, heat, or magnetic fields).',
        'The environment effectively "measures" the system, forcing the delicate superposition to collapse.',
        'Decoherence happens incredibly fast in macroscopic systems, which is why we do not observe quantum effects in everyday life.'
      ],
    );
  }
}

// Slide 5: Implications
class SlideFive extends StatelessWidget {
  const SlideFive({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlideContent(
      title: 'Why Decoherence Matters',
      icon: Icons.memory,
      bulletPoints: [
        'It solves the measurement problem partially by explaining how classical reality emerges from quantum rules.',
        'Decoherence is the biggest obstacle in building scalable quantum computers, as it destroys the quantum information.',
        'Researchers use extreme cooling (near absolute zero) and electromagnetic shielding to delay decoherence.',
        'Advanced quantum error correction codes are being developed to detect and fix decoherence errors as they happen.'
      ],
    );
  }
}
