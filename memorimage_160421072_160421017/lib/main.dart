import 'package:flutter/material.dart';
import 'package:memorimage_160421072_160421017/screen/hasil.dart';
import 'package:memorimage_160421072_160421017/screen/login.dart';
import 'package:memorimage_160421072_160421017/screen/quiz.dart';
import 'package:memorimage_160421072_160421017/screen/leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

String active_user = "";
int top_point = 0;
List<List<String>> user_top_point = [
  ['none', '0'],
  ['none', '0'],
  ['none', '0']
];

void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  active_user = "";
  prefs.remove("user_id");
  main();
}

void main() {
  Future<String> checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString("user_id") ?? '';
    return user_id;
  }

  Future<int> checkScore() async {
    final prefs = await SharedPreferences.getInstance();
    int score = prefs.getInt("score") ?? 0;
    return score;
  }

  Future<String> checkTopScore() async {
    final prefs = await SharedPreferences.getInstance();
    String top_score = prefs.getString("top_score") ?? '';
    return top_score;
  }

  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  checkScore().then((int result) {
    top_point = result;
  });
  checkUser().then((String result) {
    if (result == '')
      runApp(LoginForm());
    else {
      active_user = result;
      runApp(MyApp());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'login': (context) => LoginForm(),
        'quiz': (context) => Quiz(),
        'leaderboard': (context) => LeaderBoard(),
        'hasil': (context) => Hasil()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;
  // final List<Widget> _screens = [Home(), Search(), History()];
  final List<String> _judul = ['Home', 'Search', 'History'];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(_judul[_currentIndex]),
        ),
        // body: _screens[_currentIndex],
        drawer: myDrawer(),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Peraturan Permainan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 100.0, right: 100.0),
              child: Text(
                'Para pemain akan diperlihatkan 5 gambar yang harus diingat. Setiap gambar akan ditampilkan selama 3 detik. Setelah semua gambar ditampilkan, kuis akan dimulai. Setiap pertanyaan dalam kuis akan menampilkan 4 pilihan gambar. Pemain harus memilih satu dari keempat gambar tersebut. Pilihan gambar harus sesuai dengan gambar yang telah ditampilkan sebelum dimulainya kuis. Pemain juga akan diberi waktu untuk menyelesaikan seluruh kuis. Skor pemain akan tercatat dalam papan peringkat.',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'quiz');
                },
                child: Text("Mainkan Permainan"))
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Drawer myDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(active_user != "" ? active_user : "xyz"),
              accountEmail: Text(active_user != ""
                  ? active_user + "@gmail.com"
                  : "user@gmail.com"),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150"))),
          ListTile(
            title: new Text("Inbox"),
            leading: new Icon(Icons.inbox),
            onTap: () {
              Navigator.popAndPushNamed(context, 'student');
            },
          ),
          ListTile(
            title: new Text("Quiz"),
            leading: new Icon(Icons.book),
            onTap: () {
              Navigator.popAndPushNamed(context, 'quiz');
            },
          ),
          ListTile(
            title: new Text("LeaderBoard"),
            leading: new Icon(Icons.leaderboard),
            onTap: () {
              Navigator.popAndPushNamed(context, 'leaderboard');
            },
          ),
          ListTile(
            title: new Text("Hasil"),
            leading: new Icon(Icons.restore_outlined),
            onTap: () {
              Navigator.popAndPushNamed(context, 'hasil');
            },
          ),

          Divider(
            height: 40,
          ),
          ListTile(
            title: new Text(active_user != "" ? "Logout" : "Login"),
            leading: new Icon(Icons.login),
            onTap: () {
              active_user != ""
                  ? doLogout()
                  : Navigator.popAndPushNamed(context, 'login');
            },
          ),
          // ListTile(
          //   title: new Text(active_user != "" ? "Logout" : "Login"),
          //   leading: new Icon(Icons.login),
          //   onTap: () {
          //     active_user != ""
          //         ? doLogout()
          //         : Navigator.popAndPushNamed(context, 'login');
          //   },
          // ),
        ],
      ),
    );
  }
}
