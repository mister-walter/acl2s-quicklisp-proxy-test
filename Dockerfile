FROM atwalter/acl2s:latest

ADD fix-quicklisp.pl /tmp/

RUN rm -R /root/quicklisp

RUN cd /tmp && \
        echo '$HTTP_PROXY' &&\
        curl -O https://beta.quicklisp.org/quicklisp.lisp && \
        sbcl --load quicklisp.lisp --quit --eval '(quicklisp-quickstart:install :proxy "$HTTP_PROXY")' &&\
        perl /tmp/fix-quicklisp.pl

RUN sbcl --eval '(load "/root/quicklisp/setup.lisp")' --eval '(ql:quickload :cl-json)'
CMD ["sbcl"]
