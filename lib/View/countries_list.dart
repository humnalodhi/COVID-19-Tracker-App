import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_2023_w5/Services/states_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  hintStyle: GoogleFonts.openSans(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statesServices.CountriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                   ListTile(
                                        title: Container(
                                            height: 10,
                                            width: 89,
                                            color: Colors.white),
                                        subtitle: Container(
                                            height: 10,
                                            width: 89,
                                            color: Colors.white),
                                        leading: Container(
                                            height: 50,
                                            width: 50,
                                            color: Colors.white),
                                      ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (searchController.text.isEmpty) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      name: snapshot.data![index]['country'],
                                                      totalCases: snapshot.data![index]['cases'],
                                                      todayRecovered: snapshot.data![index]['recovered'],
                                                      totalDeaths: snapshot.data![index]['deaths'],
                                                      active: snapshot.data![index]['active'],
                                                      critical: snapshot.data![index]['critical'],
                                                      test: snapshot.data![index]['tests'],
                                                      totalRecovered: snapshot.data![index]['todayRecovered'],
                                                      image: snapshot.data![index]['countryInfo']['flag'],
                                                    ),
                                            ),
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country'], style: GoogleFonts.openSans(fontSize: 16),),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString(), style: GoogleFonts.openSans(fontSize: 14),),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]['countryInfo']
                                                  ['flag']),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      name: snapshot.data![index]['country'],
                                                      totalCases: snapshot.data![index]['cases'],
                                                      todayRecovered: snapshot.data![index]['recovered'],
                                                      totalDeaths: snapshot.data![index]['deaths'],
                                                      active: snapshot.data![index]['active'],
                                                      critical: snapshot.data![index]['critical'],
                                                      test: snapshot.data![index]['tests'],
                                                      totalRecovered: snapshot.data![index]['todayRecovered'],
                                                      image: snapshot.data![index]['countryInfo']['flag'],
                                                    )));
                                      },
                                      child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country'], style: GoogleFonts.openSans(fontSize: 16),),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString(), style: GoogleFonts.openSans(fontSize: 14),),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]['countryInfo']
                                                  ['flag']),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            });
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
