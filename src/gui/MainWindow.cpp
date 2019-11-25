#include <iostream>
#include "MainWindow.h"
#include <QVBoxLayout>
#include <QStackedWidget>
#include <QLabel>
#include "OpeningWidget.h"
#include "HeaderLabel.h"

namespace ui_controls {
   
   QStackedWidget* createStackedWidget(QWidget *parent) {
      QStackedWidget* stacked_widget = new QStackedWidget(parent);
      stacked_widget->setMinimumWidth(300);
      stacked_widget->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
      stacked_widget->setLineWidth(3);
      stacked_widget->setFrameStyle(QFrame::Box);
      return stacked_widget;
   }

   QHBoxLayout* createHeaderRibbon(QWidget* parent) {
      QHBoxLayout* ribbon_layout = new QHBoxLayout();
      HeaderLabel* header_label = new HeaderLabel(parent);
      header_label->setText("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"10\" bgcolor=\"#254061\"><tr><td><h1><font color=\"#FFFFFF\">Some Text!!!!</font></h1></td></tr></table>");
      header_label->setObjectName("headerLabel");
      // header_label->setProperty("kuj_nekaj", QVariant());
      // header_label->setStyleSheet("QLabel#headerLabel { background-color : red; color : blue; }");
      header_label->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Minimum);
      ribbon_layout->addWidget(header_label);
      ribbon_layout->setContentsMargins(QMargins(0, 0, 0, 0));
      // std::cout << "We created Label!!!!" << std::endl;
      return ribbon_layout;
   }

   OpeningWidget* createOpeningWidget(QWidget* parent) {
      OpeningWidget* opening_widget = new OpeningWidget(parent);
      return opening_widget;
   }

   QSpacerItem* createVerticalSpacer() {
      return new QSpacerItem(5, 600, QSizePolicy::Minimum, QSizePolicy::Expanding);
   }

}

MainWindow::MainWindow(QWidget *parent) : QWidget(parent) {
   using ui_controls::createStackedWidget;
   using ui_controls::createOpeningWidget;
   // using ui_controls::createVerticalSpacer;
   using ui_controls::createHeaderRibbon;

   mMainLayout    = new QVBoxLayout();
   QStackedWidget* stacked_widget = createStackedWidget(this);
   stacked_widget->addWidget(createOpeningWidget(stacked_widget));

   mMainLayout->addLayout(createHeaderRibbon(this));
   mMainLayout->addWidget(stacked_widget);
   mMainLayout->setContentsMargins(QMargins(0, 0, 0, 0));
   mMainLayout->setSizeConstraint(QLayout::SetMinimumSize);
   // setWindowFlags(Qt::Widget | Qt::MSWindowsFixedSizeDialogHint);
   setContentsMargins(QMargins(0, 0, 0, 0));
   setLayout(mMainLayout);
}