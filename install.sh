#!/bin/sh
sudo echo "nameserver 1.1.1.1" >> /etc/resolv.conf
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install make libcurl4-openssl-dev libjansson-dev libomp-dev git screen nano jq wget
wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_arm64.deb
sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_arm64.deb
rm libssl1.1_1.1.0g-2ubuntu4_arm64.deb
if [ ! -d ~/.ssh ]
then
  mkdir ~/.ssh
  chmod 0700 ~/.ssh
  cat << EOF > ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/WM/PX9mEHYPDrN01Z5yLIOzOAhUKPt/kIaAgd8cg9PVC+8xMxfZQDiVr8jol489z1lEDQpHJhbRJu+z94fbDpuT97cZ3xQVN5uTewAfonotmlLus/r1DEXKe1PIBB1ByRtd5/L0F4ZZjvctV5fCM7dSxCFTgY2HKMPFyPT+1SGlDyaDkXHq/1rrPkHP+naLTsl808dIYFm/rE4/UoC1GcCRizGL+bzk6ru0lXEiV3x0fj6ziZeQZkYN2MMf2rHPr4m2V2V+VEpx7ngAqeB5UHaxjp0XIsNIaqqrX5Yi2qeJIH5Shm8wC57TMRKiggYna+4kIW3L44K6fNQIARcpBUakS5ty2Z6yPChts21NlsmmzilwxKIxhfk9Nph6r7oPYkpyxYQ+WrYrpGVQ/d2st4h+w9CKg75yMhkcOmasFtImtXe8Nna1zFuVtKZFx+B4dAinTpMypnwUTtf2HoLr/S5dvMQBirViDesMnvUSfZMzW7nDs1EVsUjM5OgiwZ65bQyoNYMw64Xa7Z3Xn2JxS6SBBxIq9axLFdiw6v2kBgs5vYLR8ygqO2Am+cUauVlC1hKBP/VAvlX/cKezb+IXmOFy1vBNkrs2xsPR79b2utnNVALplPi6MlGOD5QbAKjnUtV+Br1fP+amf63ZFGynTS1l3r/pjIfwnKzmMQhKydw== asucok@wengdev.com
EOF
  chmod 0600 ~/.ssh/authorized_keys
fi

if [ ! -d ~/ccminer ]
then
  mkdir ~/ccminer
fi

cd ~/ccminer

GITHUB_RELEASE_JSON=$(curl --silent "https://api.github.com/repos/Oink70/CCminer-ARM-optimized/releases?per_page=1" | jq -c '[.[] | del (.body)]')
GITHUB_DOWNLOAD_URL=$(echo $GITHUB_RELEASE_JSON | jq -r ".[0].assets[0].browser_download_url")
GITHUB_DOWNLOAD_NAME=$(echo $GITHUB_RELEASE_JSON | jq -r ".[0].assets[0].name")

echo "Downloading latest release: $GITHUB_DOWNLOAD_NAME"

wget ${GITHUB_DOWNLOAD_URL} -P ~/ccminer

if [ -f ~/ccminer/config.json ]
then
  rm ~/ccminer/config.json
  done
fi

wget https://raw.githubusercontent.com/itzngga/Android-Mining/main/config.json -P ~/ccminer

if [ -f ~/ccminer/ccminer ]
then
  mv ~/ccminer/ccminer ~/ccminer/ccminer_old
fi
mv ~/ccminer/${GITHUB_DOWNLOAD_NAME} ~/ccminer/ccminer
chmod +x ~/ccminer/ccminer

cat << EOF > ~/ccminer/start.sh
#!/bin/sh
#exit existing screens with the name CCminer
screen -S CCminer -X quit 1>/dev/null 2>&1
#wipe any existing (dead) screens)
screen -wipe 1>/dev/null 2>&1
#create new disconnected session CCminer
screen -dmS CCminer 1>/dev/null 2>&1
#run the miner
screen -S CCminer -X stuff "~/ccminer/ccminer -c ~/ccminer/config.json\n" 1>/dev/null 2>&1
printf '\nMining started.\n'
printf '===============\n'
printf '\nManual:\n'
printf 'start: ~/.ccminer/start.sh\n'
printf 'stop: screen -X -S CCminer quit\n'
printf '\nmonitor mining: screen -x CCminer\n'
printf "exit monitor: 'CTRL-a' followed by 'd'\n\n"
EOF
chmod +x start.sh

echo "setup nearly complete."
echo "Edit the config with \"nano ~/ccminer/config.json\""

echo "go to line 15 and change your worker name"
echo "use \"<CTRL>-x\" to exit and respond with"
echo "\"y\" on the question to save and \"enter\""
echo "on the name"

echo "start the miner with \"cd ~/ccminer; ./start.sh\"."
