import 'package:bwa_flutter_jobs/models/job_model.dart';
import 'package:bwa_flutter_jobs/theme.dart';
import 'package:bwa_flutter_jobs/widgets/tile_detail_job.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final JobModel? job;

  DetailPage({this.job});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var isApplied = false;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Center(
        child: Container(
          margin: EdgeInsets.only(
            top: isApplied ? 30 : 80,
          ),
          child: Column(
            children: [
              Image.network(
                widget.job!.companyLogo!,
                width: 60,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.job!.name!,
                style: poppinsSemiBold.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                '${widget.job!.companyName!} - ${widget.job!.location}',
                style: poppinsRegular.copyWith(
                  fontSize: 14,
                  color: titleColor,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget body() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About the job',
              style: poppinsMedium.copyWith(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: widget.job!.about!
                  .map(
                    (job) => TileDetailJob(text: job),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              'Qualifications',
              style: poppinsMedium.copyWith(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: widget.job!.qualifications!
                  .map((job) => TileDetailJob(text: job))
                  .toList(),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              'Responsibilities',
              style: poppinsMedium.copyWith(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: widget.job!.responsibilities!
                  .map((job) => TileDetailJob(text: job))
                  .toList(),
            ),
            SizedBox(
              height: 24,
            ),
            Center(
              child: Container(
                width: 200,
                height: 45,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          isApplied ? Colors.red.shade300 : splashColorBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(66),
                      )),
                  onPressed: () {
                    setState(() {
                      isApplied = !isApplied;
                    });
                  },
                  child: Text(
                    isApplied ? 'Cancel Apply' : 'Apply For Job',
                    style: poppinsMedium.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    'Message Recruiter',
                    style: poppinsLight.copyWith(
                      fontSize: 14,
                      color: titleColor,
                    ),
                  )),
            ),
            SizedBox(
              height: 35,
            )
          ],
        ),
      );
    }

    Widget successApplied() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(49),
          color: appliedColor,
        ),
        child: Center(
          child: Text(
            'You have applied this job and the\nrecruiter will contact you',
            textAlign: TextAlign.center,
            style: poppinsRegular.copyWith(
              fontSize: 14,
              color: textAppliedColor,
            ),
          ),
        ),
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isApplied ? successApplied() : SizedBox(),
          header(),
          body(),
        ],
      ),
    ));
  }
}
