import 'dart:developer';
import 'package:flutter/material.dart';

class ReactionsButtonWidget extends StatefulWidget {
  const ReactionsButtonWidget({super.key});
  @override
  State<ReactionsButtonWidget> createState() => _ReactionsButtonWidgetState();
}

class _ReactionsButtonWidgetState extends State<ReactionsButtonWidget> {
  final List<bool> _hoverStates = List.generate(5, (_) => false);
  int? _currentHoveredIndex;
  final _overlayController = OverlayPortalController();

  final List<String> _reactions = ['👍', '❤️', '😂', '😲', '😢'];

  final double normalSize = 40.0;
  final double shrunkSize = 30.0;
  final double expandedSize = 60.0;
  late final List<double> _lastFontSizes;

  @override
  void initState() {
    super.initState();
    _lastFontSizes = List.generate(5, (_) => normalSize);
  }

  void _onPointerEnter(int index) {
    if (_currentHoveredIndex != index) {
      setState(() {
        _resetHoverState();
        _hoverStates[index] = true;
        _currentHoveredIndex = index;
      });
      // log('Entered reaction: ${_reactions[index]}');
    }
  }

  void _onPointerExit() {
    if (_currentHoveredIndex != null) {
      // log('Exited reaction: ${_reactions[_currentHoveredIndex!]}');

      setState(() {
        _resetHoverState();
        _currentHoveredIndex = null;
      });
    }
  }

  void _resetHoverState() {
    for (int i = 0; i < _hoverStates.length; i++) {
      _hoverStates[i] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _overlayController.toggle,
      child: OverlayPortal(
        controller: _overlayController,
        child: const Icon(Icons.thumb_up_sharp,),
        overlayChildBuilder: (context) => Material(
          color: Colors.transparent,
          child: Listener(
            onPointerMove: (event) {
              for (int index = 0; index < _reactions.length; index++) {
                final box = context.findRenderObject() as RenderBox?;
                if (box != null) {
                  final localPosition = box.globalToLocal(event.position);
                  final reactionWidth =
                      (box.size.width - 16 * (_reactions.length - 1)) /
                          _reactions.length;
                  final reactionBounds = Rect.fromLTWH(
                    index * (reactionWidth + 16),
                    0,
                    reactionWidth,
                    box.size.height,
                  );
          
                  if (reactionBounds.contains(localPosition)) {
                    _onPointerEnter(index);
                    return;
                  }
                }
              }
          
              _onPointerExit();
            },
            onPointerUp: (event) {
              _onPointerExit();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
              child: RedContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_reactions.length, (index) {
                    double fontSize;
                    if (_hoverStates[index]) {
                      fontSize = expandedSize;
                    } else if (_currentHoveredIndex != null) {
                      fontSize = shrunkSize;
                    } else {
                      fontSize = normalSize;
                    }
                    _lastFontSizes[index] = fontSize;
          
                    return TweenAnimationBuilder(
                      tween: Tween(begin: _lastFontSizes[index], end: fontSize),
                      duration: const Duration(milliseconds: 200),
                      builder: (context, size, _) => Text(
                        _reactions[index],
                        style: TextStyle(fontSize: size),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class RedContainer extends StatelessWidget {
  const RedContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red
        )
      ),
      child: child,
    );
  }
}