import 'package:bwa_flutter_jobs/models/category_model.dart';
import 'package:bwa_flutter_jobs/models/job_model.dart';
import 'package:bwa_flutter_jobs/providers/category_provider.dart';
import 'package:bwa_flutter_jobs/providers/job_provider.dart';
import 'package:bwa_flutter_jobs/providers/user_provider.dart';
import 'package:bwa_flutter_jobs/theme.dart';
import 'package:bwa_flutter_jobs/widgets/just_posted_card.dart';
import 'package:bwa_flutter_jobs/widgets/section_home_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var categoryProvider = Provider.of<CategoryProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30, right: defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Howdy',
                    style: poppinsRegular.copyWith(
                      fontSize: 16,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    userProvider.user.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: poppinsSemiBold.copyWith(
                      fontSize: 24,
                      color: headerColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: splashColorBg!),
              ),
              child: Container(
                padding: EdgeInsets.all(3),
                child: Image.asset('assets/image_profile.png'),
              ),
            )
          ],
        ),
      );
    }

    Widget body() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hot Categories',
                style: poppinsRegular.copyWith(
                  fontSize: 16,
                  color: Color(0xff272C2F),
                )),
            SizedBox(
              height: 16,
            ),
            FutureBuilder<List<CategoryModel?>?>(
                future: categoryProvider.getCategories(),
                builder: (BuildContext context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!
                            .map(
                              (category) => HomeCard(
                                categoryModel: category,
                              ),
                            )
                            .toList(),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            SizedBox(
              height: 30,
            ),
            Text(
              'Just Posted',
              style: poppinsRegular.copyWith(
                fontSize: 16,
                color: headerColor,
              ),
            ),
            SizedBox(
              height: 26,
            ),
            FutureBuilder<List<JobModel>?>(
              future: jobProvider.getJobs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: snapshot.data!
                        .map(
                          (job) => Container(
                            margin: EdgeInsets.only(bottom: 16.5),
                            child: Column(
                              children: [
                                JustPostedCard(job: job),
                                SizedBox(
                                  height: 18.5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 70,
                                    right: defaultMargin,
                                  ),
                                  child: Divider(),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }

                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 30),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          elevation: 0,
          iconSize: 24,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: currentIndex == 0
                  ? ImageIcon(
                      AssetImage('assets/icon_home.png'),
                      color: Color(0xff272C2F),
                    )
                  : ImageIcon(
                      AssetImage('assets/icon_home.png'),
                      color: Color(0xffB3B5C4),
                    ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: currentIndex == 1
                  ? ImageIcon(
                      AssetImage('assets/icon_notification.png'),
                      color: Color(0xff272C2F),
                    )
                  : ImageIcon(
                      AssetImage('assets/icon_notification.png'),
                      color: Color(0xffB3B5C4),
                    ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: currentIndex == 2
                  ? ImageIcon(
                      AssetImage('assets/icon_love.png'),
                      color: Color(0xff272C2F),
                    )
                  : ImageIcon(
                      AssetImage('assets/icon_love.png'),
                      color: Color(0xffB3B5C4),
                    ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: currentIndex == 3
                  ? ImageIcon(
                      AssetImage('assets/icon_user.png'),
                      color: Color(0xff272C2F),
                    )
                  : ImageIcon(
                      AssetImage('assets/icon_user.png'),
                      color: Color(0xffB3B5C4),
                    ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: defaultMargin),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              body(),
            ],
          ),
        ),
      ),
    );
  }
}
