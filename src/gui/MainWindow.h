#pragma once

#include <QWidget>

class QVBoxLayout;

class MainWindow : public QWidget {

   Q_OBJECT

public:
   MainWindow(QWidget *parent = nullptr);
   

private:
   QVBoxLayout    *mMainLayout;
};