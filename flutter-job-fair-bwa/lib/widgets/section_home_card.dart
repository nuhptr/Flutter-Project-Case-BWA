import 'package:bwa_flutter_jobs/models/category_model.dart';
import 'package:bwa_flutter_jobs/pages/second_home_page.dart';
import 'package:bwa_flutter_jobs/theme.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final CategoryModel? categoryModel;

  HomeCard({this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondHomePage(
                categoryModel: categoryModel!,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        height: 200,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Image.network(
              categoryModel!.imageUrl!,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  categoryModel!.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: poppinsMedium.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
