import 'package:country_code_picker/country_code.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController{

  var hasInternet = false.obs;
  var isSubscribe = false.obs;
  var contactsText = "".obs;
  var notificationToken = "".obs;

  var addState = 0.obs;
  var nameController = ''.obs;
  var numberController = ''.obs;
  var countryCode = ''.obs;
  var verifyController = ''.obs;
  var documentId = '0'.obs;

  var endDate = DateTime.now().obs;
  var startDate = DateTime.now().subtract(const Duration(days: 1)).obs;
}

void onCountryChange(CountryCode countryCode) {
  ProjectController _controller = Get.put(ProjectController());
  _controller.countryCode.value = countryCode.toString();
}


