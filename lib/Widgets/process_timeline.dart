import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 50.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Colors.blue; //Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class ProcessTimelinePage extends StatefulWidget {
  int processIndex;
  String type;

  ProcessTimelinePage({this.processIndex = 0, required this.type});

  @override
  _ProcessTimelinePageState createState() => _ProcessTimelinePageState();
}

class _ProcessTimelinePageState extends State<ProcessTimelinePage> {
  // int _processIndex = 0;

  Color getColor(int index) {
    if (index == widget.processIndex) {
      return inProgressColor;
    } else if (index < widget.processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  // Widget getwidget(int indexx) {
  //   switch (indexx) {
  //     case 0:
  //       return Icon(Icons.person_outline_outlined);

  //     default:
  //   }

  //   // if (indexx == 0) {
  //   //   return Icon(Icons.person_outline_outlined);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   backgroundColor: Colors.white,
        //   appBar:AppBar(title:Text('Process Timeline'),),
        //   body:
        Container(
      height: 130,
      //width: 20,
      child: Center(
        child: Timeline.tileBuilder(
          theme: TimelineThemeData(
            direction: Axis.horizontal,
            connectorTheme: ConnectorThemeData(
              space: 25.0,
              thickness: 2.0,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemExtentBuilder: (_, __) => widget.type == "coach"
                ? MediaQuery.of(context).size.width / 3.5
                : widget.type == "supporter"
                    ? MediaQuery.of(context).size.width / 2.2
                    : MediaQuery.of(context).size.width / 4.6,
            oppositeContentsBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Icon(widgetlist[index], color: getColor(index)),
                // child: Image.asset(
                //   'images/processTimeline/status${index + 1}.png',
                //   width: 50.0,
                //   color: getColor(index),
                // ),
              );
            },
            contentsBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  processes[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: getColor(index),
                  ),
                ),
              );
            },
            indicatorBuilder: (_, index) {
              var color;
              var child;
              if (index == widget.processIndex) {
                color = inProgressColor;
                child = Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              } else if (index < widget.processIndex) {
                color = completeColor;
                child = Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 10.0,
                );
              } else {
                color = todoColor;
              }

              if (index <= widget.processIndex) {
                return Stack(
                  children: [
                    CustomPaint(
                      size: Size(30.0, 30.0),
                      painter: _BezierPainter(
                        color: color,
                        drawStart: index > 0,
                        drawEnd: index < widget.processIndex,
                      ),
                    ),
                    DotIndicator(
                      size: 30.0,
                      color: color,
                      child: child,
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: [
                    CustomPaint(
                      size: Size(15.0, 15.0),
                      painter: _BezierPainter(
                        color: color,
                        drawEnd: index < processes.length - 1,
                      ),
                    ),
                    OutlinedDotIndicator(
                      borderWidth: 2.0,
                      color: color,
                    ),
                  ],
                );
              }
            },
            connectorBuilder: (_, index, type) {
              if (index > 0) {
                if (index == widget.processIndex) {
                  final prevColor = getColor(index - 1);
                  final color = getColor(index);
                  List<Color> gradientColors;
                  if (type == ConnectorType.start) {
                    gradientColors = [
                      Color.lerp(prevColor, color, 0.5)!,
                      color
                    ];
                  } else {
                    gradientColors = [
                      prevColor,
                      Color.lerp(prevColor, color, 0.5)!
                    ];
                  }
                  return DecoratedLineConnector(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                      ),
                    ),
                  );
                } else {
                  return SolidLineConnector(
                    color: getColor(index),
                  );
                }
              } else {
                return null;
              }
            },
            itemCount: processes.length,
          ),
        ),
      ),
    );
    // floatingActionButton: FloatingActionButton(
    //   child: Icon(Icons.arrow_right),
    //   onPressed: () {
    //     setState(() {
    //       _processIndex = (_processIndex + 1) % _processes.length;
    //     });
    //   },
    //   backgroundColor: inProgressColor,
    // ),
    // );
  }
}

/// hardcoded bezier painter
/// TODO: Bezier curve into package component
class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color? color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color!;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

List processes = [
  'Identity',
  'Localisation',
  'Field \nPosition',
  'Techninal \nSkills',
];

List<IconData> widgetlist = [
  Icons.person_outline_outlined,
  // Icon(
  //   Icons.person_outline_outlined,
  // ),
  Icons.language_outlined,
  Icons.sports_soccer_outlined,
  Icons.sports_soccer_outlined,
  // Icon(

  // ),
  // Icon(
  //   Icons.sports_football_outlined,
  // ),
  // Icon(
  //   Icons.sports_football_outlined,
  // ),
];
