#!/bin/bash

# Define variables
ROUTER_IP="192.168.50.1"  # Your router's IP address
EXTERNAL_IP="8.8.8.8"     # Google's public DNS
DOMAIN="google.com"

# Color codes
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
NC="\033[0m" # No Color

# Function to print colored messages
print_result() {
    echo -e "$(date): $1"
}

# Function to show checking message
show_checking() {
    echo -n "Checking $1... "
    sleep 1  # Simulate delay
}

# Check if the router is reachable
show_checking "Router"
if ping -c 4 "$ROUTER_IP" > /dev/null; then
    print_result "${GREEN}Router is reachable.${NC}"
else
    print_result "${RED}Router is NOT reachable.${NC}"
fi

# Check if external IP is reachable
show_checking "External IP ($EXTERNAL_IP)"
if ping -c 4 "$EXTERNAL_IP" > /dev/null; then
    print_result "${GREEN}External IP is reachable.${NC}"
else
    print_result "${RED}External IP is NOT reachable.${NC}"
fi

# Check DNS resolution
show_checking "DNS resolution for $DOMAIN"
if nslookup "$DOMAIN" > /dev/null; then
    print_result "${GREEN}DNS resolution is working.${NC}"
else
    print_result "${RED}DNS resolution is NOT working.${NC}"
fi

# Perform traceroute
print_result "${YELLOW}Performing traceroute to $EXTERNAL_IP:${NC}"
traceroute "$EXTERNAL_IP"

