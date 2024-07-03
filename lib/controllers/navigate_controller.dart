import 'package:get/get.dart';


class MyController extends GetxController {
  var selectedSidebarItem = '/'.obs;

  void updateSelectedSidebarItem(String item) {
    selectedSidebarItem.value = item;
  }
}

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}