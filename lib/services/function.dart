class service {
  //base
  static final base = 'http://demos.sappleserve.com:3000/api/';

//base+business and base+user
  static final baseBusiness = base + 'business-';
  static final baseUser = base + 'user-';
  static final baseUser2 = base + 'user/';
  static final baseBusiness2 = baseBusiness + 'user/';

//firebaseId
  static final getFirebaseId = baseBusiness2 + 'firebase-id';

  //offers
  static final getoffers = baseUser + 'offer/list';

  //update offers
  static final updateoffers = baseUser + 'offer/offer-status';

  //get highlights
  static final gethighlights = baseUserProfile + 'get-business-highlight';

  //User+switch
  static final baseUserBusiness = baseUser + 'business-';
  static final baseUserProfile = baseUser + 'profile/';
  static final baseUserWaitlist = baseUser + 'waitlist/';
  static final baseUserBooking = baseUser + 'booking/';
  static final baseUserAppointment = baseUser + 'appointment/';
  static final baseBusinessDashboard = baseBusiness + 'dashboard/';
  static final baseBusinessReview = baseBusiness + 'review/';
  static final baseUserOrder = baseUser + 'order/';

//clicks
  static final funClicks = baseUserProfile + 'promo-click';

//function
  static final register = baseUser2 + 'register';
  static final login = baseUser2 + 'login';
  static final businessCarousel = baseUserProfile + 'business-carousel';
  static final getAddress = baseUser + 'address/get-address';
  static final getUserImage = base + 'user-profile/user-profile-photo';
  static final search = base + 'user-business/search-by-name';
  static final hotAndNewBusiness = baseBusinessDashboard + 'get-new-business';
  static final trendingBusiness = baseBusinessDashboard + 'get-trending-nearby';
  static final topRatedBusiness = baseBusinessDashboard + 'get-top-rated';

  static final userBusinessMenu = baseUserBusiness + 'menu/';
  static final mostPopulerBusiness = baseBusinessDashboard + 'get-most-popular';
  static final foodBusiness = baseBusinessDashboard + 'get-business-by-food';
  static final jobBusiness = baseBusinessDashboard + 'get-business-by-job';
  static final appointmentBusiness =
      baseBusinessDashboard + 'get-business-by-appintment';
  static final freelanceBusiness =
      baseBusinessDashboard + 'get-business-by-freelancer';
  static final doctorBusiness =
      baseBusinessDashboard + 'get-business-by-doctor';
  static final bookTableBusiness =
      baseBusinessDashboard + 'get-business-by-book-table';

  static final baseUserProfileOverview = baseUserProfile + 'business-overview';
  static final baseUserProfileDetail = baseUserProfile + 'business-detail';
  static final baseUserProfileBusinessCatalogList =
      baseUserProfile + 'business-catalog-list';

  static final joblist = base + 'job/list';
  static final checkPostalCode = base + 'job/city-from-pincode';
  static final jobDetail = base + 'user-job/detail';

  //waitlist
  static final baseUserWaitlistVerbose = baseUserWaitlist + 'waitlist-verbose';
  static final baseUserWaitlistSet = baseUserWaitlist + 'set-waitlist';
  static final baseUserWaitlistGet = baseUserWaitlist + 'get-waitlist';
  static final baseUserWaitlistCancel = baseUserWaitlist + 'cancel-waitlist';

  //relation
  static final businessRelationGet = baseUserProfile + 'user-business-relation';

  //review
  static final businessSetReview = baseBusinessReview + 'set-review';
  static final getReviewReplies = baseBusinessReview + 'get-review-replies';
  static final getrating = baseBusinessReview + 'get-review-detail';
  static final getReviewListing = baseUserProfile + 'user-review';
  static final setRating = baseUserProfile + 'set-business-rating';
  static final getMyRating = baseUserProfile + 'get-business-rating';

  //userDetail
  static final userdetail = baseUserProfile + 'user-detail';
  static final getFollowing = baseUserProfile + 'get-all-relation';

  //booking
  static final baseUserBookingList = baseUserBooking + 'get-book-table';
  static final baseUserBookingVerbose = baseUserBooking + 'get-booking-verbose';
  static final baseUserBookingCreate = baseUserBooking + 'set-book-table';

  //appoinment
  static final baseUserAppointmentList =
      baseUserAppointment + 'get-booking-appointment';

  static final baseUserAppointmentVerboseService =
      baseUserAppointment + 'verbose-service';

  static final baseUserAppointmentPersonByServiceid =
      baseUserAppointment + 'get-person-by-service';

  static final baseUserAppointmentSlots =
      baseUserAppointment + 'get-appointment-slot';

  static final baseUserAppointmentCreate =
      baseUserAppointment + 'set-booking-appointment';

//menu
  static final menuTabGet = userBusinessMenu + 'get-category';
  static final menusIsFoodItem = userBusinessMenu + 'get-business-isfood';
  static final menuTabItemGet =
      userBusinessMenu + 'get-category-item'; //this is based on previous
  static final menuItemCust = userBusinessMenu +
      'get-item-customization-detail'; //this is based on previous

  //Order
  static final userOrderCreate =
      baseUserOrder + 'create-order'; //this is used to create a new order
  static final userOrderList =
      baseUserOrder + 'get-order-list'; //this is used to list order
  static final userOrderCreateVerbose =
      userOrderCreate + '-verbose'; //this is used to create a new order
  static final userOrderVerify =
      baseUserOrder + 'payment-order-verify'; //this is used to verify order

  //sendOtp
  static final sendOtp = base +
      'user-change-password/send-otp-change-password'; //this is used to create a new order
  static final verifyOtp = base +
      'user-change-password/verify-otp-change-password'; //this is used to create a new order
  static final checkId =
      base + 'user/is-profile-exist'; //this is used to create a new order

  static final checkMobileOrEmail =
      base + 'user/is-account-exist'; //this is used to create a new order

  static final workingHours = base + 'user-business/get-business-hours';

  static final changeAddress = baseUser + 'address/change-default-address';
  static final modifyAddress = baseUser + 'address/change-address';
  static final deleteAddress = baseUser + 'address/delete-address';
  static final profileImageUpdate = baseUserProfile + 'set-user-profile-photo';
  static final stateList = base + 'state-city/state-list';
  static final sendLoginotp = base + 'user/send-login-otp';
  static final verifyLogin = base + 'user/verify-login-otp';
  static final emailRegister = base + 'user/email-register';
  static final changePassword = base + 'user/set-password';
  //Chat
  static final getChatList = baseBusiness2 + 'get-chat-list';
  static final getChat = baseBusiness2 + 'get-chats';
  static final setGetFirebaseId = baseBusiness2 + 'firebase-id';
  static final getChatConnectedList = baseBusiness2 + 'get-chat-connected-list';
  static final createChatConnected = baseBusiness2 + 'create-chat-connected';
}
