#!/bin/bash
if [ "$1" == "build" ]
then
  echo "Running \"flutter pub run build_runner build\" on flutter_permission_handling_ui"
  flutter pub run build_runner build --delete-conflicting-outputs
else
  echo "Running \"flutter pub run build_runner watch\" on flutter_permission_handling_ui"
  flutter pub run build_runner watch --delete-conflicting-outputs
fi