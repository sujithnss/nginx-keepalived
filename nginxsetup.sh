#!/usr/bin/env bash

# BEGIN ########################################################################
echo -e "-- ---------- --\n"
echo -e "-- BEGIN ${HOSTNAME} --\n"
echo -e "-- ---------- --\n"

# VARIABLES ####################################################################
echo -e "-- Setting global variables\n"
SYSCTL_CONFIG=/etc/sysctl.conf

# BOX ##########################################################################

# HAPROXY ######################################################################


echo "Installing epel-release"
sudo yum install -y epel-release

echo "Installing supporting tools requirements on RHEL"
sudo yum install -y ruby ruby-devel gcc libxml2-devel

echo "Installing nginx"
sudo yum install -y nginx

sudo rm -rf /etc/nginx/nginx.conf

cd /vagrant/

sudo cp nginx/nginx.conf /etc/nginx

sudo systemctl enable nginx

sudo systemctl start nginx

# KEEPALIVED ###################################################################
echo -e "-- Installing Keepalived\n"
sudo yum install -y keepalived > /dev/null 2>&1

echo -e "-- Allowing HAProxy to bind to the virtual IP address\n"
grep -q "net.ipv4.ip_nonlocal_bind=1" "${SYSCTL_CONFIG}" || echo "net.ipv4.ip_nonlocal_bind=1" >> "${SYSCTL_CONFIG}"

echo -e "-- Enabling virtual IP binding\n"
sysctl -p

echo -e "-- Configuring Keepalived\n"
cat > /etc/keepalived/keepalived.conf <<EOF
vrrp_script chk_nginx {
    script "pidof nginx"
    interval 2
    weight 2
}
vrrp_instance VI_1 {
    interface enp0s8           # This may be eth0
    state MASTER
    virtual_router_id 51
    priority ${PRIORITY}
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.50.10
    }
    track_script {
        chk_nginx
    }
}
EOF

echo -e "-- Starting Keepalived\n"
sudo service keepalived start
sudo chkconfig keepalived on
# END ##########################################################################
echo -e "-- -------- --"
echo -e "-- END ${HOSTNAME} --"
echo -e "-- -------- --"
