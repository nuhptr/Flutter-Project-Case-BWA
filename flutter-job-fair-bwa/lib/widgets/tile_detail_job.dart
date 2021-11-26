import 'package:bwa_flutter_jobs/theme.dart';
import 'package:flutter/material.dart';

class TileDetailJob extends StatelessWidget {
  final String? text;

  const TileDetailJob({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Image.asset(
            'assets/dot.png',
            width: 12,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              text!,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: poppinsLight,
            ),
          )
        ],
      ),
    );
  }
}
