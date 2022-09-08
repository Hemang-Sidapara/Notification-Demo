// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Appcolors {

  var successMessage = GetStorage().read("IS_DARK_MODE") ? const Color(0xF707F548) : const Color(0x892387EF);
  var warningMessage = GetStorage().read("IS_DARK_MODE") ? const Color(0xF7FFAD33) : const Color(0xFF000000);
  var errorMessage = GetStorage().read("IS_DARK_MODE") ? const Color(0xF7FA1A1A) : const Color(0xFF000000);
  var kPrimaryTextColor = GetStorage().read("IS_DARK_MODE") ? const Color(0xDDFFFFFF) : const Color(0xDD000000);

  static var splash_blue = const Color(0x505B9EC6);
  static var scroll_blue = const Color(0x005B9EC6);
  static var icon_white = const Color(0x70FFFFFF);

  static var primary_white = const Color(0xFFFFFFFF);
  static var primary_grey = const Color(0xFFF0F3FB);
  static var primary_blue = const Color(0xFF2C7094);
  static var secondary_blue = const Color(0xFF5B9EC6);
  static var selected_blue = const Color(0x305B9EC6);
  static var light_blue = const Color(0xFFE8F7FF);
  static var alert_header_blue = const Color(0xFFDFF4FF);


  static var background_quiz_color = const Color(0xFFF3FBFF);
  static var radiobtn_quiz_color = const Color(0xFFCAE0EC);

  static var text_color = const Color(0xFF717171);
  static var chips_grey = const Color(0xFFF1F1F1);
  static var text_color2 = const Color(0xFFA6A6A6);
  static var bold_text_color = const Color(0xFF262626);

  static var badge_green = const Color(0xFF5BAF4D);
  static var badge_red = const Color(0xFFE66E54);
  static var border_red = const Color(0xFFDE4A39);

  static var indicator_yellow = const Color(0xFFFFA800);
  static var indicator_green = const Color(0xFF41C33E);
  static var pending_yellow = const Color(0xFFFFB800);
  static var pending_light_yellow = const Color(0xFFFFF5DD);
  static var dark_yellow = const Color(0xFFF8AF41);
  static var splash_yellow = const Color(0x30F8AF41);
  static var btn_red = const Color(0xFFE94C4C);
  static var red = const Color(0xFFFF0000);
  static var blue_tick_color = const Color(0xFF00C2FF);


  static var black = const Color(0xFF1C1C1D);
  static var dark_black = const Color(0xFF070707);

  static var image_border = const Color(0xFFCCD4F4);


  static var grey = const Color(0xFFF2F2F2);
  static var progress_grey = const Color(0xFFE3E3E3);
  static var text_grey = const Color(0xFFA6A6A6);
  static var text_home_grey = const Color(0xFF5B5B5B);
  static var home_light_grey = const Color(0xFFECECEC);
  static var home_background = const Color(0xFFF1F5F8);
  static var home_background_white = const Color(0xFFEEEEEE);







}
