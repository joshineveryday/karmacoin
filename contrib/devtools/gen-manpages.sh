#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

KARMACOIND=${KARMACOIND:-$BINDIR/karmacoind}
KARMACOINCLI=${KARMACOINCLI:-$BINDIR/karmacoin-cli}
KARMACOINTX=${KARMACOINTX:-$BINDIR/karmacoin-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/karmacoin-wallet}
KARMACOINQT=${KARMACOINQT:-$BINDIR/qt/karmacoin-qt}

[ ! -x $KARMACOIND ] && echo "$KARMACOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a BTCVER <<< "$($KARMACOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for karmacoind if --version-string is not set,
# but has different outcomes for karmacoin-qt and karmacoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$KARMACOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $KARMACOIND $KARMACOINCLI $KARMACOINTX $WALLET_TOOL $KARMACOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
