import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage()
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
// appBar: new AppBar(
//   title: Text("FTApp"),
// ),
drawer: Drawer(
  
  child: ListView(
    children: <Widget>[
      UserAccountsDrawerHeader(
  accountName: Text("Feelings Talk"),
  accountEmail: Text("feelingstalkemail@gmail.com"),
  currentAccountPicture: CircleAvatar(
    backgroundColor:
        Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.blue
            : Colors.white,
    child: Text(
      "A",
      style: TextStyle(fontSize: 40.0),
    ),
  ),
),
      ListTile(
        
        
        title: Text("Login"),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
  Navigator.of(context).pop();
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => LoginPage()));
},
      ),
      ListTile(
        title: Text("Item 2"),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
  Navigator.of(context).pop();
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => HomePage()));
},
      ),
    ],
  ),
),
      body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("FTApp"),
              floating: true,
              flexibleSpace: Placeholder(),
              expandedHeight: 70,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text('Item #$index')),
                childCount: 100,
              ),
            ),
          ],
        ),

    );
  }
}


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  //final _email = TextEditingController;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
     home : new  DefaultTabController(
  length: 2,
     child: new Scaffold(
        appBar: new AppBar(
          
               bottom: TabBar(
              tabs: [  
                Tab(icon: Icon(Icons.account_circle)),
                Tab(icon: Icon(Icons.add_circle_outline)),
              ],
            ),
            title: Text('Tabs Demo'),
            
          ),
      
        body: 
        TabBarView(
            children: [ 
              
              
              new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: loginui(),
            ),
          
          ),
        ),
         new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: formui(),
            ),
          
          ),
        ), 
            ],
          ),
      ),
    ));
  }
// Here is our Form UI & Login UI.
  Widget formui() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Name'),
          keyboardType: TextInputType.text,
           validator: (String arg) {
    if(arg.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Mobile'),
          keyboardType: TextInputType.phone,
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Password'),
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
         new TextFormField(
          decoration: const InputDecoration(labelText: 'Birthdate'),
          keyboardType: TextInputType.datetime,
        ),
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: _validateInputs,
          child: new Text('Sign Up'),
        )
      ],
    );
    
  }

  Widget loginui() {
    return new Column(
      children: <Widget>[

        new TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
           validator: null,
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Password'),
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
  
   
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: _validateInputs,
          child: new Text('login'),
        )
      ],
    );
  }
  void _validateInputs() {}
}

