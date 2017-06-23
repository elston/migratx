FROM python:2.7-slim
MAINTAINER Den Elston "4665284@gmail.com"

# ...
RUN apt-get update && apt-get install -y --no-install-recommends locales
RUN sh -c "echo 'LANG="'"'"ru_RU.UTF-8"'"'"' > /etc/default/locale"
ENV LANG='ru_RU.UTF-8' LANGUAGE='ru_RU:ru' LC_ALL='ru_RU.UTF-8'
RUN localedef -i ru_RU -f UTF-8 ru_RU.UTF-8

# ...
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

# ...    
RUN apt-get install -y --no-install-recommends \
    gcc \
    curl \
    libffi-dev \    
    libssl-dev \
&& pip install --upgrade \
    pip \
    virtualenv \
&& pip install \
    virtualenvwrapper \
&& pip install --upgrade \
    virtualenvwrapper

# ...
# RUN rm -rf /var/lib/apt/lists/*

# ...
RUN sed -i '/^\[ new_oids \]/i \
# GOST \n\
openssl_conf = openssl_def \n\
\[openssl_def\] \n\
engines = engine_section \n\
\[engine_section\] \n\
gost = gost_section \n\
\[gost_section\] \n\
soft_load=1 \n\
default_algorithms = ALL \n\
# END GOST \
' /etc/ssl/openssl.cnf

#..
RUN touch ~/.bashrc \
&& echo " " >> ~/.bashrc \
&& echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
