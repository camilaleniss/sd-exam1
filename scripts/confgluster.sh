mkdir -p ~/.ssh
echo "Host *" > ~/.ssh/config
echo " StrictHostKeyChecking no" >> ~/.ssh/config

gluster peer probe master
gluster peer probe brick1

sleep 5
gluster volume create gv0 replica 3 db:/gluster/data/gv0 node-1:/gluster/data/gv0 node-2:/gluster/data/gv0
sleep 5
gluster volume start gv0
sleep 5


ssh -i private_key_db vagrant@192.168.33.100 'sudo mount.glusterfs localhost:/gv0 /mnt'
ssh -i private_key_web1 vagrant@192.168.33.11 'sudo mount.glusterfs localhost:/gv0 /mnt'
