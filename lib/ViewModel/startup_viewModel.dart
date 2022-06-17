import 'package:get/get.dart';
import 'package:mentor_mentee_connecting/Constant/route_constraint.dart';
import 'package:mentor_mentee_connecting/Model/DAO/AccountDAO.dart';
import 'package:mentor_mentee_connecting/Utils/shared_pref.dart';
import 'package:mentor_mentee_connecting/ViewModel/root_viewModel.dart';

import 'base_model.dart';

class StartUpViewModel extends BaseModel {
  StartUpViewModel() {
    handleStartUpLogic();
  }
  Future handleStartUpLogic() async {
    AccountDAO _accountDAO = AccountDAO();
    await Future.delayed(Duration(seconds: 3));
    var hasLoggedInUser = await _accountDAO.isUserLoggedIn();
    bool isFirstOnBoard = await getIsFirstOnboard() ?? true;

    if (isFirstOnBoard) {
      await Get.find<RootViewModel>().startUp();
      Get.offAndToNamed(RouteHandler.ONBOARD);
    } else if (hasLoggedInUser) {
      await Get.find<RootViewModel>().startUp();
      Get.offAndToNamed(RouteHandler.NAV);
    } else {
      Get.offAndToNamed(RouteHandler.LOGIN);
    }
  }
}
