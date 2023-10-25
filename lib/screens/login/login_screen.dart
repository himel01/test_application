import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_application_it_grow/screens/home/home_screen.dart';
import 'package:test_application_it_grow/screens/login/login_model.dart';
import 'package:test_application_it_grow/utils/api_service.dart';
import 'package:test_application_it_grow/utils/display_size.dart';
import 'package:test_application_it_grow/utils/nav_util.dart';
import 'package:test_application_it_grow/utils/urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? idController;
  TextEditingController? passwordController;
  var loginResponseModel = LoginResponseModel();

  bool passwordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idController = TextEditingController();
    passwordController = TextEditingController();
    syncDataWithProvider();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    idController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            height: displayHeight(context),
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: "Enter ID",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelStyle: TextStyle(fontSize: 16)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    labelStyle: const TextStyle(fontSize: 16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * (0.04),
                ),
                ElevatedButton(
                    onPressed: () {
                      onTapLogin();
                    },
                    child: const Text("Login")),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapLogin() async {
    if (idController!.text.isNotEmpty && passwordController!.text.isNotEmpty) {
      var body = {
        "login": idController!.text,
        "password": passwordController!.text
      };
      var response =
          await ApiService().postRequest(Urls.loginUrl, body, context);

      loginResponseModel = loginResponseModelFromJson(response.body);

      if (loginResponseModel.result == true) {
        await saveLoginData(loginResponseModel.token!);
        NavUtil.navigateScreen(context, const Home());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something Went Wrong, Try again Later")));
      }
    }
  }

  Future syncDataWithProvider() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? id = sharedPreferences.getString("id");
    String? password = sharedPreferences.getString("password");
    if (id != null && id.toString().isNotEmpty) {
      idController!.text = id;
      passwordController!.text = password!;
    } else {}
  }

  Future<void> saveLoginData(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("id", idController!.text);
    await preferences.setString("password", passwordController!.text);
    await preferences.setString("token", token);
  }
}
