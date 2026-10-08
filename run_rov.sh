#!/bin/bash

set -e

echo "----------------------------------------"
echo "🔧 Building Stingray core packages for WELT..."
echo "----------------------------------------"

cd "$(dirname "$0")"
export STINGRAY_CONFIG_DIR="${STINGRAY_CONFIG_DIR:-$(pwd)/src/welt_config/control}"

colcon build \
    --base-paths src/stingray_core/src src/welt_bringup \
    --packages-select \
    dvl_msgs \
    dvl_a50 \
    stingray_interfaces \
    stingray_core_control \
    stingray_core_communication \
    lights_device \
    serial_driver \
    io_context \
    asio_cmake_module \
    vectornav_msgs \
    vectornav \
    stingray_interface_bridge \
    pressure_sensor \
    stingray_core_description \
    stingray_core_localization \
    welt_bringup

echo "----------------------------------------"
echo "🔄 Sourcing install/setup.bash ..."
echo "----------------------------------------"

source install/setup.bash

echo "----------------------------------------"
echo "🚀 Launching WELT ROV..."
echo "----------------------------------------"

ros2 launch welt_bringup run_rov.launch.py "$@"
