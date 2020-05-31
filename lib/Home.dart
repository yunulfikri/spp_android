import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spp_app/profile.dart';
import 'package:spp_app/tagihan.dart';
import 'package:spp_app/transaksi.dart';
import 'Models/api.dart';
import 'Models/userModels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  final VoidCallback signOut;
  final String nis;

  HomePage(
    this.signOut,
    this.nis,
  );
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  signOut() {
    widget.signOut();
  }

  String nisn = "", nama = "", jurusan = '', kelas = '', gender = '';
  List list = List<TagihanModels>();
  var loading = false;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nisn = preferences.getString("nisn");
      nama = preferences.getString("nama");
      jurusan = preferences.getString("jurusan");
      kelas = preferences.getString("kelas");
      gender = preferences.getString('gender');
    });
  }

  Future viewData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.post(
      BaseUrl.tagihan,
      headers: {"Accept": "application/json"},
      body: {
        'nisn': widget.nis,
      },
    );

    this.setState(() {
      final data = jsonDecode(response.body.toString());
      data.forEach((api) {
        final ab = TagihanModels(
          api['nama'],
          api['jumlah'],
          api['diskon'],
          api['total'],
          api['is_lunas'].toString(),
          api['created_at'],
          api['keterangan'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    viewData();
  }

  bool sort = true;

  @override
  Widget build(BuildContext context) {
    // var item = widget.data;
    // var nisn = item.nisn.toString();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "$nama",
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text('$nisn'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                  gender == 'L' ? 'images/man.png' : 'images/girl.png',
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.verified_user),
            //   title: Text('Profile'),
            //   onTap: () => {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (context) => Profile()))
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Tagihan'),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Tagihan(
                              nis: nisn,
                            )))
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Transaksi'),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Transaksi(
                              nis: nisn,
                            )))
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => {signOut()},
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              height: 60,
              // color: Colors.yellowAccent,
              child: IconButton(
                icon: Icon(
                  Icons.sort,
                  size: 30,
                ),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  // color: Colors.blue,
                  ),
              child: Row(
                children: <Widget>[
                  Container(
                    // color: Colors.green,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 3.3,
                    child: Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          // color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: AssetImage(
                              gender == 'L'
                                  ? 'images/man.png'
                                  : 'images/girl.png',
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    // color: Colors.cyan,
                    height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width / 1.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Name: ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$nama',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Jurusan: ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$jurusan',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Kelas: ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$kelas',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Jenis Kelamin: ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                gender == 'L' ? 'Laki-Laki' : 'Perempuan',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.9,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                // scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final x = list[index];
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 7),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  x.nama,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  x.createdAt,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'Lunas',
                                  style: TextStyle(
                                    color: x.isLunas == '1'
                                        ? Colors.blueAccent
                                        : Colors.redAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Rp. ' + x.jumlah,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
