import 'package:bwa_flutter_jobs/models/job_model.dart';
import 'package:bwa_flutter_jobs/pages/detail_page.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class JustPostedCard extends StatelessWidget {
  final JobModel? job;

  const JustPostedCard({this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(job: job!),
            ));
      },
      child: Container(
        child: Row(
          children: [
            Image.network(
              job!.companyLogo!,
              width: 44,
            ),
            SizedBox(
              width: 27,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job!.name!,
                    style: poppinsMedium.copyWith(
                      fontSize: 16,
                      color: headerColor,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    job!.companyName!,
                    style: poppinsRegular.copyWith(
                      fontSize: 14,
                      color: titleColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
