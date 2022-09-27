import 'dart:collection';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;

class postCodeAPI{
  Future<Map<String, String>> getData() async{
    {
      Map<String, String> addressData = HashMap();
      var token = '5d1bbc5f-2e53-407a-9a5b-d1bbe8e5df38';
      var url =
      Uri.https('postcode.tech', 'api/v1/postcode/full',
        {'postcode': '4174HG', 'number': '3'},);
      print(url);

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

        addressData['postalCode'] = jsonResponse['postcode'];
        addressData['number'] = jsonResponse['number'].toString();
        addressData['street'] = jsonResponse['street'];
        addressData['city'] = jsonResponse['city'];
        addressData['municipality'] = jsonResponse['municipality'];

      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      return addressData;
    }
  }
}