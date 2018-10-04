# STEP:0 
	FROM nvidia/cuda:9.0-devel-centos7
	LABEL maintainer "AMUZLAB CORPORATION <amuzlab@amuzlab.com>"

# STEP:1 기본 패키지 설치
	RUN yum -y update && \
		yum -y install wget tar which vim yum-utils git rsync gcc gcc-c++ net-tools iproute man-pages man setuptool ncurses-devel libevent-expat-devel bzip2 bzip2-devel unzip gzip make automake cmake cmake3 initscripts lsof vsftpd && \
	yum groupinstall -y development tools
	#initscripts : server package
	#lsof : list open files 의 약자로 시스템에서 열린 정보 확인

# STEP:2 CUDNN 설치
	
	ENV CUDNN_VERSION 7.2.1.38
	LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

	# cuDNN license: https://developer.nvidia.com/cudnn/license_agreement
	RUN CUDNN_DOWNLOAD_SUM=cf007437b9ac6250ec63b89c25f248d2597fdd01369c80146567f78e75ce4e37 && \
	    curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v7.2.1/cudnn-9.0-linux-x64-v7.2.1.38.tgz -O && \
	    echo "$CUDNN_DOWNLOAD_SUM  cudnn-9.0-linux-x64-v7.2.1.38.tgz" | sha256sum -c - && \
	    tar --no-same-owner -xzf cudnn-9.0-linux-x64-v7.2.1.38.tgz -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*' && \
	    rm cudnn-9.0-linux-x64-v7.2.1.38.tgz && \
	    ldconfig 
	
# STEP:3 nv-codec-headers for using nvidia-graphic card on ffmpeg
	RUN git clone https://github.com/FFmpeg/nv-codec-headers /root/nv-codec-headers && \
	  cd /root/nv-codec-headers && \
	  make -j8 && \
	  make install -j8 && \
	  cd /root && rm -rf nv-codec-headers
	

# STEP:4 언어 설정
	RUN localedef -f UTF-8 -i ko_KR ko_KR.utf8 && \
		ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# STEP:5 python 설치
	#python3
	RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
	RUN yum install -y python36u python36u-libs python36u-devel python36u-pip
	RUN yum install -y python36u*	
	
	RUN ln -s /bin/python3.6 /bin/python3
	RUN ln -s /bin/pip3.6 /bin/pip
	RUN echo "alias python='python3'" >> /root/.bashrc
	RUN source /root/.bashrc
	RUN pip install --upgrade pip
	RUN pip install numpy
	
	#python2.*
	#RUN yum install -y epel-release
	#RUN yum install -y python-pip
	#RUN yum install -y python-devel
	#RUN pip install --upgrade pip
	#RUN pip install numpy

# STEP:6 Node js 관련 package install
	RUN curl --silent --location https://rpm.nodesource.com/setup_9.x | bash - && \
		yum -y install nodejs

# clean
	RUN rm -rf /var/lib/apt/lists/*

