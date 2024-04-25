part of 'image_compare_slider.dart';

class _DividerPainter extends CustomPainter {
  const _DividerPainter({
    required this.position,
    required this.color,
    required this.handleColor,
    required this.handleOutlineColor,
    required this.strokeWidth,
    required this.portrait,
    required this.hideHandle,
    required this.handlePosition,
    required this.fillHandle,
    required this.handleSize,
    required this.handleRadius,
    required this.visibleControlHandle,
  });

  final double position;
  final Color color;
  final Color handleColor;
  final Color handleOutlineColor;
  final double strokeWidth;
  final bool portrait;
  final bool hideHandle;
  final bool fillHandle;
  final double handlePosition;
  final Size handleSize;
  final BorderRadius handleRadius;
  final bool visibleControlHandle;

  @override
  void paint(Canvas canvas, Size size) {
    final color = strokeWidth == 0.0000 ? Colors.transparent : this.color;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final dx = portrait ? size.width * handlePosition : size.width * position;
    final dy = portrait ? size.height * position : size.height * handlePosition;
    final handle = hideHandle
        ? Size.zero
        : portrait
            ? Size(handleSize.height, handleSize.width)
            : Size(handleSize.width, handleSize.height);

    canvas
      ..drawLine(
        portrait ? Offset(0, dy) : Offset(dx, 0),
        portrait
            ? Offset(dx - handle.width / 2, dy)
            : Offset(dx, dy - handle.height / 2),
        paint,
      )
      ..drawLine(
        portrait
            ? Offset(dx + handle.width / 2, dy)
            : Offset(dx, dy + handle.height / 2),
        portrait ? Offset(size.width, dy) : Offset(dx, size.height),
        paint,
      );

    if (!hideHandle) {
      final circlePaint = Paint()
        ..color = handleColor
        ..style = PaintingStyle.fill;
      final rect = Rect.fromCenter(
        center: Offset(dx, dy),
        width: handle.width,
        height: handle.height,
      );

      if (fillHandle) canvas.drawRRect(handleRadius.toRRect(rect), circlePaint);

      final handleOutlinePaint = Paint()
        ..color = handleOutlineColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt;
      canvas.drawRRect(handleRadius.toRRect(rect), handleOutlinePaint);

      if (visibleControlHandle) {
        // Draw icons
        const iconPadding = 0.0;
        const iconSize = 18.0;

        // Draw left icon
        const leftIcon = Icons.arrow_left_sharp;
        final textLeftPainter = TextPainter(textDirection: TextDirection.ltr);
        // ignore: cascade_invocations
        textLeftPainter
          ..text = TextSpan(
            text: String.fromCharCode(leftIcon.codePoint),
            style: TextStyle(
              color: Colors.black,
              fontSize: iconSize,
              fontFamily: leftIcon.fontFamily,
              package: leftIcon.fontPackage,
            ),
          )
          ..layout()
          ..paint(
            canvas,
            Offset(dx - handle.height / 2 + iconPadding, dy - iconSize / 2),
          );

        // Draw left icon
        const rightIcon = Icons.arrow_right_sharp;
        final textRightPainter = TextPainter(textDirection: TextDirection.ltr);
        // ignore: cascade_invocations
        textRightPainter
          ..text = TextSpan(
            text: String.fromCharCode(rightIcon.codePoint),
            style: TextStyle(
              color: Colors.black,
              fontSize: iconSize,
              fontFamily: rightIcon.fontFamily,
              package: rightIcon.fontPackage,
            ),
          )
          ..layout()
          ..paint(
            canvas,
            Offset(
              dx + iconPadding,
              dy - iconSize / 2,
            ),
          );
      }
    }
  }

  @override
  bool shouldRepaint(_DividerPainter oldDelegate) => true;
}
