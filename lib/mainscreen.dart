import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:sort_visualizer/controller/controller.dart';
import './sorting_algos.dart';
import 'package:get/get.dart';
import './controller/controller.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  String? sortType;
  MainScreen({Key? key, required this.sortType}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  double lineFraction = 0.0;
  late Animation<double> lineAnimation;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animate();
  }

  animate() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    lineAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {
          lineFraction = lineAnimation.value;
        });
      });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var dataController = Get.find<DataController>(tag: 'dataController');

    return Scaffold(
      appBar: PreferredSize(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 50,
                      color: ui.Color.fromARGB(255, 108, 255, 133),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.sortType.toString(),
                      style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'sfui'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 100)),
      body: Center(
          child: Container(
        margin: const EdgeInsets.only(right: 30),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Obx(
              () => CustomPaint(
                // ignore: invalid_use_of_protected_member
                painter: PaintSort(
                  data: dataController.data.value,
                  lineFraction: lineFraction,
                ),
                child: Container(),
              ),
            )),
      )),
      floatingActionButton: MaterialButton(
        onPressed: () {
          switch (widget.sortType) {
            case "Insertion Sort":
              SortingAlgo().insertionSort();
              break;
            case "Selection Sort":
              SortingAlgo().selectionSort();
              break;
            case "Bubble Sort":
              SortingAlgo().bubbleSort();
              break;
          }
        },
        child: const Icon(Icons.play_circle_fill_rounded,
            size: 100, color: ui.Color.fromARGB(255, 108, 255, 133)),
      ),
    );
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class PaintSort extends CustomPainter {
  List<dynamic>? data;
  double lineFraction;
  late double len;

  PaintSort({this.data, required this.lineFraction});
  @override
  void paint(Canvas canvas, Size size) {
    len = size.width / 2;
    List<int> finalData = [];
    for (int i = 0; i < data!.length; i++) {
      finalData.insert(i, data![i]);
    }

    for (int i = 0; i < finalData.length; i++) {
      var paint = Paint()
        ..shader = ui.Gradient.linear(
          Offset((size.width / 2 - (finalData.length * 40) / 2 + i * 40),
              size.height),
          Offset(
            (size.width / 2 - (finalData.length * 40) / 2 + i * 40),
            (size.height -
                (finalData[i] / (finalData.reduce(max))) * 400 * lineFraction),
          ),
          const [ui.Color.fromARGB(255, 54, 244, 86), Colors.blue],
        )
        ..strokeWidth = 4
        ..strokeCap = ui.StrokeCap.round;

      canvas.drawLine(
          Offset(
            -(len / 2 - size.width / 2) + (i * (len / finalData.length) + 14),
            size.height - 118,
          ),
          Offset(
              -(len / 2 - size.width / 2) + (i * (len / finalData.length) + 14),
              (size.height -
                      (finalData[i] / (finalData.reduce(max))) *
                          300 *
                          lineFraction) -
                  118),
          paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => true;
}
