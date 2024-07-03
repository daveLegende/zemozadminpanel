import 'package:admin/blocs/admin/admin_bloc.dart';
import 'package:admin/blocs/auth/auth_bloc.dart';
import 'package:admin/blocs/auth/auth_event.dart';
import 'package:admin/constant.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          bottom: BorderSide(
            color: mwhite.withOpacity(.5),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: context.read<MenuAppController>().controlMenu,
            ),
          if (!Responsive.isMobile(context))
            Text(
              "Tournoi Zémoz",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: bgColor),
            ),
          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Expanded(child: SearchField()),
          ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late AdminBloc abloc = BlocProvider.of<AdminBloc>(context);
  Offset? tapPosition;

  @override
  void initState() {
    super.initState();
    abloc.add(GetAdminSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: InkWell(
            onTapDown: (details) {
              setState(() {
                tapPosition = details.globalPosition;
              });
              showPopupMenu(
                context: context,
                email: state is GetAdminSuccessState ? state.admin.email : "",
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    UnAuthenticateEvent(),
                  );
                },
              );
            },
            child: Container(
              width: 100,
              margin: EdgeInsets.only(left: defaultPadding, right: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: mwhite,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 20,
                    color: mgrey,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      state is GetAdminSuccessState ? state.admin.email : "",
                      style: StyleText().googleTitre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: mgrey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showPopupMenu(
      {required BuildContext context,
      required String email,
      required Callback onTap}) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        tapPosition! & Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: "1",
          child: Row(
            children: [
              Icon(Icons.person),
              SizedBox(width: 20),
              Text(email),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: "2",
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(Icons.logout, color: mbSeconderedColorKbe,),
                SizedBox(width: 20),
                Text("Se déconnecter", style: TextStyle(color: mbSeconderedColorKbe),),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(),
      decoration: InputDecoration(
        hintText: "Rechercher...",
        hintStyle: TextStyle(color: mblack),
        fillColor: mwhite,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: mbSeconderedColorKbe,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
