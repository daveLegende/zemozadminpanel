import 'package:admin/blocs/auth/auth_bloc.dart';
import 'package:admin/blocs/auth/auth_event.dart';
import 'package:admin/blocs/auth/auth_state.dart';
import 'package:admin/components/general_field.dart';
import 'package:admin/components/loading.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/helper.dart';
import 'package:admin/models/admin.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final email = TextEditingController();
  final password = TextEditingController();
  final conf = TextEditingController();
  late AuthenticationBloc authBloc =
      BlocProvider.of<AuthenticationBloc>(context);
  bool login = true;
  final formKey = GlobalKey<FormState>();
// Affichage des mots de passe
  bool obscurePassword = true;
  bool obscurePasswordConf = true;

  @override
  void initState() {
    super.initState();
    authBloc.stream.listen((state) {
      if (state is LoginErrorState) {
        Helper().myErrorToast(state.message, context);
      } else if (state is RegisterErrorState) {
        Helper().myErrorToast(state.message, context);
      } else if (state is LoginSuccessState) {
        Helper().goToAndRemoveUntil(
          context: context,
          page: MainScreen(),
        );
      } else if (state is RegisterSuccessState) {
        Helper().goToAndRemoveUntil(
          context: context,
          page: MainScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Container(
        width: width,
        height: height,
        color: mgrey[200],
        child: Center(
          child: Container(
            width: width / 4,
            height: height / 1.5,
            decoration: BoxDecoration(
              color: mwhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: bgColor,
                  child: Center(
                    child: Text(
                      "Zemoz Admin Panel",
                      style: TextStyle(
                        color: mwhite,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: 10,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            login ? "LOGIN" : "REGISTER",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GeneralTextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Email",
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return mEmailNullError;
                              } else if (!emailValidatorRegExp.hasMatch(p0)) {
                                return mInvalidEmailError;
                              } else {
                                return null;
                              }
                            },
                          ),
                          GeneralTextField(
                            controller: password,
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Password",
                            obscureText:
                                obscurePassword, 
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                          ),
                          login
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        "mot de passe oublié",
                                        style: StyleText().googleTitre.copyWith(
                                              color: mbSeconderedColorKbe,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  mbSeconderedColorKbe,
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                              : GeneralTextField(
                                  controller: conf,
                                  prefixIcon: Icon(Icons.verified),
                                  hintText: "Confirm password",
                                  obscureText:
                                      obscurePasswordConf, 
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePasswordConf
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscurePasswordConf = !obscurePasswordConf;
                                      });
                                    },
                                  ),
                                ),
                          state is LoginLoadingState ||
                                  state is RegisterLoadingState
                              ? LoadingCircular()
                              : InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      if (!login) {
                                        authBloc.add(
                                          RegisterSuccessEvent(
                                            email: email.text.trim(),
                                            password: password.text.trim(),
                                            confirm: conf.text.trim(),
                                          ),
                                        );
                                      } else {
                                        authBloc.add(
                                          LoginSuccessEvent(
                                            admin: Admin(
                                              email: email.text.trim(),
                                              password: password.text.trim(),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: mbSeconderedColorKbe,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        login ? "Login" : "Register",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: mwhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  !login
                                      ? "Vous avez déja un compte ? "
                                      : "Pas de compte ? ",
                                  style: StyleText().googleTitre.copyWith(
                                        color: mgrey,
                                        fontSize: 14,
                                      ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      login = !login;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      !login ? "Se Connecter" : "S'enrégistrer",
                                      style: StyleText().googleTitre.copyWith(
                                            color: mbSecondebleuColorKbe,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                mbSecondebleuColorKbe,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
