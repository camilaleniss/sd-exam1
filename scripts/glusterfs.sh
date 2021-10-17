# The Gluster configuration is here to be reused in db, web1 and web2 
# This is necessary to have Glusterfs installed and allows us to 
# access to a shared folder.

#Install the Centos current version for gluster dependencies
yum install -y centos-release-gluster
#Install the glusterfs-server in the centos machine
yum install -y glusterfs-server
#Install the default file system 
yum install -y xfsprogs


service glusterd start
echo +++++++++++++++++ **Script install glusterfs finished** ++++++++++++++++
sfdisk /dev/sdb <<EOF
;
EOF

mkfs.xfs /dev/sdb1

mkdir -p /gluster/data

mount /dev/sdb1 /gluster/data