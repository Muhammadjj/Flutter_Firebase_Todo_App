import 'package:flutter/material.dart';

class ReceiveImage extends StatelessWidget {
  const ReceiveImage({super.key, required this.backgroundImage});
  final ImageProvider backgroundImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: backgroundImage,
          backgroundColor: Colors.grey,
        )
      ],
    );
  }
}

class ProfileViewListTile extends StatelessWidget {
  const ProfileViewListTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.leading,
      this.onTap});
  final Widget title;
  final Widget subTitle;
  final Widget leading;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        shadowColor: Colors.grey.shade200,
        child: ListTile(
          onTap: onTap,
          title: title,
          subtitle: subTitle,
          leading: leading,
        ),
      ),
    );
  }
}
