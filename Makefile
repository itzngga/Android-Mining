start:
	sh ccminer/start.sh
	screen -x CCminer

install:
	curl -o- -k https://raw.githubusercontent.com/itzngga/Android-Mining/main/install.sh | bash

stop:
	screen -X -S CCminer quit

view:
	screen -x CCminer

config:
	sh ccminer/up-config.sh