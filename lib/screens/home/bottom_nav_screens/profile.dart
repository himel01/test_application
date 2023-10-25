import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_application_it_grow/screens/home/bottom_nav_screens/profile_model.dart';
import 'package:test_application_it_grow/utils/api_service.dart';
import 'package:test_application_it_grow/utils/display_size.dart';
import 'package:test_application_it_grow/utils/urls.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String loginId = "";
  String savedToken = "";
  ProfileModel? profileModel;
  String digits = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    syncDataWithProvider().then((value) {
      getUser();
    });
  }

  Future syncDataWithProvider() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? id = sharedPreferences.getString("id");
    String? token = sharedPreferences.getString("token");
    if (id != null && id.toString().isNotEmpty) {
      loginId = id;
      savedToken = token!;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
        centerTitle: true,
      ),
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        margin: const EdgeInsets.all(30.0),
        child: profileModel != null
            ? Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text("Name - ${profileModel!.name!}"),
                  _text("Address - ${profileModel!.address!}"),
                  _text("Balance - ${profileModel!.balance}"),
                  _text("City - ${profileModel!.city!}"),
                  _text("Country - ${profileModel!.country!}"),
                  _text("Last Four digit - $digits"),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> getUser() async {
    var body = {"login": loginId, "token": savedToken};
    var response = await ApiService().postRequest(Urls.accountInfoUrl, body);
    var digitResponse =
        await ApiService().postRequest(Urls.getLastDigitsUrl, body);

    if (response.statusCode == 200 && digitResponse.statusCode == 200) {
      setState(() {
        digits = digitResponse.body.toString().substring(9, 13);
        profileModel = ProfileModel.fromJson(jsonDecode(response.body));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something Went Wrong, Try again Later")));
    }
  }

  Widget _text(String s) {
    return Text(
      s,
      style: TextStyle(
          color: Colors.blue,
          fontSize: displayWidth(context) * 0.05,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold),
    );
  }
}
