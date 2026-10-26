import 'package:flutter/material.dart';

IconData muttaIcon(String name) {
  return switch (name) {
    'graphic_eq' => Icons.graphic_eq,
    'confirmation_number' => Icons.confirmation_number,
    'expand_more' => Icons.expand_more,
    'pin_drop' => Icons.pin_drop,
    'check_circle' => Icons.check_circle,
    'stars' => Icons.stars,
    'schedule' => Icons.schedule,
    'play_arrow' => Icons.play_arrow,
    'pause' => Icons.pause,
    'water_drop' => Icons.water_drop,
    'local_bar' => Icons.local_bar,
    'surround_sound' => Icons.surround_sound,
    'verified' => Icons.verified,
    'palette' => Icons.palette,
    'directions_bus' => Icons.directions_bus,
    'local_parking' => Icons.local_parking,
    'checkroom' => Icons.checkroom,
    'photo_camera' => Icons.photo_camera,
    'speaker' => Icons.speaker,
    'menu' => Icons.menu,
    'close' => Icons.close,
    'add' => Icons.add,
    'remove' => Icons.remove,
    _ => Icons.circle,
  };
}
