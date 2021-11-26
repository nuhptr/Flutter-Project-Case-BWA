import 'package:flutter/material.dart';

import '/shared/shared_value.dart';
import '/theme.dart';
import '/model/actor.dart';

class ActorCard extends StatelessWidget {
  final Actor actor;

  ActorCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 70,
          decoration: BoxDecoration(
              color: grayColor,
              borderRadius: BorderRadius.circular(8),
              image: (actor.profilePath == null)
                  ? null
                  : DecorationImage(
                      image:
                          NetworkImage(imageKey + "w185" + actor.profilePath),
                      fit: BoxFit.cover)),
        ),
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 70,
          child: Text(
            actor.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: blackRalewayRegular.copyWith(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
