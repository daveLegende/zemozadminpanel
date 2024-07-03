// import 'package:admin/api/url.dart';
import 'package:admin/api/url.dart';
import 'package:admin/constant.dart';
import 'package:flutter/material.dart';

class EquipeFlagName extends StatelessWidget {
  const EquipeFlagName({
    super.key,
    required this.radius,
    required this.logo,
    required this.name,
  });

  final double radius;
  final String logo, name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage("${APIURL.imgUrl}$logo"),
        ),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// a venir
class TeamFlagNameLeft extends StatelessWidget {
  const TeamFlagNameLeft({
    super.key,
    required this.radius,
    required this.logo,
    required this.name,
  });

  final double radius;
  final String logo, name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage("${APIURL.imgUrl}$logo"),
        ),
      ],
    );
  }
}

class TeamFlagNameRight extends StatelessWidget {
  const TeamFlagNameRight({
    super.key,
    required this.radius,
    required this.logo,
    required this.name,
  });

  final double radius;
  final String logo, name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage("${APIURL.imgUrl}$logo"),
        ),
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class TeamLogo extends StatelessWidget {
  const TeamLogo({
    super.key,
    required this.path,
  });
  final String path;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: mtransparent,
      child: Image.network(
        "${APIURL.imgUrl}$path",
        fit: BoxFit.cover,
      ),
    );
  }
}
