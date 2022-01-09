import 'package:flutter/material.dart';
import 'package:netflux/const.dart';
import 'package:netflux/screens/search_result/search_result_screen.dart';
import 'package:netflux/utils/custom_route.dart';

class SearchArguments {
  final String movieTitle;

  SearchArguments(this.movieTitle);
}

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();

  void navigationButtonHandler() async {
    Navigator.of(context).pushReplacement(FadePageRoute(
      builder: (context) => SearchResultScreen(query: controller.text),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mainColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Input movie title here',
                  labelStyle: TextStyle(color: mainColor),
                )),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.center,
            width: 100,
            child: ElevatedButton(
              onPressed: navigationButtonHandler,
              style: ElevatedButton.styleFrom(
                primary: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
              child: const Text(
                "Search",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
