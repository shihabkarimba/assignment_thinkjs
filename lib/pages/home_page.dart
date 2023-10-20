import 'package:assignment/providers/word_list_provider.dart';
import 'package:assignment/widgets/home%20page/build_words.dart';
import 'package:assignment/widgets/home%20page/header_section.dart';
import 'package:assignment/widgets/home%20page/home_drawer.dart';
import 'package:assignment/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? 'Default User';
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(Icons.settings)),
          )
        ],
      ),
      drawer: HomeDrawer(),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: getUserName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    final userName = snapshot.data!;
                    return HomeHeaderSection(text: userName);
                  },
                ),
                Divider(
                  color: const Color.fromARGB(97, 0, 0, 0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Note your words...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                BuildWords(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final _textController = TextEditingController();
          customShowDialog(
            context: context,
            textController: _textController,
            onButtonPressed: () {
              String newWord = _textController.text;
              Provider.of<WordListProvider>(context, listen: false)
                  .addWord(newWord);
              Navigator.of(context).pop();
            },
            header: 'Add a word',
            textButton: 'Add',
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
