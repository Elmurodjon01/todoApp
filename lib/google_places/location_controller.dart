import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

class GoogleAddressSearchPage extends StatefulWidget {
  const GoogleAddressSearchPage({super.key});

  @override
  State<GoogleAddressSearchPage> createState() =>
      _GoogleAddressSearchPageState();
}

class _GoogleAddressSearchPageState extends State<GoogleAddressSearchPage> {
  final searchController = TextEditingController();
  final controller = Get.put(VMGoogleSearch());
  @override
  void initState() {
    searchController.addListener(() {
      controller.onChanged(searchController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주소 검색'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 55,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search place ...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: searchController.clear,
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            Expanded(
              child: GetBuilder(
                init: controller,
                builder: (value) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.listOfLocations.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => controller.chosenAddress =
                            value.listOfLocations[index]['description'],
                        child: ListTile(
                          title: Text(
                            value.listOfLocations[index]['description'],
                          ),
                          subtitle: const Divider(
                            color: Colors.grey,
                          ),
                          trailing: const Icon(Icons.north_east),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VMGoogleSearch extends GetxController {
  String token = '133324335';
  List<dynamic> listOfLocations = [];
  String chosenAddress = '';

  onChanged(TextEditingController controller) {
    placeSuggestion(controller.text);
  }

  void placeSuggestion(String input) async {
    const String apiKey = "AIzaSyAXiBssmSBcY9LcRIzesJdBVPFjgKkotko";
    try {
      String baseUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request = "$baseUrl?input=$input&key=$apiKey&sessiontoken=$token";
      //inpute or input
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print(data);
      }
      if (response.statusCode == 200) {
        listOfLocations = json.decode(response.body)['predictions'];

        update();
      } else {
        throw Exception('Failed to load the address');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
