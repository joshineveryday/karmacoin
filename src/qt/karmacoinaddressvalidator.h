// Copyright (c) 2011-2014 The Karmacoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef KARMACOIN_QT_KARMACOINADDRESSVALIDATOR_H
#define KARMACOIN_QT_KARMACOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class KarmacoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit KarmacoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Karmacoin address widget validator, checks for a valid karmacoin address.
 */
class KarmacoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit KarmacoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // KARMACOIN_QT_KARMACOINADDRESSVALIDATOR_H
