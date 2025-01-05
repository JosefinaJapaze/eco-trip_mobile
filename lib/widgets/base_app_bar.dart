import 'package:flutter/material.dart';
import '../utils/locale/app_localization.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleKey;

  const BaseAppBar({
    Key? key,
    required this.titleKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          onPressed: () => {Navigator.of(context).pop()},
          icon: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).colorScheme.primary,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                shape: BoxShape.circle,
              )),
        ),
        title: Text(AppLocalizations.of(context).translate(this.titleKey)),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer);
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
