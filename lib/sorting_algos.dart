import 'controller/controller.dart';
import 'package:get/get.dart';

class SortingAlgo {
  final dataController = Get.find<DataController>(tag: 'dataController');
  // Function animate = Get.find<Function>(tag: 'animator');
  void bubbleSort() async {
    int lengthOfData = dataController.data.length;

    for (int i = 0; i < lengthOfData - 1; i++) {
      for (int j = 0; j < lengthOfData - i - 1; j++) {
        if (dataController.data[j] > dataController.data[j + 1]) {
          int temp = dataController.data[j];
          dataController.data[j] = dataController.data[j + 1];
          dataController.data[j + 1] = temp;

          await Future.delayed(Duration(
            milliseconds: lengthOfData > 100 ? 0 : 200,
          ));
        }
      }
    }
  }

  void selectionSort() async {
    final lengthOfData = dataController.data.length;
    for (int i = 0; i < dataController.data.length - 1; i++) {
      int minIndex = i;
      for (int j = i + 1; j < dataController.data.length; j++) {
        if (dataController.data[j] < dataController.data[minIndex]) {
          minIndex = j;
        }
      }
      await Future.delayed(
          Duration(milliseconds: lengthOfData > 100 ? 0 : 200));
      int temp = dataController.data[i];
      dataController.data[i] = dataController.data[minIndex];
      dataController.data[minIndex] = temp;
    }
  }

  void insertionSort() async {
    final lengthOfData = dataController.data.length;
    for (int i = 1; i < dataController.data.length; i++) {
      int j = i - 1;
      int key = dataController.data[i];
      while (j >= 0 && dataController.data[j] > key) {
        dataController.data[j + 1] = dataController.data[j];
        j = j - 1;
        await Future.delayed(
            Duration(milliseconds: lengthOfData > 100 ? 0 : 200));
      }
      dataController.data[j + 1] = key;
    }
  }

  void swap(List list, int i, int j) async {
    int temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }
}
