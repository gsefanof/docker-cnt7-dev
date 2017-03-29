FROM centos:7
MAINTAINER bkadm@yandex.com

ENV URL_GIT_SRC="https://www.kernel.org/pub/software/scm/git/git-2.12.2.tar.gz"

RUN set -ex \
    && yum update -y \ 
    && yum groupinstall -y "Development Tools" \
    && yum install -y bind-utils iftop incron bzip2 lbzip2 psmisc rsync mailx tmux logrotate wget \
    && yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-CPAN perl-devel \
    && yum install -y perl gcc attr libacl-devel libblkid-devel gnutls-devel readline-devel \
                      python-devel gdb pkgconfig krb5-workstation zlib-devel setroubleshoot-server \
                      libaio-devel setroubleshoot-plugins policycoreutils-python libsemanage-python \
                      perl-ExtUtils-MakeMaker perl-Parse-Yapp perl-Test-Base popt-devel libxml2-devel \
                      libattr-devel keyutils-libs-devel cups-devel bind-utils libxslt docbook-style-xsl \
                      openldap-devel autoconf python-crypto pam-devel \
    && yum clean all 

# Install latest Git
ENV GIT_ARCH="/tmp/git.tar.gz" GIT_SRC="/tmp/git_src"
RUN wget ${URL_GIT_SRC} -O ${GIT_ARCH} \
 && mkdir ${GIT_SRC} \
 && tar -xf ${GIT_ARCH} --strip-components=1 -C ${GIT_SRC} \
 && cd ${GIT_SRC} \
 && make prefix=/usr/local all \
 && make prefix=/usr/local install \
 && rm -rf ${GIT_ARCH} ${GIT_SRC}



#ENV PATH /usr/local/samba/sbin:/usr/local/samba/bin:$PATH

VOLUME [ "/root/dev" ]

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

