import 'dart:collection';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;

class postCodeAPI {
  Future<Map<String, String>> getData(String postCode, String number) async {
    {
      Map<String, String> addressData = HashMap();


      final postCodeCheck = RegExp(r'^[1-9][0-9]{3} ?(?!sa|sd|ss)[A-Za-z]{2}$');
      if(!postCodeCheck.hasMatch(postCode)){
        print("postcode is fout!");
        return addressData;
      }

      final numberCheck = RegExp(r'[0-9]+');
      if(!numberCheck.hasMatch(postCode)){
        print("huisnummer is fout!");
        return addressData;
      }


      var token = '5d1bbc5f-2e53-407a-9a5b-d1bbe8e5df38';
      var url = Uri.https(
        'postcode.tech',
        'api/v1/postcode/full',
        {'postcode': '$postCode', 'number': '$number'},
      );


      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(
        url,
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
        addressData['province'] = jsonResponse['province'];
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return addressData;
      }
      return addressData;
    }
  }


}
