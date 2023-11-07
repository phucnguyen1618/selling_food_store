import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/models/credential.dart';
import 'package:selling_food_store/models/product_detail.dart';
// ignore: library_prefixes
import 'package:selling_food_store/models/user_info.dart' as user;
import 'package:selling_food_store/models/type_product.dart';
import 'package:selling_food_store/shared/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/cart.dart';
import '../../models/detail_brand.dart';
import '../../models/product.dart';
import '../../models/request_order.dart';

class FirebaseService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  static final DatabaseReference _dbRef =
      _firebaseDatabase.refFromURL(Strings.databaseUrl);

  static final prefs = getIt.get<SharedPreferences>();

  static Future<void> fetchDataTypeProducts(
      {required Function(List<TypeProduct>) onLoadComplete}) async {
    List<TypeProduct> typeProducts = [];
    _dbRef.child('typeProducts').get().then((snapshot) {
      if (snapshot.exists) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final result = jsonDecode(jsonEncode(dataSnapshot.value))
              as Map<String, dynamic>;
          final dataType = TypeProduct.fromJson(result);
          typeProducts.add(dataType);
        }
        onLoadComplete(typeProducts);
      }
    });
  }

  static Future<void> fetchDataRecommendProducts(
      {required Function(List<Product>) onLoadComplete}) async {
    List<Product> products = [];
    _dbRef.child('products').child('recommended').get().then((snapshot) {
      if (snapshot.exists) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final result = jsonDecode(jsonEncode(dataSnapshot.value))
              as Map<String, dynamic>;
          final dataValue = Product.fromJson(result);
          products.add(dataValue);
        }
        onLoadComplete(products);
      }
    });
  }

  static Future<void> fetchDataHotSellingProducts(
      {required Function(List<Product>) onLoadComplete}) async {
    List<Product> products = [];
    _dbRef.child('products').child('hotSelling').get().then((snapshot) {
      if (snapshot.exists) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final result = jsonDecode(jsonEncode(dataSnapshot.value))
              as Map<String, dynamic>;
          final dataValue = Product.fromJson(result);
          products.add(dataValue);
        }
        onLoadComplete(products);
      }
    });
  }

  static void fetchDataProductDetail(
    String id,
    Function(ProductDetail) onComplete,
    Function(String) onError,
  ) {
    _dbRef.child('detailProducts').child(id).get().then((snapshot) {
      if (snapshot.exists) {
        final result =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        ProductDetail detail = ProductDetail.fromJson(result);
        onComplete(detail);
      }
    }).onError(
      (error, stackTrace) => onError(error.toString()),
    );
  }

  static void fetchProductListToCart(
    Function(List<Cart>) onComplete,
    Function(String) onError,
  ) {
    List<Cart> cartList = [];
    final String? id = prefs.getString(Strings.idUser);
    _dbRef.child('carts').child(id ?? '').get().then((snapshot) {
      if (snapshot.exists) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final result = jsonDecode(jsonEncode(dataSnapshot.value));
          Cart cart = Cart.fromJson(result);
          cartList.add(cart);
        }
        onComplete(cartList);
      } else {
        onComplete(cartList);
      }
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static Future<void> addProductToCart(
    Cart cart,
    Function() onComplete,
    Function(String) onError,
  ) async {
    final String? id = prefs.getString(Strings.idUser);
    if (id != null) {
      _dbRef
          .child('carts')
          .child(id)
          .child(cart.idCart)
          .set(cart.toJson())
          .then((value) => onComplete())
          .onError((error, stackTrace) => onError(error.toString()));
    }
  }

  static bool checkUserIsSignIn() {
    return _firebaseAuth.currentUser == null ||
            prefs.getString(Strings.idUser) == null
        ? false
        : true;
  }

  static Future<void> signUpFirebaseWithEmail(String email, String password,
      Function(String) onComplete, Function(String) onError) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        if (userCredential.user != null) {
          onComplete(userCredential.user!.uid);
        }
      });
    } on FirebaseAuthException catch (error) {
      log('Code: ${error.code} - Message: ${error.message}');
      String errStr = Strings.errorStr;
      switch (error.code) {
        case 'email-already-in-use':
          errStr = Strings.emailAlreadyUse;
          break;
        case 'weak-password':
          errStr = Strings.notStrongPassword;
          break;
        case 'invalid-email':
          errStr = Strings.emailInvalid;
          break;
        default:
          errStr = '${Strings.unknown} - ${error.code}';
          break;
      }
      onError(errStr);
    }
  }

  static Future<void> signInFirebaseWithEmail(String email, String password,
      Function(String) onComplete, Function(String?) onError) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((credential) {
        if (credential.user != null) {
          onComplete(credential.user!.uid);
        }
      });
    } on FirebaseAuthException catch (error) {
      log('Code: ${error.code} - Message: ${error.message}');
      String errStr = Strings.errorStr;
      switch (error.code) {
        case 'network-request-failed':
          errStr = Strings.notInternetConnect;
          break;
        case 'wrong-password':
          errStr = Strings.wrongPassword;
          break;
        case 'user-not-found':
          errStr = Strings.userNotFoundErrorText;
          break;
        case 'invalid-email':
          errStr = Strings.emailInvalid;
          break;
        default:
          errStr = '${Strings.unknown} - ${error.code}';
          break;
      }
      onError(errStr);
    }
  }

  static void insertAccountInfoToDb(
    Credential credential,
    Function() onComplete,
    Function(String) onError,
  ) {
    _dbRef
        .child('credentials')
        .child(credential.idUser)
        .set(credential.toJson())
        .then((value) => onComplete())
        .onError((error, stackTrace) => onError(error.toString()));
  }

  static void insertUserInfoToDb(
    user.UserInfo userInfo,
    Function() onComplete,
    Function(String) onError,
  ) {
    _dbRef
        .child('userInfos')
        .child(userInfo.idAccount)
        .set(userInfo.toJson())
        .then((value) => onComplete())
        .onError((error, stackTrace) => onError(error.toString()));
  }

  static Future<void> forgotPasswordAccount(
    String email,
    Function() onComplete,
    Function(String) onError,
  ) async {
    try {
      await _firebaseAuth
          .sendPasswordResetEmail(email: email)
          .then((value) => onComplete());
    } on FirebaseAuthException catch (error) {
      log('Code: ${error.code} - Message: ${error.message}');
      String errStr = Strings.errorStr;
      switch (error.code) {
        case 'invalid-email':
          errStr = Strings.emailInvalid;
          break;
        case 'user-not-found':
          errStr = Strings.userNotFound;
          break;
        default:
          errStr = '${Strings.unknown} - ${error.code}';
          break;
      }
      onError(errStr);
    }
  }

  static Future<void> signUpFirebaseWithPhone(
    String phone,
    Function() onComplete,
    Function(String) onError,
  ) async {
    try {
      await _firebaseAuth
          .signInWithPhoneNumber(phone)
          .then((value) => onComplete());
    } on FirebaseAuthException catch (error) {
      log('Code: ${error.code} - Message: ${error.message}');
      String errStr = Strings.errorStr;
      switch (error.code) {
        case 'email-already-in-use':
          errStr = Strings.emailAlreadyUse;
          break;
        case 'weak-password':
          errStr = Strings.notStrongPassword;
          break;
        case 'invalid-email':
          errStr = Strings.emailInvalid;
          break;
        default:
          errStr = '${Strings.unknown} - ${error.code}';
          break;
      }
      onError(errStr);
    }
  }

  static Future<void> getUserInfo(
      Function(user.UserInfo?) onComplete, Function(String) onError) async {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('userInfos').child(idUser).get().then((snapshot) {
        final dataSnapshot =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        user.UserInfo userInfo = user.UserInfo.fromJson(dataSnapshot);
        onComplete(userInfo);
      }).onError((error, stackTrace) => onError(error.toString()));
    } else {
      onComplete(null);
    }
  }

  static Future<void> signOutAccount(
      Function() onComplete, Function(String) onError) async {
    _firebaseAuth
        .signOut()
        .then((value) => onComplete())
        .onError((error, stackTrace) => onError(error.toString()));
  }

  static Future<void> updateUserInfo(
      String name, String address, DateTime dateTime) async {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('userInfos').child(idUser).update({
        "fullName": name,
        "address": address,
        "birthDay": dateTime.toString(),
      });
    }
  }

  static void fetchDetailBrand(
      String id, Function(DetailBrand) onComplete, Function(String) onError) {
    _dbRef.child('detailBrands').child(id).get().then((snapshot) {
      if (snapshot.exists) {
        final dataValue =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        DetailBrand detailBrand = DetailBrand.fromJson(dataValue);
        onComplete(detailBrand);
      }
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static void deleteUserAccount(
    String password,
    Function() onComplete,
    Function(String) onError,
  ) {
    final email = prefs.getString(Strings.email);
    if (email != null) {
      _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          value.user!
              .delete()
              .then((value) => onComplete())
              .onError((error, stackTrace) => onError(error.toString()));
        }
      }).onError((error, stackTrace) => onError(error.toString()));
    }
  }

  static void requestOrder(
    RequestOrder requestOrder,
    Function() onComplete,
    Function(String) onError,
  ) {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef
          .child('requestOrders')
          .child(idUser)
          .child(requestOrder.idOrder)
          .set(requestOrder.toJson())
          .then((value) => onComplete())
          .onError((error, stackTrace) => onError(error.toString()));
    }
  }

  static void removeCartList() {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('carts').child(idUser).remove();
    }
  }

  static void getOrderList(
    Function(List<RequestOrder>) onComplete,
    Function(String) onError,
  ) {
    List<RequestOrder> orderList = [];
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('requestOrders').child(idUser).get().then((snapshot) {
        if (snapshot.exists) {
          for (DataSnapshot dataSnapshot in snapshot.children) {
            final dataValue = jsonDecode(jsonEncode(dataSnapshot.value))
                as Map<String, dynamic>;
            final requestOrder = RequestOrder.fromJson(dataValue);
            orderList.add(requestOrder);
          }
          onComplete(orderList);
        } else {
          onComplete(orderList);
        }
      }).onError((error, stackTrace) => onError(error.toString()));
    }
  }

  static void addOrderToBrand(String id, RequestOrder order) {
    _dbRef.child('brandHaveOrders').child(id).child(order.idOrder).set(order);
  }

  static void updateQuantityForCart(String idCart, int value) {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('carts').child(idUser).child(idCart).update({
        'orderQuantity': value,
      });
    }
  }

  static void updateReasonForCancelOrder(
    String idOrder,
    String reason,
    Function() onComplete,
    Function(String) onError,
  ) {
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      _dbRef.child('requestOrders').child(idUser).child(idOrder).update({
        'status': 3,
        'reasonCancelOrder': reason,
      }).then((value) {
        onComplete();
      }).onError((error, stackTrace) => onError(error.toString()));
    }
  }
}
