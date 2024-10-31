install:
	curl -o- -k https://raw.githubusercontent.com/itzngga/Android-Mining/main/install.sh | bash

start:
	sh ccminer/start.sh

stop:
	screen -X -S CCminer quit

view:
	screen -x CCminer

monitoring:
