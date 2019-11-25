#include "HeaderLabel.h"
#include <iostream>


HeaderLabel::HeaderLabel(QWidget* parent, Qt::WindowFlags windowFlags) : QLabel(parent, windowFlags) {}

HeaderLabel::~HeaderLabel() {}

void HeaderLabel::mousePressEvent(QMouseEvent * event) {
   std::cout << "Mouse press event on Label!!!!" << std::endl;
}
