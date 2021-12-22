import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CovidData {
  String lastUpdate = '', infections = '', deaths = '', recovers = '';
  // const CovidData({required this.lastUpdate, required this.infections, required this.deaths, required this.recovers});
}

Future<CovidData> fetchCovidAPI({required bool isVN}) async {
  CovidData covidData = new CovidData();
  String baseAPI =
      "https://crn-api.vgcloud.vn/ajax/api/getvnandtg/data.jsx?option=";
  var url = Uri.parse(isVN ? (baseAPI + '1') : (baseAPI + '0'));
  var response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);

    covidData.lastUpdate = data["lastUpdate"];
    covidData.infections =
        NumberFormat('###,###', 'en_US').format(data["data"]["confirmed"]);
    covidData.deaths =
        NumberFormat('###,###', 'en_US').format(data["data"]["deaths"]);
    covidData.recovers =
        NumberFormat('###,###', 'en_US').format(data["data"]["recovered"]);
  }

  return covidData;
}
