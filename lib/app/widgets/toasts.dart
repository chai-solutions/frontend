import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void infoToast({
  required BuildContext context,
  required String message,
  String? title,
  Duration? timeout,
  Alignment? alignment,
  Icon? icon,
}) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    title: title != null ? Text(title) : null,
    description: Text(message),
    alignment: alignment ?? Alignment.bottomLeft,
    autoCloseDuration: timeout ?? const Duration(seconds: 3),
    animationBuilder: (
      context,
      animation,
      alignment,
      child,
    ) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    showProgressBar: false,
    primaryColor: const Color(0xff32a0bc),
    backgroundColor: const Color(0xff3268bc),
    foregroundColor: const Color(0xffc9c1c9),
    icon: icon,
    showIcon: icon != null,
  );
}

void warningToast({
  required BuildContext context,
  required String message,
  String? title,
  Duration? timeout,
  Alignment? alignment,
  Icon? icon,
}) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    title: title != null ? Text(title) : null,
    description: Text(message),
    alignment: alignment ?? Alignment.bottomLeft,
    autoCloseDuration: timeout ?? const Duration(seconds: 3),
    animationBuilder: (
      context,
      animation,
      alignment,
      child,
    ) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    showProgressBar: false,
    primaryColor: const Color(0xffffd700),
    backgroundColor: const Color(0xffbc7c32),
    foregroundColor: const Color(0xffffffff),
    icon: icon,
    showIcon: icon != null,
  );
}

void errorToast({
  required BuildContext context,
  required String message,
  String? title,
  Duration? timeout,
  Alignment? alignment,
  Icon? icon,
}) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    title: title != null ? Text(title) : null,
    description: Text(message),
    alignment: alignment ?? Alignment.bottomLeft,
    autoCloseDuration: timeout ?? const Duration(seconds: 3),
    animationBuilder: (
      context,
      animation,
      alignment,
      child,
    ) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    showProgressBar: false,
    primaryColor: const Color(0xffffffff),
    backgroundColor: const Color(0Xffbc3547),
    foregroundColor: const Color(0xffffffff),
    icon: icon,
    showIcon: icon != null,
  );
}
