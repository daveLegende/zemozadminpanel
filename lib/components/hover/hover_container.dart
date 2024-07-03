import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class HoverContainer extends StatefulWidget {
  final Widget child;
  final Widget? hoverChild; // Widget à afficher lors du survol
  final VoidCallback? onTap;
  final VoidCallback? onHoverEnter;
  final VoidCallback? onHoverExit;

  const HoverContainer({
    Key? key,
    required this.child,
    this.hoverChild,
    this.onTap,
    this.onHoverEnter,
    this.onHoverExit,
  }) : super(key: key);

  @override
  _HoverContainerState createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isHovered = true;
          if (widget.onHoverEnter != null) {
            widget.onHoverEnter!();
          }
        });
      },
      onExit: (event) {
        setState(() {
          _isHovered = false;
          if (widget.onHoverExit != null) {
            widget.onHoverExit!();
          }
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          children: [
            widget.child,
            if (_isHovered && widget.hoverChild != null)
              Positioned(
                top: defaultPadding,
                right: defaultPadding,
                child: widget.hoverChild!,
              ),
          ],
        ),
      ),
    );
  }
}
