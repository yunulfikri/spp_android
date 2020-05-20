import 'package:flutter/material.dart';
import 'Models/userModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final VoidCallback signOut;
  HomePage(
    this.signOut,
  );
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  signOut() {
    widget.signOut();
  }

  String nisn = "", name = "", jurusan = '', kelas = '', alamat = '';

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nisn = preferences.getString("nisn");
      name = preferences.getString("nama_lengkap");
      jurusan = preferences.getString("jurusan");
      kelas = preferences.getString("kelas");
      alamat = preferences.getString("alamat");
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  bool sort = true;

  List nama = [
    DataColumn(
      label: Text("Name"),
      numeric: false,
    ),
    DataColumn(
      label: Text("Weapons"),
      numeric: false,
    ),
  ];

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
                "$name",
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text('$nisn'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                  'images/placeholder.png',
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Tagihan'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Transaksi'),
              onTap: () => {Navigator.of(context).pop()},
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
                            image: AssetImage('images/placeholder.png'),
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
                                '$name',
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
                      ],
                    ),
                  ),
                ],
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
