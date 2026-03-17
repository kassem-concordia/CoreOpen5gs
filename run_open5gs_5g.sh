#!/usr/bin/env bash
 
BASE_DIR="/home/vagrant/open5gs"
BIN_DIR="$BASE_DIR/install/bin"
CFG_DIR="$BASE_DIR/install/etc/open5gs"
LOG_DIR="$BASE_DIR/nfs-logs"
PID_FILE="$LOG_DIR/pids.txt"
 
mkdir -p "$LOG_DIR"
: > "$PID_FILE"
 
echo "Starting Open5GS 5G daemons..."
echo "Logs will be stored in: $LOG_DIR"
echo
 
start_nf() {
    local name="$1"
    local cmd="$2"
    local log_file="$LOG_DIR/${name}.log"
 
    echo "Starting $name ..."
    nohup bash -c "$cmd" > "$log_file" 2>&1 &
    echo "$name $!" >> "$PID_FILE"
    sleep 1
}
 
start_nf "nrfd"   "$BIN_DIR/open5gs-nrfd"
start_nf "scpd"   "$BIN_DIR/open5gs-scpd"
start_nf "seppd"  "$BIN_DIR/open5gs-seppd -c $CFG_DIR/sepp1.yaml"
start_nf "amfd"   "$BIN_DIR/open5gs-amfd"
start_nf "smfd"   "$BIN_DIR/open5gs-smfd"
start_nf "upfd"   "$BIN_DIR/open5gs-upfd"
start_nf "ausfd"  "$BIN_DIR/open5gs-ausfd"
start_nf "udmd"   "$BIN_DIR/open5gs-udmd"
start_nf "pcfd"   "$BIN_DIR/open5gs-pcfd"
start_nf "nssfd"  "$BIN_DIR/open5gs-nssfd"
start_nf "bsfd"   "$BIN_DIR/open5gs-bsfd"
start_nf "udrd"   "$BIN_DIR/open5gs-udrd"
 
echo
echo "All 5G daemons started."
echo "PID list saved in: $PID_FILE"