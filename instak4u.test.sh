#!/bin/bash
flutter test -r expanded
cd presenter
flutter test -r expanded
cd ..
cd domain
flutter test -r expanded
cd ..
