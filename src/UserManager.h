#ifndef USERMANAGER_H_
#define USERMANAGER_H_

#include <QObject>

namespace canadainc {
    class DatabaseHelper;
    class Persistance;
}

namespace ilmtest {

using namespace canadainc;

struct UserProfile
{
    QString name;
    QString kunya;
    bool female;
    int points;

    UserProfile();
};

class UserManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name NOTIFY profileChanged)
    Q_PROPERTY(QString kunya READ kunya NOTIFY profileChanged)
    Q_PROPERTY(bool female READ female NOTIFY profileChanged)
    Q_PROPERTY(int points READ points WRITE setPoints NOTIFY pointsChanged)
    Q_PROPERTY(bool profileSet READ profileSet NOTIFY profileChanged)

    Persistance* m_persist;
    DatabaseHelper* m_db;
    UserProfile m_profile;

private slots:
    void onDataLoaded(QVariant id, QVariant data);
    void onSettingChanged(QVariant newValue, QVariant key);

signals:
    void profileChanged();
    void pointsChanged();

public:
    UserManager(Persistance* persist, DatabaseHelper* db);
    virtual ~UserManager();

    QString name() const;
    QString kunya() const;
    bool female() const;
    int points() const;
    bool profileSet() const;
    void setPoints(int points);

    void lazyInit();

    Q_INVOKABLE void saveProfile(QString const& name, QString const& kunya, bool female);
};

} /* namespace canadainc */

#endif /* UserManager_H_ */
