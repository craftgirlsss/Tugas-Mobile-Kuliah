import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// Main Function
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// Halaman Awal
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network("https://masputra.nextjiesdev.site/assets/kuliah/calendar.gif",
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.calendar_month, size: 100), width: size.width / 2,
                  loadingBuilder: (BuildContext context, Widget image, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return image;
                    return SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                        ),
                      ),
                    );
                  },
                ),
                const Padding(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Selamat datang di Aplikasi Kalender',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: size.width/2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 0,
                      shape: const StadiumBorder()
                    ),
                    onPressed: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      'Buka Kalender',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Create and Design by\nSaputra Budianto - 211080200072", textAlign: TextAlign.center),
      )
    );
  }
}

// Halaman Login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime newYorkTime =  now.subtract(const Duration(hours: 11));
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(229, 230, 225, 1),
        appBar: AppBar(
          title: const Text("Kalenderku"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: size.width,
                padding: const EdgeInsets.all(20),
                // height: size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black38
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('EEEE').format(now), style: const TextStyle(fontSize: 20)),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('hh.mm').format(now), style: const TextStyle(fontSize: 60), overflow: TextOverflow.clip, maxLines: 1),
                              Text(DateFormat('MMM').format(now).toUpperCase(), style: const TextStyle(fontSize: 70), overflow: TextOverflow.clip, maxLines: 1),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            width: 20,
                            indent: 20,
                            endIndent: 20,
                            color: Colors.black,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  dense: true,
                                  title: Text(DateFormat().add_jm().format(now), style: const TextStyle(fontSize: 30)),
                                  subtitle: const Text("Sidoarjo", style: TextStyle(fontSize: 20, color: Colors.black54)),
                                ),
                                ListTile(
                                  dense: true,
                                  title: Text(DateFormat().add_jm().format(newYorkTime), style: const TextStyle(fontSize: 30)),
                                  subtitle: const Text("New York", style: TextStyle(fontSize: 20, color: Colors.black54)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                          color: Colors.white
                        ),
                        child: TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: DateTime.now(),
                        )
                      ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

