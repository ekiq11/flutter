import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/screens/admin/main_screen_admin.dart';
import 'package:pdp_wisatakuliner/screens/forgot_pass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';
import 'package:pdp_wisatakuliner/modals/api.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginScreenState extends State<LoginScreen> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String username, password;
  final _key = new GlobalKey<FormState>();

  bool _scurePassword = true;

  showHide() {
    setState(() {
      _scurePassword = !_scurePassword;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http.post(BaseURL.login, body: {
      "username": username,
      "password": password,
    });
    final data = jsonDecode(response.body);
    String level = data['level'];
    String message = data['message'];
    String id = data['id'];
    String usernameAPI = data['username'];
    String namaAPI = data['nama'];
    String jenisKelamin = data['jenisKelamin'];
    String nohp = data['nohp'];
    String alamat = data['alamat'];
    String img = data['img'];

    if (level == '1') {
      setState(() {
        savePref(
            level, id, usernameAPI, namaAPI, jenisKelamin, nohp, alamat, img);
        print(message);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MainScreen();
            },
          ),
        );
      });
    } else if (level == '2') {
      setState(() {
        savePref(
            level, id, usernameAPI, namaAPI, jenisKelamin, nohp, alamat, img);
        print(message);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MainScreenAdmin();
            },
          ),
        );
      });
    } else {
      // set up the button
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () => Navigator.pop(context),
      );
      print("hasil");
      print(level);
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Gagal login"),
        content: Text("Maaf, username dan password Anda salah,, ."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  savePref(String level, String id, String username, String nama,
      String jenisKelamin, String nohp, String alamat, String img) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("level", level);
      preferences.setString("id", id);
      preferences.setString("username", username);
      preferences.setString("nama", nama);
      preferences.setString("jenisKelamin", jenisKelamin);
      preferences.setString("nohp", nohp);
      preferences.setString("alamat", alamat);
      preferences.setString("img", img);
      print(level);
      print(id);
      print(nama);
      print(username);
      print(jenisKelamin);
      print(nohp);
      print(alamat);
      print(img);
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
          child: Form(
            key: _key,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: 25.0,
                  ),
                  child: Text(
                    "Log in to your account",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Card(
                  elevation: 3.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: TextField(
                      onChanged: (e) => username = e,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: "Username/Email",
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Card(
                  elevation: 3.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: TextField(
                      obscureText: _scurePassword,
                      onChanged: (e) => password = e,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(_scurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Colors.redAccent),
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ForgotPass();
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    child: Text(
                      "LOGIN".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      check();
                    },
                    color: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(height: 10.0),
                Divider(
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {},
                          fillColor: Colors.blue[800],
                          shape: CircleBorder(),
                          elevation: 4.0,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.white,
//              size: 24.0,
                            ),
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          fillColor: Colors.white,
                          shape: CircleBorder(),
                          elevation: 4.0,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              FontAwesomeIcons.google,
                              color: Colors.blue[800],
//              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return MainScreen();
        break;
    }
  }
}
