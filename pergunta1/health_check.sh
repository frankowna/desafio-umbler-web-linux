#!/bin/bash

echo "======================================="
echo " Linux Health Check"
echo "======================================="

echo
echo "Hostname:"
hostname

echo
echo "Uptime:"
uptime

echo
echo "Memory:"
free -h

echo
echo "Disk:"
df -h

echo
echo "Top CPU Processes:"
ps -eo pid,user,%cpu,%mem,cmd --sort=-%cpu | head

echo
echo "Listening Ports:"
ss -tulpn

echo
echo "Nginx Status:"
systemctl is-active nginx 2>/dev/null || echo "Nginx não instalado"

echo
echo "PHP-FPM Status:"
systemctl is-active php-fpm 2>/dev/null || systemctl is-active php8.2-fpm 2>/dev/null || echo "PHP-FPM não instalado"

echo
echo "Health Check finalizado."