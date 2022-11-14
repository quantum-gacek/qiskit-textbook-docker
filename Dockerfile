FROM python:3.8.15

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt update
RUN apt install nodejs

WORKDIR /usr/qiskit-textbook

RUN git clone https://github.com/Qiskit/platypus.git
RUN cd platypus/converter/textbook-converter &&  \
    pip install -r requirements.txt -r requirements-test.txt

RUN cd platypus && npm update --legacy-peer-deps
RUN cd platypus && npm install
RUN export NODE_OPTIONS="--max-old-space-size=8192" && cd platypus && npm run build
EXPOSE 8080
RUN cd platypus && npm start
