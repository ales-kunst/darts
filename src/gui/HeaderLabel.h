#pragma once

#include <QLabel>

class HeaderLabel : public QLabel {

   Q_OBJECT

public:
   explicit HeaderLabel(QWidget* parent = nullptr, Qt::WindowFlags windowFlags = Qt::WindowFlags());
   ~HeaderLabel();

protected:
   void mousePressEvent(QMouseEvent* event) override;
};