import 'package:crypto_currency_app/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController age = TextEditingController();

  Future<void> saveData(String key, String value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString(key, value);
  }

  void saveUserDetails() async {
    await saveData('name', name.text);
    await saveData('email', email.text);
    await saveData('age', age.text);
  }

  bool isDarkMode = AppTheme.isDarkModeEnables;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Profile Update'),
      ),
      body: Column(children: [
        customTextField('Name', name, false),
        customTextField('Email', email, false),
        customTextField('Age', age, true),
        ElevatedButton(
            onPressed: () {
              saveUserDetails();
            },
            child: Text('Save Details'))
      ]),
    );
  }

  Widget customTextField(
      String title, TextEditingController controller, bool isAgeTextField) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode ? Colors.white : Colors.grey,
            )
          ),
          hintText: title,
          hintStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black,)
        ),
        keyboardType: isAgeTextField ? TextInputType.number : null,
      ),
    );
  }
}
