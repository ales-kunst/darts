#include <QApplication>
#include <QWidget>
#include "MainWindow.h"
#include "Console.h"

// maximum mumber of lines the output console should have
static const int16_t MAX_CONSOLE_LINES = 9000;

int main(int argc, char *argv[]) {

   Console console(MAX_CONSOLE_LINES);

   QApplication app(argc, argv);  

   MainWindow window;

   window.setWindowTitle("Darts");
   window.show();

   return app.exec();
}