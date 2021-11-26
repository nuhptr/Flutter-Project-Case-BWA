import 'package:bwa_flutix/theme.dart';
import 'package:flutter/material.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  BrowseButton(this.genre);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // TODO: IMAGE KATEGORI
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: grayColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                child: (genre == "Horror")
                    ? Image.asset("assets/icon/horror_icon.png")
                    : (genre == "Musik")
                        ? Image.asset("assets/icon/music_icon.png")
                        : (genre == "Bertarung")
                            ? Image.asset("assets/icon/blade_icon.png")
                            : (genre == "Cinta")
                                ? Image.asset("assets/icon/love_icon.png")
                                : (genre == "Perang")
                                    ? Image.asset("assets/icon/war_icon.png")
                                    : (genre == "Kriminal")
                                        ? Image.asset(
                                            "assets/icon/crime_icon.png")
                                        : Image.asset(
                                            "assets/icon/cancel_photo_icon.png")),
          ),
        ),
        const SizedBox(height: 10),

        // TODO: TEXT KATEGORI
        Center(
            child: Text(
          genre,
          style: blackRalewayRegular.copyWith(fontSize: 12),
        )),
      ],
    );
  }
}
