import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:spp_app/Models/api.dart';
import 'package:spp_app/profile.dart';
import 'Models/userModels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Tagihan extends StatefulWidget {
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

  viewData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.tagihan);

    if (response.statusCode == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = TagihanModels(
          api['id'],
          api['siswa_id'],
          api['tagihan_id'],
          api['potongan'],
          api['is_lunas'],
          api['keterangan'],
          api['nama'],
          api['tagihan'],
          api['jumlah'],
        );

        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    viewData();
  }

  bool sort = true;

  Future<Void> _neverSatisfied(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
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
    // var item = widget.data;
    // var nisn = item.nisn.toString();
    return Scaffold(
      // appBar: AppBar(title: Text(nama),),
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
                        return x.nama == nama
                            ? Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                height: 70,
                                color: Colors.grey[100],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          x.tagihan,
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
                                          '20-20-2020',
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
                                            _neverSatisfied(context);
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
