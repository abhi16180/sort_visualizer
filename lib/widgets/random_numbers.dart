import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sort_visualizer/controller/controller.dart';
import 'package:sort_visualizer/mainscreen.dart';

// ignore: must_be_immutable
class RandomNumbersGenerator extends StatefulWidget {
  String? sortType;
  RandomNumbersGenerator({
    Key? key,
    this.sortType,
  }) : super(key: key);

  @override
  State<RandomNumbersGenerator> createState() => _RandomNumbersGeneratorState();
}

class _RandomNumbersGeneratorState extends State<RandomNumbersGenerator> {
  TextEditingController _lowerLimitController = TextEditingController();
  TextEditingController _higherLimitController = TextEditingController();
  TextEditingController _arraySizeController = TextEditingController();
  late int lowerLimit;
  late int higherLimit;
  late int size;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
            width: MediaQuery.of(context).size.width > 600 ? 500 : 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select the range of numbers',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: TextField(
                    controller: _lowerLimitController,
                    decoration: InputDecoration(
                      labelText: 'Lower limit',
                      hintText: 'Enter lower limit',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(202, 241, 240, 240)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ),
                Card(
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: TextField(
                    controller: _higherLimitController,
                    decoration: InputDecoration(
                      labelText: 'Higher limit',
                      hintText: 'Enter higher limit',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(202, 241, 240, 240)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ),
                Card(
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: TextField(
                    controller: _arraySizeController,
                    decoration: InputDecoration(
                      labelText: 'Size of the array',
                      hintText: 'should be >10',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(202, 241, 240, 240)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlue]),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                    onPressed: () {
                      lowerLimit = int.parse(_lowerLimitController.text);
                      higherLimit = int.parse(_higherLimitController.text);
                      size = int.parse(_arraySizeController.text);
                      if (lowerLimit < higherLimit) {
                        generateRandomList(lowerLimit, higherLimit, size);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                      sortType: widget.sortType,
                                    )));
                      } else {}
                    },
                    child: const Text(
                      'Go',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }

  generateRandomList(int low, int high, int size) {
    var rnd = Random();
    List<int> lst = [];
    final dataController = Get.find<DataController>(tag: 'dataController');

    for (int i = 0; i < size; i++) {
      int number = low + rnd.nextInt(high - low);
      lst.insert(i, number);
    }
    dataController.data.value = lst;
  }
}
