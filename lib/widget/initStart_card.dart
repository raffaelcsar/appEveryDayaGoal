import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everydayagoal/feature/initStart.dart';

class HistoricCard extends StatelessWidget {
  final InitStart initStart;
  HistoricCard({required this.initStart});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF06466C),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF06466c), width: 1),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(initStart.date!,
                      style: GoogleFonts.kanit(
                          fontSize: 20, color: Color(0xFFF65E25))),
                  Text((initStart.distance! / 1000).toStringAsFixed(2) + " km",
                      style: GoogleFonts.kanit(
                          fontSize: 18, color: Color(0xFFF65E25))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(initStart.duration!,
                      style:
                          GoogleFonts.kanit(fontSize: 20, color: Colors.white)),
                  Text(initStart.speed!.toStringAsFixed(2) + " km/h",
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: Colors.white)),
                ],
              )
            ],
          )),
    );
  }
}
