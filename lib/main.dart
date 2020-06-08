import 'package:auto_size_text/auto_size_text.dart';
import 'package:state_app/pages/custom_bloc/custom_bloc.dart';
import 'package:state_app/pages/flutterbloc/flutter_bloc_state.dart';
import 'package:state_app/pages/local_state/local_state.dart';
import 'package:state_app/pages/provider/provider_state.dart';
import 'package:state_app/pages/simple_bloc/simple_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
          primarySwatch: Colors.teal,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var widgetList = _getPages();

    return Scaffold(
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            widgetList.length,
            (index) => Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    print(index);
                    _pageController.animateToPage(index,
                        duration: Duration(seconds: 1), curve: Curves.ease);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    alignment: Alignment.topCenter,
                    height: 100,
                    decoration: BoxDecoration(color: Colors.teal),
                    child: AutoSizeText(
                      widgetList[index].text,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 18,
                          color: _index == index
                              ? Colors.white
                              : Colors.white.withOpacity(.7),
                          fontWeight: _index == index
                              ? FontWeight.w800
                              : FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
          ),
        ),
      ),
      body: PageView.builder(
        onPageChanged: (index) {
          setState(() {
            _index = index;
          });
        },
        controller: _pageController,
        itemCount: widgetList.length,
        itemBuilder: (context, index) => widgetList[index].child,
      ),
    );
  }

  List<WidgetPage> _getPages() {
    return [
      WidgetPage('Local State', LocalState()),
      WidgetPage('Simple Bloc', SimpleBloc()),
      WidgetPage('Custom Bloc', CustomBloc()),
      WidgetPage('Flutter Bloc', FlutterBlocState()),
      WidgetPage('Provider State', ProviderState())
    ];
  }
}

class WidgetPage {
  final String text;
  final Widget child;

  WidgetPage(this.text, this.child);
}
