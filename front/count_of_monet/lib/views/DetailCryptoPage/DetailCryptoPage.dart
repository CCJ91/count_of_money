import 'dart:math';

import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:count_of_monet/model/core/RssFeed.dart';
import 'package:count_of_monet/model/helper/CryptoHelper.dart';
import 'package:count_of_monet/model/helper/FluxRssHelper.dart';
import 'package:count_of_monet/provider/CryptoProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:count_of_monet/views/dashboardPage/Widgets/PressWidget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class DetailCryptoPage extends StatelessWidget {
  const DetailCryptoPage({required this.crypto, Key? key}) : super(key: key);

  final Crypto crypto;

  List<FlSpot> flSpotFromTuple2(List<Tuple2<int, double>> listTuple2) {
    int i = 0;
    List<FlSpot> listFlSpot = [];
    for (Tuple2<int, double> tuple2 in listTuple2) {
      listFlSpot.add(FlSpot(i.toDouble(), tuple2.item2));
      i++;
    }
    return listFlSpot;
  }

  @override
  Widget build(BuildContext context) {
    CryptoHelper cryptoHelper = CryptoHelper(context: context);
    CryptoProvider cryptoProvider =
        Provider.of<CryptoProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        cryptoProvider.crypto = null;
                      },
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Image.network(crypto.linkImage),
                    ),
                    Text(
                      crypto.name,
                      style: GoogleFonts.comfortaa(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          FutureBuilder<List<Tuple2<int, double>>>(
            future: cryptoHelper.getMarketChart(name: crypto.cryptoId),
            builder:
                (context, AsyncSnapshot<List<Tuple2<int, double>>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container();
              }
              if (snapshot.data!.isEmpty) {
                return Container();
              }
              List<Color> gradientColors = [
                const Color(0xff23b6e6),
                const Color(0xff02d39a),
              ];
              List<double> listData =
                  snapshot.data!.map((e) => e.item2).toList();
              double maxValue = listData.reduce(max);
              double minValue = listData.reduce(min);
              // double moyValue =
              //     listData.reduce((a, b) => a + b) / listData.length;

              int interval = ((maxValue - minValue) / 3).ceil();
              return Container(
                height: 300,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: interval.toDouble(),
                      verticalInterval: interval.toDouble(),
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            DateTime date = DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data![value.toInt()].item1,
                            );
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                DateFormat("dd/MM").format(date),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            if (value % interval != 0) return Container();
                            return Text(value.toInt().toString());
                          },
                          reservedSize: 42,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: const Color(0xff37434d)),
                    ),
                    minY: minValue * 0.98,
                    maxY: maxValue * 1.02,
                    lineBarsData: [
                      LineChartBarData(
                        spots: flSpotFromTuple2(snapshot.data!),
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: gradientColors,
                        ),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: false,
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: gradientColors
                                .map((color) => color.withOpacity(0.3))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Text("${lang.currentPrice} : ${crypto.currentPrice}"),
          Text("${lang.genesisDate} : ${crypto.genesisDate}"),
          Text("${lang.ath} : ${crypto.ath}"),
          Text("${lang.perSinceATH} : ${crypto.athChangePer}%"),
          Text("${lang.last24Highest} : ${crypto.high24}"),
          Text("${lang.last24Lowest} : ${crypto.low24}"),
          Text("${lang.persince24h} : ${crypto.priceChange24h}%"),
          Text("${lang.volume} : ${crypto.volume}"),
          FutureBuilder<List<RssFeed>>(
            future: FluxRssHelper().getFluxRss(coinName: crypto.name),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container();
              }
              if (snapshot.data!.isEmpty) {
                return Text(
                  lang.noDataRssFeed,
                );
              }
              return Column(
                children:
                    snapshot.data!.map((e) => PressWidget(rssFeed: e)).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
