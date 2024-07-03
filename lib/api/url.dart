class APIURL {
  // static const localhost = "http://192.173.1.103";
  static const localhost = "https://zemozserverapi.onrender.com";
  // static const localhost = "http://192.168.1.73";
  static const imgUrl = "$localhost:/";
  static const baseConURL = "$localhost/auth";
  static const baseUserURL = "$localhost/user";
  static const baseAdminURL = "$localhost/admin";
  static const baseNoneURL = "$localhost/none";

  // None user
  static const String getLiveURL = "$baseNoneURL/getLives";
  static const String getMatchURL = "$baseNoneURL/getAllMatchs";
  static const String getPouleURL = "$baseNoneURL/getPoules";
  static const String getEventURL = "$baseNoneURL/getEvents";

  // * * *
  // admin
  // get current admin
  static const String profile = "$baseAdminURL/profile";
  static const String adminListURL = "$baseAdminURL/allAdmins";
  static const String deleteAdmintURL = "$baseAdminURL/deleteAdmin";

  // login
  static const String loginUrl = "$baseAdminURL/login";
  static const String registerUrl = "$baseAdminURL/register";
  // teams
  static const String getTeamUrl = "$baseAdminURL/getTeams";
  static const String addTeamUrl = "$baseAdminURL/addTeams";
  static const String updateTeamUrl = "$baseAdminURL/updateOneTeam";
  static const String deleteOneTeam = "$baseAdminURL/deleteOneTeam";
  // matchs
  static const String createMatchURL = "$baseAdminURL/createMatch";
  // poules
  static const String addPouleUrl = "$baseAdminURL/creerPoule";
  static const String stopMatchURL = "$baseAdminURL/stopMatch";
  static const String beginMatch = "$baseAdminURL/beginMatch";
  static const String deleteOnePoule = "$baseAdminURL/deleteOnePoule";
  static const String deleteOneMatch = "$baseAdminURL/deleteOneMatch";
  // transactions
  static const String depot = "$baseAdminURL/depot";
  static const String getDepots = "$baseAdminURL/getDepots";
  static const String retrait = "$baseAdminURL/retrait";
  static const String getRetraits = "$baseAdminURL/getRetraits";
  static const String getAlltransacURL = "$baseAdminURL/getAllTransac";
  // Tickets
  static const String scanTicketURL = "$baseAdminURL/scanTicket";
  static const String getTicketsURL = "$baseAdminURL/getAllTickets";

  // events
  static const String createEventURL = "$baseAdminURL/createEvent";
  static const String editEventURL = "$baseAdminURL/editEvent";
  static const String deleteEventURL = "$baseAdminURL/deleteEvent";

  // users
  static const String getAllUserURL = "$baseAdminURL/allUsers";
  static const String deleteUserURL = "$baseAdminURL/deleteUser";
  


  // socket
  static const String socketURL = 'wss://zemozserverapi.onrender.com';


}
