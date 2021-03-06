import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class UserGuideScreen extends StatefulWidget {
  const UserGuideScreen({
    Key? key,
    required this.dismissGuide,
  }) : super(key: key);

  final VoidCallback dismissGuide;

  @override
  _UserGuideScreenState createState() => _UserGuideScreenState();
}

class _UserGuideScreenState extends State<UserGuideScreen>
    with SingleTickerProviderStateMixin {
  /// controller to animate arrows in user guide
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    /// initialization of controller to animate arrows in user guide
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    /// tween that controls the scale of the arrows
    _scale = Tween(begin: 30.0, end: 50.0).animate(_animationController);

    /// listener that repeats the animation
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        /// to reverse the scale of the arrows
        _animationController.reverse();
      } else if (_animationController.status == AnimationStatus.dismissed) {
        /// to initialize the animation
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    /// to initialize the chevron icons animations (only if show the user guide)
    _animationController.forward();
    return Positioned.fill(
      child: Container(
        color: Colors2222.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget? child) {
                      return Icon(
                        Icons.chevron_left,
                        size: _scale.value,
                      );
                    },
                  ),
                  Flexible(
                    flex: 2,
                    child: Text(
                      'Puedes deslizar para\nnavegar dentro de la ciudad',
                      textAlign: TextAlign.center,
                      style: textTheme.headline5?.apply(fontSizeFactor: 0.8),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget? child) {
                      return Icon(
                        Icons.chevron_right,
                        size: _scale.value,
                      );
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: widget.dismissGuide,
              child: Text('Cerrar',
                  style: textTheme.button
                      ?.apply(fontSizeFactor: 1.2, color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
