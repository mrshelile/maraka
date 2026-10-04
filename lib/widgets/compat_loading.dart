import 'package:flutter/material.dart';

class SpinKitFoldingCube extends StatelessWidget {
  const SpinKitFoldingCube({
    super.key,
    this.color = Colors.white,
    this.size = 50,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: size / 12,
      ),
    );
  }
}

class SpinKitSpinningLines extends StatelessWidget {
  const SpinKitSpinningLines({
    super.key,
    this.color = Colors.white,
    this.size = 50,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: size / 12,
      ),
    );
  }
}

class SpinKitThreeInOut extends StatelessWidget {
  const SpinKitThreeInOut({
    super.key,
    this.color = Colors.white,
    this.size = 50,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: size / 12,
      ),
    );
  }
}
