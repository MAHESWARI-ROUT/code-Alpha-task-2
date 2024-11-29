import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String quote = 'failed to generate..........';
  String author = 'unknown';
  final String quoteURL = 'https://zenquotes.io/api/random';
  void generateQuote() async {
    var res = await http.get(Uri.parse(quoteURL));
    var result = jsonDecode(res.body);
    //print(result);
    setState(() {
      quote = result[0]["q"];
      author = result[0]["a"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Quote Generator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(quote),
              const SizedBox(
                height: 10,
              ),
              Text(
                author,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 100,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      generateQuote();
                    },
                    child: const Text(
                      'Generate',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        Share.share('Check out this random quote: "$quote"', subject: 'Random Quote');
                      },
                      icon: const Icon(Icons.share))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
