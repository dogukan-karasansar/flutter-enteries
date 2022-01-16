import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_giris/album.dart';
import 'package:flutter_giris/input_page.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    print("Myapp çalıştı");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("build");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Text('Merhaba')));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key) {
    print("home page yaratıldı");
  }

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
  int aktifButton = 0;
  bool checkMi = false;
  int sinif = 5;
  var ogrenciler = ['ahmet', 'mehmet', 'yusuf'];

  void yeniOgrenciEkle(String ogrenci) {
    setState(() {
      ogrenciler = [...ogrenciler, ogrenci];
    });
  }

  _MyHomePageState() {
    print("my home page state");
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      ogrenciler.add("yeni");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("myhomepage state");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Scaffold(
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Drawer Header'),
                  ),
                  ListTile(
                    title: const Text('Item 1'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    print('settings');
                    Navigator.of(context).pushNamed('/settings');
                  },
                  icon: Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: () {
                    print("pressed");
                  },
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () {
                    print("pressed");
                  },
                  icon: const Icon(Icons.add),
                )
              ],
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(widget.title),
            ),
            body: DefaultTextStyle(
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
              child: SinifBilgisi(
                sinif: sinif,
                ogrenciler: ogrenciler,
                aktifButton: aktifButton,
                yeniOgrenciEkle: yeniOgrenciEkle,
                child: Stack(fit: StackFit.expand, children: [
                  //const ArkaPlan(),
                  Positioned(
                    top: 100,
                    left: 10,
                    right: 10,
                    bottom: 0,
                    child: LayoutBuilder(builder: (context, constraints) {
                      if (constraints.maxWidth > 450) {
                        return Row(
                          children: const [
                            Sinif(),
                            Expanded(child: Text("Seçili Olan Öğrenci Detayı")),
                          ],
                        );
                      } else {
                        return const Sinif();
                      }
                    }),
                  ),
                  const Positioned(
                      bottom: 100, left: 10, right: 10, child: OgrenciEkle()),
                ]),
              ),
            ),
            /* floatingActionButton: FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('merhaba ben volkan konak')));
              },
              child: Text('FAB'),
            ),*/
            // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ),
      ),
    );
  }
}

class Sinif extends StatelessWidget {
  const Sinif({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //YaziYazmaYeri(),

        Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.deepOrange,
            ),
            Text(
              sinifBilgisi.sinif.toString(),
              textScaleFactor: 2,
            ),
            const Icon(Icons.star),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        Expanded(child: OgrencilerList()),
        /*Image.network(
            "https://images.pexels.com/photos/10324713/pexels-photo-10324713.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),*/
        RotatedBox(
          quarterTurns: 2,
          child: ElevatedButton(
            onPressed: () async {
              final ogrenciler = SinifBilgisi.of(context).ogrenciler;
              await Future.forEach(ogrenciler, (ogrenci) async {
                print('$ogrenci yükleniyor');
                await Future.delayed(Duration(seconds: 1));
                print('$ogrenci yüklendi');
              });
              print("Tüm Öğrenciler Yüklendi");
            },
            child: RichText(
                text: const TextSpan(text: 'Sunucucya Ekle', children: <TextSpan>[
              TextSpan(
                text: '/yükle',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ])),
            style: ElevatedButton.styleFrom(
              primary: Colors.amberAccent,
            ),
          ),
        ),
        Transform.rotate(
          angle: pi * 0.1,
          child: ElevatedButton(
            child: Text('Git'),
            onPressed: () {
              //Sor(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => InputPage()));
              /*pushFuture.then((bool? cevap) {
                if (cevap == true) {
                  print('beğendi');
                  return Future.value(true);
                } else {
                  return Navigator.of(context)
                      .push<bool>(MaterialPageRoute(builder: (context) {
                    return VideoEkran(
                        'Keşke beğenseydin be kardeş.... videoyu beğendiniz mi');
                  }));
                }
              }).then((value) {
                if (value == true) {
                  print("Beğendiniz");
                }
              }).onError((error, stackTrace) {
                print('hata');
              }).whenComplete(() => print('herşey bitti'));*/
            },
          ),
        )
      ],
    );
  }

  Future<void> Sor(BuildContext context) async {
    try {
      Future<dynamic> cevap = await Cevapal(context);

      if (cevap == true) {
        print('beğendi');
      } else {
        cevap = (await Navigator.of(context)
            .push<bool>(MaterialPageRoute(builder: (context) {
          return VideoEkran(
              'Keşke beğenseydin be kardeş.... videoyu beğendiniz mi');
        }))) as Future;
      }
      if (cevap == true) {
        print("Beğendiniz");
      }
    } catch (e) {
      print('hata');
    } finally {
      print('herşey bitti');
    }
  }

  Cevapal(BuildContext context) async {
    Future cevap = (await Navigator.of(context)
        .push<bool>(MaterialPageRoute(builder: (context) {
      return VideoEkran('videoyu beğendiniz mi');
    }))) as Future<bool?>;
    return cevap;
  }
}

class VideoEkran extends StatelessWidget {
  final String mesaj;

  const VideoEkran(
    this.mesaj, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('pop edecek');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          children: [
            const Video(),
            SizedBox(
              height: 40,
            ),
            Text(mesaj),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).maybePop(true);
                },
                child: Text('Evet')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).maybePop(false);
                },
                child: Text('Hayır')),
          ],
        )),
      ),
    );
  }
}

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoState();
  }
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://player.vimeo.com/external/567373608.sd.mp4?s=d51269ac85cd4db0338e17f79b0e798e589916af&profile_id=164&oauth2_token_id=57447761')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        ElevatedButton(
            child: Text("Play / Pause"),
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            })
      ],
    );
  }
}

class OgrenciEkle extends StatefulWidget {
  const OgrenciEkle({
    Key? key,
  }) : super(key: key);

  @override
  State<OgrenciEkle> createState() => _OgrenciEkleState();
}

class _OgrenciEkleState extends State<OgrenciEkle> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);

    return Column(
      children: [
        TextField(
            controller: controller,
            onChanged: (value) {
              setState(() {});
            }),
        Align(
          child: ElevatedButton(
              onPressed: controller.text.isEmpty
                  ? null
                  : () {
                      final ogrenci = controller.text;
                      sinifBilgisi.yeniOgrenciEkle(ogrenci);
                      controller.text = "";
                    },
              child: Text("Ekle")),
        ),
      ],
    );
  }
}

class ArkaPlan extends StatelessWidget {
  const ArkaPlan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: PhysicalModel(
        color: Colors.white,
        shadowColor: Colors.black45,
        elevation: 30,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: FractionallySizedBox(
            widthFactor: 0.75,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                //color: Colors.grey.shade800,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 58.0),
                  child: Image(image: AssetImage('images/course-img-1.png')),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SinifBilgisi extends InheritedWidget {
  const SinifBilgisi({
    Key? key,
    required Widget child,
    required this.sinif,
    required this.ogrenciler,
    required this.aktifButton,
    required this.yeniOgrenciEkle,
  }) : super(key: key, child: child);

  final int sinif;
  final List<String> ogrenciler;
  final int aktifButton;
  final void Function(String ogrenci) yeniOgrenciEkle;

  static SinifBilgisi of(BuildContext context) {
    final SinifBilgisi? result =
        context.dependOnInheritedWidgetOfExactType<SinifBilgisi>();
    assert(result != null, 'No SinifBilgisi found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SinifBilgisi old) {
    return sinif != old.sinif ||
        ogrenciler != old.ogrenciler ||
        yeniOgrenciEkle != old.yeniOgrenciEkle;
  }
}

class OgrencilerList extends StatelessWidget {
  const OgrencilerList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);

    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          key: ValueKey(index),
          title: Text(
            sinifBilgisi.ogrenciler[index],
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
          leading: Icon(Icons.circle),
        );
      },
      itemCount: sinifBilgisi.ogrenciler.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.black45,
        );
      },
    );
  }
}

class YaziYazmaYeri extends StatefulWidget {
  const YaziYazmaYeri({
    Key? key,
  }) : super(key: key);

  @override
  State<YaziYazmaYeri> createState() => YaziYazmaYeriState();
}

class YaziYazmaYeriState extends State<YaziYazmaYeri> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      print('yeni değer ${controller.text}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {},
      decoration: InputDecoration(
          suffixIcon: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          controller.text = '';
        },
      )),
    );
  }
}

class Yazi extends StatelessWidget {
  final String icerik;

  const Yazi(this.icerik, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(icerik);
  }
}

class Sayac extends StatefulWidget {
  final String sayac;
  final int ilkDeger;

  const Sayac(this.sayac, this.ilkDeger, {Key? key}) : super(key: key);

  @override
  _SayacState createState() => _SayacState();
}

class _SayacState extends State<Sayac> {
  int sayi = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sayi = widget.ilkDeger;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text('dışardaki: ${widget.sayac} içerdeki:$sayi'),
        onPressed: () {
          setState(() {
            sayi++;
          });
        });
  }
}
