#/bin/bash
sudo apt-get update -y
sudo apt-get install nfs-common zip -y
sudo mkdir -p /data
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 10.0.1.254:/ /data
sudo chmod 777 /data
sudo wget https://codeload.github.com/creativetimofficial/now-ui-dashboard/zip/refs/heads/master -O /data/now-ui-dashboard-master.zip
sudo unzip /data/now-ui-dashboard-master.zip -d /data/
sudo mv /data/now-ui-dashboard-master/* /data/
sudo cat > /data/index.htm <<EOF
<meta http-equiv="refresh" content="0; url=examples/dashboard.html" />
EOF
sudo curl -sSL https://get.docker.com/ | sh
sudo docker run -d --name nginx -v /data:/usr/share/nginx/html -p 80:80 nginx
