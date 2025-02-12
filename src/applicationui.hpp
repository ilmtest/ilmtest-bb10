#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include "DatabaseHelper.h"
#include "Game.h"
#include "InvokeHelper.h"
#include "LifelineManager.h"
#include "NetworkChannel.h"
#include "Offloader.h"
#include "Persistance.h"
#include "ShopManager.h"
#include "SoundManager.h"
#include "TextUtils.h"
#include "UserManager.h"

#include <bb/system/CardDoneMessage>

namespace ilmtest {

using namespace canadainc;

class ApplicationUI : public QObject
{
    Q_OBJECT

    DatabaseHelper m_sql;
    Persistance m_persistance;
    InvokeHelper m_invoke;
    Offloader m_offloader;
    SoundManager m_sound;
    Game m_game;
    UserManager m_user;
    ShopManager m_shop;
    LifelineManager m_life;
    NetworkChannel m_network;

    void init(QString const& qml);

signals:
    void childCardFinished(QString const& message, QString const& cookie);
    void initialize();
    void lazyInitComplete();

private slots:
    void childCardDone(bb::system::CardDoneMessage const& message=bb::system::CardDoneMessage());
    void invoked(bb::system::InvokeRequest const& request);
    void lazyInit();

public:
    ApplicationUI(bb::system::InvokeManager* im);
    virtual ~ApplicationUI() {}
};

}

#endif /* ApplicationUI_HPP_ */
