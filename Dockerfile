# Copyright (C) 2016, 2017 by Maciej Serylak
# Copyright (C) 2019 by Maciej Serylak and Vivek Venkatraman Krishnan

# Licensed under the Academic Free License version 3.0
# This program comes with ABSOLUTELY NO WARRANTY.
# You are free to modify and redistribute this code as long
# as you do not remove the above attribution and reasonably
# inform receipients that you have modified the original work.




FROM ubuntu:jammy

MAINTAINER Gregory Desvignes "gdesvignes.astro@gmail.com"

# Suppress debconf warnings
ENV DEBIAN_FRONTEND noninteractive

# Switch account to root and adding user accounts and password
USER root
RUN echo "root:V153k!" | chpasswd

# Create psr user which will be used to run commands with reduced privileges.
RUN adduser --disabled-password --gecos 'unprivileged user' psr && \
    echo "psr:psr" | chpasswd && \
    mkdir -p /home/psr/.ssh && \
    chown -R psr:psr /home/psr/.ssh

# Create space for ssh deamozshn and update the system
RUN echo 'deb [arch=amd64] http://archive.ubuntu.com/ubuntu focal main multiverse' >> /etc/apt/sources.list && \
    echo 'deb [arch=amd64] http://mirrors.kernel.org/ubuntu/ focal main multiverse' >> /etc/apt/sources.list && \
    mkdir /var/run/sshd && \
    apt-get -y check && \
    apt-get -y update && \
    apt-get install -y apt-utils apt-transport-https software-properties-common &&\
    apt-get -y update --fix-missing && \
    apt-get -y upgrade &&\
    apt-get -y update --fix-missing

RUN apt-get -y install \
    apt-utils \
    autoconf \
    automake \
    autotools-dev \
    binutils-dev \
    build-essential \
    cmake \
    cmake-curses-gui \
    cmake-data \
    cpp \
    csh \
    curl \
    cvs \
    cython3 \
    dkms \
    dvipng \
    emacs\
    exuberant-ctags \
    f2c \
    fftw-dev \
    fftw2 \
    fort77 \
    g++ \
    gawk \
    gcc \
    gfortran \
    ghostscript \
    ghostscript-x \
    git \
    git-core \
    gnuplot \
    gnuplot-x11 \
    gsl-bin \
    gv \
    h5utils \
    hdf5-helpers \
    hdf5-tools \
    hdfview \
    htop \
    hwloc \
    python3-ipython \
    python3-notebook \
    jupyter \
    jupyter-core \
    latex2html \
    libatlas-base-dev \
    libbison-dev \
    libblas-dev \
    liblapack-dev \
    libboost-all-dev \
    libc-dev-bin \
    libc6-dev \
    libcfitsio-bin \
    libcfitsio-dev \
    libcfitsio-doc \
    libcppunit-dev \
    libcppunit-subunit-dev \
    libcppunit-subunit0 \
    libfftw3-3 \
    libfftw3-bin \
    libfftw3-dev \
    libfftw3-double3 \
    libfftw3-long3 \
    libfftw3-single3 \
    libfreetype6 \
    libfreetype6-dev \
    libgd-dev \
    libgd3 \
    libgeos-dev \
    libglib2.0-0 \
    libglib2.0-dev \
    libgmp3-dev \
    libgsl-dev \
    libhdf5-dev \
    libhdf5-serial-dev \
    libhwloc-dev \
    liblapack-dev \
    liblapack-pic \
    liblapack-test \
    liblapack3 \
    liblapacke \
    liblapacke-dev \
    libltdl-dev \
    libltdl7 \
    liblua5.1-0 \
    liblua5.1-0-dev \
    liblua5.2-0 \
    liblua5.2-dev \
    liblua5.3-0 \
    liblua5.3-dev \
    libncurses5-dev \
    libopenblas-base \
    libopenblas-dev \
    libpng++-dev \
    libpng-sixlegs-java \
    libpng-sixlegs-java-doc \
    libpng-dev \
    libpnglite-dev \
    libpth-dev \
    libqt5dbus5 \
    libqt5designer5 \
    libqt5core5a \
    libqt5gui5 \
    libqt5help5 \
    libqt5network5 \
    libqt5opengl5 \
    libqt5script5 \
    libqt5scripttools5 \
    libqt5sql5 \
    libqt5sql5-mysql \
    libqt5svg5 \
    libqt5test5 \
    libqt5xml5 \
    libqt5xmlpatterns5 \
    libreadline-dev \
    libsocket++-dev \
    libsocket++1 \
    libssl-dev \
    libtool \
    libx11-dev \
    llvm-12 \
    llvm-12-dev \
    llvm-12-examples \
    llvm-12-runtime \
    locate \
    lsof \
    m4 \
    make \
    man \
    mc \
    nano \
    nfs-common \
    numactl \
    openjdk-8-jdk \
    openssh-server \
    pax \
    pbzip2 \
    pgplot5 \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip \
    python3-pyside2.qtcore \
    python3-pyside2.qtgui \
    python3-pyside2.qtwidgets \
    python3-tk \
    python3-setuptools \
    rsync \
    screen \
    software-properties-common \
    source-highlight \
    subversion \
    swig \
    tcsh \
    tk \
    tk-dev \
    tmux \
    vim \
    wcslib-dev \
    wcslib-tools \
    wget \
    zlib1g-dev \
    zsh

# Install python modules

RUN pip3 install pip -U && \
    pip3 install setuptools -U && \
    pip3 install datetime -U && \
    pip3 install bitstring -U && \
    pip3 install ipython -U && \
    pip3 install --ignore-installed jupyter -U && \
    pip3 install six -U && \
    pip3 install numpy -U && \
    pip3 install scipy -U && \
    pip3 install pandas -U && \
    pip3 install h5py -U && \
    pip3 install astropy -U && \
    pip3 install astroplan -U && \
    pip3 install astropy_helpers -U && \
    pip3 install astroquery -U && \
    pip3 install matplotlib -U && \
    pip3 install pyephem -U && \
    pip3 install setuptools_scm pep517 -U && \
    pip3 install emcee -U && \
    pip3 install scikit-learn -U && \
    pip3 install corner -U && \
    pip3 install psrqpy -U && \
    pip3 install uncertainties -U && \
    pip3 install getdist -U && \
    pip3 install dynesty -U && \
    pip3 install dyPolyChord -U && \
    pip3 install lmfit -U && \
    pip3 install PyWavelets -U && \
    pip3 install ultranest -U && \
    pip3 install iminuit -U && \
    pip3 install numba -U && \
    pip3 install pint-pulsar -U

# Set python3 as default version
RUN update-alternatives --install  /usr/bin/python python /usr/bin/python3 1

# Switch account to psr
USER psr

# Define home, psrhome, OSTYPE and create the directory
ENV HOME /home/psr
ENV PSRHOME /home/psr/software
ENV OSTYPE linux
RUN mkdir -p /home/psr/software

# Downloading all source codes
WORKDIR $PSRHOME
RUN wget  http://ds9.si.edu/download/ubuntu20/ds9.ubuntu20.8.4.tar.gz && \
    mkdir $PSRHOME/ds9-8.4 && \
    tar -xvvf ds9.ubuntu20.8.4.tar.gz -C $PSRHOME/ds9-8.4 && \
    wget http://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/fv/fv5.4_pc_linux64.tar.gz && \
    tar -xvvf fv5.4_pc_linux64.tar.gz -C $PSRHOME && \
    wget http://www.atnf.csiro.au/people/pulsar/psrcat/downloads/psrcat_pkg.tar.gz && \
    tar -xvf psrcat_pkg.tar.gz -C $PSRHOME && \
    wget http://www.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz && \
    tar -xvvf szip-2.1.1.tar.gz && \
    wget https://www.hdfgroup.org/ftp/HDF5/tools/h5check/src/h5check-2.0.1.tar.gz && \
    tar -xvvf h5check-2.0.1.tar.gz && \
    wget -U 'Linux' https://bsdforge.com/projects/devel/clig/src/clig-1.9.11.2.tar.xz && \
    tar -xvvf clig-1.9.11.2.tar.xz && \
    wget http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.2.0.tar.gz && \
    tar -xvf cfitsio-4.2.0.tar.gz && \
    git clone https://bitbucket.org/psrsoft/tempo2.git && \
    git clone https://github.com/gdesvignes/tempo.git && \
    git clone https://git.code.sf.net/p/psrchive/code psrchive && \
    git clone https://github.com/SixByNine/sigproc.git && \
    git clone https://github.com/ewanbarr/sigpyproc.git && \
    git clone https://git.code.sf.net/p/dspsr/code dspsr && \
    git clone https://github.com/weltevrede/psrsalsa.git && \
    git clone https://github.com/scottransom/presto.git && \
    git clone https://github.com/scottransom/psrfits2psrfits.git && \
    git clone https://github.com/gdesvignes/psrfits_utils.git && \
    git clone https://github.com/scottransom/pyslalib.git && \
    git clone https://github.com/straten/epsic.git && \
    git clone https://github.com/JohannesBuchner/MultiNest  && \
    git clone https://github.com/PolyChord/PolyChordLite.git && \
    git clone https://github.com/vivekvenkris/plotres.git && \
    git clone https://github.com/vivekvenkris/fitorbit.git &&\
    git clone https://github.com/gdesvignes/PulsePortraiture.git &&\
    git clone https://github.com/gdesvignes/pyfitorbit.git &&\
    git clone https://github.com/demorest/tempo_utils &&\
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" 


# PGPLOT
ENV PGPLOT_DIR="/usr/lib/pgplot5" \
    PGPLOT_FONT="/usr/lib/pgplot5/grfont.dat" \
    PGPLOT_INCLUDES="/usr/include" \
    PGPLOT_BACKGROUND="white" \
    PGPLOT_FOREGROUND="black" \
    PGPLOT_DEV="/xs"

# CFITSIO
ENV CFITSIO=$PSRHOME"/cfitsio-4.2.0" 
WORKDIR $PSRHOME/cfitsio
RUN ./configure  && \
    make -j $(nproc) && \
    make shared && \
    make install

# ds9
ENV PATH $PATH:$PSRHOME/ds9-7.5

# fv
ENV PATH $PATH:$PSRHOME/fv5.4

# psrcat
ENV PSRCAT_FILE=$PSRHOME"/psrcat_tar/psrcat.db" \
    PATH=$PATH:$PSRHOME"/psrcat_tar"
WORKDIR $PSRHOME/psrcat_tar
RUN /bin/bash makeit

# tempo
ENV TEMPO=$PSRHOME"/tempo" \
    PATH=$PATH:$PSRHOME"/tempo/bin"
WORKDIR $PSRHOME/tempo
RUN ./prepare && \
    ./configure --prefix=$PSRHOME/tempo && \
    make && \
    make install

# tempo2
ENV TEMPO2=$PSRHOME"/tempo2/T2runtime" \
    PATH=$PATH:$PSRHOME"/tempo2/T2runtime/bin" \
    C_INCLUDE_PATH=$C_INCLUDE_PATH:$PSRHOME"/tempo2/T2runtime/include" \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PSRHOME"/tempo2/T2runtime/lib"
WORKDIR $PSRHOME/tempo2
# A fix to get rid of: returned a non-zero code: 126.
RUN sync && perl -pi -e 's/chmod \+x/#chmod +x/' bootstrap
RUN ./bootstrap && \
    ./configure --x-libraries=/usr/lib/x86_64-linux-gnu --enable-shared --enable-static --with-pic F77=gfortran  && \
    make -j $(nproc) && \
    make install && \
    make plugins-install
WORKDIR $PSRHOME/tempo2/T2runtime/clock
RUN touch meerkat2gps.clk && \
    echo "# UTC(meerkat) UTC(GPS)" > meerkat2gps.clk && \
    echo "#" >> meerkat2gps.clk && \
    echo "50155.00000 0.0" >> meerkat2gps.clk && \
    echo "58000.00000 0.0" >> meerkat2gps.clk


ENV EPSIC=$PSRHOME"/epsic"
WORKDIR $EPSIC/src

RUN ./bootstrap && \
    ./configure --prefix=$PSRHOME"/epsic/install" && make -j $(nproc) && make &&  make install > test

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PSRHOME"/epsic/install/lib" \
    C_INCLUDE_PATH=$C_INCLUDE_PATH:$PSRHOME"/epsic/install/include/epsic" \
    PATH=$PATH:$PSRHOME"/epsic/install/bin" \
    CPPFLAGS="-I ${PSRHOME}/epsic/install/include/epsic"  \
    CFLAGS="-I ${PSRHOME}/epsic/install/include/epsic" 

# PSRCHIVE
ENV PSRCHIVE=$PSRHOME"/psrchive/install" \
    PATH=$PATH:$PSRHOME"/psrchive/install/bin" \
    C_INCLUDE_PATH=$C_INCLUDE_PATH:$PSRHOME"/psrchive/install/include" \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PSRHOME"/psrchive/install/lib" \
    PYTHONPATH=$PYTHONPATH:$PSRHOME"/psrchive/install/lib/python3.8/site-packages"
WORKDIR $PSRHOME/psrchive/
RUN ./bootstrap && \
    ./configure --prefix=$PSRCHIVE --x-libraries=/usr/lib/x86_64-linux-gnu  --enable-shared --enable-static F77=gfortran  && \
    make -j $(nproc) && \
    make install 
WORKDIR $HOME
RUN $PSRCHIVE/bin/psrchive_config >> .psrchive.cfg && \
    sed -i 's/# ArrivalTime::default_format = Parkes/ArrivalTime::default_format = Tempo2/g' .psrchive.cfg && \
    sed -i 's/# Predictor::default = polyco/Predictor::default = tempo2/g' .psrchive.cfg && \
    sed -i 's/# Predictor::policy = ephem/Predictor::policy = default/g' .psrchive.cfg && \
    sed -i 's/# WeightedFrequency::round_to_kHz = 1/WeightedFrequency::round_to_kHz = 0/g' .psrchive.cfg

# SIGPROC
ENV SIGPROC=$PSRHOME"/sigproc" \
    PATH=$PATH:$SIGPROC"/install/bin" \
    FC="gfortran" \
    F77="gfortran" \
    CC="gcc" \
    CXX="g++"
WORKDIR $SIGPROC
RUN ./bootstrap && \
    ./configure --prefix=$SIGPROC/install --x-libraries=/usr/lib/x86_64-linux-gnu --enable-shared LDFLAGS="-L"$TEMPO2"/lib" LIBS="-ltempo2" && \
    make && \
    make install

# sigpyproc
ENV SIGPYPROC=$PSRHOME"/sigpyproc" \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PSRHOME"/sigpyproc/lib/c"
WORKDIR $PSRHOME/sigpyproc
RUN python3 setup.py install --record list.txt --user


# DSPSR
ENV DSPSR=$PSRHOME"/dspsr" \
    PATH=$PATH:$PSRHOME"/dspsr/install/bin" \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PSRHOME"/dspsr/install/lib" \
    C_INCLUDE_PATH=$C_INCLUDE_PATH:$PSRHOME"/dspsr/install/include"

WORKDIR $DSPSR
RUN ./bootstrap && \
    echo "apsr asp bcpm bpsr caspsr cpsr cpsr2 dummy fits kat lbadr lbadr64  puma2 sigproc ska1" > backends.list && \
    ./configure --prefix=$DSPSR/install --x-libraries=/usr/lib/x86_64-linux-gnu CPPFLAGS="$CPPFLAGS -I"$DAL"/install/include -I/usr/include/hdf5/serial -I/usr/local/cuda/include"  LDFLAGS="-L"$DAL"/install/lib -L/usr/lib/x86_64-linux-gnu/hdf5/serial  -L/usr/local/cuda/lib64" LIBS="-lpgplot -lcpgplot" && \
    make -j $(nproc) && \
    make && \
    make install

# clig
ENV CLIG=$PSRHOME"/clig" \
    PATH=$PATH:$PSRHOME"/clig/instal/bin" \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PSRHOME"/clig/instal/lib"
WORKDIR $CLIG
RUN sed -i 's|prefix =/usr|prefix=$(CLIG)/instal|g' makefile && \
    make && \
    make install

# PSRSALSA
ENV PSRSALSA=$PSRHOME"/psrsalsa" \
    PATH=$PATH:$PSRHOME"/psrsalsa/bin" \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PSRHOME"/psrsalsa/src/lib"
WORKDIR $PSRSALSA
RUN sed -i.backup -e's/GSLFLAGS =.*/GSLFLAGS = -DGSL_VERSION_NUMBER=203/' Makefile && \
    make -j $(nproc) && \
    make


# PRESTO 3
ENV PRESTO=$PSRHOME"/presto" \
    PATH=$PATH:$PSRHOME"/presto/bin" \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PSRHOME"/presto/lib" \
    PYTHONPATH=$PYTHONPATH:$PSRHOME"/presto/lib/python"
WORKDIR $PRESTO/src
#RUN make makewisdom
RUN make prep && \
    make -j $(nproc) && \
    make && \
    make mpi
WORKDIR $PRESTO
RUN pip install .

# psrfits2psrfits
ENV CLIGF=$PSRHOME"/clig" \
    PSRFITS2PSRFITS=$PSRHOME"/psrfits2psrfits" \
    PATH=$PATH:$PSRHOME"/psrfits2psrfits"
WORKDIR $PSRFITS2PSRFITS
RUN sed -i 's|/usr/bin/clig|$(CLIGF)/instal/bin/clig|g' Makefile && \
    make -j $(nproc) && \
    make

# pyslalib
ENV PYSLALIB=$PSRHOME"/pyslalib"
WORKDIR $PYSLALIB
RUN python3 setup.py install --record list.txt --user

#Zsh commands
RUN rm -rf /home/psr/.zprezto && zsh -c 'git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"' && \
zsh -c 'setopt EXTENDED_GLOB && for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done '


RUN curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh && \
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash

# PolyChordLite
WORKDIR $PSRHOME/PolyChordLite
RUN make all && pip install . --user
ENV PC_DIR="$PSRHOME/PolyChordLite/lib"

# MultiNest
WORKDIR $PSRHOME/MultiNest/build
RUN cmake .. && make && ln -s $PSRHOME/MultiNest/lib/libmultinest_mpi.so $PSRHOME/MultiNest/lib/libnest3.so
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$PSRHOME/MultiNest/lib":"/usr/lib/x86_64-linux-gnu/openmpi/lib/" \
    CFLAGS="$CFLAGS -I$PSRHOME/MultiNest/include" \
    CPPFLAGS="$CPPFLAGS -I$PSRHOME/MultiNest/include" \
    MULTINEST_DIR="$PSRHOME/MultiNest/lib"
    
#plotres
ENV PLOTRES=$PSRHOME"/plotres"
WORKDIR $PLOTRES
RUN gfortran -o plotres plotres.f -lcpgplot -lpgplot -lX11 -lm && \
    gfortran -o plotres_ps plotres_ps.f -lcpgplot -lpgplot -lX11 -lm

ENV PATH=$PATH:"$PLOTRES/"

#fitorbit
ENV FITORBIT=$PSRHOME"/fitorbit"
WORKDIR $FITORBIT
RUN ./install.sh
ENV PATH=$PATH:"$FITORBIT/bin"

#pulse portraiture
ENV PP=$PSRHOME"/PulsePortraiture"
WORKDIR $PP
RUN git checkout --track remotes/origin/py3

#tempo_utils
ENV TEMPOUTILS=$PSRHOME"/tempo_utils"
WORKDIR $TEMPOUTILS
RUN python3 setup.py install --record list.txt --user

# psrfits_utils
ENV PSRFITS_UTILS=$PSRHOME"/psrfits_utils" \
    PATH=$PATH:$PSRHOME"/psrfits_utils/install/bin" \
    C_INCLUDE_PATH=$C_INCLUDE_PATH:$PSRHOME"/psrfits_utils/install/include" \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PSRHOME"/psrfits_utils/install/lib"
WORKDIR $PSRFITS_UTILS
#RUN git pull
#RUN sed -i 's|-Werror foreign|-Werror foreign -Wno-extra-portability|g' configure.ac && \
#    ./prepare && \
#    ./configure --prefix=$PSRFITS_UTILS/install --with-presto=$PRESTO && \
#    make -j $(nproc) && \
#    make && \
#    make install

# Clean downloaded source codes
WORKDIR $PSRHOME
RUN rm -rf ./*.bz2 ./*.gz ./*.xz ./*.ztar ./*.zip

# Put in file with all environmental variables
WORKDIR $HOME
RUN echo "" >> .bashrc && \
    echo "if [ -e \$HOME/.mysetenv.bash ]; then" >> .bashrc && \
    echo "   source \$HOME/.mysetenv.bash" >> .bashrc && \
    echo "fi" >> .bashrc && \
    echo "" >> .bashrc && \
    echo "alias rm='rm -i'" >> .bashrc && \
    echo "alias mv='mv -i'" >> .bashrc && \
    echo "alias ldc='ls -lrt'" >> .bashrc && \
    echo "# Set up PS1" >> .mysetenv.bash && \
    echo "export PS1=\"\u@\h [\$(date +%d\ %b\ %Y\ %H:%M)] \w> \"" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \
    echo "# Define home, psrhome, software, OSTYPE" >> .mysetenv.bash && \
    echo "export HOME=/home/psr" >> .mysetenv.bash && \
    echo "export PSRHOME=/home/psr/software" >> .mysetenv.bash && \
    echo "export OSTYPE=linux" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \
    echo "# Up arrow search" >> .mysetenv.bash && \
    echo "export HISTFILE=\$HOME/.bash_eternal_history" >> .mysetenv.bash && \
    echo "export HISTFILESIZE=" >> .mysetenv.bash && \
    echo "export HISTSIZE=" >> .mysetenv.bash && \
    echo "export HISTCONTROL=ignoreboth" >> .mysetenv.bash && \
    echo "export HISTIGNORE=\"l:ll:lt:ls:bg:fg:mc:history::ls -lah:..:ls -l;ls -lh;lt;la\"" >> .mysetenv.bash && \
    echo "export HISTTIMEFORMAT=\"%F %T \"" >> .mysetenv.bash && \
    echo "export PROMPT_COMMAND=\"history -a\"" >> .mysetenv.bash && \
    echo "bind '\"\e[A\":history-search-backward'" >> .mysetenv.bash && \
    echo "bind '\"\e[B\":history-search-forward'" >> .mysetenv.bash && \

    echo "" >> .mysetenv.bash && \
    echo "# PGPLOT" >> .mysetenv.bash && \
    echo "export PGPLOT_DIR=/usr/lib/pgplot5" >> .mysetenv.bash && \
    echo "export PGPLOT_FONT=/usr/lib/pgplot5/grfont.dat" >> .mysetenv.bash && \
    echo "export PGPLOT_INCLUDES=/usr/include" >> .mysetenv.bash && \
    echo "export PGPLOT_BACKGROUND=white" >> .mysetenv.bash && \
    echo "export PGPLOT_FOREGROUND=black" >> .mysetenv.bash && \
    echo "export PGPLOT_DEV=/xs" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# calceph" >> .mysetenv.bash && \
    echo "export CALCEPH=\$PSRHOME/calceph-2.3.2" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$CALCEPH/install/bin" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$CALCEPH/install/lib" >> .mysetenv.bash && \
    echo "export C_INCLUDE_PATH=\$C_INCLUDE_PATH:\$CALCEPH/install/include" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# ds9" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$PSRHOME/ds9-7.5" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# fv" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$PSRHOME/fv5.4" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# psrcat" >> .mysetenv.bash && \
    echo "export PSRCAT_FILE=\$PSRHOME/psrcat_tar/psrcat.db" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$PSRHOME/psrcat_tar" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# tempo" >> .mysetenv.bash && \
    echo "export TEMPO=\$PSRHOME/tempo" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$TEMPO/bin" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# tempo2" >> .mysetenv.bash && \
    echo "export TEMPO2=\$PSRHOME/tempo2/T2runtime" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$TEMPO2/bin" >> .mysetenv.bash && \
    echo "export C_INCLUDE_PATH=\$C_INCLUDE_PATH:\$TEMPO2/include" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$TEMPO2/lib" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# EPSIC" >> .mysetenv.bash && \
    echo "export EPSIC=\$PSRHOME/epsic" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$PSRHOME/epsic/install/lib" >> .mysetenv.bash && \
    echo "C_INCLUDE_PATH=\$C_INCLUDE_PATH:\$EPSIC/install/include/epsic" >> .mysetenv.bash && \

    echo "# PSRCHIVE" >> .mysetenv.bash && \
    echo "export PSRCHIVE=\$PSRHOME/psrchive/install" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$PSRCHIVE/bin" >> .mysetenv.bash && \
    echo "export C_INCLUDE_PATH=\$C_INCLUDE_PATH:\$PSRCHIVE/include" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$PSRCHIVE/lib" >> .mysetenv.bash && \
    echo "export PYTHONPATH=\$PYTHONPATH:\$PSRCHIVE/lib/python3.8/site-packages" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# SIGPROC" >> .mysetenv.bash && \
    echo "export SIGPROC=\$PSRHOME/sigproc" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$SIGPROC/install/bin" >> .mysetenv.bash && \
    echo "export FC=gfortran" >> .mysetenv.bash && \
    echo "export F77=gfortran" >> .mysetenv.bash && \
    echo "export CC=gcc" >> .mysetenv.bash && \
    echo "export CXX=g++" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# sigpyproc" >> .mysetenv.bash && \
    echo "export SIGPYPROC=\$PSRHOME/sigpyproc" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$SIGPYPROC/lib/c" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \
    
    echo "# DSPSR" >> .mysetenv.bash && \
    echo "export DSPSR=\$PSRHOME/dspsr" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$DSPSR/install/bin" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$DSPSR/install/lib" >> .mysetenv.bash && \
    echo "export C_INCLUDE_PATH=\$C_INCLUDE_PATH:\$DSPSR/install/include" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# clig" >> .mysetenv.bash && \
    echo "export CLIG=\$PSRHOME/clig" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$CLIG/instal/bin" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$CLIG/instal/lib" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# PSRSALSA" >> .mysetenv.bash && \
    echo "export PSRSALSA=\$PSRHOME/psrsalsa" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$PSRSALSA/bin" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$PSRSALSA/src/lib" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# PRESTO 3" >> .mysetenv.bash && \
    echo "export PRESTO=\$PSRHOME/presto" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$PRESTO/bin" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$PRESTO/lib" >> .mysetenv.bash && \
    echo "export PYTHONPATH=\$PYTHONPATH:\$PRESTO/lib/python" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# psrfits2psrfits" >> .mysetenv.bash && \
    echo "export PSRFITS2PSRFITS=\$PSRHOME/psrfits2psrfits" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$PSRFITS2PSRFITS" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# psrfits_utils" >> .mysetenv.bash && \
    echo "export PSRFITS_UTILS=\$PSRHOME/psrfits_utils" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$PSRFITS_UTILS/install/bin" >> .mysetenv.bash && \
    echo "export C_INCLUDE_PATH=\$C_INCLUDE_PATH:\$PSRFITS_UTILS/install/include" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$PSRFITS_UTILS/install/lib" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# pyslalib" >> .mysetenv.bash && \
    echo "export PYSLALIB=\$PSRHOME/pyslalib" >> .mysetenv.bash && \
    echo "" >> .mysetenv.bash && \

    echo "# MultiNest" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/home/psr/software/MultiNest/lib" >> .mysetenv.bash && \
    echo "export MULTINEST_DIR=\$PSRHOME/MultiNest/lib" >> .mysetenv.bash && \

    echo "# PolyChordLite" >> .mysetenv.bash && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/home/psr/software/PolyChordLite/lib" >> .mysetenv.bash && \
    echo "export PC_DIR=\$PSRHOME/PolyChordLite/lib" >> .mysetenv.bash && \


    echo "# Plotres" >> .mysetenv.bash && \
    echo "export PLOTRES=\$PSRHOME/plotres" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$PLOTRES/" >> .mysetenv.bash && \

    echo "# Fitorbit" >> .mysetenv.bash && \
    echo "export FITORBIT=\$PSRHOME/fitorbit" >> .mysetenv.bash && \
    echo "export PATH=\$PATH:\$FITORBIT/bin" >> .mysetenv.bash && \
    echo "export fitorbitdir=\$PSRHOME/fitorbit/src/" >> .mysetenv.bash && \

    echo "# Pulse Portraiture" >> .mysetenv.bash && \
    echo "export PP=\$PSRHOME/PulsePortraiture" >> .mysetenv.bash && \
    echo "export PYTHONPATH=\$PYTHONPATH:\$PP/" >> .mysetenv.bash && \

    echo "alias emacs='emacs -nw'" >> .mysetenv.bash  && \
    echo "alias emcas='emacs'" >> .mysetenv.bash  && \
    echo "alias em='emacs'" >> .mysetenv.bash  && \
    echo "alias mroe='more'" >> .mysetenv.bash  && \


    echo "source \$HOME/.bashrc" >> $HOME/.zshrc && \



    /bin/bash -c "source \$HOME/.bashrc" 



# Update database for locate and run sshd server and expose port 22
USER root
RUN sed 's/X11Forwarding yes/X11Forwarding yes\nX11UseLocalhost no/' -i /etc/ssh/sshd_config && \
    echo "if [ -e \/home/psr/.mysetenv.bash ]; then" >> .bashrc && \
    echo "   source \/home/psr/.mysetenv.bash" >> .bashrc && \
    echo "fi" >> .bashrc && \
    echo "" >> .bashrc && \
    echo "alias rm='rm -i'" >> .bashrc && \
    echo "alias mv='mv -i'" >> .bashrc 
RUN updatedb
EXPOSE 22
EXPOSE 9000
CMD ["/usr/sbin/sshd", "-D"]
