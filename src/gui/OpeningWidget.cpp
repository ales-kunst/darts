#include "OpeningWidget.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QPushButton>
#include <QEvent>
#include <QmouseEvent>
#include <iostream>

namespace ui_controls {

   QPushButton * createPlayDartsButton(QWidget* parent) {
      QPushButton* darts_button = new QPushButton(parent);
      darts_button->setMinimumSize(QSize(300, 200));
      darts_button->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
      QPixmap pixmap(":/resources/images/48_grey/Comics-Vision-icon.png");
      QIcon   button_icon(pixmap);
      darts_button->setIcon(button_icon);
      darts_button->setIconSize(pixmap.rect().size());
      darts_button->installEventFilter(parent);
      return darts_button;
   }

   QHBoxLayout * createPlayerAndStatButtons(QWidget* parent) {
      QHBoxLayout* buttons_layout = new QHBoxLayout();
      QPushButton* stat_button    = new QPushButton(parent);

      QPixmap pixmap(":/resources/images/48/Comics-Vision-icon.png");
      QIcon   button_icon(pixmap);
      stat_button->setIcon(button_icon);
      stat_button->setIconSize(pixmap.rect().size());
      stat_button->setStyleSheet(QString::fromUtf8(
                                    "QPushButton{background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,"
                                    "stop: 0 white, stop: 1 grey);"
                                    "border-style: solid;"
                                    "border-width: 1px;"
                                    "border-color: black;"
                                    "border-radius: 15px;}"));

      stat_button->setMinimumSize(QSize(147, 150));
      stat_button->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
      QPushButton* player_button = new QPushButton(parent);
      player_button->setMinimumSize(QSize(147, 150));
      player_button->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

      buttons_layout->setSpacing(6);
      buttons_layout->setSizeConstraint(QLayout::SetMinimumSize);
      buttons_layout->addWidget(player_button);
      buttons_layout->addWidget(stat_button);

      return buttons_layout;
   }

}

OpeningWidget::OpeningWidget(QWidget *parent) : QWidget(parent) {
   using ui_controls::createPlayDartsButton;
   using ui_controls::createPlayerAndStatButtons;
   mMainLayout = new QVBoxLayout();
   mMainLayout->addWidget(createPlayDartsButton(this));
   mMainLayout->addLayout(createPlayerAndStatButtons(this));
   // mMainLayout->addItem(new QSpacerItem(3, 10, QSizePolicy::Fixed, QSizePolicy::Expanding));
   mMainLayout->setSizeConstraint(QLayout::SetMinimumSize);
   mMainLayout->setContentsMargins(QMargins(3, 3, 3, 3));
   setLayout(mMainLayout);
}

bool OpeningWidget::eventFilter(QObject *watched, QEvent *event) {

   QPushButton *button      = qobject_cast<QPushButton *>(watched);
   QMouseEvent *mouse_event = static_cast<QMouseEvent *>(event);

   if ((button != nullptr) && (mouse_event != nullptr) && (mouse_event->button() != Qt::NoButton)) {
      std::cout << "Yuhuhu, bruhuhu [" << mouse_event->x() << ", " << mouse_event->y() << "] = " << event->type() 
                << std::endl;
   }

   if (!button) {
      return false;
   }

   if (event->type() == QEvent::Enter) {
      // The push button is hovered by mouse
      QPixmap pixmap(":/resources/images/48/Comics-Vision-icon.png");
      QIcon   button_icon(pixmap);
      button->setIcon(button_icon);
      button->setIconSize(pixmap.rect().size());
      return true;
   }

   if (event->type() == QEvent::Leave) {
      // The push button is not hovered by mouse
      QPixmap pixmap(":/resources/images/48_grey/Comics-Vision-icon.png");
      QIcon   button_icon(pixmap);
      button->setIcon(button_icon);
      button->setIconSize(pixmap.rect().size());
      return true;
   }

   return false;
}