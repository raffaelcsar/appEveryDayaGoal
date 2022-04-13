import 'package:everydayagoal/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:everydayagoal/dataBase/db.dart';
import 'package:everydayagoal/feature/initStart.dart';
import 'package:everydayagoal/widget/initStart_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({Key? key}) : super(key: key);

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  List<InitStart>? _data;
  List<HistoricCard> _cards = [];

  void initState() {
    super.initState();
    DB.init().then((value) => _fetchEntries());
  }

  void _fetchEntries() async {
    _cards = [];
    List<Map<String, dynamic>> _results = await DB.query(InitStart.table);
    _data = _results.map((item) => InitStart.fromMap(item)).toList();
    _data!.forEach((element) => _cards.add(HistoricCard(initStart: element)));
    setState(() {});
  }

  void _addEntries(InitStart en) async {
    DB.insert(InitStart.table, en);
    _fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Image.asset(
                  'assets/Logo.png',
                  scale: 7,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/Perfil.jpg'),
                        )),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'RaffaelCsar',
                          style: GoogleFonts.kanit(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: _cards,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFF06466C),
          child: Container(height: 50.0),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()))
              .then((value) => _addEntries(value)),
          tooltip: 'Increment',
          label: const Text('Iniciar'),
          icon: const Icon(Icons.play_arrow_rounded),
          backgroundColor: Color(0xFFF65E25),
        ),
      ),
    );
  }
}
