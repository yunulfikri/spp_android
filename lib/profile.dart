import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String nisn = "",
      nama = "",
      jurusan = '',
      kelas = '',
      gender = '',
      alamat = '',
      wali = '',
      yatim = '';

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nisn = preferences.getString("nisn");
      nama = preferences.getString("nama");
      jurusan = preferences.getString("jurusan");
      kelas = preferences.getString("kelas");
      gender = preferences.getString('gender');
      alamat = preferences.getString("alamat");
      wali = preferences.getString('wali');
      yatim = preferences.getString('yatim');
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nama),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                image: AssetImage(
                    gender == 'L' ? 'images/man.png' : 'images/girl.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 20),
            child: Text(
              'Data Siswa :',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey, width: 2.0),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Nama : ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        nama,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Jurusan : ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        jurusan,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Kelas : ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        kelas,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Status : ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        yatim == '0' ? 'Non Yatim' : 'Yatim',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Jenis Kelamin : ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        gender == 'L' ? 'Laki-Laki' : 'Perempuan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Alamat : ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        alamat,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Wali Murid : ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        wali,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
