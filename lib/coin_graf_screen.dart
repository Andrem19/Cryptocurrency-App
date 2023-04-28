import 'dart:math';

import 'package:crypto_currency_app/fake_data/chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CoinGrafScreen extends StatefulWidget {
  final String coinId, coinName;
  const CoinGrafScreen(
      {super.key, required this.coinId, required this.coinName});

  @override
  State<CoinGrafScreen> createState() => _CoinGrafScreenState();
}

class _CoinGrafScreenState extends State<CoinGrafScreen> {
  late double punkt = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.coinName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                        text: '${widget.coinName} Price\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        children: const [
                      TextSpan(
                          text: 'Rs.1806052.98\n',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          )),
                      TextSpan(
                          text: '2.73692%\n',
                          style: TextStyle(
                            color: Colors.red,
                          )),
                      TextSpan(
                        text: 'Rs.206545851',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )
                    ])),
              ),
            ),
            SizedBox(
              height: 400,
              child: LineChart(LineChartData(
                  minX: 0,
                  minY: 0,
                  maxX: chart.length.toDouble(),
                  maxY: chart.reduce(max),
                  lineBarsData: [
                    LineChartBarData(
                      spots: chart.map((e) {
                        setState(() {
                          punkt++;
                        });
                        return FlSpot(punkt, e);
                      }).toList(),
                      dotData: FlDotData(
                        show: false,
                      )
                    )
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
