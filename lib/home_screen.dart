import 'dart:convert';

import 'package:crypto_currency_app/app_theme.dart';
import 'package:crypto_currency_app/coin_details_model.dart';
import 'package:crypto_currency_app/coin_graf_screen.dart';
import 'package:crypto_currency_app/fake_data/data.dart';
import 'package:crypto_currency_app/update_profale_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String url =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en';
  String name = '', email = '', age = '';
  bool isFirstTimeDataAcess = true;
  bool isDarkMode = AppTheme.isDarkModeEnables;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<CoinDetailsModel> coinDetailsList = [];
  late Future<List<CoinDetailsModel>> coinDetailsFuture;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    coinDetailsFuture = getCoinDetails();
  }

  void getUserDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      name = pref.getString('name') ?? '';
      email = pref.getString('email') ?? '';
      age = pref.getString('age') ?? '';
    });
  }

  Future<List<CoinDetailsModel>> getCoinDetails() async {
    // final response = await http.get(Uri.parse(url));
    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   List coinData = json.decode(response.body);

    //   return coinData.map((e) => CoinDetailsModel.fromJson(e)).toList();
    //   print(coinData);
    // } else {
    //   return <CoinDetailsModel>[];
    // }
    List coinData = json.decode(data);

    return coinData.map((e) => CoinDetailsModel.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _globalKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'CryptoCurrency App',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            accountEmail: Text(
              '$email\n$age',
              style: const TextStyle(fontSize: 17),
            ),
            currentAccountPicture: const Icon(
              Icons.account_circle,
              size: 70,
              color: Colors.white,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateProfileScreen()));
            },
            leading: Icon(Icons.account_box,
                color: isDarkMode ? Colors.white : Colors.black),
            title: Text(
              'Update Profile',
              style: TextStyle(
                  fontSize: 17,
                  color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          ListTile(
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              setState(() {
                isDarkMode = !isDarkMode;
                print(isDarkMode);
              });
              AppTheme.isDarkModeEnables = isDarkMode;
              pref.setBool('isDarkMode', isDarkMode);
            },
            leading: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: isDarkMode ? Colors.white : Colors.black),
            title: Text(
              isDarkMode ? 'Dark Mode' : 'Light Mode',
              style: TextStyle(
                  fontSize: 17,
                  color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ]),
      ),
      body: FutureBuilder(
        future: coinDetailsFuture,
        builder: (context, AsyncSnapshot<List<CoinDetailsModel>> snapshot) {
          if (snapshot.hasData) {
            if (isFirstTimeDataAcess) {
              coinDetailsList = snapshot.data!;
              isFirstTimeDataAcess = false;
            }
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: TextField(
                    onChanged: (query) {
                      List<CoinDetailsModel> searchResult = snapshot.data!
                          .where((element) => element.name.contains(query))
                          .toList();
                      setState(() {
                        coinDetailsList = searchResult;
                      });
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Search for a coin'),
                  ),
                ),
                Expanded(
                    child: coinDetailsList.isEmpty
                        ? const Center(
                            child: Text('No coin found'),
                          )
                        : ListView.builder(
                            itemCount: coinDetailsList.length,
                            itemBuilder: (context, index) {
                              return coinDetails(coinDetailsList[index]);
                            }))
              ],
            );
          } else {
            return const Center(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

  Widget coinDetails(CoinDetailsModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CoinGrafScreen(coinId: model.id, coinName: model.name)));
          },
          leading: SizedBox(
              height: 50, width: 50, child: Image.network(model.image)),
          title: Text(
            '${model.name}\n${model.symbol}',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          trailing: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                  text: 'Rs.${model.currentPrice}\n',
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: '${model.priceChangePercentage24h}%',
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    )
                  ]))),
    );
  }
}
