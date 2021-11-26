import 'package:bwa_flutter_jobs/models/category_model.dart';
import 'package:bwa_flutter_jobs/models/job_model.dart';
import 'package:bwa_flutter_jobs/providers/job_provider.dart';
import 'package:bwa_flutter_jobs/theme.dart';
import 'package:bwa_flutter_jobs/widgets/just_posted_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondHomePage extends StatelessWidget {
  final CategoryModel? categoryModel;

  SecondHomePage({this.categoryModel});

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    Widget header() {
      return Container(
        height: 270,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
          image: DecorationImage(
              image: NetworkImage(categoryModel!.imageUrl!), fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  categoryModel!.name!,
                  style: poppinsSemiBold.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '12,309 Available',
                  style: poppinsRegular.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget body() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Big Companies',
              style: poppinsRegular.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<JobModel>?>(
              future: jobProvider.getJobsByCategory(categoryModel!.name!),
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
            SizedBox(
              height: 14,
            ),
            Text(
              'New Startups',
              style: poppinsRegular.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<JobModel>?>(
              future: jobProvider.getJobsByCategory(categoryModel!.name!),
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            body(),
          ],
        ),
      ),
    );
  }
}
