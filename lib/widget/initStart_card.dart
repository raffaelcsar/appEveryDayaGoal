import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everydayagoal/feature/initStart.dart';

class HistoricCard extends StatelessWidget {
  final InitStart initStart;
  HistoricCard({required this.initStart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(initStart.date!, style: GoogleFonts.kanit(fontSize: 18)),
                  Text((initStart.distance! / 1000).toStringAsFixed(2) + " km",
                      style: GoogleFonts.kanit(fontSize: 18)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(initStart.duration!,
                      style: GoogleFonts.kanit(fontSize: 14)),
                  Text(initStart.speed!.toStringAsFixed(2) + " km/h",
                      style: GoogleFonts.montserrat(fontSize: 14)),
                ],
              )
            ],
          )),
    );
  }
}
