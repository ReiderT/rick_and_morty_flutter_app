import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';
import 'package:rick_and_morty_api/view/theme/text_styles.dart';
import 'package:rick_and_morty_api/view/widgets/custom_gradient.dart';

class CustomButton2 extends StatefulWidget {
  
  final VoidCallback? onTap;
  final String? text;
  final double? fontSize;
  final Color? buttonColor;
  final TextStyle? textStyle;

  const CustomButton2({
    super.key,
    this.onTap,
    this.text,
    this.fontSize,
    this.buttonColor,
    this.textStyle,
  });

  @override
  State<CustomButton2> createState() => _CustomButton2State();
}

class _CustomButton2State extends State<CustomButton2> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _radiusAnimation;
  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300,),
    );
    _radiusAnimation = Tween<double>(
      begin: 0.0, 
      end: 30.0
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapUp(TapUpDetails details) {
    // Guardar la posición del tap
    _tapPosition = details.localPosition;

    // Iniciar la animación
    _controller.forward().then((_) {
      // Resetear el controlador después de que la animación se complete
      _controller.reset();

      // Llamar al evento onTap después de la animación
      widget.onTap?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _handleTapUp,
      child: Stack(
        alignment: Alignment.center,
        children: [
          
          Container(
            height: 46.0,
            padding: const EdgeInsets.only(left: 24.0, top: 12.0, right: 24.0, bottom: 12.0),
            decoration: BoxDecoration(
              color: widget.buttonColor ?? AppDarkTheme.black600,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomGradient(
                  widget: Text(widget.text ?? '', style: widget.textStyle ?? TextStyles.body1()),
                ),
                const SizedBox(width: 10.0,),
                const CustomGradient(
                  widget: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ]
            )
          ),
          CustomPaint(
            painter: _tapPosition == null ? null : RipplePainter(_tapPosition!, _radiusAnimation.value),
            child: const SizedBox(
              width: double.infinity,
              height: 46.0,
            ),
          ), 
        ]

      ), 
    );
  }
}

class RipplePainter extends CustomPainter {
  final Offset position;
  final double radius;

  RipplePainter(this.position, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = AppDarkTheme.primaryColor.withOpacity(1 - (radius / 30.0));
    canvas.drawCircle(position, radius, paint);
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.radius != radius;
  }
}