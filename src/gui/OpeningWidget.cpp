#include "OpeningWidget.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QPushButton>

namespace ui_controls {

   QPushButton* createPlayDartsButton(QWidget* parent) {
      QPushButton* darts_button = new QPushButton(parent);
      darts_button->setMinimumSize(QSize(300, 200));
      darts_button->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
      return darts_button;
   }

   QHBoxLayout* createPlayerAndStatButtons(QWidget* parent) {
      QHBoxLayout* buttons_layout = new QHBoxLayout();
      QPushButton* stat_button = new QPushButton(parent);
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
   mMainLayout->setContentsMargins(QMargins(0, 0, 0, 0));
   setLayout(mMainLayout);
}