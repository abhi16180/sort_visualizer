import 'package:flutter/material.dart';
import 'package:sort_visualizer/controller/controller.dart';
import 'package:get/get.dart';
import 'package:sort_visualizer/widgets/alert_dialog.dart';
import 'package:sort_visualizer/widgets/random_numbers.dart';
import 'dart:ui' as ui;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'questrial', brightness: Brightness.dark),
      home: const App(),
      routes: {
        'home': (context) => const App(),
      },
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final dataController = DataController();
  List<String> items = ["Selection Sort", "Insertion Sort", "Bubble Sort"];
  String selectedValue = "Selection Sort";
  double _sigmaX = 0.0; // from 0-10
  double _sigmaY = 0.0; // from 0-10
  double _opacity = 0.1; // from 0-1.0

  @override
  Widget build(BuildContext context) {
    Get.put<DataController>(dataController, tag: 'dataController');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: SizedBox(
                width: 250,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.blueAccent,
                  ),
                  // Initial Value
                  value: selectedValue,
                  // Down Arrow Icon
                  // Array list of items
                  items: items.map((String item) {
                    return DropdownMenuItem(
                      value: item.toString(),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 200,
                          child: Text(
                            item,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 54, 136, 244),
                    Color.fromARGB(255, 101, 206, 255),
                  ], begin: Alignment.topLeft, end: Alignment.centerRight)),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: 56,
                width: 250,
                child: InkWell(
                  onTap: () {
                    Get.put<String>(selectedValue, tag: 'sortType');
                    showDialog(
                        context: context,
                        builder: (context) {
                          return EnterData(
                            sortType: selectedValue,
                          );
                        });
                  },
                  child: const Center(child: Text('Enter numbers')),
                ),
              ),
            ),
            const SizedBox(
              width: 100,
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 54, 136, 244),
                    Color.fromARGB(255, 101, 206, 255),
                  ], begin: Alignment.topLeft, end: Alignment.centerRight)),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: 56,
                width: 250,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => RandomNumbersGenerator(
                        sortType: selectedValue,
                      ),
                    );
                  },
                  child: const Center(child: Text('Random numbers')),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
