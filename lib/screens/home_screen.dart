import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰's",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons, //await 비동기
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                var webtoon = snapshot.data![index];
                print(index);
                return Text(webtoon.title);
              },
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
            );
          } // snapshot 변화 확인
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
