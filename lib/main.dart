import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spp_app/Home.dart';
import 'package:spp_app/Models/api.dart';
import 'package:spp_app/home2.dart';
import 'Models/userModels.dart';
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

  // nisnLogin = int.parse(nis);

  bool _autoValidate = false;
  final _key = GlobalKey<FormState>();

  check() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      login();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  savePref(int value, String nisn, nama, jurusan, kelas, imageUrl, alamat,
      gender) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('value', value);
    preferences.setString('nisn', nisn);
    preferences.setString('nama_lengkap', nama);
    preferences.setString('jurusan', jurusan);
    preferences.setString('kelas', kelas);
    preferences.setString('imageUrl', imageUrl);
    preferences.setString('alamat', alamat);
    preferences.setString('gender', gender);
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
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
      preferences.setInt('value', null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
      pesan = null;
    });
  }

  Future login() async {
    final response = await http.post(
      BaseUrl.login,
      body: {
        'nisn': nisn,
      },
    );
    final data = jsonDecode(response.body);
    int value = data['value'];
    String nisnApi = data['nisn'];
    String namaApi = data['nama_lengkap'];
    String jurusanApi = data['jurusan'];
    String kelasApi = data['kelas'];
    String imageApi = data['imageUrl'];
    String alamatApi = data['alamat'];
    String genderApi = data['gender'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, nisnApi, namaApi, jurusanApi, kelasApi, imageApi,
            alamatApi, genderApi);
      });
    } else {
      setState(() {
        pesan = 'Nisn tidak ditemukan!';
      });
    }
  }

  Widget asd() {
    return null;
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
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          // onSaved: (user) => nisn = user,
                          validator: (e) {
                            if (e.isEmpty) {
                              return 'Masukkan Nisn Anda';
                            } else if (e.length < 5) {
                              return 'Minimal 6 angka';
                            }
                            final isDigitsOnly = int.tryParse(nisn = e);
                            return isDigitsOnly == null
                                ? 'Input needs to be digits only'
                                : null;
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
        return Home2();
        break;
    }
  }
}
