import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../mainscreen.dart';

// ignore: must_be_immutable
class EnterData extends StatefulWidget {
  String? sortType;
  EnterData({Key? key, required this.sortType}) : super(key: key);

  @override
  State<EnterData> createState() => _EnterDataState();
}

class _EnterDataState extends State<EnterData> {
  // ignore: prefer_final_fields

  TextEditingController _dataHandler = TextEditingController();
  DataController dataController =
      Get.find<DataController>(tag: 'dataController');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Enter space separated integers'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    enabled: true,
                    controller: _dataHandler,
                    decoration: InputDecoration(
                      hintText: 'Enter the data here',
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
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlue]),
              ),
              child: MaterialButton(
                onPressed: () {
                  dataController.data.value = _dataHandler.text
                      .split(' ')
                      .toList()
                      .map((e) => int.parse(e))
                      .toList();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                        sortType: widget.sortType,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Go',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
