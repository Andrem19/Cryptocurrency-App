import 'package:crypto_currency_app/app_theme.dart';
import 'package:crypto_currency_app/update_profale_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '', email = '', age = '';
  bool isDarkMode = AppTheme.isDarkModeEnables;

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  void getUserDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      name = pref.getString('name') ?? '';
      email = pref.getString('email') ?? '';
      age = pref.getString('age') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('CryptoCurrency App'),
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
    );
  }
}
