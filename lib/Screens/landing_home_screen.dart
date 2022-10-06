import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingHomeScreen extends StatelessWidget {
  const LandingHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey there,',
                    style: Get.textTheme.headline4!.copyWith(
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    //TODO: Get user name
                    'Michael',
                    style: Get.textTheme.displaySmall,
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Text('Your properties', style: Get.textTheme.headline6),
              const SizedBox(height: 16),
              //TODO: Get user properties
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(3, 3),
                            spreadRadius: -3,
                            blurRadius: 10,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.width / 1.75,
                            height: Get.width / 2.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://assets-news.housing.com/news/wp-content/uploads/2022/03/15102726/Vastu-for-flats-in-apartments.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'PG 1',
                            style: Get.textTheme.headline6,
                          ),
                          // const SizedBox(height: 8),
                          Text(
                            'PG Name',
                            style: Get.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
