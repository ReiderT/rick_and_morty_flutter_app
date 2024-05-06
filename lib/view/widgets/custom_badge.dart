import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';

class CustomBadge extends StatefulWidget {
  final Widget? label;
  final Widget? icon;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderLineColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double velocity;

  const CustomBadge({
    super.key,
    this.label,
    this.icon,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderLineColor,
    this.borderRadius,
    this.padding,
    this.velocity = 15.0,
  });

  @override
  State<CustomBadge> createState() => _CustomBadgeState();
}

class _CustomBadgeState extends State<CustomBadge> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;

  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20), // ajustar para controlar la velocidad de desplazamiento
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.maxScrollExtent > 0) {
        _animationController.repeat();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.addListener(() {
      double newScrollPosition = _scrollController.offset + widget.velocity * 0.02;
      if (newScrollPosition >= _scrollController.position.maxScrollExtent) {
        newScrollPosition = _scrollController.position.minScrollExtent; // reiniciar desde el principio
      }
      _scrollController.jumpTo(newScrollPosition);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void getSize() {
    final RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    final size = renderBox!.size;
    log("Tamaño: $size");  
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
        final size = renderBox?.size;
        log("Tamaño: $size");   
        });
      },
      child: Container(
        height: widget.height ?? 40.0,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppDarkTheme.black800,
          border: Border.all(color: widget.borderLineColor ?? AppDarkTheme.black800),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 24.0),
        ),
        padding: widget.padding ?? const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: 4),
              ],
              widget.label ?? const SizedBox(width: 20, height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
