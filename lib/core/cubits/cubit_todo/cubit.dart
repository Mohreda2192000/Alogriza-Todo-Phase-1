import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:totodo/core/cubits/cubit_todo/states.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoInitialState());

  static TodoCubit get(context) => BlocProvider.of(context);
  bool isSearching=false;
  int currentIndex = 0;
  bool favorite = false;
  IconData favoriteIcon = Icons.favorite_border_outlined;
  void search(bool search){
    isSearching=search;
    emit(SearchingState());
  }
  void favoriteOrNot() {
    favorite = !favorite;
    if (favorite) {
      favoriteIcon = Icons.favorite;
    } else {
      favoriteIcon = Icons.favorite_border_outlined;
    }
    emit(TodoChangeFavoriteTaskState());
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(TodoChangeTabBarState());
  }

  IconData iconOfChoiceColorRed = Icons.check_circle;
  IconData iconOfChoiceColorOrange = Icons.circle_sharp;
  IconData iconOfChoiceColorYellow = Icons.circle_sharp;
  IconData iconOfChoiceColorBlue = Icons.circle_sharp;
  List<IconData> changeTaskColor = [Icons.circle_sharp, Icons.check_circle];
  String colorOfTask = "red";

  void choiceTaskColor({required int red,
    required int orange,
    required int yellow,
    required int blue}) {
    if (red > 0) colorOfTask = "red";
    if (orange > 0) colorOfTask = "orange";
    if (yellow > 0) colorOfTask = "yellow";
    if (blue > 0) colorOfTask = "blue";
    iconOfChoiceColorRed = changeTaskColor[red];
    iconOfChoiceColorOrange = changeTaskColor[orange];
    iconOfChoiceColorYellow = changeTaskColor[yellow];
    iconOfChoiceColorBlue = changeTaskColor[blue];
    emit(TodoChangeColorTaskState());
  }

  late Database database;

  void createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath, 'tasks.db');
    openAppDatabase(path: path);
    emit(TodoDatabaseTableCreatedState());
  }

  void openAppDatabase({
    required String path,
  }) {
    openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        debugPrint('database created');
        database
            .execute(
          ('CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,startTime TEXT,endTime TEXT,remind TEXT,repeat TEXT,favorite Text,color TEXT,statue TEXT)'),
        )
            .then((value) {
          debugPrint('table created');
          return null;
        }).catchError((error) {
          debugPrint('table not created$error');
        });
      },
      onOpen: (database) {
        debugPrint('database opened');
        emit(TodoDatabaseOpenedState());
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(TodoDatabaseTableCreatedState());
    }).catchError((error) {});
  }

  void insertDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required String remind,
    required String repeat,
    required String color,
    required String favorite,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        ('INSERT INTO Tasks (title ,date ,startTime ,endTime ,remind ,repeat ,favorite ,color ,statue) VALUES("$title","$date","$startTime","$endTime","$remind","$repeat","$favorite","$color","uncompleted")'),
      )
          .then((value) {
        debugPrint('row $value inserted');
        emit(TodoDatabaseInsertedState());
        getDataFromDatabase(database);
      }).catchError((error) {
        debugPrint('row not inserted  $error');
      });
    });
  }

  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> uncompletedTasks = [];
  List<Map> favoriteTasks = [];

  void getDataFromDatabase(Database database) {
    database.rawQuery(('SELECT * FROM Tasks')).then((value) {
      allTasks = value;
      completedTasks = [];
       uncompletedTasks = [];
       favoriteTasks = [];
      debugPrint('$allTasks');
      for (var element in allTasks) {
        if (element['statue'] == 'completed') {
          completedTasks.add(element);
        } else if (element['statue'] == 'uncompleted') {
          uncompletedTasks.add(element);
        }
        if (element['favorite'] == 'favorite') {
          favoriteTasks.add(element);
        }
      }
      debugPrint('RowGet = $value');
      emit(TodoGetDataFromDatabaseState());
    }).catchError((error) {
      debugPrint('RowGet = $error');
    });
  }

  void deleteFromDatabase({required int id}) {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      emit(TodoDeleteDatabaseState());
      getDataFromDatabase(database);
    });
  }
  void changeFavoriteTask({
    required String favorite,
    required int id,
  }) {
    database.rawUpdate('UPDATE Tasks SET favorite = ? WHERE id = ?',
        [favorite,id ]).then((value) {
      emit(ChangeFavoriteTaskState());
      getDataFromDatabase(database);
    });
  }
  void checkCompletedTask({
    required String completed,
    required int id,
  }) {
    database.rawUpdate('UPDATE Tasks SET statue = ? WHERE id = ?',
        [completed,id ]).then((value) {
      emit(ChangeCompletedTaskState());
      getDataFromDatabase(database);
    });
  }
  var date = DateTime.now();
  String day = "Today";
  List<Map>tasksDay = [];

  void tasksOfDay(DateTime dateTime) {
    date = dateTime;
    day = "";
    tasksDay.clear();
    String temp = DateFormat('EEEE, d MMM, yyyy').format(date);
    for (int i = 0; i < temp.length; i++) {
      if (temp[i] == ',') {
        i = temp.length;
      }
      else {
        day += temp[i];
      }
    }
    String formatDate = DateFormat.yMMMd().format(date);
    for (var element in allTasks) {
      if (element['date'] == formatDate) {
        tasksDay.add(element);
      }
    }
    emit(ShowTasksOfDayState());
  }


}