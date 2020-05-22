import 'package:flutter/material.dart';
import 'package:spp_app/profile.dart';
import 'Models/userModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tagihan extends StatefulWidget {

  @override
  _TagihanState createState() => _TagihanState();
}

class _TagihanState extends State<Tagihan> {

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

  @override
  void initState() {
    super.initState();
    getPref();
  }

  bool sort = true;

  @override
  Widget build(BuildContext context) {
    // var item = widget.data;
    // var nisn = item.nisn.toString();
    return Scaffold(
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
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return DataTable(
                    rows: daftarTagih
                        .map(
                          (months) =>
                              DataRow(selected: daftarTagih.contains(daftarTagih), cells: [
                            DataCell(
                              Text(
                                months.nama,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataCell(
                              Icon(
                                Icons.check,
                                size: 30,
                                color: Colors.blue[900],
                              ),
                            ),
                          ]),
                        )
                        .toList(),
                    columns: [
                      DataColumn(
                        label: Text(
                          "Spp",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                        label: Text(
                          "Check",
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        numeric: false,
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return DataTable(
                    rows: dataB
                        .map(
                          (months) =>
                              DataRow(selected: dataB.contains(dataB), cells: [
                            DataCell(
                              Text(
                                months.nama,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataCell(
                              Icon(
                                months.check == true
                                    ? Icons.check
                                    : Icons.close,
                                size: 30,
                                color: months.check == true
                                    ? Colors.blue[900]
                                    : Colors.red,
                              ),
                            ),
                          ]),
                        )
                        .toList(),
                    columns: [
                      DataColumn(
                        label: Text(
                          "Bulan",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                        label: Text(
                          "Check",
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        numeric: false,
                      ),
                    ],
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
