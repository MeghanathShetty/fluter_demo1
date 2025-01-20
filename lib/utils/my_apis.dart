import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:demo1/utils/my_constants.dart';

class UserDioController extends GetxController {
  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  var user = {}.obs;
  Future<void> getUser() async{
    try{
      final response = await dio.get(MyConstants.fetchUserUrl);
      user.value = response.data['results'][0];
      // print('FetchData1 data = ${response.data}');
    }catch(e){
      // user.value = {'error':'${MyConstants.errorMsg} : $e'};
      print('getUser Error = $e');
    }
  }
}

class TourismDioController extends GetxController {
  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    getTourism();
  }

  var tourism = <Map<String, dynamic>>[].obs;
  Future<void> getTourism() async {
    try {
      // print("=============Fetching Tourism Data===========================================\n");

      final response = await dio.get(MyConstants.fetchTourismUrl);

      // Make sure the response.data is a list and update the tourism list
      tourism.value = List<Map<String, dynamic>>.from(response.data);
      // print('\n\n\n${tourism.value.runtimeType}');
      // print('Fetched Tourism data = \n${response.data}');
    } catch (e) {
      print('getTourism Error = $e');
    }
  }
}