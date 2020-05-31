import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spp_app/Models/api.dart';
import 'Models/userModels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Tagihan extends StatefulWidget {
  final String nis;
  Tagihan({this.nis});
  @override
  _TagihanState createState() => _TagihanState();
}

class _TagihanState extends State<Tagihan> {
  List list = List<TagihanModels>();
  var loading = false;

  String nisn = "",
      nama = "",
      jurusan = '',
      kelas = '',
      gender = '',
      alamat = '';

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nisn = preferences.getString("nisn");
      nama = preferences.getString("nama");
      jurusan = preferences.getString("jurusan");
      kelas = preferences.getString("kelas");
      gender = preferences.getString('gender');
      alamat = preferences.getString("alamat");
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

  Future<void> _neverSatisfied(
    BuildContext context,
    var nama,
    keterangan,
    isLunas,
    diskon,
    jumlah,
    total,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text(
                nama,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Status :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  isLunas == '0'
                      ? Text(
                          'Belum Lunas',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : Text(
                          'Lunas',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                  SizedBox(height: 10),
                  Text(
                    'Jumlah :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    jumlah,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Diskon :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    diskon,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    total,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Keterangan :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    keterangan == "" ? 'Belum ada keterangan' : keterangan,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 60,
                    // color: Colors.yellowAccent,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Text(
                          'Data Tagihan',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final x = list[index];
                        return x.isLunas == "0"
                            ? Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                height: 70,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          x.nama,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          x.createdAt,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
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
                                        IconButton(
                                          icon: Icon(
                                            Icons.more_vert,
                                          ),
                                          iconSize: 30,
                                          onPressed: () {
                                            _neverSatisfied(
                                              context,
                                              x.nama,
                                              x.keterangan,
                                              x.isLunas,
                                              x.diskon,
                                              x.jumlah,
                                              x.total,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
