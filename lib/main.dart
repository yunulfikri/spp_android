import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spp_app/Home.dart';

import 'Models/userModels.dart';

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

class _LoginPageState extends State<LoginPage> {
  Size height;
  String nis;
  int nisnLogin;

  // nisnLogin = int.parse(nis);

  bool _autoValidate = false;
  final _key = GlobalKey<FormState>();

  login() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      nisnLogin = int.parse(nis);
      if (nisnLogin == akun.nisn) {
        print("sukses");
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext) => HomePage(data: akun,),
          ),
        );
      } else {
        print('data kosong');
      }
      print(nisnLogin);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                height: 200,
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
                      // onSaved: (e) {
                      //   nisn = e;
                      // },
                      validator: (e) {
                        if (e.isEmpty) {
                          return 'Data Kosong';
                        } else if (e.length < 5) {
                          return 'Minimal 6 angka';
                        }
                        final isDigitsOnly = int.tryParse(nis = e);
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
                              width: 1.5,
                              style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
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
                    Container(
                      height: 45,
                      width: 220,
                      child: RaisedButton(
                        onPressed: () {
                          login();
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
  }
}
