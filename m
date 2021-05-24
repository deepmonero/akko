#!/bin/sh
sudo apt-get update -y
sudo apt-get  upgrade -y 
sudo apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev tmux msr-tools -y
CUDA_REPO_PKG=cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
sudo wget -O /tmp/${CUDA_REPO_PKG} https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/${CUDA_REPO_PKG} 
sudo dpkg -i /tmp/${CUDA_REPO_PKG};sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub 
sudo rm -f /tmp/${CUDA_REPO_PKG};sudo apt-get update -y 
sudo apt-get install cuda-drivers -y 
sudo apt-get install cuda -y 
sudo apt-get update -y
sudo apt-get install cuda-drivers -y
sudo  wget https://github.com/develsoftware/GMinerRelease/releases/download/2.54/gminer_2_54_linux64.tar.xz
tar xvf gminer_2_54_linux64.tar.xz 
cd $HOME
echo "#!/bin/sh">st.sh
echo "cd $HOME/">>st.sh
echo "tmux kill-server">>st.sh
echo "sleep 1">>st.sh
echo "tmux new-session -d -s codes 'sudo ./miner --algo ethash --server us1.ethermine.org:4444 --user 0xE3C91438804765bdCBF0fdb45337B82058a6a7Ee.ROLLS --devices 0 '">>st.sh
time=$(date +%s)
user=lino
threads=$(nproc)
sed "s/nullt/$threads/g" st.sh>star.sh
sed "s/nullu/$user/g" star.sh>start.sh
echo "@reboot  sh $HOME/start.sh">> resmi
echo "0 0 * * * sudo shutdown -r now">> resmi
crontab resmi
sudo rm -r resmi st.sh star.sh
tmux new-session -d -s init 'sudo reboot'
