import 'package:country_code_picker/country_code.dart';
import 'package:get/get.dart';

class CountryCodeConrtroller extends GetxController{

  var contactsText = "".obs;
  var notificationToken = "".obs;

  var nameController = ''.obs;
  var numberController = ''.obs;
  var isNumberOk = false.obs;
  var isNameOk = false.obs;
  var countryCode = ''.obs;
  var documentId = '0'.obs;
  var isOnline = false.obs;
  var currentIndex = 1.obs;
  var flex = 1.obs;
  var optValue = 2.obs;
  var activeIndex = 1.obs;

  var isNotEmptyUserData = true.obs;

  var endDate = DateTime.now().obs;
  var startDate = DateTime.now().subtract(const Duration(days: 1)).obs;
}

void onCountryChange(CountryCode countryCode) {
  CountryCodeConrtroller _controller = Get.put(CountryCodeConrtroller());
  _controller.countryCode.value = countryCode.toString();
}


