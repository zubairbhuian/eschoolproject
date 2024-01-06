import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalClient {


  /// Set in local storage with expiry time
  ///
  ///
  /// @param key
  /// @param value
  /// @param ttl
  setLocalStorageWithExpiry(key, value, ttl) async {
    //based on https://www.sohamkamani.com/blog/javascript-localstorage-with-ttl-expiry/
    // print('Value: $value');
    DateTime now = DateTime.now();

    // print(now.microsecond + ttl);
    // `item` is an object which contains the original value
    // as well as the time when it's supposed to expire
    var item = {
      'value': jsonEncode(value),
      'expiry': now.millisecond + ttl,
    };

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String items = jsonEncode(item);
    preferences.setString(key, items);
  }

  /// Get from local storage checking expiry time
  ///
  ///
  /// @param key
  /// @returns {null|*}
  getLocalStorageWithExpiry(key) async {
    //based on https://www.sohamkamani.com/blog/javascript-localstorage-with-ttl-expiry/
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.remove(key);
    var itemStr = preferences.getString(key);

    // if the item doesn't exist, return null
    if (itemStr == null) {
      return null;
    }
    var item = jsonDecode(itemStr);
    DateTime now = DateTime.now();

    // print(item['expiry']);

    // compare the expiry time of the item with the current time
    if (now.millisecond > item['expiry']) {
      // If the item is expired, delete the item from storage
      // and return null
      preferences.remove(key);
      return null;
    }

    return item['value'];
  }


}
