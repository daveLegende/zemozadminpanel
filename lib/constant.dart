import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final appBarHeight = AppBar().preferredSize.height;
// var height = SizeConfig.screenHeight!;
// var width = SizeConfig.screenWidth!;
String assets = "assets";
const mPrimaryLightColor = Color(0xFFFFECDF);
const mtransparent = Colors.transparent;

//
const mPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFA573FF), Color(0xFF645AFF)],
);
//
const mbackgGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF121016), Color(0xFF3F3C48)],
);
//
const mchateblueGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF2DC9EB), Color(0xFF14D2B8)],
);
//
const mchateredGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFF15887), Color(0xFFFE9B86)],
);
//
const mbuttonGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromARGB(255, 1, 81, 151), Color(0xFF003E74)],
);
//0xFF1C162E
const mpink = Colors.pink;
const mbackgrondColor = Color.fromARGB(255, 1, 0, 24);
const mbackgrondColordashbord = Color(0xFF131315);
const mbSeconderedColor = Color(0xFFFF2D55);
const mbSeconderedColorKbe = Color(0xFFFF5F01);
const mbleuColorKbe = Color.fromARGB(255, 1, 81, 151);
const mbSecondebleuColorKbe = Color(0xFF003E74);

const mbnotificationwritColor = Color(0xFF5A7BEF);
// const couleurViolet = Color(0xFF1C162E);

// const mbtnfofaitColor = Color(0xFF50A1FF);
const mblack = Colors.black;
const mwhite = Colors.white;
const mgrey = Colors.grey;
const mred = Color.fromARGB(255, 245, 20, 4);
const mBotomColor = Color(0xFF1C162E);
const mTextColor = Color(0xFF757575);
const mBeige = Color.fromARGB(255, 243, 242, 240);

const mcardColor = Color(0xFFBEC2CE);
const mcardbtnColor = Color(0xFF242A37);

//
const appBarColor = Color(0xFF1C162E);
// const appFooterColor = Color(0xFF1C162E);

// liste des coloreur du profilr
const mColor1 = Color(0xFF50E3C2);
const mColor2 = Color(0xFF5856D6);
const mColor3 = Color(0xFFFFCC00);
const mColor4 = Color(0xFF5AC8FA);
const mColor5 = Color.fromARGB(255, 75, 143, 3);
const mColor6 = Color(0xFFFF8C00);
const mColor7 = Color(0xFF000000);
const mColor8 = Color(0xFF4CD964);
const mColor9 = Colors.tealAccent;
// edit profile backgrond color
//

//
// Form Error
final RegExp nameRegExp = RegExp(r'^[a-zA-Z0-9_\- ]{3,}$');

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp passWordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

final RegExp phoneRegExp =
    RegExp(r'\+994\s+\([0-9]{2}\)\s+[0-9]{3}\s+[0-9]{2}\s+[0-9]{2}');
final RegExp passwordRegex = RegExp(r"^(?=.*[A-Za-z0-9]).{6,}$");

const String mEmailNullError = "Veuillez entrer votre email";
const String mInvalidEmailError = "Veuillez saisir un e-mail valide";
const String mInvalidNameError = "Veuillez saisir un nom valide";
const String mPassNullError = "Veuillez entrer votre mot de passe";
const String mChampVide = 'Ce champ ne peut pass être vide';
const String mShortPassError = "Le mot de passe est trop court";
const String mMatchPassError = "Les mots de passe ne correspondent pas";
const String mNamelNullError = "S'il vous plaît entrez votre nom";
const String mPhoneNumberNullError = "Veuillez entrer un numéro de téléphone";
const String mPhoneNumberInvalide = "Veuillez entrer un numéro valide";
const String mAddressNullError = "Veuillez entrer votre adresse";

// images
const svgPath = 'assets/svg';
const String lorum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at urna enim. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nam eget sem nec justo pulvinar finibus. Fusce volutpat lacus id sagittis commodo. Donec convallis, nulla at consequat hendrerit, libero urna pulvinar elit, ut commodo dolor risus ac ante. Suspendisse potenti. Integer semper tortor ac justo rutrum, id tempor enim vulputate. Proin placerat nunc vel mauris mollis, at tincidunt neque pellentesque. Nulla pharetra fringilla eros in condimentum.Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi id mi consequat, dignissim elit sit amet, scelerisque purus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla at est a enim vehicula vehicula. Curabitur ac consequat nulla. Nullam accumsan leo at suscipit ultrices. In vel efficitur arcu, nec faucibus mi. Fusce sed commodo orci. Aliquam ut lacinia lectus, ut rutrum ligula.Etiam sit amet ullamcorper enim. Mauris mollis sapien eget libero ullamcorper tristique. Suspendisse potenti. Sed commodo interdum sem vitae laoreet. Nam eget lobortis ipsum, a suscipit felis. Pellentesque pulvinar sapien nec tortor scelerisque ullamcorper. Suspendisse non nibh auctor, aliquet orci sed, tempor ex. Mauris malesuada efficitur tellus. Nam ac lacinia nulla. Integer auctor maximus odio ut volutpat. Donec malesuada nulla id efficitur pretium. Sed laoreet consequat ligula, sit amet finibus dolor semper in. Duis lobortis odio non venenatis dignissim.";
const List category = [
  'Tout',
  'Villa',
  'Maison',
  'CS',
  'Terrains',
  'Une Pièce',
  'Appartement',
];

//

const String ticketSimple = "Une Journée";
const String ticketPhase = "Phase Poule";
const String ticketTournoi = "Tournoi Complet";

ColorScheme colorScheme = const ColorScheme(
  primary: mbSecondebleuColorKbe,
  primaryContainer: mbSecondebleuColorKbe,
  secondary: mbSeconderedColor,
  secondaryContainer: Colors.white,
  surface: Colors.white,
  background: Colors.white,
  error: Colors.red,
  onPrimary: Colors.black,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);

// MaterialColor primaryColor = const MaterialColor(
//   0xFF003E74, // Valeur hexadécimale de la couleur primaire
//   <int, Color>{
//     50: mwhite, // Nuance 50
//     100: Color(0xFF003E74), // Nuance 100
//     200: Color(0xFF003E74), // Nuance 200
//     300: Color(0xFF003E74), // Nuance 300
//     400: Color(0xFF003E74), // Nuance 400
//     500: mbSecondebleuColorKbe, // Nuance 500 (couleur primaire)
//     600: Color(0xFF003E74), // Nuance 600
//     700: Color(0xFF003E74), // Nuance 700
//     800: Color(0xFF003E74), // Nuance 800
//     900: Color(0xFF003E74), // Nuance 900
//   },
// );

var inputFormaters = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(
    RegExp(r'[0-9]'),
  ),
  FilteringTextInputFormatter.digitsOnly,
];

// depot
const String tmoney = "*145*1*montant*numero*2*code secret#";
const String flooz = "*155*1*1*numero*montant*1*code secret#";
const String loading = "loading";
