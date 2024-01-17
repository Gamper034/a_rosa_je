import 'package:a_rosa_je/services/api/data_api.dart';

class GuardService {
  Future<Map<String, dynamic>> addGuard(String startDate, String endDate,
      String address, String zipCode, String city, List plants) async {
    DataApi dataApi = DataApi();
    var result = await dataApi.addGuard(
        startDate, endDate, address, zipCode, city, plants);

    return result;
  }
}
