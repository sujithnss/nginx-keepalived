echo "Installing Wget"
sudo yum install -y wget

echo "Installing epel-release"
sudo yum install -y epel-release

echo "Installing node"
sudo yum install -y nodejs

echo "Installing npm"
sudo yum install -y npm


echo "start node service"
cd NodeJS-API
node server.js
