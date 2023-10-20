import 'package:assignment/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputNamePage extends StatelessWidget {
  InputNamePage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

   Future<void> saveNameToPref() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthenticated', true); 
    prefs.setString('userName', _nameController.text); 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(73, 244, 67, 54),
              Color.fromARGB(83, 255, 235, 59)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please enter your\nsweet name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    validator: (name) {
                      if (_nameController.text.isEmpty) {
                        return 'Name is requid';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.black),
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.pink, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.pink, width: 2),
                      ),
                      filled: true,
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(133, 20, 20, 20),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () async{
                      if (_formKey.currentState!.validate()) {
                        await saveNameToPref();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => MainePage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'Go',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
