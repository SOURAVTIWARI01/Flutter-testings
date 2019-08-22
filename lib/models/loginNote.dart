//define a class
class LoginNote{
//define some variables
int _id;
String _name;
String _password;
String _description;
//instanciate the class with variable names. In simple words, create the clas with variables or something
LoginNote(this._name,this._password,[this._description]);
LoginNote.withId(this._id,this._name,this._password,[this._description]);

//create getter methods

int get id => _id;
String get name => _name;
String get password => _password;
String get description => _description;

//create setter methods

set name(String newName){
  if (newName.length <= 150){
    this.name = newName;
  }
}

set password(String newPassword){
  if (newPassword.length >5 && newPassword.length <=25 && newPassword.isNotEmpty){
    this.password = newPassword;
  }
}

set description(String newDescription){
  this.description = newDescription;
}

// Create Map of these variables

Map<dynamic, dynamic> toMap(){

var map =  Map <dynamic, dynamic>(); // <-- map object creasted of function Map <dynamic, dynamic> toMap(){}


// Converting to Map objects
if (id != null ){map ['id'] =_id;}
map['name'] = _name;
map['pasword'] = _password;
map['description'] =_description;
return map; // <-- return the map object
}

// Converting Map type objects to normal objects

LoginNote.fromMapToObject (Map<dynamic, dynamic> map){
this._id = map['id'];
this._name = map['name'];
this._password = map['password'];
this._description = map['description'];
}
} // <--- this is the end of LoginNote Clase
