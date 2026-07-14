#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
    echo "Uso: $0 dominio.com"
    exit 1
fi

echo "========================================"
echo " Verificação de Deliverability"
echo " Domínio: $DOMAIN"
echo "========================================"

echo
echo "[MX]"
dig +short MX $DOMAIN

echo
echo "[SPF]"
dig +short TXT $DOMAIN | grep "v=spf1"

echo
echo "[DMARC]"
dig +short TXT _dmarc.$DOMAIN

echo
echo "[DKIM]"
echo "Informe o selector utilizado (default, mail, selector1...)"

read SELECTOR

dig +short TXT ${SELECTOR}._domainkey.$DOMAIN

echo
echo "[A]"
dig +short A $DOMAIN

IP=$(dig +short A $DOMAIN | head -1)

if [ ! -z "$IP" ]; then

    echo
    echo "[PTR]"
    dig +short -x $IP

fi

echo
echo "Verificação concluída."