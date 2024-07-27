import 'package:flutter/material.dart';

class ColoredPoint {
  final Offset offset;
  final Color color;

  ColoredPoint(this.offset, this.color);
}

class PaintScreen extends StatefulWidget {
  @override
  _PaintScreenState createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  Color selectedColor = Colors.red;
  List<ColoredPoint?> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paint'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Assuming this goes to the main menu
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                points.clear(); // Clear all points to clear the canvas
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox? renderBox = context.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              points.add(ColoredPoint(details.localPosition, selectedColor));
            }
          });
        },
        onPanEnd: (details) {
          setState(() {
            points.add(null); // Add a separator between lines
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: MyPainter(points),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0), // Add bottom padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _colorButton(Colors.red),
            _colorButton(Colors.green),
            _colorButton(Colors.blue),
            _colorButton(Colors.yellow),
          ],
        ),
      ),
    );
  }

  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<ColoredPoint?> points;

  MyPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        Paint paint = Paint()
          ..color = points[i]!.color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5.0;

        canvas.drawLine(points[i]!.offset, points[i + 1]!.offset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
