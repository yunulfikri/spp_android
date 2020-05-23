import 'package:flutter/material.dart';
import 'package:spp_app/Models/userModels.dart';

class Transaksi extends StatefulWidget {
  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    'Data Transaksi',
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
              height: 400,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: <Widget>[
                        DataTable(
                          rows: daftarTagih
                              .map(
                                (months) => DataRow(
                                    selected: daftarTagih.contains(daftarTagih),
                                    cells: [
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
                                        Text(
                                          months.jumlah,
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
                                "Harga",
                                style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 20,
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
