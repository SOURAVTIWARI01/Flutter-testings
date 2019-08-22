import 'dart:async';

import 'package:flutter_app1/models/loginNote.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

//ek DatabaseHelper naam ka blank class banao. fir ek static variable banao _databasehelper naam ka.
//fir factory keyword use karko, (use kya hai ki kuch return karwa sakte ho), aur variable return karwa do 
//A normal constructor always returns a new instance of the class.
// A factory constructor is permitted to return an existing instance, an instance of a derived class.
//padh liya . ab ek instance create karo(_createinstance) uss variable ka (_databaseHelper)
// aur usko bhi define kar do
// ab database ka singleton object banao jisse saara aage ka kaam hoga
// in sab ke baad tables ka naam and columns ka naam banana
// uske baad database create karne ka command likhna _createdb wala
// fir database initialize karna ka command likhna initialize database wala, dhyan dena initialize DatabaseHelper class ke andar hi ho bahar nai 
//now contruct a getter for database 
// so wehn you access Database instance it will initialize and createdb for first time and will open rest of the time
//ab CRUD opertions
//


class DatabaseHelper {
  DatabaseHelper._createInstance(); //named constructor to create instance of DatabaseHelper
  static DatabaseHelper _databaseHelper;
  static Database _database; //singleton datbase object //isi se saatra kaam hoga

  String loginTable = 'login_table'; //table name
  String colId = 'id';
  String colName = 'name';
  String colPassword = 'password';
  String colDescription = 'description';

  factory DatabaseHelper(){
if(DatabaseHelper == null){
  _databaseHelper= DatabaseHelper._createInstance(); //THis is executed only once as it is a singleton object
}
    return _databaseHelper;
  }

  //getter created here for Database 

  Future<Database> get database async {
if (_database == null){
  _database = await initializeDatabase();
}
    return _database;
  }

Future <Database> initializeDatabase () async {
Directory directory = await getApplicationDocumentsDirectory(); // gets directory path  
String path = directory.path + 'login.db';


var loginDatabase = await openDatabase(path, version :1, onCreate: _createDb); //this opens databse
return loginDatabase;

} 

void _createDb (Database db , int newVersion) async{
await db.execute('CREATE TABLE $loginTable($colId INTEGER PRIMARY KEY, $colName TEXT, $colPassword TEXT, $colDescription TEXT )');
}
//Fetch
Future <List<Map<dynamic,dynamic>>>getLoginNoteMapList () async { //get reference to Database
//In simple, it means future of list of maps having key (left wala) dynamic and value (right wala) dynamic
  Database db = await this.database;  
  var result = await db.rawQuery('SELECT * FROM $loginTable order by $colName ASC');
  return result;
}


//Insert
Future<int>insertLoginNote (LoginNote loginnote) async{
  Database db = await this.database;
var result = await db.insert(loginTable,loginnote.toMap());
  return result;
}


//Update

Future<int> updateLoginNote(LoginNote loginnote)async {
  var db = await this.database;
var result = await db.update(loginTable,loginnote.toMap(),where: '$colId= ?',whereArgs:[loginnote.id]);

  return result;
}

//Delete

Future<int> deleteLoginNote(int id)async{
  var db = await this.database;
  int result = await db.rawDelete('DELETE FROM $loginTable WHERE $colId =$id');
  return result;

}

//number of objects

Future<int> getloginCount() async{

  Database db = await this.database;
  List<Map<String, dynamic>> listOfData = await db.rawQuery('SELECT COUNT (*)  FROM $loginTable');
  int result = Sqflite.firstIntValue(listOfData);
  return result;
}

// get the map list (List<Map>)and convert to object list List<LoginNote> 

Future<List<LoginNote>> getLoginNoteList() async{

var loginNoteMapList = await getLoginNoteMapList();
int count = loginNoteMapList.length;
List<LoginNote> loginNoteList = List<LoginNote>();
for (int i=0;i<count;i++){
  loginNoteList.add(LoginNote.fromMapToObject(loginNoteMapList[i]));
}
  return loginNoteList;
}

}