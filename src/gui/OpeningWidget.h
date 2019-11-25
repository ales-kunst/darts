#pragma once

#include <QWidget>

class QVBoxLayout;

class OpeningWidget : public QWidget {

   Q_OBJECT

public:
   OpeningWidget(QWidget *parent = nullptr);

private:
   QVBoxLayout    *mMainLayout;
};