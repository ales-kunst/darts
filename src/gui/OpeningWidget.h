#pragma once

#include <QWidget>

class QVBoxLayout;
class QEvent;

class OpeningWidget : public QWidget {

   Q_OBJECT

public:

   OpeningWidget(QWidget *parent = nullptr);

   bool eventFilter(QObject *watched, QEvent *event) Q_DECL_OVERRIDE;

private:
   QVBoxLayout *mMainLayout;
};