import 'package:everydayagoal/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:everydayagoal/dataBase/db.dart';
import 'package:everydayagoal/feature/initStart.dart';
import 'package:everydayagoal/widget/initStart_card.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Every Day a Goal"),
      ),
      body: ListView(
        children: _cards,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()))
            .then((value) => _addEntries(value)),
        tooltip: 'Increment',
        child: Icon(Icons.start),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
