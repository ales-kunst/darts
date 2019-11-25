TEMPLATE = app

QT += widgets

TARGET = gui

INCLUDEPATH += ../../src/gui

HEADERS += ../../src/gui/MainWindow.h \
           ../../src/gui/OpeningWidget.h \
           ../../src/gui/HeaderLabel.h \
           ../../src/gui/Console.h

SOURCES += ../../src/main.cpp \
           ../../src/gui/MainWindow.cpp \
           ../../src/gui/OpeningWidget.cpp \
           ../../src/gui/HeaderLabel.cpp

RESOURCES += darts_resources.qrc
