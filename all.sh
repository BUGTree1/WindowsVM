#!/bin/bash

# This script starts the VM and the SPICE viewer, then cleans up when done.

VM_PID=0
VIEWER_PID=0
MONITOR_SOCKET="/tmp/qemu-monitor-$VM_PID" # We'll set this when VM starts

cleanup() {
    echo "Cleaning up processes..."
    local timeout=10 # Seconds to wait for graceful shutdown

    # 1. Try graceful shutdown via QEMU Monitor (if socket exists)
    if [ -S "$MONITOR_SOCKET" ]; then
        echo "Attempting graceful shutdown via QEMU monitor..."
        echo "system_powerdown" | socat - UNIX-CONNECT:"$MONITOR_SOCKET"
        # Wait for QEMU to exit gracefully
        for ((i=0; i<timeout; i++)); do
            if ! kill -0 $VM_PID 2>/dev/null; then
                echo "VM shut down gracefully."
                VM_PID=0
                break
            fi
            sleep 1
        done
    fi

    # 2. Force kill if still running after graceful attempt
    if [ $VM_PID -ne 0 ] && kill -0 $VM_PID 2>/dev/null; then
        echo "VM did not exit gracefully, forcing termination..."
        # Kill the entire process group
        kill -- -$(ps -o pgid= $VM_PID | grep -o '[0-9]*') 2>/dev/null
        sleep 2
        # Final force kill if still alive
        if kill -0 $VM_PID 2>/dev/null; then
            kill -9 $VM_PID 2>/dev/null
        fi
        VM_PID=0
    fi

    # 3. Kill the viewer
    if [ $VIEWER_PID -ne 0 ] && kill -0 $VIEWER_PID 2>/dev/null; then
        kill $VIEWER_PID 2>/dev/null
        wait $VIEWER_PID 2>/dev/null
    fi

    # 4. Clean up the monitor socket
    rm -f "$MONITOR_SOCKET" 2>/dev/null
    echo "Cleanup complete."
}

# Trap Ctrl+C (SIGINT), script exit (EXIT), and termination signal (SIGTERM)
trap cleanup INT TERM EXIT

echo "Starting the virtual machine..."
./start.sh &
VM_PID=$!
echo "VM process started with PID: $VM_PID"

echo "Starting virt-viewer..."
./view.sh &
VIEWER_PID=$!

echo "Viewer process started with PID: $VIEWER_PID"

wait $VIEWER_PID 2>/dev/null

echo "Virt-viewer window closed."
