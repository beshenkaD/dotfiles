#!/bin/sh

HWMON=$(ls /sys/class/drm/card0/device/hwmon/)

echo "* Setting pwm to auto..."
sudo sh -c "echo "2" > /sys/class/drm/card0/device/hwmon/${HWMON}/pwm1_enable"

echo "* Setting power cap to 120W..."
sudo sh -c "echo 120000000 > /sys/class/drm/card0/device/hwmon/${HWMON}/power1_cap"

sudo xterm -e "sh -c 'watch -n 0.5 cat /sys/kernel/debug/dri/0/amdgpu_pm_info'" &

kawpowminer -G -P stratum+tcp://RFopJWcfPejJrN9uXdvZHCaCXxr7yUTq1p.Beshenka@asia-rvn.2miners.com:6060
