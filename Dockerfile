FROM centos:8
ENV PATH /root/.rbenv/bin:$PATH
ENV PATH /root/.rbenv/shims/:${PATH}
RUN yum install which wget git -y \
    && curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash \
    && dnf install -y epel-release \
    && dnf install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel \
    && curl -sL https://rpm.nodesource.com/setup_12.x | bash - \
    && dnf install -y nodejs \
    && curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
    && dnf install -y yarn \
    && echo 'eval "$(rbenv init -)"' >> /root/.bash_profile \
    && echo 'eval "$(rbenv init -)"' >> .bashrc \
    && rbenv install 3.0.2 \
    && rbenv global 3.0.2 \
    && gem install rails
COPY ./ /root/ruby_dir/
WORKDIR /root/ruby_dir/
RUN bundle install
EXPOSE 3000
ENTRYPOINT ["rails", "s","-b","0.0.0.0","--port","3000"]
