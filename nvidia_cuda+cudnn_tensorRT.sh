# it is for nvidia driver install!!
# cuda11.7
echo "It is a install help with cuda11.7 "
echo "PRESS [ENTER] TO CONTINUE INSTALL [CUDA]"
echo "IF YOU WANT CANCEL PRESS [CTRL] + [C]"
read

echo "[-------installing cuda---------]"
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
# 需替換成你要下載的版本
if [ ! -f cuda-repo-ubuntu2004-11-7-local_11.7.0-515.43.04-1_amd64.deb ] ; then
    wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2004-11-7-local_11.7.0-515.43.04-1_amd64.deb
fi
sudo dpkg -i cuda-repo-ubuntu2004-11-7-local_11.7.0-515.43.04-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2004-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda

# cudnn 8.6.0
echo "It is a install help with cudnn8.6.0"
echo "PRESS [ENTER] TO CONTINUE INSTALL [CUDNN]"
echo "IF YOU WANT CANCEL PRESS [CTRL] + [C]"
read

echo "[---------installin cudnn---------]"
# 解壓檔案，需替換成你下載的檔名
if find $(pwd) -name cudnn-linux-x86_64-8.6.0.163_cuda11-archive.tar.xz;
then
    printf "It is valid script "
else
    printf "Invalid file name "
    exit 1
fi

tar -xzvf cudnn-linux-x86_64-8.6.0.163_cuda11-archive.tar.xz
sudo cp cuda/include/cudnn*.h /usr/local/cuda/include 
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64 
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*

# # tensorRT
echo "It is a install help with tensorRT8.5.2"
echo "PRESS [ENTER] TO CONTINUE INSTALL [TENSORRT]"
echo "IF YOU WANT CANCEL PRESS [CTRL] + [C]"
read

echo "[---------installin tensorRT!---------]"
tar -xzvf TensorRT-8.5.2.2.Linux.x86_64-gnu.cuda-11.8.cudnn8.6.tar.gz
if find $(pwd) -name TensorRT-8.5.2.2.Linux.x86_64-gnu.cuda-11.8.cudnn8.6;
then
    printf "It is valid script "
else
    printf "Invalid file name "
    exit 1
fi
cd TensorRT-8.5.2.2.Linux.x86_64-gnu.cuda-11.8.cudnn8.6/TensorRT-8.5.2.2/python/
pip install tensorrt-8.5.2.2-cp38-none-linux_x86_64.whl
cd TensorRT-8.5.2.2.Linux.x86_64-gnu.cuda-11.8.cudnn8.6/TensorRT-8.5.2.2/uff/
pip install uff-0.6.9-py2.py3-none-any.whl 
cd TensorRT-8.5.2.2.Linux.x86_64-gnu.cuda-11.8.cudnn8.6/TensorRT-8.5.2.2/graphsurgeon/
pip install graphsurgeon-0.6.9-py2.py3-none-any.whl 
pip install pycuda

# run test code
echo "[---------test cudnn & cuda---------]"
cp -r /usr/src/cudnn_samples_v8/ $HOME
cd  $HOME/cudnn_samples_v8/mnistCUDNN
make clean && make && ./mnistCUDNN 

