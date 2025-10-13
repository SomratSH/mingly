class AppUrls {
  static String baseUrl = "http://10.10.13.20:8005/app/api/v1";
  static String imageUrl = "http://10.10.13.20:8005";
  // static String baseUrl = "https://080aadaa0adf.ngrok-free.app/app/api/v1";

  //authentication
  static String login = "/auth/login/";
  static String signUp = "/auth/signup/";
  static String verifyOtp = "/auth/verify-otp/";
  static String forgotPassword = "/auth/forget-password/";
  static String resetPassword = "/auth/reset-password/";

  //profile
  static String profile = "/profile/";
  static String profileUpdate = "/profile/update/";

  //event join
  static String joinEvent = "/events/";

  //venues
  static String venuesUrl = "/all-venues/";

  //events
  static String eventsUrl = "/all-events/";
  static String eventDetails = "/event/";
  static String ticketList = "/event_tickets/";
  static String buyTicket = "/book_ticket/";

  //bottles
  static String getBottle = "/all-bottles/";

  //tables and sofa ticket list
  static String getTableTicket = "/table-availability/";
  static String tableBook = "/book-table/";

  //top leader board
  static String leaderBoard = "/top-spenders/";

  //subscription
  static String pakageget = "/membership/packages/";

  static String updagradePlan = "/membership/upgrade/";

  static String getPopularEvent = "/popular-events/";

  static String notification = "/get-notifications/";

  static String getVoucher = "/my-vouchers/";

  static String favourite = "/my-favourites/";

  static String sendChat = "/chats/send_message/";

  static String pointHistory = "/my-point-transactions/";

  static String reservation = "/my-reservations/";

  static String addToFav = "/favourite/";
}
