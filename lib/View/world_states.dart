import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_2023_w5/Services/states_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Models/world_states_model.dart';
import 'countries_list.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01,
              ),
              FutureBuilder(
                future: statesServices.FetchWorldStates(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                      controller: _controller,
                    ),
                  );
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total cases": double.parse(snapshot.data!.cases!.toString()),
                          "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                          "Deaths": double.parse(snapshot.data!.deaths!.toString()),
                        },
                        centerTextStyle: GoogleFonts.openSans(fontSize: 16),
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                        ),
                        chartRadius: MediaQuery
                            .of(context)
                            .size
                            .width / 3.2,
                        legendOptions:
                        const LegendOptions(legendPosition: LegendPosition.left),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery
                            .of(context)
                            .size
                            .height * 0.06),
                        child: Card(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              ReusableComponent(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                              ReusableComponent(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              ReusableComponent(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              ReusableComponent(title: 'Active', value: snapshot.data!.active.toString()),
                              ReusableComponent(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ReusableComponent(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              ReusableComponent(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountriesListScreen()));
                    },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text('Track Countries', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),

            ],
          ),
        ),
      ),
    );
  }
}

class ReusableComponent extends StatelessWidget {
  final String title, value;

  const ReusableComponent({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: GoogleFonts.openSans(fontSize: 16),),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
