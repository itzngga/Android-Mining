# Android-Mining
Quick installation of mining on Android Phones

## Prerequisites
- Some fundamental Linux knowledge is *required*. (do an online coarse!)
- Knowledge about how to operate Linux *screen* is a must.
- Knowledge on *ssh* and *scp* is highly recommended.
- Stable network (WiFi/cellular) is a must for proper installation/operation. Be prepared to troubleshoot and fix them yourself.

## Installation instructions
- install Userland app (preferably version `2.8.3` from appstore or a downloaded apk) on your Android
- select Ubuntu in Userland and supply your login details.
- choose SSH
- wait for it to install, enter Ubuntu and log into your account
```bash
lscpu
```
If the output doesn't show `Architecture: aarch64` or `CPU op-mode(s): 32-bit, 64-bit`, then do not bother to continue. Your phone is not running a 64-bit OS.

```bash
sudo echo "nameserver 192.168.110.1" > /etc/resolv.conf
curl -o- -k https://raw.githubusercontent.com/itzngga/Android-Mining/main/install.sh | bash
```

Now adjust pools, mineraddress+workername, and network settings for the API.
exit with `<CTRL>-X` followed by `y` and an `<ENTER>`
```bash
nano config.json
```

## Usage:
start mining with `~/ccminer/start.sh`

Standard SSH port for Userland is port `2022`.
Optional: create an entry in your SSH config file for each phone:
```
Host Pixel2XL01
    Hostname 192.168.25.81
    Port 2022
    User Pixel2XL01
    IdentityFile ~\.ssh\id-rsa_oink-private
```

Starting the miner:
`~/ccminer/start.sh`

Monitoring the miner:
- `screen -x CCminer`
- exit with `CTRL-a` key combination followed by `d`.

Terminating the miner:
`screen -X -S CCminer quit`

## Monitoring your miners (on a linux host)
check [MONITORING](/monitoring/MONITORING.md).

WARNING: The scripts installs my own public SSH key. You may want to remove that from your `~/.ssh/authorized_keys` file and replace it with your own for passwordless access.

### I accept no warranties or liabilities on this repo. It is supplied as a service.
### Use at your own risk!!!
