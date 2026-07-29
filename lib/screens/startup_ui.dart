import 'package:flutter/material.dart';

import 'list_ui.dart';

class StartupUi extends StatefulWidget {
  const StartupUi({super.key});

  @override
  State<StartupUi> createState() => _StartupUIState();
}

class _StartupUIState extends State<StartupUi> with TickerProviderStateMixin {
  // Controllers for managing timing of each stage
  late AnimationController _bounceController;
  late AnimationController _textController;

  // Stage animations
  late Animation<double> _bounceAnimation;
  late Animation<double> _textFadeAnimation;

  bool _showText = false;
  double _width = 150;

  @override
  void initState() {
    super.initState();
    // Delay before triggering the indicator line animation
    Future.delayed(const Duration(milliseconds: 2900), () {
      setState(() {
        _width = 0.0; // Target width for AnimatedContainer
      });
    });

    // Bouncing central dot animation
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: -50.0,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -50.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: -40.0,
        ).chain(CurveTween(curve: Curves.easeOutQuad)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -40.0,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeInQuad)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: -30.0,
        ).chain(CurveTween(curve: Curves.easeOutQuad)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -30.0,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeInQuad)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: -20.0,
        ).chain(CurveTween(curve: Curves.easeOutQuad)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -20.0,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeInQuad)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: -10.0,
        ).chain(CurveTween(curve: Curves.easeOutQuad)),
        weight: 5,
      ),
    ]).animate(_bounceController);

    // Fade-in animation for the ToDo App text
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _runBounceSequence();
  }

  void _runBounceSequence() async {
    // Start the bounce animation sequence
    await _bounceController.forward();

    // Show text and trigger fade-in animation
    setState(() {
      _showText = true;
    });
    await _textController.forward();

    // Pause for 1 second before navigating
    await Future.delayed(const Duration(seconds: 1));

    // Smooth fade navigation to ListUi screen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ListUi(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 2000),
        ),
      );
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Central animated dot
            if (!_showText)
              AnimatedBuilder(
                animation: _bounceAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _bounceAnimation.value),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),

            // App Title Presentation (ToDo App)
            if (_showText)
              FadeTransition(
                opacity: _textFadeAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.09),
                    Text(
                      'ToDo App',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 2000),
                      width: _width,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class WaterSplashPainter extends CustomPainter {
  final double radius;
  final Color particleColor;
  final double progress;

  WaterSplashPainter({
    required this.radius,
    required this.particleColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint _ = Paint()
      ..color = particleColor
      ..style = PaintingStyle.fill;
  }

  @override
  bool shouldRepaint(covariant WaterSplashPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.progress != progress;
  }
}
