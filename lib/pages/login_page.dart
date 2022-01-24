// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:one_lead/common/custom_progress.dart';
import 'package:one_lead/constants/color_code.dart';
import 'package:one_lead/utils/my_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = "";
  String _password = "";
  String _showError = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _username = "";
    _password = "";
    _showError = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: loading? customProgress(context): Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150,
                  color: ColorCodes.primary,
                ),
                const Positioned(
                  top: 90,
                  child: Image(
                      image: AssetImage('assets/logo.png'),
                      width: 150,
                      height: 150),
                )
              ],
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (username) => {
                      setState(() {
                        _username = username;
                        _showError = "";
                      })
                    },
                    style: const TextStyle(color: Colors.black),
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: ColorCodes.secondary,
                        border: InputBorder.none,
                        counterText: "",
                        hintText: "Username"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    onChanged: (password) => {
                      setState(() {
                        _password = password;
                        _showError = "";
                      })
                    },
                    obscureText: true,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: ColorCodes.secondary,
                        border: InputBorder.none,
                        counterText: "",
                        hintText: "Password"),
                  ),
                  const SizedBox(height: 40),
                  InkWell(
                      onTap: () => _login(),
                      child: Container(
                        color: ColorCodes.primary,
                        width: double.infinity,
                        height: 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text("Login",
                                style: TextStyle(
                                    color: ColorCodes.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Text(
                    _showError,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Send login credentials to server.
  _login() async {
    // check for empty details.
    setState(() {
      loading = true;
    });
    if (_username.trim() == "" || _password.trim() == "") {
      setState(() {
        _showError = "Username or password cannot be empty";
      });
    } else {
      try {
        // send login data to server
        var loginData = <String, dynamic>{};
        loginData['mobile'] = _username;
        loginData['psd'] = _password;

        // POST API CALL.
        var response = await MyHttp.post('/login.php', loginData);
        final Map responseData = json.decode(response.body);

        // If username or password is incorrect.
        if (responseData["status"] == 0) {
          setState(() {
            _showError = "Invalid username or password";
          });
        } else {
          // store authdata in sharedPreferences.
          var sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString(
              "emp_id", responseData["response"]["emp_id"]);
          sharedPreferences.setString(
              "crm_id", responseData["response"]["crm_id"]);
          sharedPreferences.setString(
              "com_id", responseData["response"]["com_id"]);
          if (responseData["response"]["org"] != null) {
            sharedPreferences.setString("org", responseData["response"]["org"]);
          }

         
          // navigate user to dashboard page.
          Navigator.pushNamed(context, "/dashboard");
        }
      } catch (e) {
        print("Error:  $e");
      }
    }
  }
}
