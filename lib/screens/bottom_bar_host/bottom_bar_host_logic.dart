import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BottomBarHostController extends GetxController
{
  RxBool home = true.obs;
  RxBool reports = true.obs;
  RxBool account = true.obs;
  RxBool branchesSelected = false.obs;
  RxBool start = false.obs;
  RxBool reportsSelected = false.obs;
  RxBool selectedBranch = false.obs;
  RxBool bellSelected = false.obs;
  RxBool selectService = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    home.value = true;
    reports.value = false;
    account.value = false;
    branchesSelected.value = false;
    reportsSelected.value = false;
    selectedBranch.value = false;
    start.value = false;
    selectService.value = false;
  }

  void makeStart() {
    start.value = true;
    selectedBranch.value = false;
    branchesSelected.value = false;
    update();
  }

  void goToSelectedBranch() {
    selectedBranch.value = true;
    branchesSelected.value = false;
    update();
  }

  void goToSelectService() {
    selectService.value = true;
    home.value = false;
    account.value = false;
    branchesSelected.value = false;
    selectedBranch.value = false;
    start.value = false;
    bellSelected.value = false;
    update();
  }

  void goToNotifications() {
    bellSelected.value = true;
    update();
  }

  void goToBranches() {
    selectedBranch.value = false;
    branchesSelected.value = true;
    update();
  }

  void selectBranches() {
    branchesSelected.value = true;
    update();
  }

  void backToBranchesView() {
    branchesSelected.value = true;
    selectedBranch.value = false;
    update();
  }

  void backToSelectedBranch() {
    selectedBranch.value = true;
    start.value = false;

    update();
  }

  void backToAllView() {
    branchesSelected.value = false;
    bellSelected.value = false;
    update();
  }

  void makeHome() {
    home.value = true;
    reports.value = false;
    account.value = false;

    update();
  }

  void makeReports() {
    home.value = false;
    reports.value = true;
    account.value = false;
    branchesSelected.value = false;
    selectedBranch.value = false;
    start.value = false;
    bellSelected.value = false;
    update();
  }

  void makeAccount() {
    home.value = false;
    reports.value = false;
    account.value = true;
    branchesSelected.value = false;
    selectedBranch.value = false;
    start.value = false;
    update();
  }
}
