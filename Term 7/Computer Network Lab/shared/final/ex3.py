#!/usr/bin/python

"""
This example shows how to create a Mininet object and add nodes to it manually.
"""
"Importing Libraries"
from mininet.net import Mininet
from mininet.node import Controller
from mininet.cli import CLI
from mininet.log import setLogLevel, info

"Function definition: This is called from the main function"


def firstNetwork():

    "Create an empty network and add nodes to it."
    net = Mininet()
    info("*** Adding controller\n")
    net.addController("c0")

    info("*** Adding hosts\n")
    h1 = net.addHost("h1", ip="10.10.14.1/24")
    h2 = net.addHost("h2", ip="10.10.24.2/24")
    h3 = net.addHost("h3", ip="10.10.34.3/24")
    h4 = net.addHost("h4", ip="10.10.14.4/24")

    info("*** Adding switch\n")
    s14 = net.addSwitch("s14")
    s24 = net.addSwitch("s24")
    s34 = net.addSwitch("s34")

    info("*** Creating links\n")
    net.addLink(h1, s14)
    net.addLink(h4, s14)

    net.addLink(h2, s24)
    net.addLink(h4, s24)

    net.addLink(h3, s34)
    net.addLink(h4, s34)

    h4.cmd("ip addr add 10.10.24.4/24 dev h4-eth1")
    h4.cmd("ip addr add 10.10.34.4/24 dev h4-eth2")

    h4.cmd("sysctl -w net.ipv4.ip_forward=1")

    info("*** Starting network\n")
    net.start()
    h1.cmd("ip route add default via 10.10.14.4")
    h2.cmd("ip route add default via 10.10.24.4")
    h3.cmd("ip route add default via 10.10.34.4")

    info("*** Configuring iptables for DNAT\n")
    h4.cmd(
        "iptables -t nat -A PREROUTING -s 10.10.34.3 -d 10.10.24.2 -p icmp -j DNAT --to-destination 10.10.14.1"
    )
    h4.cmd("iptables -A FORWARD -p icmp -d 10.10.14.1 -j ACCEPT")

    info("*** Starting terminals on hosts\n")
    h1.cmd('xterm -xrm "XTerm.vt100.allowTitleOps: false" -T h1 &')
    h2.cmd('xterm -xrm "XTerm.vt100.allowTitleOps: false" -T h2 &')
    h3.cmd('xterm -xrm "XTerm.vt100.allowTitleOps: false" -T h3 &')
    h4.cmd('xterm -xrm "XTerm.vt100.allowTitleOps: false" -T h4 &')

    info("*** Running the command line interface\n")
    CLI(net)

    info("*** Closing the terminals on the hosts\n")
    h1.cmd("killall xterm")
    h2.cmd("killall xterm")
    h3.cmd("killall xterm")
    h4.cmd("killall xterm")

    info("*** Stopping network")
    net.stop()


"main Function: This is called when the Python file is run"
if __name__ == "__main__":
    setLogLevel("info")
    firstNetwork()
