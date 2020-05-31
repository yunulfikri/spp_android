import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spp_app/Home.dart';
import 'package:spp_app/Models/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      title: 'Aplikasi Bayar SPP',
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { signIn, notSignIn }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  String nisn;

  String pesan;

  bool _autoValidate = false;
  final _key = GlobalKey<FormState>();

  check() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      login();
      // print(nisn);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  savePref(
    String nisn,
    nama,
    jurusan,
    kelas,
    gender,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('nisn', nisn);
    preferences.setString('nama', nama);
    preferences.setString('gender', gender);
    preferences.setString('jurusan', jurusan);
    preferences.setString('kelas', kelas);
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nisn = preferences.getString('nisn');

      _loginStatus = nisn == null ? LoginStatus.notSignIn : LoginStatus.signIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString('nisn', null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
      pesan = null;
    });
  }

  Future login() async {
    final response = await http.post(
      BaseUrl.login,
      headers: {"Accept": "application/json"},
      body: {
        'nisn': nisn,
      },
    );
    print(response.request);
    final data = jsonDecode(response.body);
    String nisnApi = data['nisn'];
    String namaApi = data['nama'];
    String jurusanApi = data['jurusan'];
    String kelasApi = data['kelas'];
    String genderApi = data['gender'];
    if (response.statusCode != 200) {
      setState(() {
        pesan="Login Gagal";
      });
    } else {
      this.setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(
          nisnApi,
          namaApi,
          jurusanApi,
          kelasApi,
          genderApi,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          // backgroundColor: Colors.amberAccent,
          body: Container(
            color: Colors.lightBlueAccent,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100)),
                  ),
                  child: Center(
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/smk5telkom.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
                Form(
                  autovalidate: _autoValidate,
                  key: _key,
                  child: Container(
                    margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                    height: 210,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (user) => nisn = user,
                          validator: (e) {
                            if (e.isEmpty) {
                              return 'Masukkan Nisn Anda';
                            } else if (e.length < 5) {
                              return 'Minimal 6 angka';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Masukkan Nisn",
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.account_circle,
                              size: 30,
                              color: Colors.blue,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.3,
                                  style: BorderStyle.solid),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      pesan == null ? Colors.black : Colors.red,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                            ),
                          ),
                        ),
                        pesan != null
                            ? Center(
                                child: Text(
                                  pesan,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                          height: 45,
                          width: 220,
                          margin: EdgeInsets.only(bottom: 10),
                          child: RaisedButton(
                            onPressed: () {
                              check();
                            },
                            color: Colors.blue,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return HomePage(signOut,nisn);
        break;
    }
  }
}
