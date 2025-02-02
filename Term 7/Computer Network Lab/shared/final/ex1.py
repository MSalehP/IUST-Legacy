#!/usr/bin/python

"""
This script creates the network environment for Lab5:
- Starts all routers, switches, and hosts
- Configures IP addresses for the network
- XTerm window launched for all devices.
"""

# Required imports
import os
import sys
from mininet.net import Mininet
from mininet.node import Controller
from mininet.log import setLogLevel, info
from mininet.cli import CLI
from mininet.term import cleanUpScreens, makeTerms
from mininet.link import TCIntf, TCLink

# Initialize global variables
net = None


def run():
    "Creates the virtual environment, starts the network, and configures devices"
    info("** Creating an instance of the network topology\n")
    global net
    net = Mininet(intf=TCIntf)

    # Adding Controller
    info("\n** Adding Controller\n")
    net.addController("c0")

    # Adding Hosts
    info("\n** Adding Hosts\n")
    h1 = net.addHost("h1", ip="10.10.1.1/24")
    h2 = net.addHost("h2", ip="10.10.1.2/24")
    h3 = net.addHost("h3", ip="10.10.2.1/24")
    r1 = net.addHost("r1", ip="10.10.1.254/24")  # Router 1
    r2 = net.addHost("r2", ip="10.10.2.254/24")  # Router 2

    # Adding Switches
    info("\n** Adding Switches\n")
    sw1 = net.addSwitch("sw1")
    sw2 = net.addSwitch("sw2")

    # Creating Links
    info("\n** Creating Links \n")
    net.addLink(h1, r1, intfName2="r1-eth1")
    net.addLink(r1, sw1, intfName1="r1-eth2")
    net.addLink(h2, sw1)
    net.addLink(h2, sw2)
    net.addLink(sw2, r2, intfName2="r2-eth1")
    net.addLink(r2, h3, intfName2="r2-eth2")

    # Starting Network
    net.start()

    # Configuring IP Addresses
    info("\n** Configuring IP Addresses\n")
    r1.cmd("ifconfig r1-eth1 10.10.1.254/24")
    r1.cmd("ifconfig r1-eth2 10.10.1.253/24")
    r2.cmd("ifconfig r2-eth1 10.10.2.253/24")
    r2.cmd("ifconfig r2-eth2 10.10.2.254/24")

    # Configuring Default Gateways
    info("\n** Configuring Default Gateways\n")
    h1.cmd("route add default gw 10.10.1.254")
    h2.cmd("route add default gw 10.10.1.254")
    h3.cmd("route add default gw 10.10.2.254")

    # Enabling IP Forwarding on Routers
    info("\n** Enabling IP Forwarding on Routers\n")
    r1.cmd("sysctl -w net.ipv4.ip_forward=1")
    r2.cmd("sysctl -w net.ipv4.ip_forward=1")

    # Opening XTerm Windows
    info("\n** Opening XTerm Windows for Hosts and Routers\n")
    hosts = [h1, h2, h3, r1, r2]
    if "DISPLAY" not in os.environ:
        error("Error starting terms: Cannot connect to display\n")
        return
    cleanUpScreens()
    makeTerms(hosts, "host")

    # Start Mininet CLI
    info("** Running CLI\n")
    CLI(net)

    # Clean Up
    info("** Stopping Network\n")
    net.stop()
    cleanUpScreens()


if __name__ == "__main__":
    setLogLevel("info")
    run()
