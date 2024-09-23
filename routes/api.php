<?php

use App\Http\Controllers\AdressController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BillController;
use App\Http\Controllers\ConversationController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\NotifactionController;
use App\Http\Controllers\NotifactionVendorController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\OrdermoneyController;
use App\Http\Controllers\OrderofferController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\ServiceSliderController;
use App\Http\Controllers\ServicesTypesController;
use App\Http\Controllers\SliderController;
use App\Http\Controllers\UsersController;
use App\Http\Controllers\VendorController;
use App\Http\Controllers\VendorservicesController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\SMSController;
use App\Http\Controllers\CustomerserviceconversationController;
use App\Http\Controllers\CustomerServiceMessageController;

// -------------------------
// --------------------------------------public routes   ---------
// -------------------------






// -------------------------
// self public routes   ----
// -------------------------
Route::get('/user/{id}', [UsersController::class,  'show']);
Route::get('/vendors/{id}', [VendorController::class, 'show']);
Route::post('/vendor/add', [VendorController::class, 'store']);
Route::post('/storefromdashbord', [VendorController::class, 'storefromdashbord']);
Route::post('/verifiyvendorphone', [VendorController::class, 'verifiyvendorphone']);
Route::post('/vendors-top-10', [VendorController::class, 'gettopten']);
Route::get('/service-types-all/{id}', [ServicesTypesController::class, 'getallservicesbyid']);
Route::get('/servicestypes', [ServicesTypesController::class, 'index']);
Route::get('/sliders', [SliderController::class, 'index']);
Route::get('/service-sliders', [ServiceSliderController::class, 'index']);
// -------------------------
// group public routes   ---
// -------------------------
Route::controller(ServiceController::class)->group(function () {
    Route::get('/services-count', 'getServicesCount');
    Route::get('/services-published', 'publishedservices');
    Route::get('/services-name', 'searchforservicebyname');
    Route::get('/services-10', 'get_top10_services');
    Route::get('/services/{id}', 'show');
    Route::get('/servicesvendor/{id}', 'getServicesByIdVendor');
    Route::get('/servicesrandom', 'get10randomservices');
    Route::get('/services-4', 'get4randomservices_with_custom_details');
    Route::get('/servicesrandom-tilte-image', 'get10randomservices_with_title_and_image_only');
});

// -------------------------
// orders routes   ---------
// -------------------------
Route::controller(OrderController::class)->group(function () {
    Route::get('/orders', 'index');
    Route::get('/orders-count', 'getOrdersCount');
    Route::get('/orders-name', 'searchfororderbyname');
    Route::get('/orders/{id}/{sender_type}', 'getOrdersByUserId');
    Route::get('/orders-count/{id}/{sender_type}', 'getordersCountByUserId');
    Route::get('/orders-vendor/{id}', 'getOrdersByVendorId');
    Route::get('/orders-vendor-count/{id}', 'getordersCountByVendorId');
    Route::get('/lastorders', 'get5lastorders');
    Route::get('/order/{id}', 'show');
});



// -------------------------
// Auth routes   -----------
// -------------------------

Route::controller(AuthController::class)->group(function () {
    Route::post('/register', 'register');
    Route::post('/quickaccesswithphone', 'quickaccesswithphone');
    Route::post('/verifyCodeAndCreateUser', 'verifyCodeAndCreateUser');
    Route::post('/registerfromdashbord', 'registerfromdashbord');
    Route::post('/registerasguest', 'registerasguest');
    Route::post('/verifyPhone', 'verifyuserPhone');
    Route::post('/resendphonecode', 'resendPhoneCode');
    Route::post('/login', 'login');
    Route::post('/logout', 'logout');
    Route::post('/loginwithphone', 'loginWithPhone');
});

// -------------------------
// order-offers routes   --
// -------------------------
Route::controller(OrderofferController::class)->group(function () {
    Route::get('/order-offers/{order_id}', 'index');
    Route::get('/offers-count/{order_id}', 'getofferscount');
    Route::post('/orderoffer-add', 'store');
});




Route::post('/send-sms', [SMSController::class, 'sendSms']);

// ---------------------------
// servicestypes routes   ----
// ---------------------------
Route::controller(PaymentController::class)->group(function () {
    Route::post('/paywithbalance/{id}',  'paywithbalance');
    Route::post('/payment/create',  'createPayment');
    Route::post('/payment/status',  'getPaymentStatus');
    Route::post('/payment/addfunds',  'addFunds');
    Route::get('/payment/addFundsCallback',  'addFundsCallback')->name('payment.addFundsCallback');
    Route::get('/payment/callback',  'handleCallback')->name('payment.callback'); // تأكد من تعريف الاسم
    Route::get('/payment/error',  'handleError')->name('payment.error');
});




// ---------------------------
// protected routes sign  -----
// ---------------------------
Route::middleware(['auth:sanctum'])->group(function () {
    Route::controller(UsersController::class)->group(function () {
        Route::post('/user/{id}',  'update');
    });
    Route::get('/user', [UsersController::class,  'currentUser']);
    // ---------------------
    // vendor routes  ------
    // ---------------------
    Route::controller(VendorController::class)->group(function () {
        Route::post('/vendors/{id}', 'update');
    });





    // -------------------------
    // order-money routes   --
    // -------------------------
    Route::controller(OrdermoneyController::class)->group(function () {
        Route::post('/orders-money-add', 'store');
    });



    // -------------------------
    // services routes   ----
    // -------------------------
    Route::controller(ServiceController::class)->group(function () {
        Route::post('/services/add', 'store');
        Route::post('/service-edit/{id}', 'update');
        Route::delete('/services/{id}', 'destroy');
    });

    // -------------------------
    // orders routes   ----
    // -------------------------
    Route::controller(OrderController::class)->group(function () {
        Route::post('/orders/add', 'store');
        Route::post('/orders/{id}', 'update');
        Route::delete('/orders/{id}', 'destroy');
    });

    // -------------------------
    // Addresses routes   ----
    // -------------------------
    Route::controller(AdressController::class)->group(function () {
        Route::post('/addresses/add', 'store');
        Route::get('/addresses/{user_id}/{account_type}', 'getAddressesByUserId');
        Route::get('/addresses-total/{user_id}/{account_type}', 'getAddressesCountByUserId');
        Route::post('/addresses/{id}', 'update');
        Route::delete('/addresses/{id}', 'destroy');
    });

    // -------------------------------
    // Notification vendor routes   ----
    // -------------------------------
    Route::controller(NotifactionVendorController::class)->group(function () {
        Route::get('/notifications-vendor/{id}', 'NotifactionsByVendorId');
        Route::post('/notifications-vendor-read/{id}', 'markAsRead');
        Route::get('/notifications-vendor-unread/{id}', 'getUnreadNotificationsByVendorId');
        Route::post('/notification-vendor/add', 'store');
        Route::get('/notification-vendor/{id}', 'show');
        Route::post('/notifications-vendor-edit/{id}', 'update');
        Route::delete('/notifications-vendor/{id}', 'destroy');
    });

    // -------------------------------
    // Notification user routes   ----
    // -------------------------------
    Route::controller(NotifactionController::class)->group(function () {
        Route::get('/notifications-user/{id}', 'NotifactionsByUserId');
        Route::post('/notifications-user-read/{id}', 'markAsRead');
        Route::get('/notifications-user-unread/{id}', 'getUnreadNotificationsByUserId');
        Route::post('/notification-user/add', 'store');
        Route::get('/notification-one/{id}', 'show');
        Route::post('/notifications/{id}', 'update');
        Route::delete('/notifications/{id}', 'destroy');
    });


    // -------------------------
    // chat routes   ----
    // -------------------------
    Route::controller(ConversationController::class)->group(function () {
        Route::get('/users/{userid}/{type}/conversations', 'getConversationsWithUnreadStatus');
        Route::post('/conversations', 'store');
        Route::post('/conversations-read', 'markMessagesAsReadForConversationsWithUnread');
        Route::get('/conversation-details/{id}', 'show');
    });
    
    
    // -------------------------
    // Messages routes   ----
    // -------------------------
    
    Route::controller(MessageController::class)->group(function () {
        Route::get('/conversations/{conversationid}/messages',  'index');
        Route::post('/messages',  'store');
        Route::post('/conversations/{conversation_id}/mark-as-read',  'markAllAsRead');
    });
    
    // -------------------------
    // Customerserviceconversation routes   ----
    // -------------------------

    Route::controller(CustomerserviceconversationController::class)->group(function () {
        Route::get('/customerconversations/{userid}', 'index');
        Route::post('/customerconversations/make', 'store');
        Route::get('/conversation-details-customer/{id}', 'show');
        Route::get('/conversation-details-secend/{id}/{current_user_type}', 'show_secend_party');
    });
    
    // ------------------------------------
    // CustomerServiceMessage routes   ----
    // ------------------------------------

    Route::controller(CustomerServiceMessageController::class)->group(function () {
        Route::get('/customer-conversations/{conversationid}/messages',  'index');
        Route::post('/customer-messages-send',  'store');
        Route::post('/custmoer-conversations/{customerserviceconversation_id}/mark-as-read',  'markAllAsRead');
    });
    
    // ------------------------------------
    // Customer routes   ----
    // ------------------------------------

    Route::controller(CustomerController::class)->group(function () {
        Route::post('/messagecustomer/send', 'store');
    });
    
    // ------------------------------------
    // Vendorservices routes   ----
    // ------------------------------------

    Route::controller(VendorservicesController::class)->group(function () {
       Route::post('/messagevendor/send', 'store');
    });
});

// ---------------------------
// protected routes admin  ---
// ---------------------------

Route::middleware(['auth:sanctum', 'CheckAdmin'])->group(function () {

    // -------------------------
    // users routes   ----
    // -------------------------
    Route::controller(UsersController::class)->group(function () {
        Route::get('/users', 'index');
        Route::get('/users-count', 'getUsersCount');
        ///////////////////////////////////////////////////////
        ///// end point should be like  /search-name?name=John
        Route::get('/search-name', 'searchUserByName');
        Route::get('/search-user', 'searchUserByNamefornotifactions');
        ///////////////////////////////////////////////////////
        Route::delete('/users/{id}', 'destroy');
    });

    // -------------------------
    // vendors routes   ----
    // -------------------------
    Route::controller(VendorController::class)->group(function () {
        Route::get('/vendors', 'index');
        Route::get('/vendors-count', 'getVendorsCount');
        Route::get('/vendors-by-orders', 'sortbyorders');
        ///////////////////////////////////////////////////////
        ///// end point should be like  /search-vendor?name=John
        Route::get('/search-vendor', 'searchforvendorbyname');
        ///////////////////////////////////////////////////////
        Route::delete('/vendors/{id}', 'destroy');
    });

    // -------------------------
    // servicestypes routes   --
    // -------------------------
    Route::controller(ServicesTypesController::class)->group(function () {
        Route::post('/service-type/add', 'store');
        Route::get('/service-type/{id}', 'show');
        Route::post('/service-type/{id}', 'update');
        Route::delete('/service-type/{id}', 'destroy');
    });

    // -------------------------
    // Bills routes   ---------
    // -------------------------
    Route::controller(BillController::class)->group(function () {
        Route::get('/bills', 'index');
        Route::get('/bills-summary', 'getBillsSummary');
        Route::delete('/bills-delete', 'destroy');
    });
    // -------------------------
    // Slider routes   ---------
    // -------------------------
    Route::controller(SliderController::class)->group(function () {
        Route::post('/slider/add', 'store');
        Route::delete('/slider/{id}', 'destroy');
    });

    // -------------------------
    // Service Slider routes   -
    // -------------------------
    Route::controller(ServiceSliderController::class)->group(function () {
        Route::post('/service-slider/add', 'store');
        Route::delete('/service-slider/{id}', 'destroy');
    });

    Route::controller(OrdermoneyController::class)->group(function () {
        Route::get('/ordersmoney', 'index');
        Route::get('/ordersmoney/{id}', 'show');
        Route::post('/ordersmoney/{id}', 'update');
        Route::delete('/ordersmoney-delete/{id}', 'destroy');
    });
});

// -------------------------
// services routes   ----
// -------------------------
Route::middleware(['auth:sanctum', 'serviceinspector'])->group(function () {
    Route::controller(ServiceController::class)->group(function () {
        Route::get('/services', 'index');
        Route::post('/services/{id}', 'update_status');
    });
});
Route::middleware(['auth:sanctum', 'customerservice'])->group(function () {
    Route::controller(CustomerController::class)->group(function () {
        Route::get('/messagescustomer', 'index');
        Route::post('/messagecustomer/{id}', 'update');
        Route::get('/messagecustomer/{id}', 'show');
        Route::delete('/messagecustomer/{id}', 'destroy');
    });
    Route::controller(VendorservicesController::class)->group(function () {
        Route::get('/messagesvendor', 'index');
        Route::post('/messagevendor/{id}', 'update');
        Route::get('/messagevendor/{id}', 'show');
        Route::delete('/messagevendor/{id}', 'destroy');
    });
});
