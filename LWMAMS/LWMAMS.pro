# ----------------------------------------------------
# This file is generated by the Qt Visual Studio Tools.
# ------------------------------------------------------

TEMPLATE = app
TARGET = LWMAMS
DESTDIR = ../Debug
QT += core network gui location qml quick webengine widgets testlib
CONFIG += debug qmltestcase
DEFINES += WIN64 QT_DLL QT_LOCATION_LIB QT_NETWORK_LIB QT_QML_LIB QT_QUICK_LIB QT_WIDGETS_LIB
#DEFINES += TEST INTENET_TEST
#DEFINES += TEST FILE_TEST
INCLUDEPATH += ./GeneratedFiles \
    . \
    ./GeneratedFiles/Debug
DEPENDPATH += .
MOC_DIR += ./GeneratedFiles/debug
OBJECTS_DIR += debug
UI_DIR += ./GeneratedFiles
RCC_DIR += ./GeneratedFiles
include(LWMAMS.pri)
win32:RC_FILE = LWMAMS.rc

HEADERS +=

SOURCES +=
