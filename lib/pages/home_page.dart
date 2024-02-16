import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todonow_lite/data/database.dart';
import 'package:todonow_lite/utils/ad_mob_services.dart';
import 'package:todonow_lite/utils/dialog_box.dart';
import 'package:todonow_lite/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd? _bannerAd;
  final _myBox = Hive.box('mybox');
  final _controller = TextEditingController();
  //todo list
  ToDoDataBase db = ToDoDataBase();
  //banner ads
  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  @override
  void initState() {
    if (_myBox.isEmpty) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
    _createBannerAd();
  }

  //checkbox changed
  void checkboxChanged(bool? value, index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

// banner ad
  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.getAdMobAppId!,
      listener: AdMobService.bannerListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD4F1F4),
      appBar: AppBar(
        backgroundColor: Color(0xFF00b4d8),
        title: Text(
          'ToDoNow-lite',
          style: TextStyle(fontFamily: GoogleFonts.pacifico().fontFamily),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      bottomNavigationBar: _bannerAd == null
          ? Container()
          : Container(
              margin: const EdgeInsets.only(bottom: 1, top: 10),
              height: 60,
              child: AdWidget(ad: _bannerAd!),
            ),
    );
  }
}
