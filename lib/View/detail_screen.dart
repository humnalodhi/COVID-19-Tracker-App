import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_2023_w5/View/world_states.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
  String name ;
  DetailScreen({super.key,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.name,
    required this.test
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name, style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      ReusableComponent(title: 'Cases', value: widget.totalCases.toString()),
                      ReusableComponent(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ReusableComponent(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReusableComponent(title: 'Active', value: widget.active.toString()),
                      ReusableComponent(title: 'Critical', value: widget.critical.toString()),
                      ReusableComponent(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          )
        ],
      ),
    );
  }
}
