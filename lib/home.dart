import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Isolates')),
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.asset('assets/animation_llyw7e3k.json'),
            ElevatedButton(
                onPressed: () {
                  int a = taskone();
                  log(a.toString());
                },
                child: const Text('Button1')),
            ElevatedButton(
                onPressed: () async {
                  int b = await tasktwo();
                  log(b.toString());
                },
                child: const Text('Button2')),
            ElevatedButton(
                onPressed: () async {
                  final port = ReceivePort();
                  await Isolate.spawn(tasktree, port.sendPort);
                  port.listen((reciveTotal) {
                    log(reciveTotal);
                  });
                },
                child: const Text('IsolatesButton'))
          ],
        ),
      ),
    );
  }

  taskone() {
    int a = 0;
    for (var i = 0; i < 1000000000; i++) {
      a = a + i;
    }
    return a;
  }

  Future<int> tasktwo() async {
    int a = 0;
    for (var i = 0; i < 1000000000; i++) {
      a = a + i;
    }
    return a;
  }

  tasktree(SendPort sendPort) {
    int a = 0;
    for (var i = 0; i < 1000000000; i++) {
      a = a + i;
    }
    sendPort.send(a);
  }
}
