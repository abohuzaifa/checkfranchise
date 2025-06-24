import 'dart:convert';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../model/city_model.dart';

class CityListController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<CityModel> cityList = <CityModel>[].obs; // Store cities

  Future<void> cityListFunction() async {
    isLoading(true);
    String token = GetStorage().read('token');

    final http.Response response = await http.get(
      Uri.parse("${AppConstants.baseUrl}cityList"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      cityList.value = (decodedData as List)
          .map((city) => CityModel.fromJson(city))
          .toList();
    } else {
      print('Failed to load data: ${response.body}');
    }

    isLoading(false);
  }
}