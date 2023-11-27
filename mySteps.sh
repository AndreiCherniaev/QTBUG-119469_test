# host: Ubuntu 23.10
# sudo apt-get build-dep qtbase5-dev cmake ninja-build

# git clone https://github.com/AndreiCherniaev/QTBUG-119469_test.git
# cd "QTBUG-119469_test"
export MyQtBaseDir=$PWD
cd ${MyQtBaseDir}

# Qt's folders must be clear: remove and create its again
rm -Rf ${MyQtBaseDir}/build_host/ ${MyQtBaseDir}/build_artifacts_host/ && mkdir ${MyQtBaseDir}/build_host ${MyQtBaseDir}/build_artifacts_host

# If you want test another Qt version do: 
# rm -Rf ${MyQtBaseDir}/qt5/
git clone https://github.com/qt/qt5 qt5
cd qt5
# git switch 6.6.0
perl init-repository --module-subset=qtbase,qtserialport
cd ${MyQtBaseDir}/build_host

../qt5/configure -release -static -opensource -nomake examples -nomake tests -confirm-license -no-pch -no-xcb -no-xcb-xlib -no-gtk -skip webengine -skip qtwayland -skip qtdoc -skip qtgraphicaleffects -skip qtqa -skip qttranslations -skip qtvirtualkeyboard -skip qtquicktimeline -skip qtquick3d -skip qt3d -skip qtrepotools -skip qttools -skip qtimageformats -skip qtnetworkauth -skip qtwebsockets -skip qtactiveqt -skip qtmacextras -skip winextras -skip qtmultimedia -skip qtgamepad -skip qtserialbus -skip qtspeech -skip qtsensors -skip qtcharts -skip qtlocation -no-ssl -prefix ../build_artifacts_host -- -GNinja -DCMAKE_TOOLCHAIN_FILE=../toolchain_host.cmake -- --trace-expand --trace-redirect="cmake_trace_QTBUG-119469.txt" --log-level=STATUS
cmake --build . --parallel && cmake --install .
