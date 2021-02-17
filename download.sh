#!/bin/bash
wget -q -O vpnbox.zip https://github.com/kerberjg/vpnbox/archive/master.zip && unzip vpnbox.zip && rm vpnbox.zip
cd vpnbox && sh init.sh
