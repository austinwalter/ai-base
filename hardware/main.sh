# https://github.com/evolvablehardware/BitstreamEvolution
sudo apt update && sudo apt upgrade  # Optional, but recommended
sudo apt install build-essential clang bison flex libreadline-dev gawk
sudo apt install tcl-dev libffi-dev libftdi-dev mercurial graphviz xdot
sudo apt install pkg-config python3 python3-pip libboost-all-dev cmake make
python3 -m pip install pyserial numpy matplotlib sortedcontainers

# https://clifford.at/icestorm

# https://github.com/YosysHQ/icestorm
git clone https://github.com/YosysHQ/icestorm.git icestorm
cd icestorm
make -j$(nproc)
sudo make install

# https://github.com/YosysHQ/nextpnr
# Replaces arachne-pnr
cmake . -DARCH=ice40
make -j$(nproc)
sudo make install


# https://github.com/YosysHQ/yosys
git clone https://github.com/YosysHQ/yosys.git yosys
cd yosys
make -j$(nproc)
sudo make install
